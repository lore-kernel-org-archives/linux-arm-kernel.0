From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Mar 2013 18:06:40 +0000
Subject: [PATCH 2/2] arm: vexpress: Decouple vexpress-poweroff implementation
 from machine_desc
In-Reply-To: <1363716400-9002-1-git-send-email-catalin.marinas@arm.com>
References: <1363716400-9002-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1363716400-9002-3-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the pm_power_off and arm_pm_restart variable settings to
the vexpress-poweroff.c driver to decouple it from the machine_desc
definition.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mach-vexpress/v2m.c            | 5 -----
 drivers/power/reset/vexpress-poweroff.c | 9 +++++++--
 include/linux/vexpress.h                | 3 ---
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 267b4f7..5dce863 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -362,8 +362,6 @@ static void __init v2m_init(void)
 	for (i = 0; i < ARRAY_SIZE(v2m_amba_devs); i++)
 		amba_device_register(v2m_amba_devs[i], &iomem_resource);
 
-	pm_power_off = vexpress_power_off;
-
 	ct_desc->init_tile();
 }
 
@@ -375,7 +373,6 @@ MACHINE_START(VEXPRESS, "ARM-Versatile Express")
 	.init_irq	= v2m_init_irq,
 	.init_time	= v2m_timer_init,
 	.init_machine	= v2m_init,
-	.restart	= vexpress_restart,
 MACHINE_END
 
 static struct map_desc v2m_rs1_io_desc __initdata = {
@@ -467,7 +464,6 @@ static void __init v2m_dt_init(void)
 {
 	l2x0_of_init(0x00400000, 0xfe0fffff);
 	of_platform_populate(NULL, v2m_dt_bus_match, NULL, NULL);
-	pm_power_off = vexpress_power_off;
 }
 
 static const char * const v2m_dt_match[] __initconst = {
@@ -484,5 +480,4 @@ DT_MACHINE_START(VEXPRESS_DT, "ARM-Versatile Express")
 	.init_irq	= irqchip_init,
 	.init_time	= v2m_dt_timer_init,
 	.init_machine	= v2m_dt_init,
-	.restart	= vexpress_restart,
 MACHINE_END
diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/vexpress-poweroff.c
index 465923a..469e696 100644
--- a/drivers/power/reset/vexpress-poweroff.c
+++ b/drivers/power/reset/vexpress-poweroff.c
@@ -18,6 +18,8 @@
 #include <linux/stat.h>
 #include <linux/vexpress.h>
 
+#include <asm/system_misc.h>
+
 static void vexpress_reset_do(struct device *dev, const char *what)
 {
 	int err = -ENOENT;
@@ -39,14 +41,14 @@ static void vexpress_reset_do(struct device *dev, const char *what)
 
 static struct device *vexpress_power_off_device;
 
-void vexpress_power_off(void)
+static void vexpress_power_off(void)
 {
 	vexpress_reset_do(vexpress_power_off_device, "power off");
 }
 
 static struct device *vexpress_restart_device;
 
-void vexpress_restart(char str, const char *cmd)
+static void vexpress_restart(char str, const char *cmd)
 {
 	vexpress_reset_do(vexpress_restart_device, "restart");
 }
@@ -103,14 +105,17 @@ static int vexpress_reset_probe(struct platform_device *pdev)
 	switch (func) {
 	case FUNC_SHUTDOWN:
 		vexpress_power_off_device = &pdev->dev;
+		pm_power_off = vexpress_power_off;
 		break;
 	case FUNC_RESET:
 		if (!vexpress_restart_device)
 			vexpress_restart_device = &pdev->dev;
+		arm_pm_restart = vexpress_restart;
 		device_create_file(&pdev->dev, &dev_attr_active);
 		break;
 	case FUNC_REBOOT:
 		vexpress_restart_device = &pdev->dev;
+		arm_pm_restart = vexpress_restart;
 		device_create_file(&pdev->dev, &dev_attr_active);
 		break;
 	};
diff --git a/include/linux/vexpress.h b/include/linux/vexpress.h
index 7581874..ea7168a 100644
--- a/include/linux/vexpress.h
+++ b/include/linux/vexpress.h
@@ -115,9 +115,6 @@ unsigned __vexpress_get_site(struct device *dev, struct device_node *node);
 void vexpress_sysreg_early_init(void __iomem *base);
 void vexpress_sysreg_of_early_init(void);
 
-void vexpress_power_off(void);
-void vexpress_restart(char str, const char *cmd);
-
 /* Clocks */
 
 struct clk *vexpress_osc_setup(struct device *dev);
