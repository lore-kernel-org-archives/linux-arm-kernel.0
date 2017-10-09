From: robh@kernel.org (Rob Herring)
Date: Mon, 9 Oct 2017 13:59:57 -0500
Subject: [PATCH 2/2] of/fdt: skip unflattening of disabled nodes
In-Reply-To: <59DAAD6F.7010907@gmail.com>
References: <20171003161815.25999-1-robh@kernel.org>
 <20171003161815.25999-2-robh@kernel.org>
 <59DAAD6F.7010907@gmail.com>
Message-ID: <CAL_JsqKeh-yegjKuwVU5Z5fSj8nK=-0BeHb1kNePMk78iBFaXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 8, 2017 at 5:57 PM, Frank Rowand <frowand.list@gmail.com> wrote:
> On 10/03/17 09:18, Rob Herring wrote:
>> For static DT usecases, we don't need the disabled nodes and can skip
>> unflattening. This saves a significant amount of RAM in memory constrained
>> cases. In one example on STM32F469, the RAM usage goes from 118K to 26K.
>>
>> There are a few cases in the kernel that modify the status property
>> dynamically. These all are changes from enabled to disabled, depend on
>> OF_DYNAMIC or are not FDT based (PDT based).
>>
>> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
>> Cc: Frank Rowand <frowand.list@gmail.com>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>> For more background, see this presentation from Nico:
>>
>> https://connect.linaro.org/resource/sfo17/sfo17-100/
>>
>>  drivers/of/fdt.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index f8c39705418b..efe91c6856a0 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -396,6 +396,10 @@ static int unflatten_dt_nodes(const void *blob,
>>               if (WARN_ON_ONCE(depth >= FDT_MAX_DEPTH))
>>                       continue;
>>
>> +             if (!IS_ENABLED(CONFIG_OF_DYNAMIC) &&
>> +                 !of_fdt_device_is_available(blob, offset))
>> +                     continue;
>> +
>>               if (!populate_node(blob, offset, &mem, nps[depth],
>>                                  &nps[depth+1], dryrun))
>>                       return mem - base;
>>
>
> Hi Rob,
>
> I strongly support the idea of this patch, but there may be an
> issue we have to resolve.  I'm pretty sure we had talked about
> the issue a long time ago, and it has been sitting on my todo
> list.
>
> We have two sets of node traversal macros and functions.  One
> set honors the status property, and the other ignores it.  If
> I recall our previous discussion properly, we want the normal
> usage to honor the status property and only a tiny (or maybe
> non-existent) set of locations to be allowed to ignore the
> status property.

Ignoring status is a bug for a static DT. There could be places that
expect the node to be present, but disabled. Those may be bugs too.

> A rough sense of how often the status property is honored or
> not is:
>
>    $ git grep for_each_child_of_node | wc -l
>    293
>    $ git grep of_get_next_child | wc -l
>    103
>
>    $ git grep for_each_available_child_of_node | wc -l
>    106
>    $ git grep of_get_next_available_child | wc -l
>    20
>
> Many of the cases where the status flag is ignored will not
> actually encounter a node that is not available, so many of
> the cases where status is not checked could currently be
> checking status.

For many nodes, status simply makes no sense or at least is undefined.

> And just for completeness, there are a number of standalone
> checks for whether a node is available:
>
>    $ git grep of_device_is_available | wc -l
>    128

I'm surprised it's that many. It's a low-level detail that the core
should handle. We'd also need to make things like of_find_node_by_name
honor status.

> It will be a pain to manually check all of the sites that
> ignore the status property, but that task should be done.
>
> In the mean time, maybe we could flush out the few cases
> that currently depend on ignoring the status property by
>
>    - making for_each_child_of_node() and of_get_next_child()
>      actually check for valid status
>
>    - provide a temporary (one or two kernel release)
>      CONFIG option to allow the old behavior for
>      for_each_child_of_node() and of_get_next_child()
>      just in case we miss any locations that need to
>      be fixed
>
>    - fix up the few places in core device tree code that
>      actually need to ignore status (if such places exist)
>
> In the end, the *_available_*() interfaces should be
> removed, because the normal behavior of node traversal
> should be to only traverse nodes that are available.

I'm not sure this is really something we want or need to fix.

I could just make this depend on OF_KOBJ instead. Then practically no
one would see any change as almost everyone enables sysfs (and in turn
/proc/device-tree).

Rob
