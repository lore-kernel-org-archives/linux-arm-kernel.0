From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Tue,  3 Jul 2018 09:12:47 +0200
Subject: [PATCH v3] ARM: imx: Provide support for NXP i.MX7D Cortex-M4
Message-ID: <20180703071247.6545-1-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cortex M4 part can be started from a boot loader or over
Linux remoteproc framework.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig          | 33 +++++++++++++++++++-----------
 arch/arm/mach-imx/Makefile         |  3 ++-
 arch/arm/mach-imx/mach-imx7d-cm4.c | 18 ++++++++++++++++
 3 files changed, 41 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/mach-imx/mach-imx7d-cm4.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index e47fa13f4b0c..5ad58b1cb4bc 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -522,18 +522,6 @@ config SOC_IMX6UL
 	help
 	  This enables support for Freescale i.MX6 UltraLite processor.
 
-config SOC_IMX7D
-	bool "i.MX7 Dual support"
-	select PINCTRL_IMX7D
-	select ARM_GIC
-	select HAVE_ARM_ARCH_TIMER
-	select HAVE_IMX_ANATOP
-	select HAVE_IMX_MMDC
-	select HAVE_IMX_SRC
-	select IMX_GPCV2
-	help
-		This enables support for Freescale i.MX7 Dual processor.
-
 config SOC_LS1021A
 	bool "Freescale LS1021A support"
 	select ARM_GIC
@@ -548,6 +536,27 @@ comment "Cortex-A/Cortex-M asymmetric multiprocessing platforms"
 
 if ARCH_MULTI_V7 || ARM_SINGLE_ARMV7M
 
+config SOC_IMX7D_CA7
+	bool
+	select ARM_GIC
+	select HAVE_ARM_ARCH_TIMER
+	select HAVE_IMX_ANATOP
+	select HAVE_IMX_MMDC
+	select HAVE_IMX_SRC
+	select IMX_GPCV2
+
+config SOC_IMX7D_CM4
+	bool
+	select ARMV7M_SYSTICK
+
+config SOC_IMX7D
+	bool "i.MX7 Dual support"
+	select PINCTRL_IMX7D
+	select SOC_IMX7D_CA7 if ARCH_MULTI_V7
+	select SOC_IMX7D_CM4 if ARM_SINGLE_ARMV7M
+	help
+		This enables support for Freescale i.MX7 Dual processor.
+
 config SOC_VF610
 	bool "Vybrid Family VF610 support"
 	select ARM_GIC if ARCH_MULTI_V7
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 2327e3e876d8..64ebeb6a4f30 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -81,7 +81,8 @@ obj-$(CONFIG_SOC_IMX6SL) += mach-imx6sl.o
 obj-$(CONFIG_SOC_IMX6SLL) += mach-imx6sl.o
 obj-$(CONFIG_SOC_IMX6SX) += mach-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += mach-imx6ul.o
-obj-$(CONFIG_SOC_IMX7D) += mach-imx7d.o
+obj-$(CONFIG_SOC_IMX7D_CA7) += mach-imx7d.o
+obj-$(CONFIG_SOC_IMX7D_CM4) += mach-imx7d-cm4.o
 
 ifeq ($(CONFIG_SUSPEND),y)
 AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
diff --git a/arch/arm/mach-imx/mach-imx7d-cm4.c b/arch/arm/mach-imx/mach-imx7d-cm4.c
new file mode 100644
index 000000000000..0800b5891d2a
--- /dev/null
+++ b/arch/arm/mach-imx/mach-imx7d-cm4.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 Pengutronix, Oleksij Rempel <o.rempel@pengutronix.de>
+ */
+
+#include <linux/kernel.h>
+#include <asm/v7m.h>
+#include <asm/mach/arch.h>
+
+static const char * const imx7d_cm4_dt_compat[] __initconst = {
+	"fsl,imx7d-cm4",
+	NULL,
+};
+
+DT_MACHINE_START(IMX7D, "Freescale i.MX7 Dual Cortex-M4 (Device Tree)")
+	.dt_compat = imx7d_cm4_dt_compat,
+	.restart = armv7m_restart,
+MACHINE_END
-- 
2.17.1
