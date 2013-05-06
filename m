From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Mon, 6 May 2013 18:30:36 +0000
Subject: mach-omap2/timer.c: Bug introduced while merging patch - ff931c82
In-Reply-To: <20130506152706.GD28721@atomide.com>
References: <79CD15C6BA57404B839C016229A409A83EC7C45D@DBDE04.ent.ti.com>
 <20130506152706.GD28721@atomide.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EC7C93A@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Monday, May 06, 2013 8:57 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap at vger.kernel.org; linux-kernel at vger.kernel.org; linux-
> arm-kernel at lists.infradead.org
> Subject: Re: mach-omap2/timer.c: Bug introduced while merging patch -
> ff931c82
> 
> * Hiremath, Vaibhav <hvaibhav@ti.com> [130506 00:12]:
> > Hi,
> >
> > Not sure whether this got discussed and fixed already, but Google
> didn't give me anything :)
> >
> > The below commit got merged wrongly to Mainline (Changes from timer.c
> got missed), and
> > due to this none of omap boards will boot.
> >
> >
> > From ff931c821bab6713a52b768b0cd7ee7e90713b36 Mon Sep 17 00:00:00
> 2001
> > From: Rajendra Nayak <rnayak@ti.com>
> > Date: Thu, 21 Mar 2013 11:04:52 +0000
> > Subject: ARM: OMAP: clocks: Delay clk inits atleast until slab is
> initialized
> >
> >
> > It seems Linux-omap tree has the fix patch for this, and it should
> get pushed ASAP.
> > Below are links for Linus's mainline commit [1], the actual patch
> submitted to the list [2] and
> > Commit  present in Linux-omap [3].
> 
> Can you please provide a proper patch for the regression since sounds
> like you already figured out what happened?
> 

Ohh yeah, I already have a patch for it -



From: Vaibhav Hiremath <hvaibhav@ti.com>
Date: Mon, 6 May 2013 13:23:27 +0530
Subject: [PATCH] ARM: OMAP2+: Regression: Add missing code while merging commit ff931c82 to Mainline

While merging commit ff931c82 [1] to Mainline,, it seems not all the changes from 
the original patch [2] have been merged; changes from mach-omap2/timer.c have been
dropped, which invokes xxx_clk_init() function required to register platform
clock table. And without this none of OMAP family of devices will boot from
Mainline.

[1] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/arch/arm/mach-omap2/io.c?id=ff931c821bab6713a52b768b0cd7ee7e90713b36
[2] https://patchwork.kernel.org/patch/2300071/

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
arch/arm/mach-omap2/timer.c |    4 ++++
1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index f12aa6c..31ae764 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -549,6 +549,8 @@ static inline void __init realtime_counter_init(void)
                               clksrc_nr, clksrc_src, clksrc_prop)      \
 void __init omap##name##_gptimer_timer_init(void)                      \
 {                                                                      \
+       if (omap_clk_init)                                              \
+               omap_clk_init();                                        \
        omap_dmtimer_init();                                            \
        omap2_gp_clockevent_init((clkev_nr), clkev_src, clkev_prop);    \
        omap2_gptimer_clocksource_init((clksrc_nr), clksrc_src,         \
@@ -559,6 +561,8 @@ void __init omap##name##_gptimer_timer_init(void)                   \
                                clksrc_nr, clksrc_src, clksrc_prop)     \
 void __init omap##name##_sync32k_timer_init(void)              \
 {                                                                      \
+       if (omap_clk_init)                                              \
+               omap_clk_init();                                        \
        omap_dmtimer_init();                                            \
        omap2_gp_clockevent_init((clkev_nr), clkev_src, clkev_prop);    \
        /* Enable the use of clocksource="gp_timer" kernel parameter */ \




Thanks,
Vaibhav
