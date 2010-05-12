From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 12 May 2010 08:43:10 +0200
Subject: [PATCH 05/16] ARM: S5PC100: new clocks definition
In-Reply-To: <001501caf18f$8bedb830$a3c92890$%kim@samsung.com>
References: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
	<1270190944-21644-6-git-send-email-m.szyprowski@samsung.com>
	<001501caf18f$8bedb830$a3c92890$%kim@samsung.com>
Message-ID: <002f01caf19e$655de6e0$3019b4a0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, May 12, 2010 6:57 AM Kukjin Kim wrote:

> Marek Szyprowski wrote:
> >
> > Prepare for moving support for S5PC100 SoC to plat-s5p framework (part 3).
> > This patch adds all clocks from plat-s5pc1xx/clocks.c and removes all the
> > code that can be reused from plat-s5p/clock.c.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  arch/arm/mach-s5pc100/clock.c                      |  841
> > ++++++++++++++++----
> >  .../include/mach}/regs-clock.h                     |    0
> >  2 files changed, 703 insertions(+), 138 deletions(-)
> >  copy arch/arm/{plat-s5pc1xx/include/plat =>
> mach-s5pc100/include/mach}/regs-
> > clock.h (100%)
> >
> > diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-
> s5pc100/clock.c
> > index c391c61..75fa9be 100644
> > --- a/arch/arm/mach-s5pc100/clock.c
> > +++ b/arch/arm/mach-s5pc100/clock.c
> > @@ -16,59 +16,22 @@
> >  #include <linux/module.h>
> >  #include <linux/kernel.h>
> >  #include <linux/list.h>
> > -#include <linux/errno.h>
> >  #include <linux/err.h>
> >  #include <linux/clk.h>
> > -#include <linux/sysdev.h>
> >  #include <linux/io.h>
> >
> > -#include <mach/hardware.h>
> >  #include <mach/map.h>
> >
> >  #include <plat/cpu-freq.h>
> > -
> > -#include <plat/regs-clock.h>
> > +#include <mach/regs-clock.h>
> >  #include <plat/clock.h>
> > -#include <plat/clock-clksrc.h>
> >  #include <plat/cpu.h>
> >  #include <plat/pll.h>
> > -#include <plat/devs.h>
> > +#include <plat/s5p-clock.h>
> > +#include <plat/clock-clksrc.h>
> >  #include <plat/s5pc100.h>
> >
> > -/* fin_apll, fin_mpll and fin_epll are all the same clock, which we call
> > - * ext_xtal_mux for want of an actual name from the manual.
> > -*/
> > -
> > -static struct clk clk_ext_xtal_mux = {
> > -	.name		= "ext_xtal",
> > -	.id		= -1,
> > -};
> > -
> > -#define clk_fin_apll clk_ext_xtal_mux
> > -#define clk_fin_mpll clk_ext_xtal_mux
> > -#define clk_fin_epll clk_ext_xtal_mux
> > -#define clk_fin_hpll clk_ext_xtal_mux
> > -
> > -#define clk_fout_mpll	clk_mpll
> > -#define clk_vclk_54m	clk_54m
> > -
> > -/* APLL */
> > -static struct clk clk_fout_apll = {
> > -	.name		= "fout_apll",
> > -	.id		= -1,
> > -	.rate		= 27000000,
> > -};
> > -
> > -static struct clk *clk_src_apll_list[] = {
> > -	[0] = &clk_fin_apll,
> > -	[1] = &clk_fout_apll,
> > -};
> > -
> > -static struct clksrc_sources clk_src_apll = {
> > -	.sources	= clk_src_apll_list,
> > -	.nr_sources	= ARRAY_SIZE(clk_src_apll_list),
> > -};
> > -
> > +/* APLL Mux output clock */
> >  static struct clksrc_clk clk_mout_apll = {
> >  	.clk	= {
> >  		.name		= "mout_apll",
> > @@ -98,63 +61,6 @@ static struct clk clk_dout_apll = {
> >  	},
> >  };
> >
> > -static unsigned long s5pc100_clk_arm_get_rate(struct clk *clk)
> > -{
> > -	unsigned long rate = clk_get_rate(clk->parent);
> > -	unsigned int ratio;
> > -
> > -	ratio = __raw_readl(S5P_CLK_DIV0) & S5P_CLK_DIV0_ARM_MASK;
> > -	ratio >>= S5P_CLK_DIV0_ARM_SHIFT;
> > -
> > -	return rate / (ratio + 1);
> > -}
> > -
> > -static unsigned long s5pc100_clk_arm_round_rate(struct clk *clk,
> > -						unsigned long rate)
> > -{
> > -	unsigned long parent = clk_get_rate(clk->parent);
> > -	u32 div;
> > -
> > -	if (parent < rate)
> > -		return rate;
> > -
> > -	div = (parent / rate) - 1;
> > -	if (div > S5P_CLK_DIV0_ARM_MASK)
> > -		div = S5P_CLK_DIV0_ARM_MASK;
> > -
> > -	return parent / (div + 1);
> > -}
> > -
> > -static int s5pc100_clk_arm_set_rate(struct clk *clk, unsigned long rate)
> > -{
> > -	unsigned long parent = clk_get_rate(clk->parent);
> > -	u32 div;
> > -	u32 val;
> > -
> > -	if (rate < parent / (S5P_CLK_DIV0_ARM_MASK + 1))
> > -		return -EINVAL;
> > -
> > -	rate = clk_round_rate(clk, rate);
> > -	div = clk_get_rate(clk->parent) / rate;
> > -
> > -	val = __raw_readl(S5P_CLK_DIV0);
> > -	val &= S5P_CLK_DIV0_ARM_MASK;
> > -	val |= (div - 1);
> > -	__raw_writel(val, S5P_CLK_DIV0);
> > -
> > -	return 0;
> > -}
> > -
> > -static struct clk clk_arm = {
> > -	.name		= "armclk",
> > -	.id		= -1,
> > -	.parent		= &clk_dout_apll,
> > -	.ops		= &(struct clk_ops) {
> > -		.get_rate	= s5pc100_clk_arm_get_rate,
> > -		.set_rate	= s5pc100_clk_arm_set_rate,
> > -		.round_rate	= s5pc100_clk_arm_round_rate,
> > -	},
> > -};
> >
> >  static unsigned long s5pc100_clk_dout_d0_bus_get_rate(struct clk *clk)
> >  {
> > @@ -217,16 +123,6 @@ static struct clk clk_dout_apll2 = {
> >  };
> >
> >  /* MPLL */
> > -static struct clk *clk_src_mpll_list[] = {
> > -	[0] = &clk_fin_mpll,
> > -	[1] = &clk_fout_mpll,
> > -};
> > -
> > -static struct clksrc_sources clk_src_mpll = {
> > -	.sources	= clk_src_mpll_list,
> > -	.nr_sources	= ARRAY_SIZE(clk_src_mpll_list),
> > -};
> > -
> >  static struct clksrc_clk clk_mout_mpll = {
> >  	.clk = {
> >  		.name		= "mout_mpll",
> > @@ -385,21 +281,6 @@ static struct clk clk_dout_mpll = {
> >  };
> >
> >  /* EPLL */
> > -static struct clk clk_fout_epll = {
> > -	.name		= "fout_epll",
> > -	.id		= -1,
> > -};
> > -
> > -static struct clk *clk_src_epll_list[] = {
> > -	[0] = &clk_fin_epll,
> > -	[1] = &clk_fout_epll,
> > -};
> > -
> > -static struct clksrc_sources clk_src_epll = {
> > -	.sources	= clk_src_epll_list,
> > -	.nr_sources	= ARRAY_SIZE(clk_src_epll_list),
> > -};
> > -
> >  static struct clksrc_clk clk_mout_epll = {
> >  	.clk	= {
> >  		.name		= "mout_epll",
> > @@ -471,6 +352,164 @@ static struct clk clk_pcm_cd1 = {
> >  	.id		= -1,
> >  };
> >
> > +static struct clk clk_hd0 = {
> > +	.name		= "hclkd0",
> > +	.id		= -1,
> > +	.rate		= 0,
> > +	.parent		= NULL,
> > +	.ctrlbit	= 0,
> > +	.ops		= &clk_ops_def_setrate,
> > +};
> > +
> > +static struct clk clk_pd0 = {
> > +	.name		= "pclkd0",
> > +	.id		= -1,
> > +	.rate		= 0,
> > +	.parent		= NULL,
> > +	.ctrlbit	= 0,
> > +	.ops		= &clk_ops_def_setrate,
> > +};
> > +
> > +static struct clk clk_54m = {
> > +	.name		= "clk_54m",
> > +	.id		= -1,
> > +	.rate		= 54000000,
> > +};
> > +
> > +
> > +static int s5pc100_clk_48m_ctrl(struct clk *clk, int enable)
> > +{
> > +	unsigned long flags;
> > +	u32 val;
> > +
> > +	/* can't rely on clock lock, this register has other usages */
> > +	local_irq_save(flags);
> > +
> > +	val = __raw_readl(S5P_CLK_SRC1);
> > +	if (enable)
> > +		val |= S5P_CLK_SRC1_CLK48M_MASK;
> > +	else
> > +		val &= ~S5P_CLK_SRC1_CLK48M_MASK;
> > +
> > +	__raw_writel(val, S5P_CLK_SRC1);
> > +	local_irq_restore(flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static unsigned long s5pc100_clk_arm_get_rate(struct clk *clk)
> > +{
> > +	unsigned long rate = clk_get_rate(clk->parent);
> > +	unsigned int ratio;
> > +
> > +	ratio = __raw_readl(S5P_CLK_DIV0) & S5P_CLK_DIV0_ARM_MASK;
> > +	ratio >>= S5P_CLK_DIV0_ARM_SHIFT;
> > +
> > +	return rate / (ratio + 1);
> > +}
> 
> This is not correct. If you use structure of clksrc_clk, you can handle
> this
> easily. So no need this function.

Ok. I will look into this.

> 
> > +
> > +static unsigned long s5pc100_clk_arm_round_rate(struct clk *clk,
> > +						unsigned long rate)
> > +{
> > +	unsigned long parent = clk_get_rate(clk->parent);
> > +	u32 div;
> > +
> > +	if (parent < rate)
> > +		return rate;
> > +
> > +	div = (parent / rate) - 1;
> > +	if (div > S5P_CLK_DIV0_ARM_MASK)
> > +		div = S5P_CLK_DIV0_ARM_MASK;
> > +
> > +	return parent / (div + 1);
> > +}
> 
> Same as above comment.
> 
> > +
> > +static int s5pc100_clk_arm_set_rate(struct clk *clk, unsigned long rate)
> > +{
> > +	unsigned long parent = clk_get_rate(clk->parent);
> > +	u32 div;
> > +	u32 val;
> > +
> > +	if (rate < parent / (S5P_CLK_DIV0_ARM_MASK + 1))
> > +		return -EINVAL;
> > +
> > +	rate = clk_round_rate(clk, rate);
> > +	div = clk_get_rate(clk->parent) / rate;
> > +
> > +	val = __raw_readl(S5P_CLK_DIV0);
> > +	val &= S5P_CLK_DIV0_ARM_MASK;
> > +	val |= (div - 1);
> > +	__raw_writel(val, S5P_CLK_DIV0);
> > +
> > +	return 0;
> > +}
> 
> Same.
> 
> > +
> > +static struct clk_ops s5pc100_armclk_ops = {
> > +	.get_rate	= s5pc100_clk_arm_get_rate,
> > +	.set_rate	= s5pc100_clk_arm_set_rate,
> > +	.round_rate	= s5pc100_clk_arm_round_rate,
> > +};
> > +
> > +static int s5pc100_clk_d00_ctrl(struct clk *clk, int enable)
> > +{
> > +	return s5p_gatectrl(S5P_CLKGATE_D00, clk, enable);
> 
> Oh, ok. I commented about this at your 1st patch.
> Anyway looks good.
> 
> > +}
> > +
> > +static int s5pc100_clk_d01_ctrl(struct clk *clk, int enable)
> > +{
> > +	return s5p_gatectrl(S5P_CLKGATE_D01, clk, enable);
> > +}
> > +
> > +static int s5pc100_clk_d02_ctrl(struct clk *clk, int enable)
> > +{
> > +	return s5p_gatectrl(S5P_CLKGATE_D02, clk, enable);
> > +}
> > +
> > +static int s5pc100_clk_d10_ctrl(struct clk *clk, int enable)
> > +{
> > +	return s5p_gatectrl(S5P_CLKGATE_D10, clk, enable);
> > +}
> > +
> > +static int s5pc100_clk_d11_ctrl(struct clk *clk, int enable)
> > +{
> > +	return s5p_gatectrl(S5P_CLKGATE_D11, clk, enable);
> > +}
> > +
> > +static int s5pc100_clk_d12_ctrl(struct clk *clk, int enable)
> > +{
> > +	return s5p_gatectrl(S5P_CLKGATE_D12, clk, enable);
> > +}
> > +
> > +static int s5pc100_clk_d13_ctrl(struct clk *clk, int enable)
> > +{
> > +	return s5p_gatectrl(S5P_CLKGATE_D13, clk, enable);
> > +}
> > +
> > +static int s5pc100_clk_d14_ctrl(struct clk *clk, int enable)
> > +{
> > +	return s5p_gatectrl(S5P_CLKGATE_D14, clk, enable);
> > +}
> > +
> > +static int s5pc100_clk_d15_ctrl(struct clk *clk, int enable)
> > +{
> > +	return s5p_gatectrl(S5P_CLKGATE_D15, clk, enable);
> > +}
> > +
> > +static int s5pc100_clk_d20_ctrl(struct clk *clk, int enable)
> > +{
> > +	return s5p_gatectrl(S5P_CLKGATE_D20, clk, enable);
> > +}
> > +
> > +static int s5pc100_sclk0_ctrl(struct clk *clk, int enable)
> > +{
> > +	return s5p_gatectrl(S5P_SCLKGATE0, clk, enable);
> > +}
> > +
> > +static int s5pc100_sclk1_ctrl(struct clk *clk, int enable)
> > +{
> > +	return s5p_gatectrl(S5P_SCLKGATE1, clk, enable);
> > +}
> > +
> >  static struct clk *clkset_audio0_list[] = {
> >  	&clk_mout_epll.clk,
> >  	&clk_dout_mpll,
> > @@ -583,7 +622,7 @@ static struct clk *clkset_lcd_fimc_list[] = {
> >  	&clk_mout_epll.clk,
> >  	&clk_dout_mpll,
> >  	&clk_mout_hpll.clk,
> > -	&clk_vclk_54m,
> > +	&clk_54m,
> >  };
> >
> >  static struct clksrc_sources clkset_lcd_fimc = {
> > @@ -773,6 +812,11 @@ void __init_or_cpufreq s5pc100_setup_clocks(void)
> >  	unsigned int ptr;
> >  	u32 clkdiv0, clkdiv1;
> >
> > +	/* Hook callbacks to base clocks */
> > +	clk_48m.enable = s5pc100_clk_48m_ctrl;
> > +	clk_arm.ops = &s5pc100_armclk_ops;
> 
> No need to register ops member.

> ...

> 
> Marek,
> 
> Actually, need to modify many part to fit new clock scheme.
> For example, to use clksrc_clk is easily to handle clock.

I thought I covered most of the changes. Probably only the armclk
related functions and a cleanup in s5pc100/mach/regs-clock.h are
left and these can be easily fixed.

> S.LSI already made the patch for C100 clock changing which is using
> clksrc_clk structure. So may I submit it?

Could you compare your version with the final version that is created
by my patch series? I don't think that there will be many differences
there.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
