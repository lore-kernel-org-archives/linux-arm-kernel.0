From: tony@atomide.com (Tony Lindgren)
Date: Fri, 21 Sep 2012 12:07:11 -0700
Subject: [PATCH 2/2] ARM: OMAP: SmartReflex: pass device dependent data
 via platform data
In-Reply-To: <CAORVsuXS=zk6SEqo=qhyaAFyYQbhLA8CY9TTMMhEQtMZf7p21Q@mail.gmail.com>
References: <1348152453-30532-1-git-send-email-j-pihet@ti.com>
 <1348152453-30532-3-git-send-email-j-pihet@ti.com>
 <20120920221504.GK28835@atomide.com>
 <CAORVsuXS=zk6SEqo=qhyaAFyYQbhLA8CY9TTMMhEQtMZf7p21Q@mail.gmail.com>
Message-ID: <20120921190710.GG28835@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jean Pihet <jean.pihet@newoldbits.com> [120920 23:31]:
> On Fri, Sep 21, 2012 at 12:15 AM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > You should be able to make this even simpler and not have to pass
> > the clock name around at all. Just do:
> >
> > syc_ck = clk_get(NULL, "fck);
> > ...
> The problem is that the system has multiple instances of the
> smartreflex module, each having its own fck. On OMAP3/4 the fck's are
> derived from sys_clk via muxes and latches.
> The proposed code uses the fck's as defined in the .main_clk field of
> the hwmod entries, so that it takes the muxes and latches into account
> and also has a consistent clock naming.

If the same system has multiple clocks, then you could have them matched
by the smartreflex driver instance number.

Or if you mean different source clocks for various omaps, then
you just need to set multiple aliases for those clocks.
 
> > In the driver, and add the necessary entries to the clock alias
> > table. That way it's up to the SoC to set up the necessary clocks
> > and the driver stays generic.
> Got it. The only solution would be to use an unique fck for all
> smartreflex modules in all configurations. Is that acceptable?

Hmm maybe I don't follow you, but sounds like you just need to
use the driver instance like we do for timers:

$ grep omap_timer arch/arm/mach-omap2/clock*data*.c
arch/arm/mach-omap2/clock44xx_data.c:   CLK("omap_timer.1",     "timer_sys_ck", &sys_clkin_ck,  CK_443X),
arch/arm/mach-omap2/clock44xx_data.c:   CLK("omap_timer.2",     "timer_sys_ck", &sys_clkin_ck,  CK_443X),
arch/arm/mach-omap2/clock44xx_data.c:   CLK("omap_timer.3",     "timer_sys_ck", &sys_clkin_ck,  CK_443X),
...

If you need multiple clocks for a driver instance, then they
typically are just "fck" and "ick".

Regards,

Tony
