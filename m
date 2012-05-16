From: rob.lee@linaro.org (Robert Lee)
Date: Tue, 15 May 2012 21:33:36 -0500
Subject: [PATCH v4 7/7] ARM: imx: Add imx6q cpuidle driver
In-Reply-To: <1337135616-8988-1-git-send-email-rob.lee@linaro.org>
References: <1337135616-8988-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1337135616-8988-8-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic imx6q cpuidle driver.  For now, only basic WFI state is
supported.  Deeper idle states will be added in the future.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-imx/mach-imx6q.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index da6c1d9..4fc1fe7 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -10,7 +10,9 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <linux/cpuidle.h>
 #include <linux/delay.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -21,6 +23,7 @@
 #include <linux/of_platform.h>
 #include <linux/phy.h>
 #include <linux/micrel_phy.h>
+#include <asm/cpuidle.h>
 #include <asm/smp_twd.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
@@ -28,8 +31,10 @@
 #include <asm/mach/time.h>
 #include <asm/system_misc.h>
 #include <mach/common.h>
+#include <mach/cpuidle.h>
 #include <mach/hardware.h>
 
+
 void imx6q_restart(char mode, const char *cmd)
 {
 	struct device_node *np;
@@ -86,6 +91,19 @@ static void __init imx6q_init_machine(void)
 	imx6q_pm_init();
 }
 
+static struct cpuidle_driver imx6q_cpuidle_driver = {
+	.name			= "imx6q_cpuidle",
+	.owner			= THIS_MODULE,
+	.en_core_tk_irqen	= 1,
+	.states[0]		= ARM_CPUIDLE_WFI_STATE,
+	.state_count		= 1,
+};
+
+static void __init imx6q_init_late(void)
+{
+	imx_cpuidle_init(&imx6q_cpuidle_driver);
+}
+
 static void __init imx6q_map_io(void)
 {
 	imx_lluart_map_io();
@@ -142,6 +160,7 @@ DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad (Device Tree)")
 	.handle_irq	= imx6q_handle_irq,
 	.timer		= &imx6q_timer,
 	.init_machine	= imx6q_init_machine,
+	.init_late      = imx6q_init_late,
 	.dt_compat	= imx6q_dt_compat,
 	.restart	= imx6q_restart,
 MACHINE_END
-- 
1.7.10
