From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Jun 2013 17:49:54 +0200
Subject: [PATCH 21/21] clk: ux500: Supply provider look-up functionality
 to support Device Tree
In-Reply-To: <1370266965-7901-22-git-send-email-lee.jones@linaro.org>
References: <1370266965-7901-1-git-send-email-lee.jones@linaro.org>
 <1370266965-7901-22-git-send-email-lee.jones@linaro.org>
Message-ID: <2458719.gboIs9CIQE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 June 2013 14:42:45 Lee Jones wrote:
> In this patch we're populating a clk_data array, one clock per element to
> act as a clk look-up using indexes supplied from Device Tree.

This is the first time I actually take a closer look at clock bindings.
It feels odd to have a single index when you have multiple clock
providers in hardware.

> +struct clk *clks[CLK_MAX];
> +
> +const static struct of_device_id u8500_clk_of_match[] = {
> +	{ .compatible = "stericsson,u8500-clk", },
> +	{ },
> +};

>From the code in drivers/clk/ux500, I would have expected two separate
clock nodes: the prcmu and the prcc, each with their own number
space.

>  void u8500_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
>  		    u32 clkrst5_base, u32 clkrst6_base)
>  {
>  	struct prcmu_fw_version *fw_version;
>  	const char *sgaclk_parent = NULL;
> +	static struct clk_onecell_data clk_data;
> +	struct device_node *np = NULL;
>  	struct clk *clk;
>  
>  	/* Clock sources */
>  	clk = clk_reg_prcmu_gate("soc0_pll", NULL, PRCMU_PLLSOC0,
>  				CLK_IS_ROOT|CLK_IGNORE_UNUSED);
>  	clk_register_clkdev(clk, "soc0_pll", NULL);
> +	clks[soc0_pll] = clk;
>  
>  	clk = clk_reg_prcmu_gate("soc1_pll", NULL, PRCMU_PLLSOC1,
>  				CLK_IS_ROOT|CLK_IGNORE_UNUSED);
>  	clk_register_clkdev(clk, "soc1_pll", NULL);
> +	clks[soc1_pll] = clk;
>  
>  	clk = clk_reg_prcmu_gate("ddr_pll", NULL, PRCMU_PLLDDR,
>  				CLK_IS_ROOT|CLK_IGNORE_UNUSED);
>  	clk_register_clkdev(clk, "ddr_pll", NULL);
> +	clks[ddr_pll] = clk;

It seems the actual numbers for the PCRMU clocks are defined
in drivers/mfd/dbx500-prcmu-regs.h, at PRCM_ACLK_MGT through
PRCM_MSP1CLK_MGT, where each clock has its own register.

> @@ -218,106 +296,130 @@ void u8500_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
>  	clk = clk_reg_prcc_pclk("p1_pclk0", "per1clk", clkrst1_base,
>  				BIT(0), 0);
>  	clk_register_clkdev(clk, "apb_pclk", "uart0");
> +	clks[uart0] = clk;
>  
>  	clk = clk_reg_prcc_pclk("p1_pclk1", "per1clk", clkrst1_base,
>  				BIT(1), 0);
>  	clk_register_clkdev(clk, "apb_pclk", "uart1");
> +	clks[uart1] = clk;
>  
>  	clk = clk_reg_prcc_pclk("p1_pclk2", "per1clk", clkrst1_base,
>  				BIT(2), 0);
>  	clk_register_clkdev(clk, "apb_pclk", "nmk-i2c.1");
> +	clks[nmk_i2c1] = clk;

The prcc clocks are inherently numbered, there is a set of six
registers with 8 bits each, so the number you use can simply
be the index from 0 to 48, or use #clock-cells=<2> and pass both.
Using the same numbers as the hardware in the binding is much less
ambiguous than making up your own number space that you have to
then document in the binding and update every time a new chip
gets released.

	Arnd
