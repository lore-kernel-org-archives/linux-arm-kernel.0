From: yixun.lan@amlogic.com (Yixun Lan)
Date: Thu, 30 Nov 2017 14:01:18 +0800
Subject: [PATCH v3 2/3] clk: meson-axg: add clock controller drivers
In-Reply-To: <20171129193433.GA19419@codeaurora.org>
References: <20171128125330.363-1-yixun.lan@amlogic.com>
 <20171128125330.363-3-yixun.lan@amlogic.com>
 <20171129193433.GA19419@codeaurora.org>
Message-ID: <d2b58c06-93dc-4368-501e-4b8bdc9a4c34@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen

On 11/30/17 03:34, Stephen Boyd wrote:
> On 11/28, Yixun Lan wrote:
>> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
>> new file mode 100644
>> index 000000000000..51c5b4062715
>> --- /dev/null
>> +++ b/drivers/clk/meson/axg.c
>> @@ -0,0 +1,948 @@
>> +/*
>> + * AmLogic Meson-AXG Clock Controller Driver
>> + *
>> + * Copyright (c) 2016 Baylibre SAS.
>> + * Author: Michael Turquette <mturquette@baylibre.com>
>> + *
>> + * Copyright (c) 2017 Amlogic, inc.
>> + * Author: Qiufang Dai <qiufang.dai@amlogic.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0+
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/init.h>
>> +
>> +#include "clkc.h"
>> +#include "axg.h"
>> +
>> +static DEFINE_SPINLOCK(clk_lock);
> 
> meson_axg_clk_lock?
> 
em... I'd leave it unchanged

because the spinlock will be used at macro MESON_GATE() [1] which
defined at drivers/clk/meson/clkc.h, and it assume using the generic
name 'clk_lock', change name will break the code..

and besides it's already defined as static, so I see no problem here


[1]
#define MESON_GATE(_name, _reg, _bit)                                   \
struct clk_gate _name = {                                               \
        .reg = (void __iomem *) _reg,                                   \
        .bit_idx = (_bit),                                              \
        .lock = &clk_lock,

[2]
drivers/clk/meson/gxbb.c
drivers/clk/meson/meson8b.c

>> +
>> +static const struct pll_rate_table sys_pll_rate_table[] = {
>> +	PLL_RATE(24000000, 56, 1, 2),
>> +	PLL_RATE(48000000, 64, 1, 2),
>> +	PLL_RATE(72000000, 72, 1, 2),
>> +	PLL_RATE(96000000, 64, 1, 2),
>> +	PLL_RATE(120000000, 80, 1, 2),
>> +	PLL_RATE(144000000, 96, 1, 2),
>> +	PLL_RATE(168000000, 56, 1, 1),
>> +	PLL_RATE(192000000, 64, 1, 1),
>> +	PLL_RATE(216000000, 72, 1, 1),
>> +	PLL_RATE(240000000, 80, 1, 1),
> [...]
>> +
>> +static const struct clkc_data axg_clkc_data = {
>> +	.clk_gates = axg_clk_gates,
>> +	.clk_gates_count = ARRAY_SIZE(axg_clk_gates),
>> +	.clk_mplls = axg_clk_mplls,
>> +	.clk_mplls_count = ARRAY_SIZE(axg_clk_mplls),
>> +	.clk_plls = axg_clk_plls,
>> +	.clk_plls_count = ARRAY_SIZE(axg_clk_plls),
>> +	.clk_muxes = axg_clk_muxes,
>> +	.clk_muxes_count = ARRAY_SIZE(axg_clk_muxes),
>> +	.clk_dividers = axg_clk_dividers,
>> +	.clk_dividers_count = ARRAY_SIZE(axg_clk_dividers),
>> +	.hw_onecell_data = &axg_hw_onecell_data,
>> +};
>> +
>> +static const struct of_device_id clkc_match_table[] = {
>> +	{ .compatible = "amlogic,axg-clkc", .data = &axg_clkc_data },
>> +	{},
> 
> Nitpick: Drop the comma. Nothing comes after this.
> 
sure, can do

>> +};
>> +
>> +static int axg_clkc_probe(struct platform_device *pdev)
>> +{
>> +	const struct clkc_data *clkc_data;
>> +	void __iomem *clk_base;
>> +	int ret, clkid, i;
>> +	struct device *dev = &pdev->dev;
>> +
>> +	clkc_data = of_device_get_match_data(&pdev->dev);
>> +	if (!clkc_data)
>> +		return -EINVAL;
>> +
>> +	/*  Generic clocks and PLLs */
>> +	clk_base = of_iomap(dev->of_node, 0);
> 
> Use platform device APIs for ioremapping?
> 
I assume you are referring to 'platform_get_resource +
devm_ioremap_resource' ?

the idea sounds good to me.


>> +	if (!clk_base) {
>> +		pr_err("%s: Unable to map clk base\n", __func__);
>> +		return -ENXIO;
>> +	}
>> +
>> +	/* Populate base address for PLLs */
>> +	for (i = 0; i < clkc_data->clk_plls_count; i++)
>> +		clkc_data->clk_plls[i]->base = clk_base;
>> +
>> +	/* Populate base address for MPLLs */
>> +	for (i = 0; i < clkc_data->clk_mplls_count; i++)
>> +		clkc_data->clk_mplls[i]->base = clk_base;
>> +
>> +	/* Populate base address for gates */
>> +	for (i = 0; i < clkc_data->clk_gates_count; i++)
>> +		clkc_data->clk_gates[i]->reg = clk_base +
>> +			(u64)clkc_data->clk_gates[i]->reg;
>> +
>> +	/* Populate base address for muxes */
>> +	for (i = 0; i < clkc_data->clk_muxes_count; i++)
>> +		clkc_data->clk_muxes[i]->reg = clk_base +
>> +			(u64)clkc_data->clk_muxes[i]->reg;
>> +
>> +	/* Populate base address for dividers */
>> +	for (i = 0; i < clkc_data->clk_dividers_count; i++)
>> +		clkc_data->clk_dividers[i]->reg = clk_base +
>> +			(u64)clkc_data->clk_dividers[i]->reg;
>> +
>> +	/*
>> +	 * register all clks
>> +	 */
> 
> Yes, that's obvious..
> 
will drop at next version

>> +	for (clkid = 0; clkid < clkc_data->hw_onecell_data->num; clkid++) {
>> +		/* array might be sparse */
>> +		if (!clkc_data->hw_onecell_data->hws[clkid])
>> +			continue;
>> +
>> +		ret = devm_clk_hw_register(dev,
>> +					clkc_data->hw_onecell_data->hws[clkid]);
>> +		if (ret)
>> +			goto iounmap;
>> +	}
>> +
>> +	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
>> +			clkc_data->hw_onecell_data);
>> +
>> +iounmap:
>> +	iounmap(clk_base);
can also drop this once convert to devm_ API

>> +	return ret;
>> +}
>> +
>> +static struct platform_driver axg_driver = {
>> +	.probe		= axg_clkc_probe,
>> +	.driver		= {
>> +		.name	= "axg-clkc",
>> +		.of_match_table = clkc_match_table,
>> +	},
>> +};
>> +
>> +builtin_platform_driver(axg_driver);
>> diff --git a/include/dt-bindings/clock/axg-clkc.h b/include/dt-bindings/clock/axg-clkc.h
>> new file mode 100644
>> index 000000000000..d2c0f49ba0df
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/axg-clkc.h
>> @@ -0,0 +1,72 @@
>> +/*
>> + * Meson-AXG clock tree IDs
>> + *
>> + * Copyright (c) 2017 Amlogic, Inc. All rights reserved.
>> + *
>> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> 
> There's a standard way to add these it seems. They should be the
> first line in the file and look like
> 
> /* SPDX-License-Identifier: */
> 
> for header files and 
> 
> // SPDX-License-Identifier: 
> 
> for C files.
> 

thanks for the suggestion, will update at next version
