From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Jun 2016 12:49:58 +0200
Subject: [PATCH 3/6] ARM: imx: deconstruct mx3_idle
In-Reply-To: <20160624105001.3166287-1-arnd@arndb.de>
References: <20160624105001.3166287-1-arnd@arndb.de>
Message-ID: <20160624105001.3166287-4-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx31 and imx35 idle functions are almost the same, but we
currently have to check the cpu type every time. This can be
simplified by moving the logic from mx3_cpu_lp_set() into
two separate idle functions, removing the last user of
cpu_is_mx35.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/Makefile  |  4 ++--
 arch/arm/mach-imx/mm-imx3.c | 26 ++++++++++++++++++++++----
 arch/arm/mach-imx/pm-imx3.c | 38 --------------------------------------
 3 files changed, 24 insertions(+), 44 deletions(-)
 delete mode 100644 arch/arm/mach-imx/pm-imx3.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 9fbe624a5ef9..9f5fffd62702 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -8,8 +8,8 @@ obj-$(CONFIG_SOC_IMX25) += cpu-imx25.o mach-imx25.o pm-imx25.o
 obj-$(CONFIG_SOC_IMX27) += cpu-imx27.o pm-imx27.o
 obj-$(CONFIG_SOC_IMX27) += mm-imx27.o ehci-imx27.o
 
-obj-$(CONFIG_SOC_IMX31) += mm-imx3.o cpu-imx31.o iomux-imx31.o ehci-imx31.o pm-imx3.o
-obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o ehci-imx35.o pm-imx3.o
+obj-$(CONFIG_SOC_IMX31) += mm-imx3.o cpu-imx31.o iomux-imx31.o ehci-imx31.o
+obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o ehci-imx35.o
 
 imx5-pm-$(CONFIG_PM) += pm-imx5.o
 obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o $(imx5-pm-y)
diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 3b135cd4b043..7638a35b3b36 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -19,6 +19,7 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/pinctrl/machine.h>
 
 #include <asm/pgtable.h>
@@ -38,8 +39,6 @@ static void imx3_idle(void)
 {
 	unsigned long reg = 0;
 
-	mx3_cpu_lp_set(MX3_WAIT);
-
 	__asm__ __volatile__(
 		/* disable I and D cache */
 		"mrc p15, 0, %0, c1, c0, 0\n"
@@ -135,11 +134,20 @@ void __init mx31_map_io(void)
 	iotable_init(mx31_io_desc, ARRAY_SIZE(mx31_io_desc));
 }
 
+static void imx31_idle(void)
+{
+	int reg = imx_readl(mx3_ccm_base + MXC_CCM_CCMR);
+	reg &= ~MXC_CCM_CCMR_LPM_MASK;
+	imx_writel(reg, mx3_ccm_base + MXC_CCM_CCMR);
+
+	imx3_idle();
+}
+
 void __init imx31_init_early(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX31);
 	arch_ioremap_caller = imx3_ioremap_caller;
-	arm_pm_idle = imx3_idle;
+	arm_pm_idle = imx31_idle;
 	mx3_ccm_base = MX31_IO_ADDRESS(MX31_CCM_BASE_ADDR);
 }
 
@@ -218,11 +226,21 @@ void __init mx35_map_io(void)
 	iotable_init(mx35_io_desc, ARRAY_SIZE(mx35_io_desc));
 }
 
+static void imx35_idle(void)
+{
+	int reg = imx_readl(mx3_ccm_base + MXC_CCM_CCMR);
+	reg &= ~MXC_CCM_CCMR_LPM_MASK;
+	reg |= MXC_CCM_CCMR_LPM_WAIT_MX35;
+	imx_writel(reg, mx3_ccm_base + MXC_CCM_CCMR);
+
+	imx3_idle();
+}
+
 void __init imx35_init_early(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX35);
 	mxc_iomux_v3_init(MX35_IO_ADDRESS(MX35_IOMUXC_BASE_ADDR));
-	arm_pm_idle = imx3_idle;
+	arm_pm_idle = imx35_idle;
 	arch_ioremap_caller = imx3_ioremap_caller;
 	mx3_ccm_base = MX35_IO_ADDRESS(MX35_CCM_BASE_ADDR);
 }
diff --git a/arch/arm/mach-imx/pm-imx3.c b/arch/arm/mach-imx/pm-imx3.c
deleted file mode 100644
index 94c0898751d8..000000000000
--- a/arch/arm/mach-imx/pm-imx3.c
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- *  Copyright (C) 2012 Freescale Semiconductor, Inc. All Rights Reserved.
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-#include <linux/io.h>
-
-#include "common.h"
-#include "crmregs-imx3.h"
-#include "devices/devices-common.h"
-#include "hardware.h"
-
-/*
- * Set cpu low power mode before WFI instruction. This function is called
- * mx3 because it can be used for mx31 and mx35.
- * Currently only WAIT_MODE is supported.
- */
-void mx3_cpu_lp_set(enum mx3_cpu_pwr_mode mode)
-{
-	int reg = imx_readl(mx3_ccm_base + MXC_CCM_CCMR);
-	reg &= ~MXC_CCM_CCMR_LPM_MASK;
-
-	switch (mode) {
-	case MX3_WAIT:
-		if (cpu_is_mx35())
-			reg |= MXC_CCM_CCMR_LPM_WAIT_MX35;
-		imx_writel(reg, mx3_ccm_base + MXC_CCM_CCMR);
-		break;
-	default:
-		pr_err("Unknown cpu power mode: %d\n", mode);
-		return;
-	}
-}
-- 
2.9.0
