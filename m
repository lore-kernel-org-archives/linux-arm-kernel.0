From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 19 May 2011 18:55:22 +0200
Subject: [PATCH] Fix smallish cleanup
Message-ID: <mailman.244.1305826349.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/kernel/smp_twd.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index dbf58d4..968f298 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -25,8 +25,6 @@
 #include <asm/smp_twd.h>
 #include <asm/hardware/gic.h>

-#define TWD_MIN_RANGE 4
-
 /* set up by the platform code */
 void __iomem *twd_base;

@@ -96,8 +94,7 @@ static void twd_update_frequency(void *data)
 {
        twd_timer_rate =3D clk_get_rate(twd_clk);

-       clockevents_reconfigure(__get_cpu_var(twd_ce), twd_timer_rate,
-                       TWD_MIN_RANGE);
+       clockevents_update_freq(__get_cpu_var(twd_ce), twd_timer_rate);
 }

 static int twd_cpufreq_transition(struct notifier_block *nb,
@@ -193,15 +190,11 @@ void __cpuinit twd_timer_setup(struct
clock_event_device *clk)
        clk->set_mode =3D twd_set_mode;
        clk->set_next_event =3D twd_set_next_event;

-       clockevents_calc_mult_shift(clk, twd_timer_rate, TWD_MIN_RANGE);
-
-       clk->max_delta_ns =3D clockevent_delta2ns(0xffffffff, clk);
-       clk->min_delta_ns =3D clockevent_delta2ns(0xf, clk);
-
        /* Make sure our local interrupt controller has this enabled */
        gic_enable_ppi(clk->irq);

        __get_cpu_var(twd_ce) =3D clk;

-       clockevents_register_device(clk);
+       clockevents_config_and_register(clk, twd_timer_rate,
+                                       0xf, 0xffffffff);
 }
--=20
1.7.3.2


With these changes (provided they work) all should be well, so:
Tested-by: Linus Walleij <linus.walleij@linaro.org>

If all is well on your side as well, ask Thomas to take this into the
timers/clockevents branch where all dependencies are.

Yours,
Linus Walleij
