From: emilio@elopez.com.ar (=?windows-1252?Q?Emilio_L=F3pez?=)
Date: Sun, 03 Aug 2014 19:11:36 -0300
Subject: [PATCH 6/9] clk: sunxi: mod1 clock support
In-Reply-To: <20140803124733.GW3952@lukather>
References: <1406842092-25207-1-git-send-email-emilio@elopez.com.ar>
 <1406842092-25207-7-git-send-email-emilio@elopez.com.ar>
 <20140803124733.GW3952@lukather>
Message-ID: <53DEB398.8010109@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 03/08/14 a las 09:47, Maxime Ripard escibi?:
> On Thu, Jul 31, 2014 at 06:28:09PM -0300, Emilio L?pez wrote:
>> The module 1 type of clocks consist of a gate and a mux and are used on
>> the audio blocks to mux and gate the PLL2 outputs for AC97, IIS or
>> SPDIF. This commit adds support for them on the sunxi clock driver.
>>
>> Not-signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
>
> Why so?
>
> It looks quite good.

Because I have not tested this with any actual mod1 clients. Once Jon or 
Marcus report it's ok I'll be happy to s/Not-s/S/; same with the DT 
bindings.

>> ---
>>
>> Changes from RFC:
>>   * Document compatible used
>>
>>   Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
>>   drivers/clk/sunxi/Makefile                        |  1 +
>>   drivers/clk/sunxi/clk-a10-mod1.c                  | 69 +++++++++++++++++++++++
>>   3 files changed, 71 insertions(+)
>>   create mode 100644 drivers/clk/sunxi/clk-a10-mod1.c
>>
>> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
>> index d18b89b..b028ee2 100644
>> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
>> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
>> @@ -50,6 +50,7 @@ Required properties:
>>   	"allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
>>   	"allwinner,sun4i-a10-codec-clk" - for the codec clock on A10
>>   	"allwinner,sun4i-a10-mod0-clk" - for the module 0 family of clocks
>> +	"allwinner,sun4i-a10-mod1-clk" - for the module 1 family of clocks
>>   	"allwinner,sun7i-a20-out-clk" - for the external output clocks
>>   	"allwinner,sun7i-a20-gmac-clk" - for the GMAC clock module on A20/A31
>>   	"allwinner,sun4i-a10-usb-clk" - for usb gates + resets on A10 / A20
>> diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
>> index a7a96f8..75d113d 100644
>> --- a/drivers/clk/sunxi/Makefile
>> +++ b/drivers/clk/sunxi/Makefile
>> @@ -5,6 +5,7 @@
>>   obj-y += clk-sunxi.o clk-factors.o
>>   obj-y += clk-a10-codec.o
>>   obj-y += clk-a10-hosc.o
>> +obj-y += clk-a10-mod1.o
>>   obj-y += clk-a10-pll2.o
>>   obj-y += clk-a20-gmac.o
>>
>> diff --git a/drivers/clk/sunxi/clk-a10-mod1.c b/drivers/clk/sunxi/clk-a10-mod1.c
>> new file mode 100644
>> index 0000000..09afd54
>> --- /dev/null
>> +++ b/drivers/clk/sunxi/clk-a10-mod1.c
>> @@ -0,0 +1,69 @@
>> +/*
>> + * Copyright 2014 Emilio L?pez
>> + *
>> + * Emilio L?pez <emilio@elopez.com.ar>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/clkdev.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +
>> +static DEFINE_SPINLOCK(mod1_lock);
>> +
>> +#define SUN4I_MOD1_ENABLE	31
>> +#define SUN4I_MOD1_MUX		16
>> +#define SUN4I_MOD1_MUX_WIDTH	2
>> +#define SUN4I_MOD1_MAX_PARENTS	4
>> +
>> +static void __init sun4i_mod1_clk_setup(struct device_node *node)
>> +{
>> +	struct clk *clk;
>> +	struct clk_mux *mux;
>> +	struct clk_gate *gate;
>> +	const char *parents[4];
>> +	const char *clk_name = node->name;
>> +	void __iomem *reg;
>> +	int i = 0;
>> +
>> +	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
>> +	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
>> +	if (!mux || !gate) {
>> +		kfree(mux);
>> +		kfree(gate);
>> +		return;
>> +	}
>> +
>> +	of_property_read_string(node, "clock-output-names", &clk_name);
>> +	reg = of_iomap(node, 0);
>> +
>> +	while (i < SUN4I_MOD1_MAX_PARENTS &&
>> +	       (parents[i] = of_clk_get_parent_name(node, i)) != NULL)
>> +		i++;
>> +
>> +	gate->reg = reg;
>> +	gate->bit_idx = SUN4I_MOD1_ENABLE;
>> +	gate->lock = &mod1_lock;
>> +	mux->reg = reg;
>> +	mux->shift = SUN4I_MOD1_MUX;
>> +	mux->mask = BIT(SUN4I_MOD1_MUX_WIDTH) - 1;
>> +	mux->lock = &mod1_lock;
>> +
>> +	clk = clk_register_composite(NULL, clk_name, parents, i,
>> +				     &mux->hw, &clk_mux_ops,
>> +				     NULL, NULL,
>> +				     &gate->hw, &clk_gate_ops, 0);

We'll probably need SET_RATE_PARENT here as well

>> +	if (!IS_ERR(clk))
>> +		of_clk_add_provider(node, of_clk_src_simple_get, clk);
>> +}
>> +CLK_OF_DECLARE(sun4i_mod1, "allwinner,sun4i-a10-mod1-clk", sun4i_mod1_clk_setup);
>
> Why are you not using clk-sunxi for this? It has pretty much
> everything in place to do so already.

If this were to have a rate component we could reuse the factors 
infrastructure, but it doesn't, as it's just a gate and a mux.

Cheers,

Emilio
