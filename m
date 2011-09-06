From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue,  6 Sep 2011 17:58:36 +0800
Subject: [PATCH 2/6] arm/imx6q: add core definitions and low-level debug uart
In-Reply-To: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1315303120-24203-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds the core definitions and low-level debug uart support
for imx6q.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/Kconfig                             |    2 +-
 arch/arm/Kconfig.debug                       |    7 +++++
 arch/arm/Makefile                            |    1 +
 arch/arm/mach-imx/Kconfig                    |    4 +++
 arch/arm/mach-imx/Makefile                   |    2 +
 arch/arm/mach-imx/Makefile.boot              |    4 +++
 arch/arm/mach-imx/lluart.c                   |   33 ++++++++++++++++++++++++++
 arch/arm/plat-mxc/Kconfig                    |    5 ++++
 arch/arm/plat-mxc/include/mach/debug-macro.S |    5 ++++
 arch/arm/plat-mxc/include/mach/entry-macro.S |   15 +++++++++++-
 arch/arm/plat-mxc/include/mach/hardware.h    |    1 +
 arch/arm/plat-mxc/include/mach/irqs.h        |    9 ++++--
 arch/arm/plat-mxc/include/mach/memory.h      |    3 ++
 arch/arm/plat-mxc/include/mach/mx6q.h        |   29 ++++++++++++++++++++++
 14 files changed, 115 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-imx/lluart.c
 create mode 100644 arch/arm/plat-mxc/include/mach/mx6q.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4ea9974..37c20a4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1348,7 +1348,7 @@ config SMP
 	depends on REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP || \
 		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
 		 ARCH_EXYNOS4 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || \
-		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE
+		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE || SOC_IMX6Q
 	select USE_GENERIC_SMP_HELPERS
 	select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP
 	help
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 965d59a..68fc155 100644
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
index 70c424e..3a0bbe4 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -159,6 +159,7 @@ machine-$(CONFIG_ARCH_MX2)		:= imx
 machine-$(CONFIG_ARCH_MX25)		:= imx
 machine-$(CONFIG_ARCH_MX3)		:= imx
 machine-$(CONFIG_ARCH_MX5)		:= mx5
+machine-$(CONFIG_ARCH_MX6)		:= imx
 machine-$(CONFIG_ARCH_MXS)		:= mxs
 machine-$(CONFIG_ARCH_NETX)		:= netx
 machine-$(CONFIG_ARCH_NOMADIK)		:= nomadik
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 0519dd7..4cf5178 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -58,6 +58,10 @@ config SOC_IMX35
 	select ARCH_MX35
 	select MXC_AVIC
 
+config SOC_IMX6Q
+	bool
+	select ARM_GIC
+	select CPU_V7
 
 if ARCH_MX1
 
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index e9eb36d..96ecc96 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -61,3 +61,5 @@ obj-$(CONFIG_MACH_MX35_3DS) += mach-mx35_3ds.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX35) += mach-cpuimx35.o
 obj-$(CONFIG_MACH_EUKREA_MBIMXSD35_BASEBOARD) += eukrea_mbimxsd35-baseboard.o
 obj-$(CONFIG_MACH_VPR200) += mach-vpr200.o
+
+obj-$(CONFIG_DEBUG_LL) += lluart.o
diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
index ebee18b..389a0e3 100644
--- a/arch/arm/mach-imx/Makefile.boot
+++ b/arch/arm/mach-imx/Makefile.boot
@@ -17,3 +17,7 @@ initrd_phys-$(CONFIG_MACH_MX27)	:= 0xA0800000
 zreladdr-$(CONFIG_ARCH_MX3)	:= 0x80008000
 params_phys-$(CONFIG_ARCH_MX3)	:= 0x80000100
 initrd_phys-$(CONFIG_ARCH_MX3)	:= 0x80800000
+
+zreladdr-$(CONFIG_SOC_IMX6Q)	:= 0x10008000
+params_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10000100
+initrd_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10800000
diff --git a/arch/arm/mach-imx/lluart.c b/arch/arm/mach-imx/lluart.c
new file mode 100644
index 0000000..34205cb
--- /dev/null
+++ b/arch/arm/mach-imx/lluart.c
@@ -0,0 +1,33 @@
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
+	.virtual	= MX6Q_UART4_BASE_VADDR,
+	.pfn		= __phys_to_pfn(MX6Q_UART4_BASE_ADDR),
+	.length		= SZ_16K,
+	.type		= MT_DEVICE,
+#endif
+};
+
+void __init imx_lluart_map_io(void)
+{
+	if (imx_lluart_desc.virtual)
+		iotable_init(&imx_lluart_desc, 1);
+}
+
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index a5353fc..e548f9b 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -48,6 +48,11 @@ config ARCH_MX51
 	help
 	  This enables support for systems based on the Freescale i.MX51 family
 
+config ARCH_MX6
+	bool "i.MX6"
+	help
+	  This enables support for systems based on the Freescale i.MX6 family
+
 endchoice
 
 source "arch/arm/mach-imx/Kconfig"
diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
index 07cfdbe..471872a 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -24,9 +24,14 @@
 #define UART_PADDR	MX51_UART1_BASE_ADDR
 #elif defined (CONFIG_DEBUG_IMX50_IMX53_UART)
 #define UART_PADDR	MX53_UART1_BASE_ADDR
+#elif defined (CONFIG_DEBUG_IMX6Q_UART)
+#define UART_PADDR	MX6Q_UART4_BASE_ADDR
+#define UART_VADDR	MX6Q_UART4_BASE_VADDR
 #endif
 
+#ifndef UART_VADDR
 #define UART_VADDR	IMX_IO_ADDRESS(UART_PADDR)
+#endif
 
 		.macro	addruart, rp, rv
 		ldr	\rp, =UART_PADDR	@ physical
diff --git a/arch/arm/plat-mxc/include/mach/entry-macro.S b/arch/arm/plat-mxc/include/mach/entry-macro.S
index 066d464..341f800 100644
--- a/arch/arm/plat-mxc/include/mach/entry-macro.S
+++ b/arch/arm/plat-mxc/include/mach/entry-macro.S
@@ -1,6 +1,6 @@
 /*
  *  Copyright (C) 2007 Lennert Buytenhek <buytenh@wantstofly.org>
- *  Copyright 2004-2009 Freescale Semiconductor, Inc. All Rights Reserved.
+ *  Copyright 2004-2011 Freescale Semiconductor, Inc. All Rights Reserved.
  */
 
 /*
@@ -11,6 +11,17 @@
 
 #include <mach/hardware.h>
 
+#ifdef CONFIG_ARM_GIC
+#include <asm/hardware/entry-macro-gic.S>
+
+	.macro	disable_fiq
+	.endm
+
+	.macro	arch_ret_to_user, tmp1, tmp2
+	.endm
+
+#else
+
 #define AVIC_NIMASK	0x04
 
 	@ this macro disables fast irq (not implemented)
@@ -78,3 +89,5 @@
 	movs \irqnr, \irqnr
 #endif
 	.endm
+
+#endif /* CONFIG_ARM_GIC */
diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
index a8bfd56..e1f84ce 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -97,6 +97,7 @@
 
 #include <mach/mxc.h>
 
+#include <mach/mx6q.h>
 #include <mach/mx50.h>
 #include <mach/mx51.h>
 #include <mach/mx53.h>
diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
index 00e812b..3ae400f 100644
--- a/arch/arm/plat-mxc/include/mach/irqs.h
+++ b/arch/arm/plat-mxc/include/mach/irqs.h
@@ -14,12 +14,15 @@
 #include <asm-generic/gpio.h>
 
 /*
- * SoCs with TZIC interrupt controller have 128 IRQs, those with AVIC have 64
+ * SoCs with AVIC interrupt controller have 64 IRQs, those with TZIC
+ * have 128, otherwise those with GIC have 160 IRQs.
  */
-#ifdef CONFIG_MXC_TZIC
+#if defined CONFIG_MXC_AVIC
+#define MXC_INTERNAL_IRQS	64
+#elif defined CONFIG_MXC_TZIC
 #define MXC_INTERNAL_IRQS	128
 #else
-#define MXC_INTERNAL_IRQS	64
+#define MXC_INTERNAL_IRQS	160
 #endif
 
 #define MXC_GPIO_IRQ_START	MXC_INTERNAL_IRQS
diff --git a/arch/arm/plat-mxc/include/mach/memory.h b/arch/arm/plat-mxc/include/mach/memory.h
index 11be5cd..2b8e186 100644
--- a/arch/arm/plat-mxc/include/mach/memory.h
+++ b/arch/arm/plat-mxc/include/mach/memory.h
@@ -19,6 +19,7 @@
 #define MX50_PHYS_OFFSET	UL(0x70000000)
 #define MX51_PHYS_OFFSET	UL(0x90000000)
 #define MX53_PHYS_OFFSET	UL(0x70000000)
+#define MX6Q_PHYS_OFFSET	UL(0x10000000)
 
 #if !defined(CONFIG_RUNTIME_PHYS_OFFSET)
 # if defined CONFIG_ARCH_MX1
@@ -37,6 +38,8 @@
 #  define PLAT_PHYS_OFFSET		MX51_PHYS_OFFSET
 # elif defined CONFIG_ARCH_MX53
 #  define PLAT_PHYS_OFFSET		MX53_PHYS_OFFSET
+# elif defined CONFIG_SOC_IMX6Q
+#  define PLAT_PHYS_OFFSET		MX6Q_PHYS_OFFSET
 # endif
 #endif
 
diff --git a/arch/arm/plat-mxc/include/mach/mx6q.h b/arch/arm/plat-mxc/include/mach/mx6q.h
new file mode 100644
index 0000000..7432310
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/mx6q.h
@@ -0,0 +1,29 @@
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
+/* static mappings */
+#define IMX6Q_VA(x)		(0xf4000000 + (x))
+
+#define MX6Q_SCU_BASE_ADDR	0x00a00000
+#define MX6Q_CCM_BASE_ADDR	0x020c4000
+#define MX6Q_ANATOP_BASE_ADDR	0x020c8000
+#define MX6Q_UART4_BASE_ADDR	0x021f0000
+
+#define MX6Q_SCU_BASE_VADDR	IMX6Q_VA(MX6Q_SCU_BASE_ADDR)
+#define MX6Q_CCM_BASE_VADDR	IMX6Q_VA(MX6Q_CCM_BASE_ADDR)
+#define MX6Q_ANATOP_BASE_VADDR	IMX6Q_VA(MX6Q_ANATOP_BASE_ADDR)
+#define MX6Q_UART4_BASE_VADDR	IMX6Q_VA(MX6Q_UART4_BASE_ADDR)
+
+#endif	/* __MACH_MX6Q_H__ */
-- 
1.7.4.1
