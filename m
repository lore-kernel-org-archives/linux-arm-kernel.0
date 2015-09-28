From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 28 Sep 2015 11:44:28 +0200
Subject: [PATCH v2] power: reset: at91-shdwc: add new shutdown controller
 driver
In-Reply-To: <20150924110652.GW4287@piout.net>
References: <20150922135925.GI23334@earth>
 <1442937472-5481-1-git-send-email-nicolas.ferre@atmel.com>
 <20150924110652.GW4287@piout.net>
Message-ID: <56090BFC.10006@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 24/09/2015 13:06, Alexandre Belloni a ?crit :
> On 22/09/2015 at 17:57:52 +0200, Nicolas Ferre wrote :
>> +config POWER_RESET_AT91_SHDWC
> 
> Maybe we should start numbering, at91-poweroff is already a driver for
> an shdwc.
> 
>> +#define SLOW_CLOCK_FREQ	32768
>> +
> 
> The slow clock is an input to the shdwc, then you have to get it,
> prepare and enable it. The you could use clk_get_rate.

Okay, sure: I modify the driver to take your enhancements into account.

> By duplicating the driver, you are repeating mistakes from the past ;)

Hey! look at the common parts that these drivers would share if it was
merged and you would realize that it was not worth the effort: I tried
and judged it was completely pointless.

>> +static void at91_poweroff(void)
>> +{
>> +	BUG_ON(!at91_shdwc);
> 
> Is that condition even possible?

No it's not. I remove it.

> 
>> +
>> +	writel(AT91_SHDW_KEY | AT91_SHDW_SHDW,
>> +			at91_shdwc->at91_shdwc_base + AT91_SHDW_CR);
> 
> This is not properly aligned.

Why? I prefer it like this and the second line doesn't cross the 80
column so I presume that it's valid.

> 
>> +}
>> +
>> +static u32 at91_shdwc_debouncer_value(struct platform_device *pdev,
>> +				      u32 in_period_us)
>> +{
>> +	int i;
>> +	int max_idx = ARRAY_SIZE(sdwc_dbc_period) - 1;
>> +	unsigned long long period_us;
>> +	unsigned long long max_period_us = DBC_PERIOD_US(sdwc_dbc_period[max_idx]);
>> +
>> +	if (in_period_us > max_period_us) {
>> +		dev_warn(&pdev->dev,
>> +			 "debouncer period %u too big, reduced to %llu us\n",
>> +			 in_period_us, max_period_us);
>> +		return max_idx;
>> +	}
>> +
>> +	for (i = max_idx - 1; i > 0; i--) {
>> +		period_us = DBC_PERIOD_US(sdwc_dbc_period[i]);
>> +		dev_dbg(&pdev->dev, "%s: ref[%d] = %llu\n",
>> +						__func__, i, period_us);
> ditto
> 
> 
>> +		if (in_period_us > period_us)
>> +			break;
>> +	}
>> +
>> +	return i + 1;
>> +}
>> +
>> +static u32 at91_shdwc_get_wakeup_input(struct platform_device *pdev,
>> +				       struct device_node *np)
>> +{
>> +	struct device_node *cnp;
>> +	const char *pm;
>> +	u32 wk_input_mask;
>> +	u32 wuir = 0;
>> +	u32 wk_input;
>> +
>> +	for_each_child_of_node(np, cnp) {
>> +		if (of_property_read_u32(cnp, "reg", &wk_input)) {
>> +			dev_warn(&pdev->dev, "reg property is missing for %s\n",
>> +				 cnp->full_name);
>> +			continue;
>> +		}
>> +
>> +		wk_input_mask = 1 << wk_input;
>> +		if (!(wk_input_mask & AT91_SHDW_WKUPEN_MASK)) {
>> +			dev_warn(&pdev->dev,
>> +				 "wake-up input %d out of bounds ignore\n",
>> +				 wk_input);
>> +			continue;
>> +		}
>> +		wuir |= wk_input_mask;
>> +
>> +		if (!of_property_read_string(cnp, "atmel,wakeup-type", &pm)) {
>> +			if (!strcasecmp(pm, "high"))
>> +				/*
>> +				 * only add a type if "high" is specified. Low
>> +				 * is the default.
>> +				 */
>> +				wuir |= AT91_SHDW_WKUPT(wk_input);
>> +		}
>> +		dev_dbg(&pdev->dev, "%s: (child %d) wuir = %#x\n",
>> +						__func__, wk_input, wuir);
> 
> ditto
> 
>> +static int at91_shdwc_probe(struct platform_device *pdev)
>> +{
>> +	struct resource *res;
>> +	const struct of_device_id *match;
>> +
>> +	if (!pdev->dev.of_node)
>> +		return -ENODEV;
>> +
>> +	at91_shdwc = devm_kzalloc(&pdev->dev, sizeof(*at91_shdwc), GFP_KERNEL);
>> +	if (!at91_shdwc)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, at91_shdwc);
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	at91_shdwc->at91_shdwc_base = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(at91_shdwc->at91_shdwc_base)) {
>> +		dev_err(&pdev->dev, "Could not map reset controller address\n");
>> +		return PTR_ERR(at91_shdwc->at91_shdwc_base);
>> +	}
>> +
>> +	match = of_match_node(at91_shdwc_of_match, pdev->dev.of_node);
>> +	if (match != NULL)
> 
> match will never be NULL, else you wouldn't be probed. You can remove that test.

I'll remove this and repost the driver as v3.

Thanks, bye,
-- 
Nicolas Ferre
