From: tony@atomide.com (Tony Lindgren)
Date: Thu, 4 Apr 2013 09:41:38 -0700
Subject: [RFC][PATCH 1/2] ARM: OMAP4: clock: Add device tree support
 for AUXCLKs
In-Reply-To: <515D2D30.3000306@ti.com>
References: <1363703220-4777-1-git-send-email-rogerq@ti.com>
 <1363703220-4777-2-git-send-email-rogerq@ti.com>
 <20130403234242.GE10155@atomide.com> <515D2D30.3000306@ti.com>
Message-ID: <20130404164137.GH10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [130404 00:39]:
> On 04/04/2013 02:42 AM, Tony Lindgren wrote:
> >> --- a/arch/arm/mach-omap2/cclock44xx_data.c
> >> +++ b/arch/arm/mach-omap2/cclock44xx_data.c
> >> @@ -27,6 +27,7 @@
> >>  #include <linux/clk-private.h>
> >>  #include <linux/clkdev.h>
> >>  #include <linux/io.h>
> >> +#include <linux/of.h>
> >>  
> >>  #include "soc.h"
> >>  #include "iomap.h"
> >> @@ -1663,6 +1664,40 @@ static struct omap_clk omap44xx_clks[] = {
> >>  	CLK(NULL,	"cpufreq_ck",	&dpll_mpu_ck,	CK_443X),
> >>  };
> >>  
> >> +static struct clk *scrm_clks[] = {
> >> +	&auxclk0_ck,
> >> +	&auxclk1_ck,
> >> +	&auxclk2_ck,
> >> +	&auxclk3_ck,
> >> +	&auxclk4_ck,
> >> +	&auxclk5_ck,
> >> +};
> > 
> > Hmm I don't like the idea of specifying the auxclk both in the
> > cclock44xx_data.c and in DT..
> 
> Right, but till we have all clocks moved to DT we only need this
> approach for general purpose clocks that are not mapped to devices
> by hwmod.

For v3.10, let's just make sure that USB works with DT as then
after v3.10 we can make omap4 DT only and get rid of estimated
7K lines of code and data. I guess this is the last piece missing
for that, or are we also missing something else?

Can't you set up a clock alias for your device so it can find the
auxclk when requesting it with the dev entry?

For the DT clock driver if needed for v3.10, how about just do a
minimal drivers/clock/omap/ that uses the standard binding?
Then that driver can just do clk_get() from cclock44xx_data.c
for now? And then later on we'll just move all the clocks to a
combination of DT + /lib/firmware.

> e.g. auxclk are required to be specified in DT nodes for USB PHY.
> Without this we can't get USB host working on Panda.

OK. So if the USB PHY has a dev entry, can't you just set up a
clock alias in struct omap_clk omap44xx_clks[] for it?
 
> As Rajendra points out, it seems moving entire clock data to DT is not
> going to happen soon. So this is the simplistic way things can work.

Right but seems like we can get started there without moving
them all at once.

Regards,

Tony
