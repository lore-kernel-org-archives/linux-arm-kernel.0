From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 25 Mar 2013 18:55:29 +0100
Subject: [PATCH 04/15] cpuidle: OMAP4: remove timer broadcast initialization
In-Reply-To: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1364234140-514-5-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The initialization is done from the cpuidle framework.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index fe0e025..f4b1b23 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -14,7 +14,6 @@
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
 #include <linux/export.h>
-#include <linux/clockchips.h>
 
 #include <asm/proc-fns.h>
 
@@ -158,16 +157,6 @@ fail:
 	return index;
 }
 
-/*
- * For each cpu, setup the broadcast timer because local timers
- * stops for the states above C1.
- */
-static void omap_setup_broadcast_timer(void *arg)
-{
-	int cpu = smp_processor_id();
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
-}
-
 static DEFINE_PER_CPU(struct cpuidle_device, omap4_idle_dev);
 
 static struct cpuidle_driver omap4_idle_driver = {
@@ -233,9 +222,6 @@ int __init omap4_idle_init(void)
 	if (!cpu_clkdm[0] || !cpu_clkdm[1])
 		return -ENODEV;
 
-	/* Configure the broadcast timer on each cpu */
-	on_each_cpu(omap_setup_broadcast_timer, NULL, 1);
-
 	for_each_cpu(cpu_id, cpu_online_mask) {
 		dev = &per_cpu(omap4_idle_dev, cpu_id);
 		dev->cpu = cpu_id;
-- 
1.7.9.5
