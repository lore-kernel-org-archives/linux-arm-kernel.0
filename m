From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 May 2017 18:37:09 -0700
Subject: [PATCH 03/11] clk: bcm: Add clocks for Stingray SOC
In-Reply-To: <1494071686-19098-4-git-send-email-anup.patel@broadcom.com>
References: <1494071686-19098-1-git-send-email-anup.patel@broadcom.com>
 <1494071686-19098-4-git-send-email-anup.patel@broadcom.com>
Message-ID: <20170519013709.GD20170@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06, Anup Patel wrote:
> From: Sandeep Tripathy <sandeep.tripathy@broadcom.com>
> 
> This patch adds support for Stingray clocks in iproc
> ccf. The Stingray SOC has various plls based on iproc
> pll architecture.
> 

Does it have anything besides PLLs?

> +CLK_OF_DECLARE(sr_genpll0_clk, "brcm,sr-genpll0",
> +				sr_genpll0_clk_init);
> +
> +static const struct iproc_pll_ctrl genpll3 = {
> +	.flags = IPROC_CLK_AON | IPROC_CLK_PLL_HAS_NDIV_FRAC |
> +		IPROC_CLK_PLL_NEEDS_SW_CFG,
> +	.aon = AON_VAL(0x0, 1, 19, 18),
> +	.reset = RESET_VAL(0x0, 12, 11),
> +	.dig_filter = DF_VAL(0x0, 4, 3, 0, 4, 7, 3),
> +	.sw_ctrl = SW_CTRL_VAL(0x10, 31),
> +	.ndiv_int = REG_VAL(0x10, 20, 10),
> +	.ndiv_frac = REG_VAL(0x10, 0, 20),
> +	.pdiv = REG_VAL(0x14, 0, 4),
> +	.status = REG_VAL(0x30, 12, 1),
> +};
> +
> +static const struct iproc_clk_ctrl genpll3_clk[] = {
> +	[BCM_SR_GENPLL3_HSLS_CLK] = {
> +		.channel = BCM_SR_GENPLL3_HSLS_CLK,
> +		.flags = IPROC_CLK_AON,
> +		.enable = ENABLE_VAL(0x4, 6, 0, 12),
> +		.mdiv = REG_VAL(0x18, 0, 9),
> +	},
> +	[BCM_SR_GENPLL3_SDIO_CLK] = {
> +		.channel = BCM_SR_GENPLL3_SDIO_CLK,
> +		.flags = IPROC_CLK_AON,
> +		.enable = ENABLE_VAL(0x4, 7, 1, 13),
> +		.mdiv = REG_VAL(0x18, 10, 9),
> +	},
> +};
> +
> +static void __init sr_genpll3_clk_init(struct device_node *node)
> +{
> +	iproc_pll_clk_setup(node, &genpll3, NULL, 0, genpll3_clk,
> +				ARRAY_SIZE(genpll3_clk));
> +}
> +CLK_OF_DECLARE(sr_genpll3_clk, "brcm,sr-genpll3",
> +			sr_genpll3_clk_init);

Can you make this a platform driver instead? Are all these clks
really used for getting the interrupt and timers running?

> +
> +static const struct iproc_pll_ctrl genpll4 = {
> +	.flags = IPROC_CLK_AON | IPROC_CLK_PLL_HAS_NDIV_FRAC |
> +		IPROC_CLK_PLL_NEEDS_SW_CFG,
> +	.aon = AON_VAL(0x0, 1, 25, 24),
> +	.reset = RESET_VAL(0x0, 12, 11),
> +	.dig_filter = DF_VAL(0x0, 4, 3, 0, 4, 7, 3),
> +	.sw_ctrl = SW_CTRL_VAL(0x10, 31),
> +	.ndiv_int = REG_VAL(0x10, 20, 10),
> +	.ndiv_frac = REG_VAL(0x10, 0, 20),
> +	.pdiv = REG_VAL(0x14, 0, 4),
> +	.status = REG_VAL(0x30, 12, 1),
> +};
> +
> +static const struct iproc_clk_ctrl genpll4_clk[] = {
> +	[BCM_SR_GENPLL4_CCN_CLK] = {
> +		.channel = BCM_SR_GENPLL4_CCN_CLK,
> +		.flags = IPROC_CLK_AON,
> +		.enable = ENABLE_VAL(0x4, 6, 0, 12),
> +		.mdiv = REG_VAL(0x18, 0, 9),
> +	},
> +};
> +

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
