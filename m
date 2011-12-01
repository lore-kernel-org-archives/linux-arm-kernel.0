From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 1 Dec 2011 22:41:13 +0800
Subject: [PATCH] arm/imx6: add restart support for imx6q
In-Reply-To: <20111201141807.GN27267@pengutronix.de>
References: <1322668872-13011-1-git-send-email-shawn.guo@linaro.org>
 <20111201141807.GN27267@pengutronix.de>
Message-ID: <20111201144112.GK711@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2011 at 03:18:07PM +0100, Sascha Hauer wrote:
> On Thu, Dec 01, 2011 at 12:01:12AM +0800, Shawn Guo wrote:
> > The restart support was missed from the initial imx6q submission.
> > The mxc_restart() does not work for imx6q.  Instead, this patch adds
> > the restart for imx6q.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> > Hi Russell,
> > 
> > This patch is to support restart support for imx6q based on your
> > 'reset' branch.  Is it possible for you to take this patch through
> > your 'reset' branch?
> > 
> >  arch/arm/mach-imx/clock-imx6q.c         |    2 -
> >  arch/arm/mach-imx/mach-imx6q.c          |   33 ++++++++++++++++++++++++++++++-
> >  arch/arm/mach-imx/src.c                 |   23 +++++++++++++++++++++
> >  arch/arm/plat-mxc/include/mach/common.h |    1 +
> >  4 files changed, 56 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/mach-imx/clock-imx6q.c b/arch/arm/mach-imx/clock-imx6q.c
> > index 613a1b9..2234031 100644
> > --- a/arch/arm/mach-imx/clock-imx6q.c
> > +++ b/arch/arm/mach-imx/clock-imx6q.c
> > @@ -1931,14 +1931,12 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
> >  		val |= 0x1 << BP_CLPCR_LPM;
> >  		val &= ~BM_CLPCR_VSTBY;
> >  		val &= ~BM_CLPCR_SBYOS;
> > -		val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
> >  		break;
> >  	case STOP_POWER_OFF:
> >  		val |= 0x2 << BP_CLPCR_LPM;
> >  		val |= 0x3 << BP_CLPCR_STBY_COUNT;
> >  		val |= BM_CLPCR_VSTBY;
> >  		val |= BM_CLPCR_SBYOS;
> > -		val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
> >  		break;
> >  	default:
> >  		return -EINVAL;
> > diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> > index dc8b6e2..54ce8ec 100644
> > --- a/arch/arm/mach-imx/mach-imx6q.c
> > +++ b/arch/arm/mach-imx/mach-imx6q.c
> > @@ -10,10 +10,13 @@
> >   * http://www.gnu.org/copyleft/gpl.html
> >   */
> >  
> > +#include <linux/delay.h>
> >  #include <linux/init.h>
> > +#include <linux/io.h>
> >  #include <linux/irq.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/of.h>
> > +#include <linux/of_address.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/of_platform.h>
> >  #include <asm/hardware/cache-l2x0.h>
> > @@ -23,6 +26,34 @@
> >  #include <mach/common.h>
> >  #include <mach/hardware.h>
> >  
> > +void imx6q_restart(char mode, const char *cmd)
> > +{
> > +	struct device_node *np;
> > +	void __iomem *wdog_base;
> > +
> > +	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-wdt");
> > +	wdog_base = of_iomap(np, 0);
> > +	WARN_ON(!wdog_base);
> 
> You don't need a WARN_ON here as you derefence the NULL pointer below...
> Wouldn't it be better to do soft_restart() if the iomap fails?
> 
Indeed.

-- 
Regards,
Shawn
