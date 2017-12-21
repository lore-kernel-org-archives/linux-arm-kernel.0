From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Dec 2017 15:56:14 -0800
Subject: [PATCH v2 3/3] clk: actions: Add clock driver for Actions S900 SoC
In-Reply-To: <1509997552-29718-4-git-send-email-manivannan.sadhasivam@linaro.org>
References: <1509997552-29718-1-git-send-email-manivannan.sadhasivam@linaro.org>
 <1509997552-29718-4-git-send-email-manivannan.sadhasivam@linaro.org>
Message-ID: <20171221235614.GG7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07, Manivannan Sadhasivam wrote:
> diff --git a/drivers/clk/actions/Kconfig b/drivers/clk/actions/Kconfig
> new file mode 100644
> index 0000000..0de7a03
> --- /dev/null
> +++ b/drivers/clk/actions/Kconfig
> @@ -0,0 +1,6 @@
> +config CLK_OWL_S900
> +	bool "Clock Driver for Actions S900 SoC"

Can it be a module too? Otherwise drop module.h and anything that
does to the driver.

> +	depends on ARCH_ACTIONS || COMPILE_TEST

Can you try compiling this with COMPILE_TEST=y and
ARCH_ACTIONS=n? It may be that drivers/clk/Makefile needs to be
obj-y and then the owl-clk, owl-pll, owl-factor files need to be
compiled only when CONFIG_CLK_OWL_S900 is y. If there becomes
more than one actions driver, then the clk, pll, factor files
will need to be compiled with some new CLK_ACTIONS kconfig symbol
or something.


> +	default ARCH_ACTIONS
> +	help
> +	  Build the clock driver for Actions S900 SoC.
> diff --git a/drivers/clk/actions/Makefile b/drivers/clk/actions/Makefile
> new file mode 100644
> index 0000000..83bef30
> --- /dev/null
> +++ b/drivers/clk/actions/Makefile
> @@ -0,0 +1,2 @@
> +obj-y				+= owl-clk.o owl-pll.o owl-factor.o
> +obj-$(CONFIG_CLK_OWL_S900)	+= owl-s900.o
> diff --git a/drivers/clk/actions/owl-s900.c b/drivers/clk/actions/owl-s900.c
> new file mode 100644
> index 0000000..51e297f
> --- /dev/null
> +++ b/drivers/clk/actions/owl-s900.c
> @@ -0,0 +1,585 @@
> +/*
> + * Copyright (c) 2014 Actions Semi Inc.
> + * Author: David Liu <liuwei@actions-semi.com>
> + *
> + * Copyright (c) 2017 Linaro Ltd.
> + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */

Can you move to the SPDX tags please?

> +	COMP_DIV_CLK(CLK_UART3, "uart3", 0,
> +			C_MUX(uart_clk_mux_p, CMU_UART3CLK, 16, 1, 0),
> +			C_GATE(CMU_DEVCLKEN1, 19, 0),
> +			C_DIVIDER(CMU_UART3CLK, 0, 8, NULL, CLK_DIVIDER_ROUND_CLOSEST)),
> +
> +	COMP_DIV_CLK(CLK_UART4, "uart4", 0,
> +			C_MUX(uart_clk_mux_p, CMU_UART4CLK, 16, 1, 0),
> +			C_GATE(CMU_DEVCLKEN1, 20, 0),
> +			C_DIVIDER(CMU_UART4CLK, 0, 8, NULL, CLK_DIVIDER_ROUND_CLOSEST)),
> +
> +	COMP_DIV_CLK(CLK_UART5, "uart5", 0,
> +			C_MUX(uart_clk_mux_p, CMU_UART5CLK, 16, 1, 0),
> +			C_GATE(CMU_DEVCLKEN1, 21, 0),
> +			C_DIVIDER(CMU_UART5CLK, 0, 8, NULL, CLK_DIVIDER_ROUND_CLOSEST)),
> +
> +	COMP_DIV_CLK(CLK_UART6, "uart6", 0,
> +			C_MUX(uart_clk_mux_p, CMU_UART6CLK, 16, 1, 0),
> +			C_GATE(CMU_DEVCLKEN1, 18, 0),
> +			C_DIVIDER(CMU_UART6CLK, 0, 8, NULL, CLK_DIVIDER_ROUND_CLOSEST)),
> +
> +	COMP_FACTOR_CLK(CLK_VCE, "vce", 0,
> +			C_MUX(vce_clk_mux_p, CMU_VCECLK, 4, 2, 0),
> +			C_GATE(CMU_DEVCLKEN0, 26, 0),
> +			C_FACTOR(CMU_VCECLK, 0, 3, bisp_factor_table, 0)),
> +
> +	COMP_FACTOR_CLK(CLK_VDE, "vde", 0,
> +			C_MUX(hde_clk_mux_p, CMU_VDECLK, 4, 2, 0),
> +			C_GATE(CMU_DEVCLKEN0, 25, 0),
> +			C_FACTOR(CMU_VDECLK, 0, 3, bisp_factor_table, 0)),
> +};
> +
> +static int s900_clk_probe(struct platform_device *pdev)
> +{
> +	struct owl_clk_provider *ctx;
> +	struct device_node *np = pdev->dev.of_node;
> +	struct resource *res;
> +	void __iomem *base;
> +	int i;
> +
> +	ctx = kzalloc(sizeof(struct owl_clk_provider) +
> +			sizeof(*ctx->clk_data.hws) * CLK_NR_CLKS, GFP_KERNEL);

It would be nice to avoid this. If the structs can all be
configured properly, it should be possible to have an array of
clk_hw pointers that are registered directly with
clk_hw_register(), and then index directly into that array to
return clk_hw pointers for the clk_hw provider function.

> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	for (i = 0; i < CLK_NR_CLKS; ++i)
> +		ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
> +
> +	ctx->reg_base = base;
> +	ctx->clk_data.num = CLK_NR_CLKS;

Hopefully CLK_NR_CLKS isn't coming from the DT header file.

> +	spin_lock_init(&ctx->lock);
> +
> +	/* register pll clocks */
> +	owl_clk_register_pll(ctx, s900_pll_clks,
> +			ARRAY_SIZE(s900_pll_clks));
> +
> +	/* register divider clocks */
> +	owl_clk_register_divider(ctx, s900_div_clks,
> +			ARRAY_SIZE(s900_div_clks));
> +
> +	/* register factor divider clocks */
> +	owl_clk_register_factor(ctx, s900_factor_clks,
> +			ARRAY_SIZE(s900_factor_clks));
> +
> +	/* register mux clocks */
> +	owl_clk_register_mux(ctx, s900_mux_clks,
> +			ARRAY_SIZE(s900_mux_clks));
> +
> +	/* register gate clocks */
> +	owl_clk_register_gate(ctx, s900_gate_clks,
> +			ARRAY_SIZE(s900_gate_clks));
> +
> +	/* register composite clocks */
> +	owl_clk_register_composite(ctx, s900_composite_clks,
> +			ARRAY_SIZE(s900_composite_clks));
> +
> +	return of_clk_add_hw_provider(np, of_clk_hw_onecell_get,
> +				&ctx->clk_data);
> +
> +}
> +
> +static const struct of_device_id s900_clk_of_match[] = {
> +	{ .compatible = "actions,s900-cmu", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, s900_clk_of_match);

This isn't necessary? It's not a module?

> +
> +static struct platform_driver s900_clk_driver = {
> +	.probe = s900_clk_probe,
> +	.driver = {
> +		.name = "s900-cmu",
> +		.of_match_table = s900_clk_of_match,

You need to supress_bind_attrs here or implement the remove
function for this driver that would unregister all the clks and
provider.

> +	},

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
