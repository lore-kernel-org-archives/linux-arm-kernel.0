From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 12 Feb 2015 18:45:55 +0100
Subject: [PATCH 05/14] ARM: call reset_controller_of_init from default
 time_init handler
In-Reply-To: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1423763164-5606-6-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some DT ARM platforms need the reset controllers to be initialized before
the timers.
This is the case of the stm32 and sunxi platforms.

This patch adds a call to reset_controller_of_init() to the default
.init_time callback when RESET_CONTROLLER is used by the platform.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/kernel/time.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index 0cc7e58..4601b1e 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -20,6 +20,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/profile.h>
+#include <linux/reset-controller.h>
 #include <linux/sched.h>
 #include <linux/sched_clock.h>
 #include <linux/smp.h>
@@ -117,6 +118,9 @@ void __init time_init(void)
 	if (machine_desc->init_time) {
 		machine_desc->init_time();
 	} else {
+#ifdef CONFIG_RESET_CONTROLLER
+		reset_controller_of_init();
+#endif
 #ifdef CONFIG_COMMON_CLK
 		of_clk_init(NULL);
 #endif
-- 
1.9.1
