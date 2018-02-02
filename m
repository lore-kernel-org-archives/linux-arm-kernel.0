From: david@lechnology.com (David Lechner)
Date: Fri, 2 Feb 2018 11:56:08 -0600
Subject: [PATCH v6 18/41] clk: davinci: New driver for TI DA8XX CFGCHIP
 clocks
In-Reply-To: <c2138795-edcd-bb7d-094d-47dc049c33df@ti.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-19-git-send-email-david@lechnology.com>
 <c2138795-edcd-bb7d-094d-47dc049c33df@ti.com>
Message-ID: <af157fd3-f1da-cf17-8b1a-47223ac3fd39@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/2018 07:19 AM, Sekhar Nori wrote:
> On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
>> +static const struct clk_ops da8xx_cfgchip_div4p5_clk_ops = {
>> +	.enable		= da8xx_cfgchip_gate_clk_enable,
>> +	.disable	= da8xx_cfgchip_gate_clk_disable,
>> +	.is_enabled	= da8xx_cfgchip_gate_clk_is_enabled,
> 
> I assume the reason for not using clk-gate.c is lack of regmap support
> there?

Correct.

I couldn't find a way to get a lock from the regmap that could
be passed to clk_register_gate() to prevent non-clock drivers from
trying to use the regmap at the same the the clocks are.

> 
>> +	.recalc_rate	= da8xx_cfgchip_div4p5_recalc_rate,
>> +};
>> +
>> +static struct clk * __init
>> +da8xx_cfgchip_gate_clk_register(const struct da8xx_cfgchip_gate_clk_info *info,
>> +				const char *parent_name,
>> +				struct regmap *regmap)
>> +{
>> +	struct da8xx_cfgchip_gate_clk *gate;
>> +	struct clk_init_data init;
>> +
>> +	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
>> +	if (!gate)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	init.name = info->name;
>> +	if (info->flags & DA8XX_GATE_CLOCK_IS_DIV4P5)
>> +		init.ops = &da8xx_cfgchip_div4p5_clk_ops;
>> +	else
>> +		init.ops = &da8xx_cfgchip_gate_clk_ops;
> 
> This will be easier to read using ternary operator, I think. But you
> will probably have line breaks.

The names are so long that the ternary operator doesn't make it better IMHO.

	init.ops = (info->flags & DA8XX_GATE_CLOCK_IS_DIV4P5) ?
		&da8xx_cfgchip_div4p5_clk_ops :
		&da8xx_cfgchip_gate_clk_ops;
