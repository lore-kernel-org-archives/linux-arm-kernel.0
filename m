From: frowand.list@gmail.com (Frank Rowand)
Date: Tue, 3 Oct 2017 14:58:43 -0700
Subject: [PATCH 2/2] of/fdt: skip unflattening of disabled nodes
In-Reply-To: <nycvar.YSQ.7.76.1710031444060.5407@knanqh.ubzr>
References: <20171003161815.25999-1-robh@kernel.org>
 <20171003161815.25999-2-robh@kernel.org>
 <nycvar.YSQ.7.76.1710031444060.5407@knanqh.ubzr>
Message-ID: <59D40813.4020009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/17 11:46, Nicolas Pitre wrote:
> On Tue, 3 Oct 2017, Rob Herring wrote:
> 
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
> 
> Tested-by: Nicolas Pitre <nico@linaro.org>
> 
>> ---
>> For more background, see this presentation from Nico:
>>
>> https://connect.linaro.org/resource/sfo17/sfo17-100/
> 
> Oh my ... this is horrible ...

I found the presentation to be quite good and useful.
The Linaro site does not have the slides, could you please send
me a copy?

Thanks,

Frank

> 
> /me hides in shame
> 
>>
>>  drivers/of/fdt.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index f8c39705418b..efe91c6856a0 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -396,6 +396,10 @@ static int unflatten_dt_nodes(const void *blob,
>>  		if (WARN_ON_ONCE(depth >= FDT_MAX_DEPTH))
>>  			continue;
>>  
>> +		if (!IS_ENABLED(CONFIG_OF_DYNAMIC) &&
>> +		    !of_fdt_device_is_available(blob, offset))
>> +			continue;
>> +
>>  		if (!populate_node(blob, offset, &mem, nps[depth],
>>  				   &nps[depth+1], dryrun))
>>  			return mem - base;
>> -- 
>> 2.11.0
>>
>>
> 
