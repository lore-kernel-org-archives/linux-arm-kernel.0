From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Tue,  2 Sep 2014 14:19:11 -0700
Subject: [PATCH v2 6/9] ARM: zynq: cpuidle: Remove pointless code
In-Reply-To: <1409692754-13437-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1409692754-13437-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1409692754-13437-7-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

The core is not powered down, it is pointless to call the cpu_pm notifiers and
switch to the global timer.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-and-tested-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/cpuidle/cpuidle-zynq.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-zynq.c b/drivers/cpuidle/cpuidle-zynq.c
index aded75928028..c61b8b2a7c77 100644
--- a/drivers/cpuidle/cpuidle-zynq.c
+++ b/drivers/cpuidle/cpuidle-zynq.c
@@ -26,7 +26,6 @@
  */
 
 #include <linux/init.h>
-#include <linux/cpu_pm.h>
 #include <linux/cpuidle.h>
 #include <linux/platform_device.h>
 #include <asm/proc-fns.h>
@@ -38,15 +37,9 @@
 static int zynq_enter_idle(struct cpuidle_device *dev,
 			   struct cpuidle_driver *drv, int index)
 {
-	/* Devices must be stopped here */
-	cpu_pm_enter();
-
 	/* Add code for DDR self refresh start */
 	cpu_do_idle();
 
-	/* Add code for DDR self refresh stop */
-	cpu_pm_exit();
-
 	return index;
 }
 
@@ -59,8 +52,7 @@ static struct cpuidle_driver zynq_idle_driver = {
 			.enter			= zynq_enter_idle,
 			.exit_latency		= 10,
 			.target_residency	= 10000,
-			.flags			= CPUIDLE_FLAG_TIME_VALID |
-						  CPUIDLE_FLAG_TIMER_STOP,
+			.flags			= CPUIDLE_FLAG_TIME_VALID,
 			.name			= "RAM_SR",
 			.desc			= "WFI and RAM Self Refresh",
 		},
-- 
2.1.0.1.g27b9230
