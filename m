From: b20788@freescale.com (Anson Huang)
Date: Wed, 20 Mar 2013 19:39:42 -0400
Subject: [PATCH V2 1/3] ARM: imx: enable anatop suspend/resume
Message-ID: <1363822784-12700-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Anatop module have sereval configurations for user
to reduce the power consumption in suspend, provide
suspend/resume interface for further use and enable
fet_odrive to reduce CORE LDO leakage during suspend.

As we have a common anatop file, remove all the operations
of anatop module in other files, use anatop interfaces to
do that.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/Kconfig      |    4 +++
 arch/arm/mach-imx/Makefile     |    1 +
 arch/arm/mach-imx/anatop.c     |   74 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/common.h     |    7 +++-
 arch/arm/mach-imx/mach-imx6q.c |   48 ++++----------------------
 arch/arm/mach-imx/pm-imx6q.c   |    4 ++-
 6 files changed, 94 insertions(+), 44 deletions(-)
 create mode 100644 arch/arm/mach-imx/anatop.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 4c9c6f9..82365d6 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -65,6 +65,9 @@ config IRAM_ALLOC
 	bool
 	select GENERIC_ALLOCATOR
 
+config HAVE_IMX_ANATOP
+	bool
+
 config HAVE_IMX_GPC
 	bool
 
@@ -813,6 +816,7 @@ config SOC_IMX6Q
 	select CPU_V7
 	select HAVE_ARM_SCU
 	select HAVE_CAN_FLEXCAN if CAN
+	select HAVE_IMX_ANATOP
 	select HAVE_IMX_GPC
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index c4ce090..148dc5d 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_MACH_EUKREA_CPUIMX35SD) += mach-cpuimx35.o
 obj-$(CONFIG_MACH_EUKREA_MBIMXSD35_BASEBOARD) += eukrea_mbimxsd35-baseboard.o
 obj-$(CONFIG_MACH_VPR200) += mach-vpr200.o
 
+obj-$(CONFIG_HAVE_IMX_ANATOP) += anatop.o
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
 obj-$(CONFIG_HAVE_IMX_MMDC) += mmdc.o
 obj-$(CONFIG_HAVE_IMX_SRC) += src.o
diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
new file mode 100644
index 0000000..b396b92
--- /dev/null
+++ b/arch/arm/mach-imx/anatop.c
@@ -0,0 +1,74 @@
+/*
+ * Copyright (C) 2013 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+
+#define REG_SET		0x4
+#define REG_CLR		0x8
+
+#define ANADIG_REG_CORE		0x140
+#define ANADIG_USB1_CHRG_DETECT	0x1b0
+#define ANADIG_USB2_CHRG_DETECT	0x210
+#define ANADIG_DIGPROG		0x260
+
+#define BM_ANADIG_REG_CORE_FET_ODRIVE		0x20000000
+#define BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B	0x80000
+#define BM_ANADIG_USB_CHRG_DETECT_EN_B		0x100000
+
+static struct regmap *anatop;
+
+static void imx_anatop_enable_fet_odrive(bool enable)
+{
+	regmap_write(anatop, ANADIG_REG_CORE + (enable ? REG_SET : REG_CLR),
+		BM_ANADIG_REG_CORE_FET_ODRIVE);
+}
+
+void imx_anatop_pre_suspend(void)
+{
+	imx_anatop_enable_fet_odrive(true);
+}
+
+void imx_anatop_post_resume(void)
+{
+	imx_anatop_enable_fet_odrive(false);
+}
+
+void imx_anatop_usb_chrg_detect_disable(void)
+{
+	regmap_write(anatop, ANADIG_USB1_CHRG_DETECT,
+		BM_ANADIG_USB_CHRG_DETECT_EN_B
+		| BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B);
+	regmap_write(anatop, ANADIG_USB2_CHRG_DETECT,
+		BM_ANADIG_USB_CHRG_DETECT_EN_B |
+		BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B);
+}
+
+u32 imx_anatop_get_digprog(void)
+{
+	u32  val;
+
+	regmap_read(anatop, ANADIG_DIGPROG, &val);
+	return val;
+}
+
+void __init imx_anatop_init(void)
+{
+	anatop = syscon_regmap_lookup_by_compatible("fsl,imx6q-anatop");
+	if (IS_ERR(anatop)) {
+		pr_err("%s: failed to find imx6q-anatop regmap!\n", __func__);
+		return;
+	}
+}
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 5a800bf..69451a9 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2004-2013 Freescale Semiconductor, Inc. All Rights Reserved.
  */
 
 /*
@@ -129,6 +129,11 @@ extern void imx_src_prepare_restart(void);
 extern void imx_gpc_init(void);
 extern void imx_gpc_pre_suspend(void);
 extern void imx_gpc_post_resume(void);
+extern void imx_anatop_init(void);
+extern void imx_anatop_pre_suspend(void);
+extern void imx_anatop_post_resume(void);
+extern void imx_anatop_usb_chrg_detect_disable(void);
+extern u32 imx_anatop_get_digprog(void);
 extern int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
 extern void imx6q_set_chicken_bit(void);
 
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 9ffd103..31aee4d 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011-2013 Freescale Semiconductor, Inc.
  * Copyright 2011 Linaro Ltd.
  *
  * The code contained herein is licensed under the GNU General Public
@@ -39,27 +39,12 @@
 #include "cpuidle.h"
 #include "hardware.h"
 
-#define IMX6Q_ANALOG_DIGPROG	0x260
-
 static int imx6q_revision(void)
 {
-	struct device_node *np;
-	void __iomem *base;
 	static u32 rev;
 
-	if (!rev) {
-		np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
-		if (!np)
-			return IMX_CHIP_REVISION_UNKNOWN;
-		base = of_iomap(np, 0);
-		if (!base) {
-			of_node_put(np);
-			return IMX_CHIP_REVISION_UNKNOWN;
-		}
-		rev =  readl_relaxed(base + IMX6Q_ANALOG_DIGPROG);
-		iounmap(base);
-		of_node_put(np);
-	}
+	if (!rev)
+		rev = imx_anatop_get_digprog();
 
 	switch (rev & 0xff) {
 	case 0:
@@ -165,29 +150,7 @@ static void __init imx6q_1588_init(void)
 }
 static void __init imx6q_usb_init(void)
 {
-	struct regmap *anatop;
-
-#define HW_ANADIG_USB1_CHRG_DETECT		0x000001b0
-#define HW_ANADIG_USB2_CHRG_DETECT		0x00000210
-
-#define BM_ANADIG_USB_CHRG_DETECT_EN_B		0x00100000
-#define BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B	0x00080000
-
-	anatop = syscon_regmap_lookup_by_compatible("fsl,imx6q-anatop");
-	if (!IS_ERR(anatop)) {
-		/*
-		 * The external charger detector needs to be disabled,
-		 * or the signal at DP will be poor
-		 */
-		regmap_write(anatop, HW_ANADIG_USB1_CHRG_DETECT,
-				BM_ANADIG_USB_CHRG_DETECT_EN_B
-				| BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B);
-		regmap_write(anatop, HW_ANADIG_USB2_CHRG_DETECT,
-				BM_ANADIG_USB_CHRG_DETECT_EN_B |
-				BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B);
-	} else {
-		pr_warn("failed to find fsl,imx6q-anatop regmap\n");
-	}
+	imx_anatop_usb_chrg_detect_disable();
 }
 
 static void __init imx6q_init_machine(void)
@@ -197,9 +160,11 @@ static void __init imx6q_init_machine(void)
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
+	imx_anatop_init();
 	imx6q_pm_init();
 	imx6q_usb_init();
 	imx6q_1588_init();
+	imx_print_silicon_rev("i.MX6Q", imx6q_revision());
 }
 
 #define OCOTP_CFG3			0x440
@@ -293,7 +258,6 @@ static void __init imx6q_timer_init(void)
 {
 	mx6q_clocks_init();
 	twd_local_timer_of_register();
-	imx_print_silicon_rev("i.MX6Q", imx6q_revision());
 }
 
 static const char *imx6q_dt_compat[] __initdata = {
diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
index 5faba7a..2049427 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011-2013 Freescale Semiconductor, Inc.
  * Copyright 2011 Linaro Ltd.
  *
  * The code contained herein is licensed under the GNU General Public
@@ -34,10 +34,12 @@ static int imx6q_pm_enter(suspend_state_t state)
 	case PM_SUSPEND_MEM:
 		imx6q_set_lpm(STOP_POWER_OFF);
 		imx_gpc_pre_suspend();
+		imx_anatop_pre_suspend();
 		imx_set_cpu_jump(0, v7_cpu_resume);
 		/* Zzz ... */
 		cpu_suspend(0, imx6q_suspend_finish);
 		imx_smp_prepare();
+		imx_anatop_post_resume();
 		imx_gpc_post_resume();
 		imx6q_set_lpm(WAIT_CLOCKED);
 		break;
-- 
1.7.9.5
