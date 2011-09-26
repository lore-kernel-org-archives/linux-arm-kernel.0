From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 26 Sep 2011 12:02:35 +0100
Subject: [PATCH v2 16/16] ARM: GIC: Make MULTI_IRQ_HANDLER mandatory
In-Reply-To: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
References: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1317034955-1029-17-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that MULTI_IRQ_HANDLER is selected by all the in-tree
GIC users, make it mandatory and remove the unused macros.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig                                |    3 -
 arch/arm/common/Kconfig                         |    1 +
 arch/arm/common/gic.c                           |    2 +-
 arch/arm/include/asm/hardware/entry-macro-gic.S |   60 -----------------------
 arch/arm/include/asm/hardware/gic.h             |    1 -
 arch/arm/mach-msm/Kconfig                       |    2 -
 arch/arm/mach-omap2/Kconfig                     |    1 +
 arch/arm/mach-tegra/Kconfig                     |    1 -
 arch/arm/mach-ux500/Kconfig                     |    1 -
 arch/arm/plat-omap/Kconfig                      |    1 -
 10 files changed, 3 insertions(+), 70 deletions(-)
 delete mode 100644 arch/arm/include/asm/hardware/entry-macro-gic.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0514264..d3e246c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -334,7 +334,6 @@ config ARCH_CNS3XXX
 	select ARM_GIC
 	select MIGHT_HAVE_PCI
 	select PCI_DOMAINS if PCI
-	select MULTI_IRQ_HANDLER
 	help
 	  Support for Cavium Networks CNS3XXX platform.
 
@@ -788,7 +787,6 @@ config ARCH_EXYNOS4
 	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-	select MULTI_IRQ_HANDLER
 	help
 	  Samsung EXYNOS4 series based systems
 
@@ -911,7 +909,6 @@ config ARCH_ZYNQ
 	select ARM_AMBA
 	select ICST
 	select USE_OF
-	select MULTI_IRQ_HANDLER
 	help
 	  Support for Xilinx Zynq ARM Cortex A9 Platform
 endchoice
diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index 114a432..de31997 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -1,5 +1,6 @@
 config ARM_GIC
 	select IRQ_PERCPU_DEVID
+	select MULTI_IRQ_HANDLER
 	bool
 
 config ARM_VIC
diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index ef803d2..8f55cf3 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -39,7 +39,7 @@
 static DEFINE_RAW_SPINLOCK(irq_controller_lock);
 
 /* Address of GIC 0 CPU interface */
-void __iomem *gic_cpu_base_addr __read_mostly;
+static void __iomem *gic_cpu_base_addr __read_mostly;
 
 /*
  * Supported arch specific GIC irq extension.
diff --git a/arch/arm/include/asm/hardware/entry-macro-gic.S b/arch/arm/include/asm/hardware/entry-macro-gic.S
deleted file mode 100644
index 74ebc80..0000000
--- a/arch/arm/include/asm/hardware/entry-macro-gic.S
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- * arch/arm/include/asm/hardware/entry-macro-gic.S
- *
- * Low-level IRQ helper macros for GIC
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <asm/hardware/gic.h>
-
-#ifndef HAVE_GET_IRQNR_PREAMBLE
-	.macro	get_irqnr_preamble, base, tmp
-	ldr	\base, =gic_cpu_base_addr
-	ldr	\base, [\base]
-	.endm
-#endif
-
-/*
- * The interrupt numbering scheme is defined in the
- * interrupt controller spec.  To wit:
- *
- * Interrupts 0-15 are IPI
- * 16-31 are local.  We allow 30 to be used for the watchdog.
- * 32-1020 are global
- * 1021-1022 are reserved
- * 1023 is "spurious" (no interrupt)
- *
- * A simple read from the controller will tell us the number of the highest
- * priority enabled interrupt.  We then just need to check whether it is in the
- * valid range for an IRQ (30-1020 inclusive).
- */
-
-	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-
-	ldr     \irqstat, [\base, #GIC_CPU_INTACK]
-	/* bits 12-10 = src CPU, 9-0 = int # */
-
-	ldr	\tmp, =1021
-	bic     \irqnr, \irqstat, #0x1c00
-	cmp     \irqnr, #15
-	cmpcc	\irqnr, \irqnr
-	cmpne	\irqnr, \tmp
-	cmpcs	\irqnr, \irqnr
-	.endm
-
-/* We assume that irqstat (the raw value of the IRQ acknowledge
- * register) is preserved from the macro above.
- * If there is an IPI, we immediately signal end of interrupt on the
- * controller, since this requires the original irqstat value which
- * we won't easily be able to recreate later.
- */
-
-	.macro test_for_ipi, irqnr, irqstat, base, tmp
-	bic	\irqnr, \irqstat, #0x1c00
-	cmp	\irqnr, #16
-	strcc	\irqstat, [\base, #GIC_CPU_EOI]
-	cmpcs	\irqnr, \irqnr
-	.endm
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 0f454c6..3411d37 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -33,7 +33,6 @@
 #define GIC_DIST_SOFTINT		0xf00
 
 #ifndef __ASSEMBLY__
-extern void __iomem *gic_cpu_base_addr;
 extern struct irq_chip gic_arch_extn;
 
 void gic_init(unsigned int, unsigned int, void __iomem *, void __iomem *);
diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index ba36b74..ebde97f 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -50,7 +50,6 @@ config ARCH_MSM8X60
 	select GPIO_MSM_V2
 	select MSM_GPIOMUX
 	select MSM_SCM if SMP
-	select MULTI_IRQ_HANDLER
 
 config ARCH_MSM8960
 	bool "MSM8960"
@@ -61,7 +60,6 @@ config ARCH_MSM8960
 	select MSM_V2_TLMM
 	select MSM_GPIOMUX
 	select MSM_SCM if SMP
-	select MULTI_IRQ_HANDLER
 
 endchoice
 
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 4c5b01d..9e29f9d 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -36,6 +36,7 @@ config ARCH_OMAP3
 	select ARM_L1_CACHE_SHIFT_6 if !ARCH_OMAP4
 	select ARCH_HAS_OPP
 	select PM_OPP if PM
+	select MULTI_IRQ_HANDLER
 
 config ARCH_OMAP4
 	bool "TI OMAP4"
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index ba0ac3f..d82ebab 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -13,7 +13,6 @@ config ARCH_TEGRA_2x_SOC
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select USB_ULPI if USB_SUPPORT
 	select USB_ULPI_VIEWPORT if USB_SUPPORT
-	select MULTI_IRQ_HANDLER
 	help
 	  Support for NVIDIA Tegra AP20 and T20 processors, based on the
 	  ARM CortexA9MP CPU and the ARM PL310 L2 cache controller
diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index bb2b52b..a3e0c86 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -7,7 +7,6 @@ config UX500_SOC_COMMON
 	select HAS_MTU
 	select ARM_ERRATA_753970
 	select ARM_ERRATA_754322
-	select MULTI_IRQ_HANDLER
 
 menu "Ux500 SoC"
 
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index c39cbca..fa62037 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -22,7 +22,6 @@ config ARCH_OMAP2PLUS
 	select CLKDEV_LOOKUP
 	select GENERIC_IRQ_CHIP
 	select OMAP_DM_TIMER
-	select MULTI_IRQ_HANDLER
 	help
 	  "Systems based on OMAP2, OMAP3 or OMAP4"
 
-- 
1.7.0.4
