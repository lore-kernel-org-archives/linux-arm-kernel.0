From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 18 Dec 2013 15:59:37 +0100
Subject: [PATCH] ARM: ux500: Enable system suspend with WFI support
Message-ID: <1387378777-7639-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building for CONFIG_SUSPEND, add the platform suspend callbacks
to enable system suspend for ux500.

At this initial step, only WFI state is supported, which is reached
for both PM_SUSPEND_MEM and PM_SUSPEND_STANDBY.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-ux500/pm.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/mach-ux500/pm.c b/arch/arm/mach-ux500/pm.c
index 1a468f0..b80a9a2 100644
--- a/arch/arm/mach-ux500/pm.c
+++ b/arch/arm/mach-ux500/pm.c
@@ -3,6 +3,8 @@
  * Author: Rickard Andersson <rickard.andersson@stericsson.com> for
  *         ST-Ericsson.
  * Author: Daniel Lezcano <daniel.lezcano@linaro.org> for Linaro.
+ * Author: Ulf Hansson <ulf.hansson@linaro.org> for Linaro.
+ *
  * License terms: GNU General Public License (GPL) version 2
  *
  */
@@ -11,6 +13,7 @@
 #include <linux/irqchip/arm-gic.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/suspend.h>
 #include <linux/platform_data/arm-ux500-pm.h>
 
 #include "db8500-regs.h"
@@ -152,6 +155,27 @@ int prcmu_copy_gic_settings(void)
 	return 0;
 }
 
+#ifdef CONFIG_SUSPEND
+static int ux500_suspend_enter(suspend_state_t state)
+{
+	cpu_do_idle();
+	return 0;
+}
+
+static int ux500_suspend_valid(suspend_state_t state)
+{
+	return state == PM_SUSPEND_MEM || state == PM_SUSPEND_STANDBY;
+}
+
+static const struct platform_suspend_ops ux500_suspend_ops = {
+	.enter	      = ux500_suspend_enter,
+	.valid	      = ux500_suspend_valid,
+};
+#define UX500_SUSPEND_OPS	(&ux500_suspend_ops)
+#else
+#define UX500_SUSPEND_OPS	NULL
+#endif
+
 void __init ux500_pm_init(u32 phy_base, u32 size)
 {
 	prcmu_base = ioremap(phy_base, size);
@@ -164,4 +188,7 @@ void __init ux500_pm_init(u32 phy_base, u32 size)
 	 * This will make sure that the GIC is correctly configured.
 	 */
 	prcmu_gic_recouple();
+
+	/* Set up ux500 suspend callbacks. */
+	suspend_set_ops(UX500_SUSPEND_OPS);
 }
-- 
1.7.9.5
