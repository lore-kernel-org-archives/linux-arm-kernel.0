From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 25 Mar 2013 18:55:30 +0100
Subject: [PATCH 05/15] cpuidle: imx6: remove timer broadcast initialization
In-Reply-To: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1364234140-514-6-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The initialization is done from the cpuidle framework.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-imx/cpuidle-imx6q.c |   15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
index 5ae22f7..a783a63 100644
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -6,7 +6,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/clockchips.h>
 #include <linux/cpuidle.h>
 #include <linux/module.h>
 #include <asm/cpuidle.h>
@@ -43,17 +42,6 @@ done:
 	return index;
 }
 
-/*
- * For each cpu, setup the broadcast timer because local timer
- * stops for the states other than WFI.
- */
-static void imx6q_setup_broadcast_timer(void *arg)
-{
-	int cpu = smp_processor_id();
-
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
-}
-
 static struct cpuidle_driver imx6q_cpuidle_driver = {
 	.name = "imx6q_cpuidle",
 	.owner = THIS_MODULE,
@@ -84,8 +72,5 @@ int __init imx6q_cpuidle_init(void)
 	/* Set chicken bit to get a reliable WAIT mode support */
 	imx6q_set_chicken_bit();
 
-	/* Configure the broadcast timer on each cpu */
-	on_each_cpu(imx6q_setup_broadcast_timer, NULL, 1);
-
 	return imx_cpuidle_init(&imx6q_cpuidle_driver);
 }
-- 
1.7.9.5
