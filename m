From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 7 Sep 2010 01:09:31 +0200
Subject: [PATCH 13/74] ST SPEAr: Update clock framework and definitions
In-Reply-To: <a15d1fca5a6e663c1fee4602013b6160512eb2dd.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<a15d1fca5a6e663c1fee4602013b6160512eb2dd.1283161023.git.viresh.kumar@st.com>
Message-ID: <20100906230931.GF8153@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  
>  /* array of all spear 13xx clock lookups */
> @@ -327,18 +749,58 @@ static struct clk_lookup spear_clk_lookups[] = {
>  	/* clock derived from pll1 clk */
>  	{.con_id = "cpu_clk",		.clk = &cpu_clk},
>  	{.con_id = "ahb_clk",		.clk = &ahb_clk},
> -	{ .con_id = "apb_clk",		.clk = &apb_clk},
> +	{.con_id = "apb_clk",		.clk = &apb_clk},
> +
how about use macro here to simplify the code

+#define CLKDEV_ID(__clk) { .con_id = #__clk, .clk = &(__clk) }
and 
+#define CLKDEV_ID_CLK(__clk) { .con_id = #__clk, .clk = &(__clk##_clk) }
> +	/* synthesizers/prescaled clocks */
> +	{.con_id = "pll1div2_clk",		.clk = &pll1div2_clk},
> +	{.con_id = "pll1div4_clk",		.clk = &pll1div4_clk},
> +	{.con_id = "c3_synth_clk",		.clk = &c3_synth_clk},
> +	{.con_id = "gmii_txclk123_pad_clk",	.clk = &gmii_txclk125_pad},
> +	{.con_id = "clcd_synth_clk",		.clk = &clcd_synth_clk},
> +	{.con_id = "uart_synth_clk",		.clk = &uart_synth_clk},
> +	{.con_id = "sd_synth_clk",		.clk = &sd_synth_clk},
> +	{.con_id = "cfxd_synth_clk",		.clk = &cfxd_synth_clk},
> +	{.con_id = "gmac_phy_input_clk",	.clk = &gmac_phy_input_clk},
> +	{.con_id = "gmac_phy_synth_clk",	.clk = &gmac_phy_synth_clk},
> +	{.con_id = "gmac_phy_clk",		.clk = &gmac_phy_clk},
>  
>  	/* clocks having multiple parent source from above clocks */
> -	{.dev_id = "uart",		.clk = &uart_clk},
> +	{.dev_id = "clcd",		.clk = &clcd_clk},
>  	{.dev_id = "gpt0",		.clk = &gpt0_clk},
>  	{.dev_id = "gpt1",		.clk = &gpt1_clk},
>  	{.dev_id = "gpt2",		.clk = &gpt2_clk},
>  	{.dev_id = "gpt3",		.clk = &gpt3_clk},
> +	{.dev_id = "uart",		.clk = &uart_clk},
>  
> -	/* clock derived from ahb/apb clk */
> -	{ .dev_id = "smi",		.clk = &smi_clk},
> -	{ .dev_id = "wdt",		.clk = &wdt_clk},
> +	/* clock derived from ahb clk */
> +	{.dev_id = "smi",		.clk = &smi_clk},
> +	{.dev_id = "uhci0",		.clk = &uhci0_clk},
> +	{.dev_id = "uhci1",		.clk = &uhci1_clk},
> +	{.dev_id = "usbd",		.clk = &usbd_clk},
> +	{.dev_id = "i2c",		.clk = &i2c_clk},
> +	{.dev_id = "dma0",		.clk = &dma0_clk},
> +	{.dev_id = "dma1",		.clk = &dma1_clk},
> +	{.dev_id = "jpeg",		.clk = &jpeg_clk},
> +	{.dev_id = "gmac",		.clk = &gmac_clk},
> +	{.dev_id = "c3",		.clk = &c3_clk},
> +	{.dev_id = "pcie0",		.clk = &pcie0_clk},
> +	{.dev_id = "pcie1",		.clk = &pcie1_clk},
> +	{.dev_id = "pcie2",		.clk = &pcie2_clk},
> +	{.dev_id = "cfxd",		.clk = &cfxd_clk},
> +	{.dev_id = "sd",		.clk = &sd_clk},
> +	{.dev_id = "fsmc",		.clk = &fsmc_clk},
> +	{.dev_id = "sysram0",		.clk = &sysram0_clk},
> +	{.dev_id = "sysram1",		.clk = &sysram1_clk},
> +
> +	/* clock derived from apb clk */
> +	{.dev_id = "i2s0",		.clk = &i2s0_clk},
> +	{.dev_id = "i2s1",		.clk = &i2s1_clk},
> +	{.dev_id = "adc",		.clk = &adc_clk},
> +	{.dev_id = "ssp",		.clk = &ssp_clk},
> +	{.dev_id = "gpio0",		.clk = &gpio0_clk},
> +	{.dev_id = "gpio1",		.clk = &gpio1_clk},
> +	{.dev_id = "kbd",		.clk = &kbd_clk},
> +	{.dev_id = "wdt",		.clk = &wdt_clk},
>  };
>  
>  void __init clk_init(void)
> diff --git a/arch/arm/mach-spear13xx/include/mach/misc_regs.h b/arch/arm/mach-spear13xx/include/mach/misc_regs.h
> index 2e87a07..c4dcab2 100644
> --- a/arch/arm/mach-spear13xx/include/mach/misc_regs.h
> +++ b/arch/arm/mach-spear13xx/include/mach/misc_regs.h
how about clock.h header?
> @@ -36,12 +36,16 @@
>  /* PLL related registers and bit values */
>  #define PLL_CFG			((unsigned int *)(MISC_BASE + 0x210))
>  	/* PLL_CFG bit values */
> -	#define OSC_24M_MASK	0
> -	#define OSC_25M_MASK	1
> -	#define PLL_CLK_MASK	3
> -	#define PLL1_CLK_SHIFT	20
> -	#define PLL2_CLK_SHIFT	22
> -	#define PLL3_CLK_SHIFT	24
> +	#define OSC_24M_VAL			0
> +	#define OSC_25M_VAL			1
> +	#define PLL_CLK_MASK			3
> +	#define PLL1_CLK_SHIFT			20
> +	#define PLL2_CLK_SHIFT			22
> +	#define PLL3_CLK_SHIFT			24
Best Regards,
J.
