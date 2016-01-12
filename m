From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 12 Jan 2016 14:12:11 -0800
Subject: [PATCH v5 1/6] clk: hisilicon: add CRG driver for hi3519 soc
In-Reply-To: <1452219400-32478-2-git-send-email-xuejiancheng@huawei.com>
References: <1452219400-32478-1-git-send-email-xuejiancheng@huawei.com>
 <1452219400-32478-2-git-send-email-xuejiancheng@huawei.com>
Message-ID: <20160112221211.GB22188@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08, Jiancheng Xue wrote:
> diff --git a/drivers/clk/hisilicon/Kconfig b/drivers/clk/hisilicon/Kconfig
> index e434854..b6baebf 100644
> --- a/drivers/clk/hisilicon/Kconfig
> +++ b/drivers/clk/hisilicon/Kconfig
> @@ -1,3 +1,10 @@
> +config COMMON_CLK_HI3519
> +	tristate "Clock Driver for Hi3519"

It looks like this has to be bool. Otherwise it needs to be a
platform driver and the hisilicon APIs need to be exported and
lose their __init markings.

> +	depends on ARCH_HISI
> +	default y
> +	help
> +	  Build the clock driver for hi3519.
> +
>  config COMMON_CLK_HI6220
>  	bool "Hi6220 Clock Driver"
>  	depends on ARCH_HISI || COMPILE_TEST
> diff --git a/drivers/clk/hisilicon/clk-hi3519.c b/drivers/clk/hisilicon/clk-hi3519.c
> new file mode 100644
> index 0000000..72d3a7b0
> --- /dev/null
> +++ b/drivers/clk/hisilicon/clk-hi3519.c
> @@ -0,0 +1,105 @@
> +
> +#define HI3519_FIXED_24M	(HI3519_EXT_CLKS + 1)
> +#define HI3519_FIXED_50M	(HI3519_EXT_CLKS + 2)
> +#define HI3519_FIXED_75M	(HI3519_EXT_CLKS + 3)
> +#define HI3519_FIXED_125M	(HI3519_EXT_CLKS + 4)
> +#define HI3519_FIXED_150M	(HI3519_EXT_CLKS + 5)
> +#define HI3519_FIXED_200M	(HI3519_EXT_CLKS + 6)
> +#define HI3519_FIXED_250M	(HI3519_EXT_CLKS + 7)
> +#define HI3519_FIXED_300M	(HI3519_EXT_CLKS + 8)
> +#define HI3519_FIXED_400M	(HI3519_EXT_CLKS + 9)
> +#define HI3519_FMC_MUX		(HI3519_EXT_CLKS + 10)
> +
> +#define HI3519_NR_CLKS	128

Is this the same clock provider as the external clocks? I don't
understand why we're offsetting the clock numbering if we have
different providers. And if these are truly fixed clocks (except
for the mux) perhaps they're not even provided by this hardware
block, and are clocks that come from the board? If that's true
then I would expect them to be described in DT as fixed rate
clocks.

> +
> +static struct hisi_fixed_rate_clock hi3519_fixed_rate_clks[] __initdata = {
> +	{ HI3519_FIXED_3M, "3m", NULL, CLK_IS_ROOT, 3000000, },
> +	{ HI3519_FIXED_24M, "24m", NULL, CLK_IS_ROOT, 24000000, },
> +	{ HI3519_FIXED_50M, "50m", NULL, CLK_IS_ROOT, 50000000, },
> +	{ HI3519_FIXED_75M, "75m", NULL, CLK_IS_ROOT, 75000000, },
> +	{ HI3519_FIXED_125M, "125m", NULL, CLK_IS_ROOT, 125000000, },
> +	{ HI3519_FIXED_150M, "150m", NULL, CLK_IS_ROOT, 150000000, },
> +	{ HI3519_FIXED_200M, "200m", NULL, CLK_IS_ROOT, 200000000, },
> +	{ HI3519_FIXED_250M, "250m", NULL, CLK_IS_ROOT, 250000000, },
> +	{ HI3519_FIXED_300M, "300m", NULL, CLK_IS_ROOT, 300000000, },
> +	{ HI3519_FIXED_400M, "400m", NULL, CLK_IS_ROOT, 400000000, },
> +};
> +
> +static const char *fmc_mux_p[] __initconst = {

const char * const ?

> +		"24m", "75m", "125m", "150m", "200m", "250m", "300m", "400m", };
> +static u32 fmc_mux_table[] = {0, 1, 2, 3, 4, 5, 6, 7};
> +
> +static struct hisi_mux_clock hi3519_mux_clks[] __initdata = {
> +	{ HI3519_FMC_MUX, "fmc_mux", fmc_mux_p, ARRAY_SIZE(fmc_mux_p),
> +		CLK_SET_RATE_PARENT, 0xc0, 2, 3, 0, fmc_mux_table, },
> +};
> +
> +static struct hisi_gate_clock hi3519_gate_clks[] __initdata = {

We should look into making these things const.

> +	/* fmc */
> +	{ HI3519_FMC_CLK, "clk_fmc", "fmc_mux",
> +		CLK_SET_RATE_PARENT, 0xc0, 1, 0, },
> +	/* uart */
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
> +static void __init hi3519_clk_init(struct device_node *np)
> +{
> +	struct hisi_clock_data *clk_data;
> +
> +
> +	clk_data = hisi_clk_init(np, HI3519_NR_CLKS);
> +	if (!clk_data)
> +		return;
> +
> +	hisi_clk_register_fixed_rate(hi3519_fixed_rate_clks,
> +				     ARRAY_SIZE(hi3519_fixed_rate_clks),
> +				     clk_data);
> +	hisi_clk_register_mux(hi3519_mux_clks, ARRAY_SIZE(hi3519_mux_clks),
> +					clk_data);
> +	hisi_clk_register_gate(hi3519_gate_clks,
> +			ARRAY_SIZE(hi3519_gate_clks), clk_data);
> +
> +	hisi_reset_init(np);
> +}
> +
> +CLK_OF_DECLARE(hi3519_clk, "hisilicon,hi3519-crg", hi3519_clk_init);
> diff --git a/drivers/clk/hisilicon/reset.h b/drivers/clk/hisilicon/reset.h
> new file mode 100644
> index 0000000..37856089
> --- /dev/null
> +++ b/drivers/clk/hisilicon/reset.h
> @@ -0,0 +1,32 @@
> +/*
> + * Copyright (c) 2015 HiSilicon Technologies Co., Ltd.
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
> +#ifndef	__HISI_RESET_H
> +#define	__HISI_RESET_H
> +
> +#include <linux/of.h>

Drop this include and forward declare struct device_node instead.

> +
> +#ifdef CONFIG_RESET_CONTROLLER
> +int __init hisi_reset_init(struct device_node *np);

We don't need __init in header files.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
