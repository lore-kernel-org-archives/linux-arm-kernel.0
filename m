From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 15 Mar 2013 15:27:05 +0100
Subject: [RFC patch 06/11] cpuidle / at91 : use common ARM cpuidle driver
In-Reply-To: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
References: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1363357630-22214-7-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-at91/cpuidle.c |   15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
index 0c63815..9dc4f6f 100644
--- a/arch/arm/mach-at91/cpuidle.c
+++ b/arch/arm/mach-at91/cpuidle.c
@@ -27,8 +27,6 @@
 
 #define AT91_MAX_STATES	2
 
-static DEFINE_PER_CPU(struct cpuidle_device, at91_cpuidle_device);
-
 /* Actual code that puts the SoC in different idle states */
 static int at91_enter_idle(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
@@ -63,18 +61,7 @@ static struct cpuidle_driver at91_idle_driver = {
 /* Initialize CPU idle by registering the idle states */
 static int at91_init_cpuidle(void)
 {
-	struct cpuidle_device *device;
-
-	device = &per_cpu(at91_cpuidle_device, smp_processor_id());
-	device->state_count = AT91_MAX_STATES;
-
-	cpuidle_register_driver(&at91_idle_driver);
-
-	if (cpuidle_register_device(device)) {
-		printk(KERN_ERR "at91_init_cpuidle: Failed registering\n");
-		return -EIO;
-	}
-	return 0;
+	return arm_idle_init(&at91_idle_driver);
 }
 
 device_initcall(at91_init_cpuidle);
-- 
1.7.9.5
