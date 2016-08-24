From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Aug 2016 11:13:50 +0100
Subject: [PATCH] ARM: imx: add cpuidle support for i.mx6ul
In-Reply-To: <1472033090.2780.20.camel@pengutronix.de>
References: <1472055231-28434-1-git-send-email-Anson.Huang@nxp.com>
 <1472029735.2780.3.camel@pengutronix.de>
 <AM3PR04MB131584BCC7F2389B8C9437C7F5EA0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <1472033090.2780.20.camel@pengutronix.de>
Message-ID: <20160824101350.GI1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 12:04:50PM +0200, Lucas Stach wrote:
> Am Mittwoch, den 24.08.2016, 09:53 +0000 schrieb Yongcai Huang:
> > 
> > 
> > Best Regards!
> > Anson Huang
> > 
> > 
> > 
> > > -----Original Message-----
> > > From: Lucas Stach [mailto:l.stach at pengutronix.de]
> > > Sent: 2016-08-24 5:09 PM
> > > To: Yongcai Huang <anson.huang@nxp.com>
> > > Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Fabio
> > > Estevam <fabio.estevam@nxp.com>; shawnguo at kernel.org;
> > > linux at armlinux.org.uk; kernel at pengutronix.de
> > > Subject: Re: [PATCH] ARM: imx: add cpuidle support for i.mx6ul
> > > 
> > > Am Donnerstag, den 25.08.2016, 00:13 +0800 schrieb Anson Huang:
> > > > This patch enables cpuidle driver for i.MX6UL, it reuses i.MX6SX's
> > > > cpuidle driver, 3 levels of cpuidle
> > > > supported:
> > > >
> > > > 1. ARM WFI;
> > > > 2. SOC in WAIT mode;
> > > > 3. SOC in WAIT mode + ARM power off.
> > > >
> > > > As i.MX6UL has cortex-A7 CORE with an internal L2 cache, so need to
> > > > add L2 cache type check to decide if to flush L2 when entering idle
> > > > with ARM power off, this is different from i.MX6SX which has PL310
> > > > external
> > > > L2 cache.
> > > >
> > > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > > ---
> > > >  arch/arm/mach-imx/cpuidle-imx6sx.c | 10 ++++++++++
> > > >  arch/arm/mach-imx/mach-imx6ul.c    |  3 +++
> > > >  2 files changed, 13 insertions(+)
> > > >
> > > > diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c
> > > > b/arch/arm/mach-imx/cpuidle-imx6sx.c
> > > > index 41cdce6..b4fcc8ae 100644
> > > > --- a/arch/arm/mach-imx/cpuidle-imx6sx.c
> > > > +++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
> > > > @@ -9,14 +9,21 @@
> > > >  #include <linux/cpuidle.h>
> > > >  #include <linux/cpu_pm.h>
> > > >  #include <linux/module.h>
> > > > +#include <linux/of.h>
> > > > +#include <asm/cacheflush.h>
> > > >  #include <asm/cpuidle.h>
> > > >  #include <asm/suspend.h>
> > > >
> > > >  #include "common.h"
> > > >  #include "cpuidle.h"
> > > >
> > > > +static bool pl310_available;
> > > > +
> > > >  static int imx6sx_idle_finish(unsigned long val)  {
> > > > +	/* check if need to flush internal L2 cache */
> > > > +	if (!pl310_available)
> > > > +		flush_cache_all();
> > > 
> > > I think this is only necessary when entering the deepest idle state with the
> > > ARM core powered off, right? It's a serious overhead for the shallow idle states.
> > > 
> > > Also flush_cache_all() only flushes architected/inner caches, so it should do the
> > > right thing for this use-case even if the outer PL310 cache is present. There is
> > > no need to make this conditional.
> > > 
> > 
> > Sorry, my mutt is NOT working now, so I just reply you using outlook, will work on my mutt later.
> > 
> > Yes, the imx6sx_idle_finish is only called when entering deepest idle with ARM powered off.
> > 
> Okay, makes sense.
> 
> > The common cpu_suspend framework already takes care of L1 cache, for i.MX6SX which is with a 
> > PL310 external L2 cache, as L2 cache memory is NOT powered down, so we no need to flush it.
> > 
> As far as I can see flush_cache_all() only flushes architected caches.
> The PL310 is NOT an architected, but an outer cache, so it will not be
> touched by flush_cache_all() even if it is present. So the condition to
> only do this when the PL310 isn't present isn't needed.

Look again.  The patch is only calling flush_cache_all() if the L2C-310
is _not_ present.  So, the question about flush_cache_all() touching
the L2C-310 is irrelevant.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
