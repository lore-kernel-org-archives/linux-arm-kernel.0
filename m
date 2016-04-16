From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 Apr 2016 17:40:55 -0700
Subject: [RESEND PATCH v10 2/6] clk: hisilicon: add CRG driver for hi3519
 soc
In-Reply-To: <1459411811-12390-3-git-send-email-xuejiancheng@hisilicon.com>
References: <1459411811-12390-1-git-send-email-xuejiancheng@hisilicon.com>
 <1459411811-12390-3-git-send-email-xuejiancheng@hisilicon.com>
Message-ID: <20160416004055.GN26353@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/31, Jiancheng Xue wrote:
> diff --git a/drivers/clk/hisilicon/clk-hi3519.c b/drivers/clk/hisilicon/clk-hi3519.c
> new file mode 100644
> index 0000000..ee9df82
> --- /dev/null
> +++ b/drivers/clk/hisilicon/clk-hi3519.c
> @@ -0,0 +1,129 @@
> +/*
> + * Hi3519 Clock Driver
> + *
> + * Copyright (c) 2015-2016 HiSilicon Technologies Co., Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <dt-bindings/clock/hi3519-clock.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>

Please include <linux/clk-provider.h> here.

> +#include "clk.h"
> +#include "reset.h"
> +
> +#define HI3519_INNER_CLK_OFFSET	64
> +#define HI3519_FIXED_24M	65
> +#define HI3519_FIXED_50M	66
> +#define HI3519_FIXED_75M	67
> +#define HI3519_FIXED_125M	68
> +#define HI3519_FIXED_150M	69
> +#define HI3519_FIXED_200M	70
> +#define HI3519_FIXED_250M	71
> +#define HI3519_FIXED_300M	72
> +#define HI3519_FIXED_400M	73
> +#define HI3519_FMC_MUX		74
> +
> +#define HI3519_NR_CLKS		128
> +
> +static const struct hisi_fixed_rate_clock hi3519_fixed_rate_clks[] = {
> +	{ HI3519_FIXED_24M, "24m", NULL, CLK_IS_ROOT, 24000000, },
> +	{ HI3519_FIXED_50M, "50m", NULL, CLK_IS_ROOT, 50000000, },
> +	{ HI3519_FIXED_75M, "75m", NULL, CLK_IS_ROOT, 75000000, },
> +	{ HI3519_FIXED_125M, "125m", NULL, CLK_IS_ROOT, 125000000, },
> +	{ HI3519_FIXED_150M, "150m", NULL, CLK_IS_ROOT, 150000000, },
> +	{ HI3519_FIXED_200M, "200m", NULL, CLK_IS_ROOT, 200000000, },
> +	{ HI3519_FIXED_250M, "250m", NULL, CLK_IS_ROOT, 250000000, },
> +	{ HI3519_FIXED_300M, "300m", NULL, CLK_IS_ROOT, 300000000, },
> +	{ HI3519_FIXED_400M, "400m", NULL, CLK_IS_ROOT, 400000000, },

CLK_IS_ROOT is dead. Please remove it.

> +};
> +
> +static const char *const fmc_mux_p[] = {
> +		"24m", "75m", "125m", "150m", "200m", "250m", "300m", "400m", };
> +static u32 fmc_mux_table[] = {0, 1, 2, 3, 4, 5, 6, 7};
> +
> +static const struct hisi_mux_clock hi3519_mux_clks[] = {
> +	{ HI3519_FMC_MUX, "fmc_mux", fmc_mux_p, ARRAY_SIZE(fmc_mux_p),
> +		CLK_SET_RATE_PARENT, 0xc0, 2, 3, 0, fmc_mux_table, },
> +};
> +
> +static const struct hisi_gate_clock hi3519_gate_clks[] = {
> +	{ HI3519_FMC_CLK, "clk_fmc", "fmc_mux",
> +		CLK_SET_RATE_PARENT, 0xc0, 1, 0, },
> +	{ HI3519_UART0_CLK, "clk_uart0", "24m",
> +		CLK_SET_RATE_PARENT, 0xe4, 20, 0, },
> +	{ HI3519_UART1_CLK, "clk_uart1", "24m",
> +		CLK_SET_RATE_PARENT, 0xe4, 21, 0, },
> +	{ HI3519_UART2_CLK, "clk_uart2", "24m",
> +		CLK_SET_RATE_PARENT, 0xe4, 22, 0, },
> +	{ HI3519_UART3_CLK, "clk_uart3", "24m",
> +		CLK_SET_RATE_PARENT, 0xe4, 23, 0, },
> +	{ HI3519_UART4_CLK, "clk_uart4", "24m",
> +		CLK_SET_RATE_PARENT, 0xe4, 24, 0, },
> +	{ HI3519_SPI0_CLK, "clk_spi0", "50m",
> +		CLK_SET_RATE_PARENT, 0xe4, 16, 0, },
> +	{ HI3519_SPI1_CLK, "clk_spi1", "50m",
> +		CLK_SET_RATE_PARENT, 0xe4, 17, 0, },
> +	{ HI3519_SPI2_CLK, "clk_spi2", "50m",
> +		CLK_SET_RATE_PARENT, 0xe4, 18, 0, },
> +};
> +
> +static int hi3519_clk_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct hisi_clock_data *clk_data;
> +
> +	clk_data = hisi_clk_init(np, HI3519_NR_CLKS);
> +	if (!clk_data)
> +		return -ENODEV;
> +
> +	hisi_clk_register_fixed_rate(hi3519_fixed_rate_clks,
> +				     ARRAY_SIZE(hi3519_fixed_rate_clks),
> +				     clk_data);
> +	hisi_clk_register_mux(hi3519_mux_clks, ARRAY_SIZE(hi3519_mux_clks),
> +					clk_data);
> +	hisi_clk_register_gate(hi3519_gate_clks,
> +			ARRAY_SIZE(hi3519_gate_clks), clk_data);
> +
> +	return hisi_reset_init(np);

Now that this is a platform driver we need to do lots of cleanup
in error cases. I mean we need to unregister clks, OF clk
providers, and reset controllers. Please add all that code too.

> +}
> +
> +static const struct of_device_id hi3519_clk_match_table[] = {
> +	{ .compatible = "hisilicon,hi3519-crg" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, hi3519_clk_match_table);
> +
> +static struct platform_driver hi3519_clk_driver = {
> +	.probe          = hi3519_clk_probe,
> +	.driver         = {
> +		.name   = "hi3519-clk",
> +		.of_match_table = hi3519_clk_match_table,
> +	},
> +};
> +
> +static int __init hi3519_clk_init(void)
> +{
> +	return platform_driver_register(&hi3519_clk_driver);
> +}
> +core_initcall(hi3519_clk_init);
> +
> +static void __exit hi3519_clk_exit(void)
> +{
> +	platform_driver_unregister(&hi3519_clk_driver);
> +}
> +module_exit(hi3519_clk_exit);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("HiSilicon Hi3519 Clock Driver");
> diff --git a/drivers/clk/hisilicon/reset.c b/drivers/clk/hisilicon/reset.c
> new file mode 100644
> index 0000000..8035366
> --- /dev/null
> +++ b/drivers/clk/hisilicon/reset.c
> @@ -0,0 +1,124 @@
> +/*
> + * Hisilicon Reset Controller Driver
> + *
> + * Copyright (c) 2015-2016 HiSilicon Technologies Co., Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +#include <linux/reset-controller.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>

Please add #include "reset.h"

> +
> +#define	HISI_RESET_BIT_MASK	0x1f
> +#define	HISI_RESET_OFFSET_SHIFT	8
> +#define	HISI_RESET_OFFSET_MASK	0xffff00
[..]
> +static int hisi_reset_deassert(struct reset_controller_dev *rcdev,
> +				unsigned long id)
> +{
> +	struct hisi_reset_controller *rstc = to_hisi_reset_controller(rcdev);
> +	unsigned long flags;
> +	u32 offset, reg;
> +	u8 bit;
> +
> +	offset = (id & HISI_RESET_OFFSET_MASK) >> HISI_RESET_OFFSET_SHIFT;
> +	bit = id & HISI_RESET_BIT_MASK;
> +
> +	spin_lock_irqsave(&rstc->lock, flags);
> +
> +	reg = readl(rstc->membase + offset);
> +	writel(reg & ~BIT(bit), rstc->membase + offset);
> +
> +	spin_unlock_irqrestore(&rstc->lock, flags);
> +
> +	return 0;
> +}
> +
> +static struct reset_control_ops hisi_reset_ops = {

const? I think that's required now.

> +	.assert		= hisi_reset_assert,
> +	.deassert	= hisi_reset_deassert,
> +};
> +
> +int hisi_reset_init(struct device_node *np)
> +{
> +	struct hisi_reset_controller *rstc;
> +
> +	rstc = kzalloc(sizeof(*rstc), GFP_KERNEL);
> +	if (!rstc)
> +		return -ENOMEM;
> +
> +	rstc->membase = of_iomap(np, 0);
> +	if (!rstc->membase)
> +		return -EINVAL;

memory leak of rstc here.

> +
> +	spin_lock_init(&rstc->lock);
> +
> +	rstc->rcdev.owner = THIS_MODULE;
> +	rstc->rcdev.ops = &hisi_reset_ops;
> +	rstc->rcdev.of_node = np;
> +	rstc->rcdev.of_reset_n_cells = 2;
> +	rstc->rcdev.of_xlate = hisi_reset_of_xlate;
> +
> +	return reset_controller_register(&rstc->rcdev);
> +}
> +EXPORT_SYMBOL_GPL(hisi_reset_init);
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
