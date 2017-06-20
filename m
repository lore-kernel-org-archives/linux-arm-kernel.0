From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 19 Jun 2017 18:41:37 -0700
Subject: [PATCH V1 8/9] clk: sprd: add clocks support for SC9860
In-Reply-To: <20170618015855.27738-9-chunyan.zhang@spreadtrum.com>
References: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
 <20170618015855.27738-9-chunyan.zhang@spreadtrum.com>
Message-ID: <20170620014137.GK4493@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18, Chunyan Zhang wrote:
> diff --git a/drivers/clk/sprd/Makefile b/drivers/clk/sprd/Makefile
> index c593a93..0d90b40 100644
> --- a/drivers/clk/sprd/Makefile
> +++ b/drivers/clk/sprd/Makefile
> @@ -1,3 +1,4 @@
>  ifneq ($(CONFIG_OF),)
>  obj-y	+= ccu_common.o ccu_gate.o ccu_mux.o ccu_div.o ccu_composite.o ccu_pll.o
> +obj-y	+= ccu-sc9860.o

And a Kconfig for this SoC specific driver.

>  endif
> diff --git a/drivers/clk/sprd/ccu-sc9860.c b/drivers/clk/sprd/ccu-sc9860.c
> new file mode 100644
> index 0000000..6cd4dc5
> --- /dev/null
> +++ b/drivers/clk/sprd/ccu-sc9860.c
> +
> +static CLK_FIXED_FACTOR(fac_4m,		"fac-4m",	"ext-26m",
> +			6, 1, CLK_IS_BASIC);
> +static CLK_FIXED_FACTOR(fac_2m,		"fac-2m",	"ext-26m",
> +			13, 1, CLK_IS_BASIC);
> +static CLK_FIXED_FACTOR(fac_1m,		"fac-1m",	"ext-26m",
> +			26, 1, CLK_IS_BASIC);
> +static CLK_FIXED_FACTOR(fac_250k,	"fac-250k",	"ext-26m",
> +			104, 1, CLK_IS_BASIC);
> +static CLK_FIXED_FACTOR(fac_rpll0_26m,	"rpll0-26m",	"ext-26m",
> +			1, 1, CLK_IS_BASIC);
> +static CLK_FIXED_FACTOR(fac_rpll1_26m,	"rpll1-26m",	"ext-26m",
> +			1, 1, CLK_IS_BASIC);
> +static CLK_FIXED_FACTOR(fac_rco_25m,	"rco-25m",	"ext-rc0-100m",
> +			4, 1, CLK_IS_BASIC);
> +static CLK_FIXED_FACTOR(fac_rco_4m,	"rco-4m",	"ext-rc0-100m",
> +			25, 1, CLK_IS_BASIC);
> +static CLK_FIXED_FACTOR(fac_rco_2m,	"rco-2m",	"ext-rc0-100m",
> +			50, 1, CLK_IS_BASIC);
> +static CLK_FIXED_FACTOR(fac_3k2,	"fac-3k2",	"ext-32k",
> +			10, 1, CLK_IS_BASIC);
> +static CLK_FIXED_FACTOR(fac_1k,		"fac-1k",	"ext-32k",
> +			32, 1, CLK_IS_BASIC);
> +
> +#define SC9860_GATE_FLAGS (CLK_IGNORE_UNUSED | CLK_IS_BASIC)

No CLK_IS_BASIC. Why is everything marked as CLK_IGNORE_UNUSED?

> +static SPRD_CCU_GATE(rpll0_gate,	"rpll0-gate",	"ext-26m", 0x402b016c,
> +		     0x1000, BIT(2), SC9860_GATE_FLAGS, 0);
> +static SPRD_CCU_GATE(rpll1_gate,	"rpll1-gate",	"ext-26m", 0x402b016c,
> +		     0x1000, BIT(18), SC9860_GATE_FLAGS, 0);
> +static SPRD_CCU_GATE(mpll0_gate,	"mpll0-gate",	"ext-26m", 0x402b00b0,
> +		     0x1000, BIT(2), SC9860_GATE_FLAGS, 0);
> +static SPRD_CCU_GATE(mpll1_gate,	"mpll1-gate",	"ext-26m", 0x402b00b0,
> +		     0x1000, BIT(18), SC9860_GATE_FLAGS, 0);
> +static SPRD_CCU_GATE(dpll0_gate,	"dpll0-gate",	"ext-26m", 0x402b00b4,
> +		     0x1000, BIT(2), SC9860_GATE_FLAGS, 0);
> +static SPRD_CCU_GATE(dpll1_gate,	"dpll1-gate",	"ext-26m", 0x402b00b4,
> +		     0x1000, BIT(18), SC9860_GATE_FLAGS, 0);
> +static SPRD_CCU_GATE(gpll_gate,		"gpll-gate",	"ext-26m", 0x402b032c,
> +		     0x1000, BIT(0), SC9860_GATE_FLAGS,
> +		     CLK_GATE_SET_TO_DISABLE);
> +static SPRD_CCU_GATE(cppll_gate,	"cppll-gate",	"ext-26m", 0x402b02b4,
> +		     0x1000, BIT(2), SC9860_GATE_FLAGS, 0);
> +static SPRD_CCU_GATE(ltepll0_gate,	"ltepll0-gate",	"ext-26m", 0x402b00b8,
> +		     0x1000, BIT(2), SC9860_GATE_FLAGS, 0);
> +static SPRD_CCU_GATE(ltepll1_gate,	"ltepll1-gate",	"ext-26m", 0x402b010c,
> +		     0x1000, BIT(2), SC9860_GATE_FLAGS, 0);
> +static SPRD_CCU_GATE(twpll_gate,	"twpll-gate",	"ext-26m", 0x402b00bc,
> +		     0x1000, BIT(2), SC9860_GATE_FLAGS, 0);
> +static SPRD_CCU_GATE_NO_PARENT(sdio0_2x_en,	"sdio0-2x-en",	0x402e013c,
> +			       0x1000, BIT(2), SC9860_GATE_FLAGS, 0);
> +static SPRD_CCU_GATE_NO_PARENT(sdio0_1x_en,	"sdio0-1x-en",	0x402e013c,
> +			       0x1000, BIT(3), SC9860_GATE_FLAGS, 0);
> +static SPRD_CCU_GATE_NO_PARENT(sdio1_2x_en,	"sdio1-2x-en",	0x402e013c,
> +			       0x1000, BIT(4), SC9860_GATE_FLAGS, 0);
> +static SPRD_CCU_GATE_NO_PARENT(sdio1_1x_en,	"sdio1-1x-en",	0x402e013c,
> +			       0x1000, BIT(5), SC9860_GATE_FLAGS, 0);
> +static SPRD_CCU_GATE_NO_PARENT(sdio2_2x_en,	"sdio2-2x-en",	0x402e013c,
> +			       0x1000, BIT(6), SC9860_GATE_FLAGS, 0);
> +static SPRD_CCU_GATE_NO_PARENT(sdio2_1x_en,	"sdio2-1x-en",	0x402e013c,
> +			       0x1000, BIT(7), SC9860_GATE_FLAGS, 0);
> +static SPRD_CCU_GATE_NO_PARENT(emmc_1x_en,	"emmc-1x-en",	0x402e013c,
> +			       0x1000, BIT(8), SC9860_GATE_FLAGS, 0);
> +static SPRD_CCU_GATE_NO_PARENT(emmc_2x_en,	"emmc-2x-en",	0x402e013c,
> +			       0x1000, BIT(9), SC9860_GATE_FLAGS, 0);
> +
> +/* GPLL/LPLL/DPLL/RPLL/CPLL */
> +static const u64 const itable1[4] = {3, 780000000, 988000000, 1196000000};
> +
> +/* TWPLL/MPLL0/MPLL1 */
> +static const u64 itable2[4] = {3, 1638000000, 2080000000, 2600000000UL};
> +
> +static const struct ccu_bit_field const f_rpll[PLL_FACT_MAX] = {
> +	{ .shift = 0,	.width = 1 },	/* lock_done	*/
> +	{ .shift = 3,	.width = 1 },	/* div_s	*/
> +	{ .shift = 80,	.width = 1 },	/* mod_en	*/

Are they even shifts? Or offsets from some base? I have to go
back and read the other patch.

> +	{ .shift = 81,	.width = 1 },	/* sdm_en	*/
> +	{ .shift = 0,	.width = 0 },	/* refin	*/
> +	{ .shift = 14,	.width = 2 },	/* ibias	*/
> +	{ .shift = 16,	.width = 7 },	/* n		*/
> +	{ .shift = 4,	.width = 7 },	/* nint		*/
> +	{ .shift = 32,	.width = 23},	/* kint		*/
> +	{ .shift = 0,	.width = 0 },	/* prediv	*/
> +	{ .shift = 0,	.width = 0 },	/* postdiv	*/
> +};
> +static const u32 const regs_rpll0[4] = { 3, 0x44, 0x48, 0x4c };
> +static SPRD_CCU_PLL_WITH_ITABLE(rpll0_clk, "rpll0", "rpll0-gate", 0x40400044,
> +				regs_rpll0, itable1, 200, f_rpll);
> +
> +static const u32 const regs_rpll1[4] = { 3, 0x50, 0x54, 0x58 };
> +static SPRD_CCU_PLL_WITH_ITABLE(rpll1_clk, "rpll1", "rpll1-gate", 0x40400050,
> +				regs_rpll1, itable1, 200, f_rpll);
> +
> +static const struct ccu_bit_field const f_mpll0[PLL_FACT_MAX] = {
[...]
> diff --git a/include/dt-bindings/clock/sc9860-ccu.h b/include/dt-bindings/clock/sc9860-ccu.h
> new file mode 100644
> index 0000000..dd7ccf9
> --- /dev/null
> +++ b/include/dt-bindings/clock/sc9860-ccu.h
> @@ -0,0 +1,19 @@
> +/*
> + * Spreadtrum SC9860 platform clocks
> + *
> + * Copyright (C) 2017, Spreadtrum Communications Inc.
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_SC9860_CCU_H_
> +#define _DT_BINDINGS_CLK_SC9860_CCU_H_
> +
> +#define CLK_FAC_1M	2
> +#define CLK_EMMC_2X_EN	29
> +#define CLK_L0_409M6	60
> +#define CLK_EMMC_2X	88
> +#define CLK_EMMC_EB	158

Why are only a handful exposed in the header file? Not exposing
everything is mostly a maintenance nightmare right now.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
