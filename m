From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 29 May 2015 11:35:15 -0700
Subject: [PATCH v3] ARM: l2c: add options to overwrite prefetching behavior
In-Reply-To: <5568B044.80600@gmail.com>
References: <1431726751-9169-1-git-send-email-hauke@hauke-m.de>
 <5568A745.7020502@gmail.com> <5568ABEF.3040001@hauke-m.de>
 <5568B044.80600@gmail.com>
Message-ID: <5568B163.60206@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/05/15 11:30, Florian Fainelli wrote:
> On 29/05/15 11:11, Hauke Mehrtens wrote:
>>
>>
>> On 05/29/2015 07:52 PM, Florian Fainelli wrote:
>>> On 15/05/15 14:52, Hauke Mehrtens wrote:
>>>> These options make it possible to overwrites the data and instruction
>>>> prefetching behavior of the arm pl310 cache controller.
>>>>
>>>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>>>> ---
>>>> v2: only set prefetch
>>>> v1: set prefetch and aux
>>>>
>>>>  Documentation/devicetree/bindings/arm/l2cc.txt |  4 ++++
>>>>  arch/arm/mm/cache-l2x0.c                       | 20 ++++++++++++++++++++
>>>>  2 files changed, 24 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
>>>> index 0dbabe9..528821a 100644
>>>> --- a/Documentation/devicetree/bindings/arm/l2cc.txt
>>>> +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
>>>> @@ -67,6 +67,10 @@ Optional properties:
>>>>    disable if zero.
>>>>  - arm,prefetch-offset : Override prefetch offset value. Valid values are
>>>>    0-7, 15, 23, and 31.
>>>> +- arm,prefetch-data : Enable data prefetch. Enabling prefetching
>>>> +  can improve performance.
>>>
>>> I do not think the "can improve performance" has a place in a binding,
>>> this is either not technical enough about what this does, or marketing
>>> enough it does not buy us much.
>>>
>>> data/instruction pre-fetching are commonly found on cache controller
>>> these days, so I would be tempted to remove the "arm," prefixing here
>>> since this can be generalized to other kinds of cache controllers.
>>> Documenting that this can be either a boolean, or accept a value (see
>>> below) could help.
>>
>> So you think I should only add prefetch-data and prefetch-instr without
>> the arm prefix.
> 
> That's what I think yes, others may disagree.
> 
>>>
>>>> +- arm,prefetch-instr : Enable instruction prefetch. Enabling prefetching
>>>> +  can improve performance.
>>>>  
>>>>  Example:
>>>>  
>>>> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
>>>> index e309c8f..1aa970a 100644
>>>> --- a/arch/arm/mm/cache-l2x0.c
>>>> +++ b/arch/arm/mm/cache-l2x0.c
>>>> @@ -1199,6 +1199,26 @@ static void __init l2c310_of_parse(const struct device_node *np,
>>>>  		pr_err("L2C-310 OF arm,prefetch-offset property value is missing\n");
>>>>  	}
>>>>  
>>>> +	ret = of_property_read_u32(np, "arm,prefetch-data", &val);
>>>> +	if (ret == 0) {
>>>> +		if (val)
>>>> +			prefetch |= L310_PREFETCH_CTRL_DATA_PREFETCH;
>>>> +		else
>>>> +			prefetch &= ~L310_PREFETCH_CTRL_DATA_PREFETCH;
>>>> +	} else if (ret != -EINVAL) {
>>>> +		pr_err("L2C-310 OF arm,prefetch-data property value is missing\n");
>>>> +	}
>>>
>>> If we want to generalize the use of this property, there could indeed be
>>> a value associated with it, if the cache controller supports different
>>> pre-fetching strides, however this is not the cache for these cache
>>> controllers it seems, are not we going to show error messages more often
>>> than desired?
>> I did this so it is possible to deactivate the prefech mode. I do not
>> know if somebody wants to do that. I haven't understood how you suggest
>> I should change.
>> When you do not associate a value with an entry in device tree it is
>> there or not there, so we could only activate it when it was not
>> automatically detected, but we could not deactivate it, because the case
>> when this value is not specified in device tree would be, use to auto
>> detected the value.
> 
> My point is that you use of_read_property_u32, but your example does not
> state what should be the value associated with this property in the
> binding, so it is unclear what are the results without looking at the
> code between these examples:
> 
> /* Enable data pre-fetching */
> #1 arm,data-prefetch;
> #2 arm,data-prefetch = <1>;
> 
> /* Disable data pre-fetching */
> #3 arm,data-prefetch = <0>;
> 
> /* do nothing, empty aka retain existing settings set by firmware */
> #4
> 
> Based on the code, only #2 and #3 are intended, which raises the
> question, do not we want of_read_property_bool() instead then? The
> binding does seem to suggest that only #1 and #4 are valid though.

I re-read the code, and I think if you just clarify the values in the
binding to be: 0 (forcibly disable), 1 (forcibly enable), property
absent (retain settings), this would be crystal clear.

Thanks!
-- 
Florian
