From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 8 Oct 2012 18:24:16 +0800
Subject: [PATCH] ARM: tegra: cpuidle: replace LP3 with ARM_CPUIDLE_WFI_STATE
Message-ID: <1349691856-30590-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Tegra CPU idle LP3 state is doing ARM WFI only. So it's same with
the common ARM_CPUIDLE_WFI_STATE. Using it to replace LP3 now.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/cpuidle.c |   44 ++--------------------------------------
 1 files changed, 3 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle.c b/arch/arm/mach-tegra/cpuidle.c
index 566e2f8..4e0b07c 100644
--- a/arch/arm/mach-tegra/cpuidle.c
+++ b/arch/arm/mach-tegra/cpuidle.c
@@ -23,60 +23,22 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/cpu.h>
 #include <linux/cpuidle.h>
-#include <linux/hrtimer.h>
 
-#include <asm/proc-fns.h>
-
-#include <mach/iomap.h>
-
-static int tegra_idle_enter_lp3(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv, int index);
+#include <asm/cpuidle.h>
 
 struct cpuidle_driver tegra_idle_driver = {
 	.name = "tegra_idle",
 	.owner = THIS_MODULE,
+	.en_core_tk_irqen = 1,
 	.state_count = 1,
 	.states = {
-		[0] = {
-			.enter			= tegra_idle_enter_lp3,
-			.exit_latency		= 10,
-			.target_residency	= 10,
-			.power_usage		= 600,
-			.flags			= CPUIDLE_FLAG_TIME_VALID,
-			.name			= "LP3",
-			.desc			= "CPU flow-controlled",
-		},
+		[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
 	},
 };
 
 static DEFINE_PER_CPU(struct cpuidle_device, tegra_idle_device);
 
-static int tegra_idle_enter_lp3(struct cpuidle_device *dev,
-	struct cpuidle_driver *drv, int index)
-{
-	ktime_t enter, exit;
-	s64 us;
-
-	local_irq_disable();
-	local_fiq_disable();
-
-	enter = ktime_get();
-
-	cpu_do_idle();
-
-	exit = ktime_sub(ktime_get(), enter);
-	us = ktime_to_us(exit);
-
-	local_fiq_enable();
-	local_irq_enable();
-
-	dev->last_residency = us;
-
-	return index;
-}
-
 static int __init tegra_cpuidle_init(void)
 {
 	int ret;
-- 
1.7.0.4
