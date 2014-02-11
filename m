From: b20788@freescale.com (Anson Huang)
Date: Tue, 11 Feb 2014 16:11:47 +0800
Subject: [PATCH] ARM: imx: avoid calling clk APIs in idle thread which
 may cause schedule
In-Reply-To: <20140211061833.GD31484@S2101-09.ap.freescale.net>
References: <1392014090-27984-1-git-send-email-b20788@freescale.com>
 <20140211061833.GD31484@S2101-09.ap.freescale.net>
Message-ID: <20140211081146.GA20631@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 02:18:35PM +0800, Shawn Guo wrote:
> On Mon, Feb 10, 2014 at 02:34:50PM +0800, Anson Huang wrote:
> > @@ -81,19 +99,67 @@ static const u32 clks_init_on[] __initconst = {
> >   * entering WAIT mode.
> >   *
> >   * This function will set the ARM clk to max value within the 12:5 limit.
> > + * As IPG clock is fixed at 66MHz(so ARM freq must not exceed 158.4MHz),
> > + * ARM freq are one of below setpoints: 396MHz, 792MHz and 996MHz, since
> > + * the clk APIs can NOT be called in idle thread(may cause kernel schedule
> > + * as there is sleep function in PLL wait function), so here we just slow
> > + * down ARM to below freq according to previous freq:
> > + *
> > + * run mode      wait mode
> > + * 396MHz   ->   132MHz;
> > + * 792MHz   ->   158.4MHz;
> > + * 996MHz   ->   142.3MHz;
> >   */
> > +static int imx6sl_get_arm_divider_for_wait(void)
> > +{
> > +	if (readl_relaxed(ccm_base + CCSR) & BM_CCSR_PLL1_SW_CLK_SEL) {
> > +		return ARM_WAIT_DIV_396M;
> > +	} else {
> > +		if ((readl_relaxed(anatop_base + PLL_ARM) &
> > +			BM_PLL_ARM_DIV_SELECT) == PLL_ARM_DIV_792M)
> > +			return ARM_WAIT_DIV_792M;
> > +		else
> > +			return ARM_WAIT_DIV_996M;
> > +	}
> > +}
> > +
> > +static void imx6sl_enable_pll_arm(bool enable)
> > +{
> > +	static u32 saved_pll_arm;
> > +	u32 val;
> > +
> > +	if (enable) {
> > +		saved_pll_arm = val = readl_relaxed(anatop_base + PLL_ARM);
> > +		val |= BM_PLL_ARM_ENABLE;
> > +		val &= ~BM_PLL_ARM_POWERDOWN;
> > +		writel_relaxed(val, anatop_base + PLL_ARM);
> > +		while (!(__raw_readl(anatop_base + PLL_ARM) & BM_PLL_ARM_LOCK))
> > +			;
> > +	} else {
> > +		 writel_relaxed(saved_pll_arm, anatop_base + PLL_ARM);
> > +	}
> > +}
> > +
> >  void imx6sl_set_wait_clk(bool enter)
> >  {
> > -	static unsigned long saved_arm_rate;
> > +	static unsigned long saved_arm_div;
> >  
> > +	/*
> > +	 * According to hardware design, arm podf change need
> > +	 * PLL1 clock enabled.
> > +	 */
> > +	imx6sl_enable_pll_arm(true);
> 
> This only applies to the ARM_WAIT_DIV_396M case, since for the other two
> PLL1 must already be enabled, right?

Yes, I will add condition check to make sure it is only called when ARM is
@396MHz.

> 
> >  	if (enter) {
> > -		unsigned long ipg_rate = clk_get_rate(clks[IMX6SL_CLK_IPG]);
> > -		unsigned long max_arm_wait_rate = (12 * ipg_rate) / 5;
> > -		saved_arm_rate = clk_get_rate(clks[IMX6SL_CLK_ARM]);
> > -		clk_set_rate(clks[IMX6SL_CLK_ARM], max_arm_wait_rate);
> > +		saved_arm_div = readl_relaxed(ccm_base + CACRR);
> > +		writel_relaxed(imx6sl_get_arm_divider_for_wait(),
> > +			ccm_base + CACRR);
> >  	} else {
> > -		clk_set_rate(clks[IMX6SL_CLK_ARM], saved_arm_rate);
> > +		writel_relaxed(saved_arm_div, ccm_base + CACRR);
> >  	}
> > +
> > +	while (__raw_readl(ccm_base + CDHIPR) & BM_CDHIPR_ARM_PODF_BUSY)
> > +		;
> > +	imx6sl_enable_pll_arm(false);
> >  }
> >  
> >  static void __init imx6sl_clocks_init(struct device_node *ccm_node)
> > @@ -110,6 +176,7 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
> >  
> >  	np = of_find_compatible_node(NULL, NULL, "fsl,imx6sl-anatop");
> >  	base = of_iomap(np, 0);
> > +	anatop_base = base;
> 
> More logical to put it after the WARN_ON() below?
> 
> >  	WARN_ON(!base);
> >  
> >  	/*                                             type               name            parent  base         div_mask */
> > @@ -157,6 +224,7 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
> >  
> >  	np = ccm_node;
> >  	base = of_iomap(np, 0);
> > +	ccm_base = base;
> 
> Ditto.

Will improve it in V2, thanks.

Anson.

> 
> Shawn
> 
> >  	WARN_ON(!base);
> >  
> >  	/* Reuse imx6q pm code */
> > -- 
> > 1.7.9.5
> > 
> > 
> 
