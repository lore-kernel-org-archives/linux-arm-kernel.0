From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue,  7 Jun 2016 21:53:05 +0300
Subject: [PATCH 4/4] ARM: i.MX: Move SOC_IMX1 into 'Device tree only'
In-Reply-To: <1465325585-1598-1-git-send-email-shc_work@mail.ru>
References: <1465325585-1598-1-git-send-email-shc_work@mail.ru>
Message-ID: <1465325585-1598-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves SOC_IMX1 into 'Device tree only' category and renames
imx1-dt.c to mach-imx1.c to align with the name schema of other
i.MX DT only platforms.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/configs/imx_v4_v5_defconfig |  8 ++-----
 arch/arm/mach-imx/Kconfig            | 31 ++++++++++---------------
 arch/arm/mach-imx/Makefile           |  4 +---
 arch/arm/mach-imx/imx1-dt.c          | 45 ------------------------------------
 arch/arm/mach-imx/mach-imx1.c        | 45 ++++++++++++++++++++++++++++++++++++
 5 files changed, 60 insertions(+), 73 deletions(-)
 delete mode 100644 arch/arm/mach-imx/imx1-dt.c
 create mode 100644 arch/arm/mach-imx/mach-imx1.c

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 9083399..72199de 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -22,14 +21,13 @@ CONFIG_ARCH_MULTI_V4T=y
 CONFIG_ARCH_MULTI_V5=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MXC=y
-CONFIG_MACH_SCB9328=y
-CONFIG_MACH_APF9328=y
 CONFIG_MACH_MX21ADS=y
 CONFIG_MACH_MX27ADS=y
 CONFIG_MACH_MX27_3DS=y
 CONFIG_MACH_IMX27_VISSTRIM_M10=y
 CONFIG_MACH_PCA100=y
 CONFIG_MACH_IMX27_DT=y
+CONFIG_SOC_IMX1=y
 CONFIG_SOC_IMX25=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 22d06f7..376c9f5 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -67,12 +67,6 @@ config IMX_HAVE_IOMUX_V1
 config ARCH_MXC_IOMUX_V3
 	bool
 
-config SOC_IMX1
-	bool
-	select CPU_ARM920T
-	select MXC_AVIC
-	select PINCTRL_IMX1
-
 config SOC_IMX21
 	bool
 	select CPU_ARM926T
@@ -101,19 +95,6 @@ config SOC_IMX35
 	select PINCTRL_IMX35
 	select SMP_ON_UP if SMP
 
-if ARCH_MULTI_V4T
-
-comment "MX1 platforms:"
-
-config MACH_IMX1_DT
-	bool "Support i.MX1 platforms from device tree"
-	select SOC_IMX1
-	help
-	  Include support for Freescale i.MX1 based platforms
-	  using the device tree for discovery.
-
-endif
-
 if ARCH_MULTI_V5
 
 comment "MX21 platforms:"
@@ -449,6 +430,18 @@ endif
 
 comment "Device tree only"
 
+if ARCH_MULTI_V4T
+
+config SOC_IMX1
+	bool "i.MX1 support"
+	select CPU_ARM920T
+	select MXC_AVIC
+	select PINCTRL_IMX1
+	help
+	  This enables support for Freescale i.MX1 processor
+
+endif
+
 if ARCH_MULTI_V5
 
 config SOC_IMX25
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index d50689d..15c25ed 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -34,9 +34,6 @@ obj-y += ssi-fiq.o
 obj-y += ssi-fiq-ksym.o
 endif
 
-# i.MX1 based machines
-obj-$(CONFIG_MACH_IMX1_DT) += imx1-dt.o
-
 # i.MX21 based machines
 obj-$(CONFIG_MACH_MX21ADS) += mach-mx21ads.o
 
@@ -90,6 +87,7 @@ obj-$(CONFIG_SOC_IMX53) += suspend-imx53.o
 endif
 obj-$(CONFIG_SOC_IMX6) += pm-imx6.o
 
+obj-$(CONFIG_SOC_IMX1) += mach-imx1.o
 obj-$(CONFIG_SOC_IMX50) += mach-imx50.o
 obj-$(CONFIG_SOC_IMX51) += mach-imx51.o
 obj-$(CONFIG_SOC_IMX53) += mach-imx53.o
diff --git a/arch/arm/mach-imx/imx1-dt.c b/arch/arm/mach-imx/imx1-dt.c
deleted file mode 100644
index de5ab8d..0000000
--- a/arch/arm/mach-imx/imx1-dt.c
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- *  Copyright (C) 2014 Alexander Shiyan <shc_work@mail.ru>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#include <linux/of_platform.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-
-#include "common.h"
-#include "hardware.h"
-
-#define MX1_AVIC_ADDR	0x00223000
-
-static void __init imx1_init_early(void)
-{
-	mxc_set_cpu_type(MXC_CPU_MX1);
-}
-
-static void __init imx1_init_irq(void)
-{
-	void __iomem *avic_addr;
-
-	avic_addr = ioremap(MX1_AVIC_ADDR, SZ_4K);
-	WARN_ON(!avic_addr);
-
-	mxc_init_irq(avic_addr);
-}
-
-static const char * const imx1_dt_board_compat[] __initconst = {
-	"fsl,imx1",
-	NULL
-};
-
-DT_MACHINE_START(IMX1_DT, "Freescale i.MX1 (Device Tree Support)")
-	.map_io		= debug_ll_io_init,
-	.init_early	= imx1_init_early,
-	.init_irq	= imx1_init_irq,
-	.dt_compat	= imx1_dt_board_compat,
-	.restart	= mxc_restart,
-MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx1.c b/arch/arm/mach-imx/mach-imx1.c
new file mode 100644
index 0000000..de5ab8d
--- /dev/null
+++ b/arch/arm/mach-imx/mach-imx1.c
@@ -0,0 +1,45 @@
+/*
+ *  Copyright (C) 2014 Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include "common.h"
+#include "hardware.h"
+
+#define MX1_AVIC_ADDR	0x00223000
+
+static void __init imx1_init_early(void)
+{
+	mxc_set_cpu_type(MXC_CPU_MX1);
+}
+
+static void __init imx1_init_irq(void)
+{
+	void __iomem *avic_addr;
+
+	avic_addr = ioremap(MX1_AVIC_ADDR, SZ_4K);
+	WARN_ON(!avic_addr);
+
+	mxc_init_irq(avic_addr);
+}
+
+static const char * const imx1_dt_board_compat[] __initconst = {
+	"fsl,imx1",
+	NULL
+};
+
+DT_MACHINE_START(IMX1_DT, "Freescale i.MX1 (Device Tree Support)")
+	.map_io		= debug_ll_io_init,
+	.init_early	= imx1_init_early,
+	.init_irq	= imx1_init_irq,
+	.dt_compat	= imx1_dt_board_compat,
+	.restart	= mxc_restart,
+MACHINE_END
-- 
2.4.9
