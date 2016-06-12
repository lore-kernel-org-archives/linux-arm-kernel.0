From: dongas86@gmail.com (Dong Aisheng)
Date: Sun, 12 Jun 2016 19:51:28 +0800
Subject: [PATCH 05/11] clk: imx: refine the powerup_set bit of clk-pllv3
In-Reply-To: <20160612113627.GC20243@tiger>
References: <1465396420-27064-1-git-send-email-aisheng.dong@nxp.com>
 <1465396420-27064-5-git-send-email-aisheng.dong@nxp.com>
 <20160612113627.GC20243@tiger>
Message-ID: <20160612115051.GA32690@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Sun, Jun 12, 2016 at 07:36:27PM +0800, Shawn Guo wrote:
> On Wed, Jun 08, 2016 at 10:33:34PM +0800, Dong Aisheng wrote:
> > There's a powerdown bit already, so let's change the name of
> > powerup_set bit to power_invert to reflects the power polarity
> > to make it less confusing.
> > 
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  drivers/clk/imx/clk-pllv3.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
> > index eea2b1b3791e..3fdfb6d2cc71 100644
> > --- a/drivers/clk/imx/clk-pllv3.c
> > +++ b/drivers/clk/imx/clk-pllv3.c
> > @@ -29,8 +29,8 @@
> >   * struct clk_pllv3 - IMX PLL clock version 3
> >   * @clk_hw:	 clock source
> >   * @base:	 base address of PLL registers
> > - * @powerup_set: set POWER bit to power up the PLL
> > - * @powerdown:   pll powerdown offset bit
> > + * @powerdown:	 pll powerdown bit offset
> 
> I think 'powerdown' is more confusing here.  I prefer to rename it to
> something like 'power_mask' and keep 'powerdown' as it is.
> 

A bit confused, you mean rename which one?
powerdown bit is defined by the spec so i just keep it.

Since *invert is wildly used in gpio subsystem, so i
change the powerup_set to power_invert to indicate the invert using
of powerdown bit.

Regards
Dong Aisheng

> Shawn
> 
> > + * @power_invert: set powerdown bit to power up the PLL
> >   * @div_mask:	 mask of divider bits
> >   * @div_shift:	 shift of divider bits
> >   *
> > @@ -40,7 +40,7 @@
> >  struct clk_pllv3 {
> >  	struct clk_hw	hw;
> >  	void __iomem	*base;
> > -	bool		powerup_set;
> > +	bool		power_invert;
> >  	u32		powerdown;
> >  	u32		div_mask;
> >  	u32		div_shift;
> > @@ -55,7 +55,7 @@ static int clk_pllv3_wait_lock(struct clk_pllv3 *pll)
> >  	u32 val = readl_relaxed(pll->base) & pll->powerdown;
> >  
> >  	/* No need to wait for lock when pll is not powered up */
> > -	if ((pll->powerup_set && !val) || (!pll->powerup_set && val))
> > +	if ((pll->power_invert && !val) || (!pll->power_invert && val))
> >  		return 0;
> >  
> >  	/* Wait for PLL to lock */
> > @@ -76,7 +76,7 @@ static int clk_pllv3_prepare(struct clk_hw *hw)
> >  	u32 val;
> >  
> >  	val = readl_relaxed(pll->base);
> > -	if (pll->powerup_set)
> > +	if (pll->power_invert)
> >  		val |= pll->powerdown;
> >  	else
> >  		val &= ~pll->powerdown;
> > @@ -91,7 +91,7 @@ static void clk_pllv3_unprepare(struct clk_hw *hw)
> >  	u32 val;
> >  
> >  	val = readl_relaxed(pll->base);
> > -	if (pll->powerup_set)
> > +	if (pll->power_invert)
> >  		val &= ~pll->powerdown;
> >  	else
> >  		val |= pll->powerdown;
> > @@ -326,7 +326,7 @@ struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
> >  		pll->div_shift = 1;
> >  	case IMX_PLLV3_USB:
> >  		ops = &clk_pllv3_ops;
> > -		pll->powerup_set = true;
> > +		pll->power_invert = true;
> >  		break;
> >  	case IMX_PLLV3_AV:
> >  		ops = &clk_pllv3_av_ops;
> > -- 
> > 1.9.1
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
