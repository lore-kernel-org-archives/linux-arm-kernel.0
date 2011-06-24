From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 24 Jun 2011 14:01:41 +0100
Subject: [PATCH] ARM: clocksource/arm_smp_twd: remove superfluous per_cpu v=
Message-ID: <mailman.33.1308921297.24103.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ariable

The twd_ce variable was used to track the per-cpu clock event devices
in the previous incarnation of the driver. As these clock event
devices are now directly accessible inside the driver, just get rid
of it and access the real thing directly.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/clocksource/arm_smp_twd.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/arm_smp_twd.c b/drivers/clocksource/arm_sm=
p_twd.c
index 4d58975..65f4669 100644
--- a/drivers/clocksource/arm_smp_twd.c
+++ b/drivers/clocksource/arm_smp_twd.c
@@ -40,7 +40,6 @@ static void __iomem *twd_base;
 static int twd_ppi;
=20
 static struct clk *twd_clk;
-static DEFINE_PER_CPU(struct clock_event_device *, twd_ce);
 static unsigned long twd_timer_rate;
 static DEFINE_PER_CPU(bool, irq_reqd);
 static struct clock_event_device __percpu *twd_evt;
@@ -106,7 +105,7 @@ static void twd_update_frequency(void *data)
 {
 =09twd_timer_rate =3D clk_get_rate(twd_clk);
=20
-=09clockevents_update_freq(__get_cpu_var(twd_ce), twd_timer_rate);
+=09clockevents_update_freq(__get_cpu_var(twd_evt), twd_timer_rate);
 }
=20
 static int twd_cpufreq_transition(struct notifier_block *nb,
@@ -238,7 +237,6 @@ static void __cpuinit twd_setup(void *data)
 =09=09return;
 =09}
=20
-=09__get_cpu_var(twd_ce) =3D clk;
 =09clockevents_config_and_register(clk, twd_timer_rate,
 =09=09=09=09=090xf, 0xffffffff);
 }
--=20
1.7.0.4

--------------040203090205030102060702--
