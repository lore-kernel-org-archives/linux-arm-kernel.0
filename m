From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 12 May 2010 13:56:51 +0900
Subject: [PATCH 05/16] ARM: S5PC100: new clocks definition
In-Reply-To: <1270190944-21644-6-git-send-email-m.szyprowski@samsung.com>
References: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
	<1270190944-21644-6-git-send-email-m.szyprowski@samsung.com>
Message-ID: <001501caf18f$8bedb830$a3c92890$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Prepare for moving support for S5PC100 SoC to plat-s5p framework (part 3).
> This patch adds all clocks from plat-s5pc1xx/clocks.c and removes all the
> code that can be reused from plat-s5p/clock.c.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pc100/clock.c                      |  841
> ++++++++++++++++----
>  .../include/mach}/regs-clock.h                     |    0
>  2 files changed, 703 insertions(+), 138 deletions(-)
>  copy arch/arm/{plat-s5pc1xx/include/plat =>
mach-s5pc100/include/mach}/regs-
> clock.h (100%)
> 
> diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
> index c391c61..75fa9be 100644
> --- a/arch/arm/mach-s5pc100/clock.c
> +++ b/arch/arm/mach-s5pc100/clock.c
> @@ -16,59 +16,22 @@
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> -#include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/clk.h>
> -#include <linux/sysdev.h>
>  #include <linux/io.h>
> 
> -#include <mach/hardware.h>
>  #include <mach/map.h>
> 
>  #include <plat/cpu-freq.h>
> -
> -#include <plat/regs-clock.h>
> +#include <mach/regs-clock.h>
>  #include <plat/clock.h>
> -#include <plat/clock-clksrc.h>
>  #include <plat/cpu.h>
>  #include <plat/pll.h>
> -#include <plat/devs.h>
> +#include <plat/s5p-clock.h>
> +#include <plat/clock-clksrc.h>
>  #include <plat/s5pc100.h>
> 
> -/* fin_apll, fin_mpll and fin_epll are all the same clock, which we call
> - * ext_xtal_mux for want of an actual name from the manual.
> -*/
> -
> -static struct clk clk_ext_xtal_mux = {
> -	.name		= "ext_xtal",
> -	.id		= -1,
> -};
> -
> -#define clk_fin_apll clk_ext_xtal_mux
> -#define clk_fin_mpll clk_ext_xtal_mux
> -#define clk_fin_epll clk_ext_xtal_mux
> -#define clk_fin_hpll clk_ext_xtal_mux
> -
> -#define clk_fout_mpll	clk_mpll
> -#define clk_vclk_54m	clk_54m
> -
> -/* APLL */
> -static struct clk clk_fout_apll = {
> -	.name		= "fout_apll",
> -	.id		= -1,
> -	.rate		= 27000000,
> -};
> -
> -static struct clk *clk_src_apll_list[] = {
> -	[0] = &clk_fin_apll,
> -	[1] = &clk_fout_apll,
> -};
> -
> -static struct clksrc_sources clk_src_apll = {
> -	.sources	= clk_src_apll_list,
> -	.nr_sources	= ARRAY_SIZE(clk_src_apll_list),
> -};
> -
> +/* APLL Mux output clock */
>  static struct clksrc_clk clk_mout_apll = {
>  	.clk	= {
>  		.name		= "mout_apll",
> @@ -98,63 +61,6 @@ static struct clk clk_dout_apll = {
>  	},
>  };
> 
> -static unsigned long s5pc100_clk_arm_get_rate(struct clk *clk)
> -{
> -	unsigned long rate = clk_get_rate(clk->parent);
> -	unsigned int ratio;
> -
> -	ratio = __raw_readl(S5P_CLK_DIV0) & S5P_CLK_DIV0_ARM_MASK;
> -	ratio >>= S5P_CLK_DIV0_ARM_SHIFT;
> -
> -	return rate / (ratio + 1);
> -}
> -
> -static unsigned long s5pc100_clk_arm_round_rate(struct clk *clk,
> -						unsigned long rate)
> -{
> -	unsigned long parent = clk_get_rate(clk->parent);
> -	u32 div;
> -
> -	if (parent < rate)
> -		return rate;
> -
> -	div = (parent / rate) - 1;
> -	if (div > S5P_CLK_DIV0_ARM_MASK)
> -		div = S5P_CLK_DIV0_ARM_MASK;
> -
> -	return parent / (div + 1);
> -}
> -
> -static int s5pc100_clk_arm_set_rate(struct clk *clk, unsigned long rate)
> -{
> -	unsigned long parent = clk_get_rate(clk->parent);
> -	u32 div;
> -	u32 val;
> -
> -	if (rate < parent / (S5P_CLK_DIV0_ARM_MASK + 1))
> -		return -EINVAL;
> -
> -	rate = clk_round_rate(clk, rate);
> -	div = clk_get_rate(clk->parent) / rate;
> -
> -	val = __raw_readl(S5P_CLK_DIV0);
> -	val &= S5P_CLK_DIV0_ARM_MASK;
> -	val |= (div - 1);
> -	__raw_writel(val, S5P_CLK_DIV0);
> -
> -	return 0;
> -}
> -
> -static struct clk clk_arm = {
> -	.name		= "armclk",
> -	.id		= -1,
> -	.parent		= &clk_dout_apll,
> -	.ops		= &(struct clk_ops) {
> -		.get_rate	= s5pc100_clk_arm_get_rate,
> -		.set_rate	= s5pc100_clk_arm_set_rate,
> -		.round_rate	= s5pc100_clk_arm_round_rate,
> -	},
> -};
> 
>  static unsigned long s5pc100_clk_dout_d0_bus_get_rate(struct clk *clk)
>  {
> @@ -217,16 +123,6 @@ static struct clk clk_dout_apll2 = {
>  };
> 
>  /* MPLL */
> -static struct clk *clk_src_mpll_list[] = {
> -	[0] = &clk_fin_mpll,
> -	[1] = &clk_fout_mpll,
> -};
> -
> -static struct clksrc_sources clk_src_mpll = {
> -	.sources	= clk_src_mpll_list,
> -	.nr_sources	= ARRAY_SIZE(clk_src_mpll_list),
> -};
> -
>  static struct clksrc_clk clk_mout_mpll = {
>  	.clk = {
>  		.name		= "mout_mpll",
> @@ -385,21 +281,6 @@ static struct clk clk_dout_mpll = {
>  };
> 
>  /* EPLL */
> -static struct clk clk_fout_epll = {
> -	.name		= "fout_epll",
> -	.id		= -1,
> -};
> -
> -static struct clk *clk_src_epll_list[] = {
> -	[0] = &clk_fin_epll,
> -	[1] = &clk_fout_epll,
> -};
> -
> -static struct clksrc_sources clk_src_epll = {
> -	.sources	= clk_src_epll_list,
> -	.nr_sources	= ARRAY_SIZE(clk_src_epll_list),
> -};
> -
>  static struct clksrc_clk clk_mout_epll = {
>  	.clk	= {
>  		.name		= "mout_epll",
> @@ -471,6 +352,164 @@ static struct clk clk_pcm_cd1 = {
>  	.id		= -1,
>  };
> 
> +static struct clk clk_hd0 = {
> +	.name		= "hclkd0",
> +	.id		= -1,
> +	.rate		= 0,
> +	.parent		= NULL,
> +	.ctrlbit	= 0,
> +	.ops		= &clk_ops_def_setrate,
> +};
> +
> +static struct clk clk_pd0 = {
> +	.name		= "pclkd0",
> +	.id		= -1,
> +	.rate		= 0,
> +	.parent		= NULL,
> +	.ctrlbit	= 0,
> +	.ops		= &clk_ops_def_setrate,
> +};
> +
> +static struct clk clk_54m = {
> +	.name		= "clk_54m",
> +	.id		= -1,
> +	.rate		= 54000000,
> +};
> +
> +
> +static int s5pc100_clk_48m_ctrl(struct clk *clk, int enable)
> +{
> +	unsigned long flags;
> +	u32 val;
> +
> +	/* can't rely on clock lock, this register has other usages */
> +	local_irq_save(flags);
> +
> +	val = __raw_readl(S5P_CLK_SRC1);
> +	if (enable)
> +		val |= S5P_CLK_SRC1_CLK48M_MASK;
> +	else
> +		val &= ~S5P_CLK_SRC1_CLK48M_MASK;
> +
> +	__raw_writel(val, S5P_CLK_SRC1);
> +	local_irq_restore(flags);
> +
> +	return 0;
> +}
> +
> +static unsigned long s5pc100_clk_arm_get_rate(struct clk *clk)
> +{
> +	unsigned long rate = clk_get_rate(clk->parent);
> +	unsigned int ratio;
> +
> +	ratio = __raw_readl(S5P_CLK_DIV0) & S5P_CLK_DIV0_ARM_MASK;
> +	ratio >>= S5P_CLK_DIV0_ARM_SHIFT;
> +
> +	return rate / (ratio + 1);
> +}

This is not correct. If you use structure of clksrc_clk, you can handle this
easily. So no need this function.

> +
> +static unsigned long s5pc100_clk_arm_round_rate(struct clk *clk,
> +						unsigned long rate)
> +{
> +	unsigned long parent = clk_get_rate(clk->parent);
> +	u32 div;
> +
> +	if (parent < rate)
> +		return rate;
> +
> +	div = (parent / rate) - 1;
> +	if (div > S5P_CLK_DIV0_ARM_MASK)
> +		div = S5P_CLK_DIV0_ARM_MASK;
> +
> +	return parent / (div + 1);
> +}

Same as above comment.

> +
> +static int s5pc100_clk_arm_set_rate(struct clk *clk, unsigned long rate)
> +{
> +	unsigned long parent = clk_get_rate(clk->parent);
> +	u32 div;
> +	u32 val;
> +
> +	if (rate < parent / (S5P_CLK_DIV0_ARM_MASK + 1))
> +		return -EINVAL;
> +
> +	rate = clk_round_rate(clk, rate);
> +	div = clk_get_rate(clk->parent) / rate;
> +
> +	val = __raw_readl(S5P_CLK_DIV0);
> +	val &= S5P_CLK_DIV0_ARM_MASK;
> +	val |= (div - 1);
> +	__raw_writel(val, S5P_CLK_DIV0);
> +
> +	return 0;
> +}

Same.

> +
> +static struct clk_ops s5pc100_armclk_ops = {
> +	.get_rate	= s5pc100_clk_arm_get_rate,
> +	.set_rate	= s5pc100_clk_arm_set_rate,
> +	.round_rate	= s5pc100_clk_arm_round_rate,
> +};
> +
> +static int s5pc100_clk_d00_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_CLKGATE_D00, clk, enable);

Oh, ok. I commented about this at your 1st patch.
Anyway looks good.

> +}
> +
> +static int s5pc100_clk_d01_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_CLKGATE_D01, clk, enable);
> +}
> +
> +static int s5pc100_clk_d02_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_CLKGATE_D02, clk, enable);
> +}
> +
> +static int s5pc100_clk_d10_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_CLKGATE_D10, clk, enable);
> +}
> +
> +static int s5pc100_clk_d11_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_CLKGATE_D11, clk, enable);
> +}
> +
> +static int s5pc100_clk_d12_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_CLKGATE_D12, clk, enable);
> +}
> +
> +static int s5pc100_clk_d13_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_CLKGATE_D13, clk, enable);
> +}
> +
> +static int s5pc100_clk_d14_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_CLKGATE_D14, clk, enable);
> +}
> +
> +static int s5pc100_clk_d15_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_CLKGATE_D15, clk, enable);
> +}
> +
> +static int s5pc100_clk_d20_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_CLKGATE_D20, clk, enable);
> +}
> +
> +static int s5pc100_sclk0_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_SCLKGATE0, clk, enable);
> +}
> +
> +static int s5pc100_sclk1_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_SCLKGATE1, clk, enable);
> +}
> +
>  static struct clk *clkset_audio0_list[] = {
>  	&clk_mout_epll.clk,
>  	&clk_dout_mpll,
> @@ -583,7 +622,7 @@ static struct clk *clkset_lcd_fimc_list[] = {
>  	&clk_mout_epll.clk,
>  	&clk_dout_mpll,
>  	&clk_mout_hpll.clk,
> -	&clk_vclk_54m,
> +	&clk_54m,
>  };
> 
>  static struct clksrc_sources clkset_lcd_fimc = {
> @@ -773,6 +812,11 @@ void __init_or_cpufreq s5pc100_setup_clocks(void)
>  	unsigned int ptr;
>  	u32 clkdiv0, clkdiv1;
> 
> +	/* Hook callbacks to base clocks */
> +	clk_48m.enable = s5pc100_clk_48m_ctrl;
> +	clk_arm.ops = &s5pc100_armclk_ops;

No need to register ops member.

> +	clk_arm.parent = &clk_dout_apll,
> +
>  	printk(KERN_DEBUG "%s: registering clocks\n", __func__);
> 
>  	clkdiv0 = __raw_readl(S5P_CLK_DIV0);
> @@ -788,10 +832,10 @@ void __init_or_cpufreq s5pc100_setup_clocks(void)
> 
>  	printk(KERN_DEBUG "%s: xtal is %ld\n", __func__, xtal);
> 
> -	apll = s5pc1xx_get_pll(xtal, __raw_readl(S5P_APLL_CON));
> -	mpll = s5pc1xx_get_pll(xtal, __raw_readl(S5P_MPLL_CON));
> -	epll = s5pc1xx_get_pll(xtal, __raw_readl(S5P_EPLL_CON));
> -	hpll = s5pc1xx_get_pll(xtal, __raw_readl(S5P_HPLL_CON));
> +	apll = s5p_get_pll45xx(xtal, __raw_readl(S5P_APLL_CON), pll_4502);
> +	mpll = s5p_get_pll45xx(xtal, __raw_readl(S5P_MPLL_CON), pll_4502);
> +	epll = s5p_get_pll45xx(xtal, __raw_readl(S5P_EPLL_CON), pll_4502);
> +	hpll = s5p_get_pll45xx(xtal, __raw_readl(S5P_HPLL_CON), pll_4502);

This is ok.

> 
>  	printk(KERN_INFO "S5PC100: Apll=%ld.%03ld Mhz, Mpll=%ld.%03ld Mhz"
>  		", Epll=%ld.%03ld Mhz, Hpll=%ld.%03ld Mhz\n",
> @@ -805,11 +849,10 @@ void __init_or_cpufreq s5pc100_setup_clocks(void)
>  	hclk = mpll / GET_DIV(clkdiv1, S5P_CLK_DIV1_D1);
>  	pclk = hclk / GET_DIV(clkdiv1, S5P_CLK_DIV1_PCLKD1);
> 
> -	printk(KERN_INFO "S5PC100: ARMCLK=%ld.%03ld MHz,
> HCLKD0=%ld.%03ld MHz,"
> -		" PCLKD0=%ld.%03ld MHz\n, HCLK=%ld.%03ld MHz,"
> -		" PCLK=%ld.%03ld MHz\n",
> -		print_mhz(armclk), print_mhz(hclkd0),
> -		print_mhz(pclkd0), print_mhz(hclk), print_mhz(pclk));
> +	printk(KERN_INFO "S5PC100: ARMCLK=%ld.%03ld MHz,
> HCLKD0=%ld.%03ld MHz, "
> +	       "PCLKD0=%ld.%03ld MHz, HCLK=%ld.%03ld MHz,
> PCLK=%ld.%03ld MHz\n",
> +	       print_mhz(armclk), print_mhz(hclkd0),
> +	       print_mhz(pclkd0), print_mhz(hclk), print_mhz(pclk));
> 
>  	clk_fout_apll.rate = apll;
>  	clk_fout_mpll.rate = mpll;
> @@ -830,8 +873,520 @@ void __init_or_cpufreq s5pc100_setup_clocks(void)
>  		s3c_set_clksrc(clksrc_clks + ptr, true);
>  }
> 
> +static struct clk init_clocks_disable[] = {
> +	{
> +		.name		= "dsi",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d11_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D11_DSI,
> +	}, {
> +		.name		= "csi",
> +		.id		= -1,
> +		.parent		= &clk_h,
> +		.enable		= s5pc100_clk_d11_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D11_CSI,
> +	}, {
> +		.name		= "ccan",
> +		.id		= 0,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d14_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D14_CCAN0,
> +	}, {
> +		.name		= "ccan",
> +		.id		= 1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d14_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D14_CCAN1,
> +	}, {
> +		.name		= "keypad",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d15_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D15_KEYIF,
> +	}, {
> +		.name		= "hclkd2",
> +		.id		= -1,
> +		.parent		= NULL,
> +		.enable		= s5pc100_clk_d20_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D20_HCLKD2,
> +	}, {
> +		.name		= "iis-d2",
> +		.id		= -1,
> +		.parent		= NULL,
> +		.enable		= s5pc100_clk_d20_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D20_I2SD2,
> +	},
> +};
> +
> +static struct clk init_clocks[] = {
> +	/* System1 (D0_0) devices */
> +	{
> +		.name		= "intc",
> +		.id		= -1,
> +		.parent		= &clk_hd0,
> +		.enable		= s5pc100_clk_d00_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D00_INTC,
> +	}, {
> +		.name		= "tzic",
> +		.id		= -1,
> +		.parent		= &clk_hd0,
> +		.enable		= s5pc100_clk_d00_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D00_TZIC,
> +	}, {
> +		.name		= "cf-ata",
> +		.id		= -1,
> +		.parent		= &clk_hd0,
> +		.enable		= s5pc100_clk_d00_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D00_CFCON,
> +	}, {
> +		.name		= "mdma",
> +		.id		= -1,
> +		.parent		= &clk_hd0,
> +		.enable		= s5pc100_clk_d00_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D00_MDMA,
> +	}, {
> +		.name		= "g2d",
> +		.id		= -1,
> +		.parent		= &clk_hd0,
> +		.enable		= s5pc100_clk_d00_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D00_G2D,
> +	}, {
> +		.name		= "secss",
> +		.id		= -1,
> +		.parent		= &clk_hd0,
> +		.enable		= s5pc100_clk_d00_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D00_SECSS,
> +	}, {
> +		.name		= "cssys",
> +		.id		= -1,
> +		.parent		= &clk_hd0,
> +		.enable		= s5pc100_clk_d00_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D00_CSSYS,
> +	},
> +
> +	/* Memory (D0_1) devices */
> +	{
> +		.name		= "dmc",
> +		.id		= -1,
> +		.parent		= &clk_hd0,
> +		.enable		= s5pc100_clk_d01_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D01_DMC,
> +	}, {
> +		.name		= "sromc",
> +		.id		= -1,
> +		.parent		= &clk_hd0,
> +		.enable		= s5pc100_clk_d01_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D01_SROMC,
> +	}, {
> +		.name		= "onenand",
> +		.id		= -1,
> +		.parent		= &clk_hd0,
> +		.enable		= s5pc100_clk_d01_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D01_ONENAND,
> +	}, {
> +		.name		= "nand",
> +		.id		= -1,
> +		.parent		= &clk_hd0,
> +		.enable		= s5pc100_clk_d01_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D01_NFCON,
> +	}, {
> +		.name		= "intmem",
> +		.id		= -1,
> +		.parent		= &clk_hd0,
> +		.enable		= s5pc100_clk_d01_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D01_INTMEM,
> +	}, {
> +		.name		= "ebi",
> +		.id		= -1,
> +		.parent		= &clk_hd0,
> +		.enable		= s5pc100_clk_d01_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D01_EBI,
> +	},
> +
> +	/* System2 (D0_2) devices */
> +	{
> +		.name		= "seckey",
> +		.id		= -1,
> +		.parent		= &clk_pd0,
> +		.enable		= s5pc100_clk_d02_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D02_SECKEY,
> +	}, {
> +		.name		= "sdm",
> +		.id		= -1,
> +		.parent		= &clk_hd0,
> +		.enable		= s5pc100_clk_d02_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D02_SDM,
> +	},
> +
> +	/* File (D1_0) devices */
> +	{
> +		.name		= "pdma",
> +		.id		= 0,
> +		.parent		= &clk_h,
> +		.enable		= s5pc100_clk_d10_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D10_PDMA0,
> +	}, {
> +		.name		= "pdma",
> +		.id		= 1,
> +		.parent		= &clk_h,
> +		.enable		= s5pc100_clk_d10_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D10_PDMA1,
> +	}, {
> +		.name		= "usb-host",
> +		.id		= -1,
> +		.parent		= &clk_h,
> +		.enable		= s5pc100_clk_d10_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D10_USBHOST,
> +	}, {
> +		.name		= "otg",
> +		.id		= -1,
> +		.parent		= &clk_h,
> +		.enable		= s5pc100_clk_d10_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D10_USBOTG,
> +	}, {
> +		.name		= "modem",
> +		.id		= -1,
> +		.parent		= &clk_h,
> +		.enable		= s5pc100_clk_d10_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D10_MODEMIF,
> +	}, {
> +		.name		= "hsmmc",
> +		.id		= 0,
> +		.parent		= &clk_48m,
> +		.enable		= s5pc100_clk_d10_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D10_HSMMC0,
> +	}, {
> +		.name		= "hsmmc",
> +		.id		= 1,
> +		.parent		= &clk_48m,
> +		.enable		= s5pc100_clk_d10_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D10_HSMMC1,
> +	}, {
> +		.name		= "hsmmc",
> +		.id		= 2,
> +		.parent		= &clk_48m,
> +		.enable		= s5pc100_clk_d10_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D10_HSMMC2,
> +	},
> +
> +	/* Multimedia1 (D1_1) devices */
> +	{
> +		.name		= "lcdcon",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d11_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D11_LCD,
> +	}, {
> +		.name		= "rotator",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d11_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D11_ROTATOR,
> +	}, {
> +		.name		= "fimc",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d11_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D11_FIMC0,
> +	}, {
> +		.name		= "fimc",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d11_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D11_FIMC1,
> +	}, {
> +		.name		= "fimc",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d11_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D11_FIMC2,
> +	}, {
> +		.name		= "jpeg",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d11_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D11_JPEG,
> +	}, {
> +		.name		= "g3d",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d11_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D11_G3D,
> +	},
> +
> +	/* Multimedia2 (D1_2) devices */
> +	{
> +		.name		= "tv",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d12_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D12_TV,
> +	}, {
> +		.name		= "vp",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d12_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D12_VP,
> +	}, {
> +		.name		= "mixer",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d12_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D12_MIXER,
> +	}, {
> +		.name		= "hdmi",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d12_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D12_HDMI,
> +	}, {
> +		.name		= "mfc",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d12_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D12_MFC,
> +	},
> +
> +	/* System (D1_3) devices */
> +	{
> +		.name		= "chipid",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d13_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D13_CHIPID,
> +	}, {
> +		.name		= "gpio",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d13_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D13_GPIO,
> +	}, {
> +		.name		= "apc",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d13_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D13_APC,
> +	}, {
> +		.name		= "iec",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d13_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D13_IEC,
> +	}, {
> +		.name		= "timers",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d13_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D13_PWM,
> +	}, {
> +		.name		= "systimer",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d13_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D13_SYSTIMER,
> +	}, {
> +		.name		= "watchdog",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d13_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D13_WDT,
> +	}, {
> +		.name		= "rtc",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d13_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D13_RTC,
> +	},
> +
> +	/* Connectivity (D1_4) devices */
> +	{
> +		.name		= "uart",
> +		.id		= 0,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d14_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D14_UART0,
> +	}, {
> +		.name		= "uart",
> +		.id		= 1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d14_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D14_UART1,
> +	}, {
> +		.name		= "uart",
> +		.id		= 2,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d14_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D14_UART2,
> +	}, {
> +		.name		= "uart",
> +		.id		= 3,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d14_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D14_UART3,
> +	}, {
> +		.name		= "i2c",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d14_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D14_IIC,
> +	}, {
> +		.name		= "hdmi-i2c",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d14_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D14_HDMI_IIC,
> +	}, {
> +		.name		= "spi",
> +		.id		= 0,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d14_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D14_SPI0,
> +	}, {
> +		.name		= "spi",
> +		.id		= 1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d14_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D14_SPI1,
> +	}, {
> +		.name		= "spi",
> +		.id		= 2,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d14_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D14_SPI2,
> +	}, {
> +		.name		= "irda",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d14_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D14_IRDA,
> +	}, {
> +		.name		= "hsitx",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d14_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D14_HSITX,
> +	}, {
> +		.name		= "hsirx",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d14_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D14_HSIRX,
> +	},
> +
> +	/* Audio (D1_5) devices */
> +	{
> +		.name		= "iis",
> +		.id		= 0,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d15_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D15_IIS0,
> +	}, {
> +		.name		= "iis",
> +		.id		= 1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d15_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D15_IIS1,
> +	}, {
> +		.name		= "iis",
> +		.id		= 2,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d15_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D15_IIS2,
> +	}, {
> +		.name		= "ac97",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d15_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D15_AC97,
> +	}, {
> +		.name		= "pcm",
> +		.id		= 0,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d15_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D15_PCM0,
> +	}, {
> +		.name		= "pcm",
> +		.id		= 1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d15_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D15_PCM1,
> +	}, {
> +		.name		= "spdif",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d15_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D15_SPDIF,
> +	}, {
> +		.name		= "adc",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d15_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D15_TSADC,
> +	}, {
> +		.name		= "cg",
> +		.id		= -1,
> +		.parent		= &clk_p,
> +		.enable		= s5pc100_clk_d15_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_D15_CG,
> +	},
> +
> +	/* Audio (D2_0) devices: all disabled */
> +
> +	/* Special Clocks 0 */
> +	{
> +		.name		= "sclk_hpm",
> +		.id		= -1,
> +		.parent		= NULL,
> +		.enable		= s5pc100_sclk0_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_SCLK0_HPM,
> +	}, {
> +		.name		= "sclk_onenand",
> +		.id		= -1,
> +		.parent		= NULL,
> +		.enable		= s5pc100_sclk0_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_SCLK0_ONENAND,
> +	}, {
> +		.name		= "spi_48",
> +		.id		= 0,
> +		.parent		= &clk_48m,
> +		.enable		= s5pc100_sclk0_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_SCLK0_SPI0_48,
> +	}, {
> +		.name		= "spi_48",
> +		.id		= 1,
> +		.parent		= &clk_48m,
> +		.enable		= s5pc100_sclk0_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_SCLK0_SPI1_48,
> +	}, {
> +		.name		= "spi_48",
> +		.id		= 2,
> +		.parent		= &clk_48m,
> +		.enable		= s5pc100_sclk0_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_SCLK0_SPI2_48,
> +	}, {
> +		.name		= "mmc_48",
> +		.id		= 0,
> +		.parent		= &clk_48m,
> +		.enable		= s5pc100_sclk0_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_SCLK0_MMC0_48,
> +	}, {
> +		.name		= "mmc_48",
> +		.id		= 1,
> +		.parent		= &clk_48m,
> +		.enable		= s5pc100_sclk0_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_SCLK0_MMC1_48,
> +	}, {
> +		.name		= "mmc_48",
> +		.id		= 2,
> +		.parent		= &clk_48m,
> +		.enable		= s5pc100_sclk0_ctrl,
> +		.ctrlbit	= S5P_CLKGATE_SCLK0_MMC2_48,
> +	},
> +	/* Special Clocks 1 */
> +};
> +
>  static struct clk *clks[] __initdata = {
> -	&clk_ext_xtal_mux,
>  	&clk_dout_apll,
>  	&clk_dout_d0_bus,
>  	&clk_dout_pclkd0,
> @@ -847,13 +1402,14 @@ static struct clk *clks[] __initdata = {
>  	&clk_dout_mpll2,
>  	&clk_dout_cam,
>  	&clk_dout_mpll,
> -	&clk_fout_epll,
>  	&clk_iis_cd0,
>  	&clk_iis_cd1,
>  	&clk_iis_cd2,
>  	&clk_pcm_cd0,
>  	&clk_pcm_cd1,
> -	&clk_arm,
> +	&clk_pd0,
> +	&clk_hd0,
> +	&clk_54m,
>  };
> 
>  void __init s5pc100_register_clocks(void)
> @@ -861,16 +1417,25 @@ void __init s5pc100_register_clocks(void)
>  	struct clk *clkp;
>  	int ret;
>  	int ptr;
> +	int size;
> +
> +	s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
> +	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
> 
> -	for (ptr = 0; ptr < ARRAY_SIZE(clks); ptr++) {
> -		clkp = clks[ptr];
> +	clkp = init_clocks_disable;
> +	size = ARRAY_SIZE(init_clocks_disable);
> +
> +	for (ptr = 0; ptr < size; ptr++, clkp++) {
>  		ret = s3c24xx_register_clock(clkp);
>  		if (ret < 0) {
>  			printk(KERN_ERR "Failed to register clock %s (%d)\n",
>  			       clkp->name, ret);
>  		}
> +
> +		(clkp->enable)(clkp, 0);
>  	}
> 
>  	s3c_register_clksrc(clksrc_audio, ARRAY_SIZE(clksrc_audio));
>  	s3c_register_clksrc(clksrc_clks, ARRAY_SIZE(clksrc_clks));
> +	s3c_pwmclk_init();
>  }
> diff --git a/arch/arm/plat-s5pc1xx/include/plat/regs-clock.h
b/arch/arm/mach-
> s5pc100/include/mach/regs-clock.h
> similarity index 100%
> copy from arch/arm/plat-s5pc1xx/include/plat/regs-clock.h
> copy to arch/arm/mach-s5pc100/include/mach/regs-clock.h
> --
> 1.6.4

Marek,

Actually, need to modify many part to fit new clock scheme.
For example, to use clksrc_clk is easily to handle clock.

S.LSI already made the patch for C100 clock changing which is using
clksrc_clk structure. So may I submit it?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
