From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Fri, 29 May 2015 20:11:59 +0200
Subject: [PATCH v3] ARM: l2c: add options to overwrite prefetching behavior
In-Reply-To: <5568A745.7020502@gmail.com>
References: <1431726751-9169-1-git-send-email-hauke@hauke-m.de>
 <5568A745.7020502@gmail.com>
Message-ID: <5568ABEF.3040001@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/29/2015 07:52 PM, Florian Fainelli wrote:
> On 15/05/15 14:52, Hauke Mehrtens wrote:
>> These options make it possible to overwrites the data and instruction
>> prefetching behavior of the arm pl310 cache controller.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>> v2: only set prefetch
>> v1: set prefetch and aux
>>
>>  Documentation/devicetree/bindings/arm/l2cc.txt |  4 ++++
>>  arch/arm/mm/cache-l2x0.c                       | 20 ++++++++++++++++++++
>>  2 files changed, 24 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
>> index 0dbabe9..528821a 100644
>> --- a/Documentation/devicetree/bindings/arm/l2cc.txt
>> +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
>> @@ -67,6 +67,10 @@ Optional properties:
>>    disable if zero.
>>  - arm,prefetch-offset : Override prefetch offset value. Valid values are
>>    0-7, 15, 23, and 31.
>> +- arm,prefetch-data : Enable data prefetch. Enabling prefetching
>> +  can improve performance.
> 
> I do not think the "can improve performance" has a place in a binding,
> this is either not technical enough about what this does, or marketing
> enough it does not buy us much.
> 
> data/instruction pre-fetching are commonly found on cache controller
> these days, so I would be tempted to remove the "arm," prefixing here
> since this can be generalized to other kinds of cache controllers.
> Documenting that this can be either a boolean, or accept a value (see
> below) could help.

So you think I should only add prefetch-data and prefetch-instr without
the arm prefix.
> 
>> +- arm,prefetch-instr : Enable instruction prefetch. Enabling prefetching
>> +  can improve performance.
>>  
>>  Example:
>>  
>> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
>> index e309c8f..1aa970a 100644
>> --- a/arch/arm/mm/cache-l2x0.c
>> +++ b/arch/arm/mm/cache-l2x0.c
>> @@ -1199,6 +1199,26 @@ static void __init l2c310_of_parse(const struct device_node *np,
>>  		pr_err("L2C-310 OF arm,prefetch-offset property value is missing\n");
>>  	}
>>  
>> +	ret = of_property_read_u32(np, "arm,prefetch-data", &val);
>> +	if (ret == 0) {
>> +		if (val)
>> +			prefetch |= L310_PREFETCH_CTRL_DATA_PREFETCH;
>> +		else
>> +			prefetch &= ~L310_PREFETCH_CTRL_DATA_PREFETCH;
>> +	} else if (ret != -EINVAL) {
>> +		pr_err("L2C-310 OF arm,prefetch-data property value is missing\n");
>> +	}
> 
> If we want to generalize the use of this property, there could indeed be
> a value associated with it, if the cache controller supports different
> pre-fetching strides, however this is not the cache for these cache
> controllers it seems, are not we going to show error messages more often
> than desired?
I did this so it is possible to deactivate the prefech mode. I do not
know if somebody wants to do that. I haven't understood how you suggest
I should change.
When you do not associate a value with an entry in device tree it is
there or not there, so we could only activate it when it was not
automatically detected, but we could not deactivate it, because the case
when this value is not specified in device tree would be, use to auto
detected the value.

Hauke
