From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 25 Jun 2013 17:24:02 +0800
Subject: [PATCH V3 3/3] ARM: tegra114: cpuidle: add powered-down state
In-Reply-To: <1372152242-16373-1-git-send-email-josephl@nvidia.com>
References: <1372152242-16373-1-git-send-email-josephl@nvidia.com>
Message-ID: <1372152242-16373-5-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This supports CPU core power down on each CPU when CPU idle. When CPU go
into this state, it saves it's context and needs a proper configuration
in flow controller to power gate the CPU when CPU runs into WFI
instruction. And the CPU also needs to set the IRQ as CPU power down idle
wake up event in flow controller.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V3:
* use CPUIDLE_FLAG_TIMER_STOP flag
V2:
* remove some redundant code of memory barrier
* remove the function declaration by rearranging the coding sequence 
---
 arch/arm/mach-tegra/cpuidle-tegra114.c | 48 +++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
index 1d1c602..658b205 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra114.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
@@ -17,15 +17,61 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/cpuidle.h>
+#include <linux/cpu_pm.h>
+#include <linux/clockchips.h>
 
 #include <asm/cpuidle.h>
+#include <asm/suspend.h>
+#include <asm/smp_plat.h>
+
+#include "pm.h"
+#include "sleep.h"
+
+#ifdef CONFIG_PM_SLEEP
+#define TEGRA114_MAX_STATES 2
+#else
+#define TEGRA114_MAX_STATES 1
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+static int tegra114_idle_power_down(struct cpuidle_device *dev,
+				    struct cpuidle_driver *drv,
+				    int index)
+{
+	local_fiq_disable();
+
+	tegra_set_cpu_in_lp2();
+	cpu_pm_enter();
+
+	cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
+
+	cpu_pm_exit();
+	tegra_clear_cpu_in_lp2();
+
+	local_fiq_enable();
+
+	return index;
+}
+#endif
 
 static struct cpuidle_driver tegra_idle_driver = {
 	.name = "tegra_idle",
 	.owner = THIS_MODULE,
-	.state_count = 1,
+	.state_count = TEGRA114_MAX_STATES,
 	.states = {
 		[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
+#ifdef CONFIG_PM_SLEEP
+		[1] = {
+			.enter			= tegra114_idle_power_down,
+			.exit_latency		= 500,
+			.target_residency	= 1000,
+			.power_usage		= 0,
+			.flags			= CPUIDLE_FLAG_TIME_VALID |
+						  CPUIDLE_FLAG_TIMER_STOP,
+			.name			= "powered-down",
+			.desc			= "CPU power gated",
+		},
+#endif
 	},
 };
 
-- 
1.8.3.1
