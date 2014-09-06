From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  6 Sep 2014 08:34:43 +0400
Subject: [PATCH 4/4] ARM: i.MX: Move SOC_IMX1 into 'Device tree only'
In-Reply-To: <1409978083-20047-1-git-send-email-shc_work@mail.ru>
References: <1409978083-20047-1-git-send-email-shc_work@mail.ru>
Message-ID: <1409978083-20047-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves SOC_IMX1 into 'Device tree only' category and renames
imx1-dt.c to mach-imx1.c to align with the name schema of other
i.MX DT only platforms.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/configs/imx_v4_v5_defconfig |  3 +--
 arch/arm/mach-imx/Kconfig            | 49 +++++++++++++-----------------------
 arch/arm/mach-imx/Makefile           |  5 +---
 arch/arm/mach-imx/imx1-dt.c          | 45 ---------------------------------
 arch/arm/mach-imx/mach-imx1.c        | 45 +++++++++++++++++++++++++++++++++
 5 files changed, 65 insertions(+), 82 deletions(-)
 delete mode 100644 arch/arm/mach-imx/imx1-dt.c
 create mode 100644 arch/arm/mach-imx/mach-imx1.c

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index a3fb866..69ddc41 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -22,8 +22,6 @@ CONFIG_ARCH_MULTI_V5=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MXC=y
 CONFIG_MXC_IRQ_PRIOR=y
-CONFIG_MACH_SCB9328=y
-CONFIG_MACH_APF9328=y
 CONFIG_MACH_MX21ADS=y
 CONFIG_MACH_MX25_3DS=y
 CONFIG_MACH_EUKREA_CPUIMX25SD=y
@@ -34,6 +32,7 @@ CONFIG_MACH_IMX27_VISSTRIM_M10=y
 CONFIG_MACH_PCA100=y
 CONFIG_MACH_MXT_TD60=y
 CONFIG_MACH_IMX27_DT=y
+CONFIG_SOC_IMX1=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 6333d30..e8d34f0 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -64,12 +64,6 @@ config IMX_HAVE_IOMUX_V1
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
@@ -105,19 +99,6 @@ config SOC_IMX35
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
@@ -553,35 +534,43 @@ config MACH_VPR200
 
 endif
 
-if ARCH_MULTI_V7
-
 comment "Device tree only"
 
+config SOC_IMX1
+	bool "i.MX1 support"
+	depends on ARCH_MULTI_V4T
+	select CPU_ARM920T
+	select MXC_AVIC
+	select PINCTRL_IMX1
+	help
+	  This enables support for Freescale i.MX1 processor.
+
 config SOC_IMX5
 	bool
 	select HAVE_IMX_SRC
 	select MXC_TZIC
 
-config	SOC_IMX50
+config SOC_IMX50
 	bool "i.MX50 support"
+	depends on ARCH_MULTI_V7
 	select PINCTRL_IMX50
 	select SOC_IMX5
-
 	help
 	  This enables support for Freescale i.MX50 processor.
 
 config SOC_IMX51
 	bool "i.MX51 support"
+	depends on ARCH_MULTI_V7
 	select PINCTRL_IMX51
 	select SOC_IMX5
 	help
 	  This enables support for Freescale i.MX51 processor
 
-config	SOC_IMX53
+config SOC_IMX53
 	bool "i.MX53 support"
+	depends on ARCH_MULTI_V7
 	select PINCTRL_IMX53
 	select SOC_IMX5
-
 	help
 	  This enables support for Freescale i.MX53 processor.
 
@@ -599,44 +588,42 @@ config SOC_IMX6
 
 config SOC_IMX6Q
 	bool "i.MX6 Quad/DualLite support"
+	depends on ARCH_MULTI_V7
 	select ARM_ERRATA_764369 if SMP
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select PCI_DOMAINS if PCI
 	select PINCTRL_IMX6Q
 	select SOC_IMX6
-
 	help
 	  This enables support for Freescale i.MX6 Quad processor.
 
 config SOC_IMX6SL
 	bool "i.MX6 SoloLite support"
+	depends on ARCH_MULTI_V7
 	select PINCTRL_IMX6SL
 	select SOC_IMX6
-
 	help
 	  This enables support for Freescale i.MX6 SoloLite processor.
 
 config SOC_IMX6SX
 	bool "i.MX6 SoloX support"
+	depends on ARCH_MULTI_V7
 	select PINCTRL_IMX6SX
 	select SOC_IMX6
-
 	help
 	  This enables support for Freescale i.MX6 SoloX processor.
 
 config SOC_VF610
 	bool "Vybrid Family VF610 support"
+	depends on ARCH_MULTI_V7
 	select ARM_GIC
 	select PINCTRL_VF610
 	select VF_PIT_TIMER
 	select PL310_ERRATA_769419 if CACHE_L2X0
-
 	help
 	  This enable support for Freescale Vybrid VF610 processor.
 
-endif
-
 source "arch/arm/mach-imx/devices/Kconfig"
 
 endif
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index ce7e05fb..ec165e2 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -1,6 +1,5 @@
 obj-y := time.o cpu.o system.o irq-common.o
 
-obj-$(CONFIG_SOC_IMX1) += clk-imx1.o
 obj-$(CONFIG_SOC_IMX21) += clk-imx21.o mm-imx21.o
 
 obj-$(CONFIG_SOC_IMX25) += clk-imx25.o mm-imx25.o ehci-imx25.o cpu-imx25.o
@@ -40,9 +39,6 @@ obj-y += ssi-fiq.o
 obj-y += ssi-fiq-ksym.o
 endif
 
-# i.MX1 based machines
-obj-$(CONFIG_MACH_IMX1_DT) += imx1-dt.o
-
 # i.MX21 based machines
 obj-$(CONFIG_MACH_MX21ADS) += mach-mx21ads.o
 
@@ -102,6 +98,7 @@ obj-$(CONFIG_SOC_IMX6) += suspend-imx6.o
 endif
 obj-$(CONFIG_SOC_IMX6) += pm-imx6.o
 
+obj-$(CONFIG_SOC_IMX1) += mach-imx1.o clk-imx1.o
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
1.8.5.5
