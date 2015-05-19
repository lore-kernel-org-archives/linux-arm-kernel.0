From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 19 May 2015 15:57:42 +0800
Subject: [PATCH 1/9] ARM: imx: move timer resources into a structure
In-Reply-To: <BL2PR03MB37086957FE1515FD0D2E87983C70@BL2PR03MB370.namprd03.prod.outlook.com>
References: <1431677507-27420-1-git-send-email-shawnguo@kernel.org>
 <1431677507-27420-2-git-send-email-shawnguo@kernel.org>
 <BL2PR03MB37086957FE1515FD0D2E87983C70@BL2PR03MB370.namprd03.prod.outlook.com>
Message-ID: <20150519075742.GU1071@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 15, 2015 at 04:36:18PM +0000, Shenwei Wang wrote:
> 
> 
> > -----Original Message-----
> > From: shawnguo at kernel.org [mailto:shawnguo at kernel.org]
> > Sent: 2015?5?15? 3:12
> > To: linux-arm-kernel at lists.infradead.org
> > Cc: kernel at pengutronix.de; Daniel Lezcano; Wang Shenwei-B38339; Shawn Guo
> > Subject: [PATCH 1/9] ARM: imx: move timer resources into a structure
> > 
> > From: Shawn Guo <shawn.guo@linaro.org>
> > 
> > Instead of passing around as argument, let's move timer resources like irq and
> > clocks together with base address into a data structure, and reference the
> > resources from the struct variable directly to simplify the function call interface.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  arch/arm/mach-imx/time.c | 119 ++++++++++++++++++++++++-----------------------
> >  1 file changed, 61 insertions(+), 58 deletions(-)
> > 
> > diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c index
> > ab5ee1c445f3..8ad7cb2a7f08 100644
> > --- a/arch/arm/mach-imx/time.c
> > +++ b/arch/arm/mach-imx/time.c
> > @@ -84,27 +84,34 @@
> >  static struct clock_event_device clockevent_mxc;  static enum
> > clock_event_mode clockevent_mode = CLOCK_EVT_MODE_UNUSED;
> > 
> > -static void __iomem *timer_base;
> > +struct imx_timer {
> > +	void __iomem *base;
> > +	int irq;
> > +	struct clk *clk_per;
> > +	struct clk *clk_ipg;
> > +};
> > +
> > +static struct imx_timer imxtm;
> > 
> Since the changes still used a global variable to hold the information, it doesn't take advantage of what the clocksource framework provides, and make the driver unable to support multi-instances.
> 

The goal of the series is to clean up cpu_is_xxx usages, and move the
driver into drivers/clocksource.  The multi-instances can be supported
later when we see a need for that.

Shawn
