From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 11 Jan 2018 21:21:06 +0800
Subject: [linux-sunxi] [PATCH 1/7] pinctrl: sunxi: add support for pin
 controllers without bus gate
In-Reply-To: <ef82983f-6f91-46c2-1f67-7d4efc10c905@arm.com>
References: <20180106042326.46519-1-icenowy@aosc.io>
 <ef82983f-6f91-46c2-1f67-7d4efc10c905@arm.com>
Message-ID: <3A97A26E-0774-4279-B7B9-8312225E2C72@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?1?11? GMT+08:00 ??7:48:40, Andre Przywara <andre.przywara@arm.com> ??:
>Hi,
>
>another take to avoid this patch at all, I just remembered this from an
>IRC discussion before:
>
>On 06/01/18 04:23, Icenowy Zheng wrote:
>> The Allwinner H6 pin controllers (both the main one and the CPUs one)
>> have no bus gate clocks.
>
>I don't think this is true. The pin controller *needs* an APB clock,
>it's just not gate-able or not exposed or documented.
>The "system bus tree" on page 90 in the manual shows that the "GPIO"
>block is located on the APB1 bus.
>So can't we just reference this apb clock directly? That would be much
>cleaner, "more" correct and require less changes: "The best patch is no
>patch":

I can accept this. (In fact I have considered this, but
I don't dare to directly use bus clock in a device, as it's not
exported before.

Maxime, Chen-Yu, can you agree the following code?

>
>	clocks = <&ccu APB1>, <&osc24M>, <&osc32k>;
>	/* or whatever this APB clock is actually called. */
>	clock-names = "apb", "hosc", "losc";
>
>Cheers,
>Andre.
>
>> 
>> Add support for this kind of pin controllers.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 30
>++++++++++++++++++++----------
>>  drivers/pinctrl/sunxi/pinctrl-sunxi.h |  1 +
>>  2 files changed, 21 insertions(+), 10 deletions(-)
>> 
>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> index 4b6cb25bc796..68cd505679d9 100644
>> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> @@ -1182,7 +1182,12 @@ static int sunxi_pinctrl_setup_debounce(struct
>sunxi_pinctrl *pctl,
>>  	unsigned int hosc_div, losc_div;
>>  	struct clk *hosc, *losc;
>>  	u8 div, src;
>> -	int i, ret;
>> +	int i, ret, clk_count;
>> +
>> +	if (pctl->desc->without_bus_gate)
>> +		clk_count = 2;
>> +	else
>> +		clk_count = 3;
>>  
>>  	/* Deal with old DTs that didn't have the oscillators */
>>  	if (of_count_phandle_with_args(node, "clocks", "#clock-cells") !=
>3)
>> @@ -1360,15 +1365,19 @@ int sunxi_pinctrl_init_with_variant(struct
>platform_device *pdev,
>>  			goto gpiochip_error;
>>  	}
>>  
>> -	clk = devm_clk_get(&pdev->dev, NULL);
>> -	if (IS_ERR(clk)) {
>> -		ret = PTR_ERR(clk);
>> -		goto gpiochip_error;
>> -	}
>> +	if (!desc->without_bus_gate) {
>> +		clk = devm_clk_get(&pdev->dev, NULL);
>> +		if (IS_ERR(clk)) {
>> +			ret = PTR_ERR(clk);
>> +			goto gpiochip_error;
>> +		}
>>  
>> -	ret = clk_prepare_enable(clk);
>> -	if (ret)
>> -		goto gpiochip_error;
>> +		ret = clk_prepare_enable(clk);
>> +		if (ret)
>> +			goto gpiochip_error;
>> +	} else {
>> +		clk = NULL;
>> +	}
>>  
>>  	pctl->irq = devm_kcalloc(&pdev->dev,
>>  				 pctl->desc->irq_banks,
>> @@ -1425,7 +1434,8 @@ int sunxi_pinctrl_init_with_variant(struct
>platform_device *pdev,
>>  	return 0;
>>  
>>  clk_error:
>> -	clk_disable_unprepare(clk);
>> +	if (clk)
>> +		clk_disable_unprepare(clk);
>>  gpiochip_error:
>>  	gpiochip_remove(pctl->chip);
>>  	return ret;
>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
>b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
>> index 11b128f54ed2..ccb6230f0bb5 100644
>> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
>> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
>> @@ -113,6 +113,7 @@ struct sunxi_pinctrl_desc {
>>  	unsigned			irq_bank_base;
>>  	bool				irq_read_needs_mux;
>>  	bool				disable_strict_mode;
>> +	bool				without_bus_gate;
>>  };
>>  
>>  struct sunxi_pinctrl_function {
>> 
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
