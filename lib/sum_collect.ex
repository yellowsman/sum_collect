defmodule SumCollect do
  @doc """
    csvファイルを第1列目でグルーピングした第2列目の数を合計を計算してファイルに出力する
  """
  def sum(file_path, write_path) do
    {:ok, data} = File.read(file_path)
    datalist = data 
    |> String.split("\n") 
    |> Enum.map(fn x -> String.split(x, ",") end) 
    |> Enum.group_by(&List.first/1, &List.last/1)
    |> Enum.sort 
    |> Enum.drop(1)
    ids = datalist
    |> Enum.map(fn x -> Tuple.to_list(x) end) |> Enum.map(fn x -> List.first(x) end)
    sales = datalist
    |> Enum.map(fn x -> Tuple.to_list(x) end) |> Enum.map(fn x -> List.last(x) end) |> Enum.map(fn x -> Enum.reduce(x, 0, fn x2, acc2 -> String.to_integer(x2) + acc2 end) end)
    File.write!(write_path, Enum.zip(ids, sales) |> Enum.map(fn x -> Tuple.to_list(x) end) |> Enum.map(fn x -> Enum.join(x, ",") end) |> Enum.join("\n"))
  end
end
