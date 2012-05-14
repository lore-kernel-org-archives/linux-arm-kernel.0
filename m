From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 14 May 2012 16:06:17 +0200
Subject: [PATCH 2/2] ARM: s3c64xx: cpuidle - use timekeeping wrapper
In-Reply-To: <1337004377-17732-1-git-send-email-daniel.lezcano@linaro.org>
References: <1337004377-17732-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1337004377-17732-3-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timekeeping is computed from the cpuidle core if we set
the .en_core_tk_irqen flag. Let's use it and remove the duplicated
code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-s3c64xx/cpuidle.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/cpuidle.c b/arch/arm/mach-s3c64xx/cpuidle.c
index 2750e54..acb197c 100644
--- a/arch/arm/mach-s3c64xx/cpuidle.c
+++ b/arch/arm/mach-s3c64xx/cpuidle.c
@@ -27,12 +27,7 @@ static int s3c64xx_enter_idle(struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv,
 			      int index)
 {
-	struct timeval before, after;
 	unsigned long tmp;
-	int idle_time;
-
-	local_irq_disable();
-	do_gettimeofday(&before);
 
 	/* Setup PWRCFG to enter idle mode */
 	tmp = __raw_readl(S3C64XX_PWR_CFG);
@@ -42,12 +37,6 @@ static int s3c64xx_enter_idle(struct cpuidle_device *dev,
 
 	cpu_do_idle();
 
-	do_gettimeofday(&after);
-	local_irq_enable();
-	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
-		    (after.tv_usec - before.tv_usec);
-
-	dev->last_residency = idle_time;
 	return index;
 }
 
@@ -56,6 +45,7 @@ static DEFINE_PER_CPU(struct cpuidle_device, s3c64xx_cpuidle_device);
 static struct cpuidle_driver s3c64xx_cpuidle_driver = {
 	.name	= "s3c64xx_cpuidle",
 	.owner  = THIS_MODULE,
+	.en_core_tk_irqen = 1,
 	.states = {
 		{
 			.enter            = s3c64xx_enter_idle,
-- 
1.7.5.4
