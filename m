From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 28 Sep 2011 17:06:43 +0800
Subject: [PATCH v4 2/7] arm/imx6q: add core definitions and low-level debug
	uart
In-Reply-To: <1317200808-6275-1-git-send-email-shawn.guo@linaro.org>
References: <1317200808-6275-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1317200808-6275-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds the core definitions and low-level debug uart support
for imx6q.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/Kconfig                             |    2 +-
 arch/arm/Kconfig.debug                       |    7 +++++
 arch/arm/Makefile                            |    1 +
 arch/arm/mach-imx/Kconfig                    |   14 +++++++++++
 arch/arm/mach-imx/Makefile                   |    2 +
 arch/arm/mach-imx/Makefile.boot              |    4 +++
 arch/arm/mach-imx/lluart.c                   |   32 +++++++++++++++++++++++++
 arch/arm/plat-mxc/Kconfig                    |    7 +++++
 arch/arm/plat-mxc/include/mach/debug-macro.S |    2 +
 arch/arm/plat-mxc/include/mach/hardware.h    |    6 ++++
 arch/arm/plat-mxc/include/mach/irqs.h        |   10 ++++++-
 arch/arm/plat-mxc/include/mach/memory.h      |    1 +
 arch/arm/plat-mxc/include/mach/mx6q.h        |   33 ++++++++++++++++++++++++++
 13 files changed, 118 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-imx/lluart.c
 create mode 100644 arch/arm/plat-mxc/include/mach/mx6q.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5cafa03..58d9343 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1363,7 +1363,7 @@ config SMP
 	depends on REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP || \
 		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
 		 ARCH_EXYNOS4 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || \
-		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE
+		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE || SOC_IMX6Q
 	select USE_GENERIC_SMP_HELPERS
 	select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP
 	help
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index add32ff..ba206e0 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -155,6 +155,13 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on i.MX50 or i.MX53.
 
+	config DEBUG_IMX6Q_UART
+		bool "i.MX6Q Debug UART"
+		depends on SOC_IMX6Q
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on i.MX6Q.
+
 	config DEBUG_S3C_UART0
 		depends on PLAT_SAMSUNG
 		bool "Use S3C UART 0 for low-level debug"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 30b9201..fc36c1b 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -160,6 +160,7 @@ machine-$(CONFIG_ARCH_MV78XX0)		:= mv78xx0
 machine-$(CONFIG_ARCH_IMX_V4_V5)	:= imx
 machine-$(CONFIG_ARCH_MX3)		:= imx
 machine-$(CONFIG_ARCH_MX5)		:= mx5
+machine-$(CONFIG_ARCH_MX6)		:= imx
 machine-$(CONFIG_ARCH_MXS)		:= mxs
 machine-$(CONFIG_ARCH_NETX)		:= netx
 machine-$(CONFIG_ARCH_NOMADIK)		:= nomadik
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 46cf2c5..4586edf 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -592,3 +592,17 @@ config MACH_VPR200
 	  configurations for the board and its peripherals.
 
 endif
+
+if ARCH_MX6
+comment "i.MX6 family:"
+
+config SOC_IMX6Q
+	bool "i.MX6 Quad support"
+	select ARM_GIC
+	select CPU_V7
+	select USE_OF
+
+	help
+	  This enables support for Freescale i.MX6 Quad processor.
+
+endif
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index d22096a..d291bc5 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -61,3 +61,5 @@ obj-$(CONFIG_MACH_MX35_3DS) += mach-mx35_3ds.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX35) += mach-cpuimx35.o
 obj-$(CONFIG_MACH_EUKREA_MBIMXSD35_BASEBOARD) += eukrea_mbimxsd35-baseboard.o
 obj-$(CONFIG_MACH_VPR200) += mach-vpr200.o
+
+obj-$(CONFIG_DEBUG_LL) += lluart.o
diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
index dbe6120..22d8588 100644
--- a/arch/arm/mach-imx/Makefile.boot
+++ b/arch/arm/mach-imx/Makefile.boot
@@ -17,3 +17,7 @@ initrd_phys-$(CONFIG_MACH_MX27)	:= 0xA0800000
 zreladdr-$(CONFIG_ARCH_MX3)	+= 0x80008000
 params_phys-$(CONFIG_ARCH_MX3)	:= 0x80000100
 initrd_phys-$(CONFIG_ARCH_MX3)	:= 0x80800000
+
+zreladdr-$(CONFIG_SOC_IMX6Q)	+= 0x10008000
+params_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10000100
+initrd_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10800000
diff --git a/arch/arm/mach-imx/lluart.c b/arch/arm/mach-imx/lluart.c
new file mode 100644
index 0000000..d4ab6f2
--- /dev/null
+++ b/arch/arm/mach-imx/lluart.c
@@ -0,0 +1,32 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/init.h>
+#include <asm/page.h>
+#include <asm/sizes.h>
+#include <asm/mach/map.h>
+#include <mach/hardware.h>
+
+static struct map_desc imx_lluart_desc = {
+#ifdef CONFIG_DEBUG_IMX6Q_UART
+	.virtual	= MX6Q_IO_P2V(MX6Q_UART4_BASE_ADDR),
+	.pfn		= __phys_to_pfn(MX6Q_UART4_BASE_ADDR),
+	.length		= MX6Q_UART4_SIZE,
+	.type		= MT_DEVICE,
+#endif
+};
+
+void __init imx_lluart_map_io(void)
+{
+	if (imx_lluart_desc.virtual)
+		iotable_init(&imx_lluart_desc, 1);
+}
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 502e45f..e2e3e5a 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -29,6 +29,13 @@ config ARCH_MX5
 	  This enables support for machines using Freescale's i.MX50 and i.MX51
 	  processors.
 
+config ARCH_MX6
+	bool "i.MX6"
+	select AUTO_ZRELADDR
+	select ARM_PATCH_PHYS_VIRT
+	help
+	  This enables support for systems based on the Freescale i.MX6 family
+
 endchoice
 
 source "arch/arm/mach-imx/Kconfig"
diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
index 07cfdbe..f2ce2cb 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -24,6 +24,8 @@
 #define UART_PADDR	MX51_UART1_BASE_ADDR
 #elif defined (CONFIG_DEBUG_IMX50_IMX53_UART)
 #define UART_PADDR	MX53_UART1_BASE_ADDR
+#elif defined (CONFIG_DEBUG_IMX6Q_UART)
+#define UART_PADDR	MX6Q_UART4_BASE_ADDR
 #endif
 
 #define UART_VADDR	IMX_IO_ADDRESS(UART_PADDR)
diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
index eba3118..a599f01 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -91,6 +91,11 @@
  *	SPBA0	0x50000000+0x100000	->	0xf5400000+0x100000
  *	AIPS1	0x53f00000+0x100000	->	0xf5700000+0x100000
  *	AIPS2	0x63f00000+0x100000	->	0xf5300000+0x100000
+ * mx6q:
+ *	SCU	0x00a00000+0x001000	->	0xf4000000+0x001000
+ *	CCM	0x020c4000+0x004000	->	0xf42c4000+0x004000
+ *	ANATOP	0x020c8000+0x001000	->	0xf42c8000+0x001000
+ *	UART4	0x021f0000+0x004000	->	0xf42f0000+0x004000
  */
 #define IMX_IO_P2V(x)	(						\
 			0xf4000000 +					\
@@ -102,6 +107,7 @@
 
 #include <mach/mxc.h>
 
+#include <mach/mx6q.h>
 #include <mach/mx50.h>
 #include <mach/mx51.h>
 #include <mach/mx53.h>
diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
index 00e812b..fd9efb0 100644
--- a/arch/arm/plat-mxc/include/mach/irqs.h
+++ b/arch/arm/plat-mxc/include/mach/irqs.h
@@ -14,9 +14,15 @@
 #include <asm-generic/gpio.h>
 
 /*
- * SoCs with TZIC interrupt controller have 128 IRQs, those with AVIC have 64
+ * SoCs with GIC interrupt controller have 160 IRQs, those with TZIC
+ * have 128 IRQs, and those with AVIC have 64.
+ *
+ * To support single image, the biggest number should be defined on
+ * top of the list.
  */
-#ifdef CONFIG_MXC_TZIC
+#if defined CONFIG_ARM_GIC
+#define MXC_INTERNAL_IRQS	160
+#elif defined CONFIG_MXC_TZIC
 #define MXC_INTERNAL_IRQS	128
 #else
 #define MXC_INTERNAL_IRQS	64
diff --git a/arch/arm/plat-mxc/include/mach/memory.h b/arch/arm/plat-mxc/include/mach/memory.h
index ae3541d..80e5bf2 100644
--- a/arch/arm/plat-mxc/include/mach/memory.h
+++ b/arch/arm/plat-mxc/include/mach/memory.h
@@ -19,6 +19,7 @@
 #define MX50_PHYS_OFFSET	UL(0x70000000)
 #define MX51_PHYS_OFFSET	UL(0x90000000)
 #define MX53_PHYS_OFFSET	UL(0x70000000)
+#define MX6Q_PHYS_OFFSET	UL(0x10000000)
 
 #if !defined(CONFIG_RUNTIME_PHYS_OFFSET)
 # if defined CONFIG_ARCH_MX3
diff --git a/arch/arm/plat-mxc/include/mach/mx6q.h b/arch/arm/plat-mxc/include/mach/mx6q.h
new file mode 100644
index 0000000..254a561
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/mx6q.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef __MACH_MX6Q_H__
+#define __MACH_MX6Q_H__
+
+#define MX6Q_IO_P2V(x)			IMX_IO_P2V(x)
+#define MX6Q_IO_ADDRESS(x)		IOMEM(MX6Q_IO_P2V(x))
+
+/*
+ * The following are the blocks that need to be statically mapped.
+ * For other blocks, the base address really should be retrieved from
+ * device tree.
+ */
+#define MX6Q_SCU_BASE_ADDR		0x00a00000
+#define MX6Q_SCU_SIZE			0x1000
+#define MX6Q_CCM_BASE_ADDR		0x020c4000
+#define MX6Q_CCM_SIZE			0x4000
+#define MX6Q_ANATOP_BASE_ADDR		0x020c8000
+#define MX6Q_ANATOP_SIZE		0x1000
+#define MX6Q_UART4_BASE_ADDR		0x021f0000
+#define MX6Q_UART4_SIZE			0x4000
+
+#endif	/* __MACH_MX6Q_H__ */
-- 
1.7.4.1
