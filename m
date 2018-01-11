From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 11 Jan 2018 10:41:39 +0000
Subject: [linux-sunxi] [PATCH 1/7] pinctrl: sunxi: add support for pin
 controllers without bus gate
In-Reply-To: <08CB03C2-1253-4072-B8AC-D3F1253C8A85@aosc.io>
References: <20180106042326.46519-1-icenowy@aosc.io>
 <2ca1ee96-8dc6-c80b-ae11-45895d6a8484@arm.com>
 <08CB03C2-1253-4072-B8AC-D3F1253C8A85@aosc.io>
Message-ID: <7c3b4294-117a-c293-03d4-a35a823a796e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/01/18 10:15, Icenowy Zheng wrote:
> 
> 
> ? 2018?1?11? GMT+08:00 ??6:08:19, Andre Przywara <andre.przywara@arm.com> ??:
>> Hi,
>>
>> On 06/01/18 04:23, Icenowy Zheng wrote:
>>> The Allwinner H6 pin controllers (both the main one and the CPUs one)
>>> have no bus gate clocks.
>>>
>>> Add support for this kind of pin controllers.
>>>
>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>> ---
>>>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 30
>> ++++++++++++++++++++----------
>>>  drivers/pinctrl/sunxi/pinctrl-sunxi.h |  1 +
>>>  2 files changed, 21 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>>> index 4b6cb25bc796..68cd505679d9 100644
>>> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>>> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>>> @@ -1182,7 +1182,12 @@ static int sunxi_pinctrl_setup_debounce(struct
>> sunxi_pinctrl *pctl,
>>>  	unsigned int hosc_div, losc_div;
>>>  	struct clk *hosc, *losc;
>>>  	u8 div, src;
>>> -	int i, ret;
>>> +	int i, ret, clk_count;
>>> +
>>> +	if (pctl->desc->without_bus_gate)
>>> +		clk_count = 2;
>>> +	else
>>> +		clk_count = 3;
>>>  
>>>  	/* Deal with old DTs that didn't have the oscillators */
>>>  	if (of_count_phandle_with_args(node, "clocks", "#clock-cells") !=
>> 3)

Just spotted: I guess you wanted to compare against that computed value
here?
But I wonder if we can get rid of this check at all? Don't we rely on
clock-names and input-debounce anyway? So we will bail out later anyway
if the DT does not have those?
Why do we need this check then?

>>> @@ -1360,15 +1365,19 @@ int sunxi_pinctrl_init_with_variant(struct
>> platform_device *pdev,
>>>  			goto gpiochip_error;
>>>  	}
>>>  
>>> -	clk = devm_clk_get(&pdev->dev, NULL);
>>> -	if (IS_ERR(clk)) {
>>> -		ret = PTR_ERR(clk);
>>> -		goto gpiochip_error;
>>> -	}
>>> +	if (!desc->without_bus_gate) {
>>
>> Do we really need explicit support for that case?
>> Can't we have something that works automatically?
> 
> It can be a sanity check. When a SoC comes with bus gate
> support but no apb is provided, there's something wrong.
> 
>>
>> if (node has clock-names property)		(A)
>> 	use clocks as enumerated and named there
>> else if (node has one clock reference)		(B)
>> 	use this as gate clock, no debounce support
>> else if (node has no clock property at all)	(C)
>> 	no gate clock needed, no debounce support
> 
> This should not happen in practice, as no gate clock is implemented
> after debounce.

But still you seem to somewhat support it with your changes above - by
bailing out if there aren't two clocks.
This kind of explicitly checking for a certain number of clocks sounds
not very robust and future proof to me, hence the suggestion to get rid
of it.

Cheers,
Andre.

>>
>> On top of that we should add the clock-names property to all DTs, even
>> for those with only a "apb" clock. Shouldn't hurt existing kernels.
>> Possibly even add debounce support for those on the way, if applicable.
>>
>> So we would just support case (B) and (C) for legacy reasons.
>>
>> Does that make sense?
>>
>> Cheers,
>> Andre.
>>
>>> +		clk = devm_clk_get(&pdev->dev, NULL);
>>> +		if (IS_ERR(clk)) {
>>> +			ret = PTR_ERR(clk);
>>> +			goto gpiochip_error;
>>> +		}
>>>  
>>> -	ret = clk_prepare_enable(clk);
>>> -	if (ret)
>>> -		goto gpiochip_error;
>>> +		ret = clk_prepare_enable(clk);
>>> +		if (ret)
>>> +			goto gpiochip_error;
>>> +	} else {
>>> +		clk = NULL;
>>> +	}
>>>  
>>>  	pctl->irq = devm_kcalloc(&pdev->dev,
>>>  				 pctl->desc->irq_banks,
>>> @@ -1425,7 +1434,8 @@ int sunxi_pinctrl_init_with_variant(struct
>> platform_device *pdev,
>>>  	return 0;
>>>  
>>>  clk_error:
>>> -	clk_disable_unprepare(clk);
>>> +	if (clk)
>>> +		clk_disable_unprepare(clk);
>>>  gpiochip_error:
>>>  	gpiochip_remove(pctl->chip);
>>>  	return ret;
>>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
>> b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
>>> index 11b128f54ed2..ccb6230f0bb5 100644
>>> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
>>> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
>>> @@ -113,6 +113,7 @@ struct sunxi_pinctrl_desc {
>>>  	unsigned			irq_bank_base;
>>>  	bool				irq_read_needs_mux;
>>>  	bool				disable_strict_mode;
>>> +	bool				without_bus_gate;
>>>  };
>>>  
>>>  struct sunxi_pinctrl_function {
>>>
