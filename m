From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 13 Apr 2014 19:50:01 +0200
Subject: [PATCH 26/29] ARM: orion5x: convert RD-88F5182 to Device Tree
In-Reply-To: <20140413175658.64b65a76@skate>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140413154715.GE10033@lunn.ch> <20140413175658.64b65a76@skate>
Message-ID: <5818301.yXvUbauJMr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 13 April 2014 17:56:58 Thomas Petazzoni wrote:
> On Sun, 13 Apr 2014 17:47:15 +0200, Andrew Lunn wrote:

> > Nice to see you are checking for compatibility in the initcall. How
> > far do you think this from a multi_v5 kernel?
> 
> I haven't thought too much about this yet. I'm hoping to do more
> Orion5x DT conversion once this patch series is done, and then think
> about multiplatform support.

I've been building orion as part of my randconfig build tests
in ARCH_MULTIPLATFORM for while now, but haven't tried actually
running it. See the patch below for the very simple things I had
to change to get things to build. The Makefile hack in plat-orion
only works as long you don't try to do the same thing in any of the
other ARMv5 (kirkwood or mv78xx0) platforms as well.

The main thing missing here is support for MULTI_IRQ_HANDLER for
the ATAGS based board files. I assume you need the same thing to
let DT and ATAGS coexist within Orion already?

Other than that, I guess it's just a couple of runtime bugs like
the one Andrew pointed out here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>


diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 09bba01..d0c37e5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -563,20 +563,6 @@ config ARCH_MV78XX0
 	  Support for the following Marvell MV78xx0 series SoCs:
 	  MV781x0, MV782x0.
 
-config ARCH_ORION5X
-	bool "Marvell Orion"
-	depends on MMU
-	select ARCH_REQUIRE_GPIOLIB
-	select CPU_FEROCEON
-	select GENERIC_CLOCKEVENTS
-	select MVEBU_MBUS
-	select PCI
-	select PLAT_ORION_LEGACY
-	help
-	  Support for the following Marvell Orion 5x series SoCs:
-	  Orion-1 (5181), Orion-VoIP (5181L), Orion-NAS (5182),
-	  Orion-2 (5281), Orion-1-90 (6183).
-
 config ARCH_MMP
 	bool "Marvell PXA168/910/MMP2"
 	depends on MMU
diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
index 14f2cae..62b560e 100644
--- a/arch/arm/mach-orion5x/Kconfig
+++ b/arch/arm/mach-orion5x/Kconfig
@@ -1,3 +1,17 @@
+config ARCH_ORION5X
+	bool "Marvell Orion"
+	depends on MMU && ARCH_MULTI_V5
+	select ARCH_REQUIRE_GPIOLIB
+	select CPU_FEROCEON
+	select GENERIC_CLOCKEVENTS
+	select MVEBU_MBUS
+	select PCI
+	select PLAT_ORION_LEGACY
+	help
+	  Support for the following Marvell Orion 5x series SoCs:
+	  Orion-1 (5181), Orion-VoIP (5181L), Orion-NAS (5182),
+	  Orion-2 (5281), Orion-1-90 (6183).
+
 if ARCH_ORION5X
 
 menu "Orion Implementations"
diff --git a/arch/arm/mach-orion5x/Makefile b/arch/arm/mach-orion5x/Makefile
index 45da805..c91a41d 100644
--- a/arch/arm/mach-orion5x/Makefile
+++ b/arch/arm/mach-orion5x/Makefile
@@ -1,3 +1,6 @@
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
+	-I$(srctree)/arch/arm/plat-orion/include
+
 obj-y				+= common.o pci.o irq.o mpp.o
 obj-$(CONFIG_MACH_DB88F5281)	+= db88f5281-setup.o
 obj-$(CONFIG_MACH_RD88F5182)	+= rd88f5182-setup.o
diff --git a/arch/arm/mach-orion5x/include/mach/irqs.h b/arch/arm/mach-orion5x/include/mach/irqs.h
index a6fa9d8..a0d2887 100644
--- a/arch/arm/mach-orion5x/include/mach/irqs.h
+++ b/arch/arm/mach-orion5x/include/mach/irqs.h
@@ -54,7 +54,7 @@
 #define IRQ_ORION5X_GPIO_START	32
 #define NR_GPIO_IRQS		32
 
-#define NR_IRQS			(IRQ_ORION5X_GPIO_START + NR_GPIO_IRQS)
+#define ORION_IRQS		(IRQ_ORION5X_GPIO_START + NR_GPIO_IRQS)
 
 
 #endif
diff --git a/arch/arm/mach-orion5x/include/mach/orion5x.h b/arch/arm/mach-orion5x/include/mach/orion5x.h
index b78ff32..7be7c2e 100644
--- a/arch/arm/mach-orion5x/include/mach/orion5x.h
+++ b/arch/arm/mach-orion5x/include/mach/orion5x.h
@@ -14,6 +14,8 @@
 #ifndef __ASM_ARCH_ORION5X_H
 #define __ASM_ARCH_ORION5X_H
 
+#include <mach/irqs.h>
+
 /*****************************************************************************
  * Orion Address Maps
  *
diff --git a/arch/arm/plat-orion/Makefile b/arch/arm/plat-orion/Makefile
index 9433605..bb17664 100644
--- a/arch/arm/plat-orion/Makefile
+++ b/arch/arm/plat-orion/Makefile
@@ -1,7 +1,8 @@
 #
 # Makefile for the linux kernel.
 #
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
+	-I$(srctree)/arch/arm/mach-orion5x/include
 
 orion-gpio-$(CONFIG_GPIOLIB)      += gpio.o
 obj-$(CONFIG_PLAT_ORION_LEGACY)   += irq.o pcie.o time.o common.o mpp.o
diff --git a/arch/arm/plat-orion/irq.c b/arch/arm/plat-orion/irq.c
index 807df14..a62b980 100644
--- a/arch/arm/plat-orion/irq.c
+++ b/arch/arm/plat-orion/irq.c
@@ -18,6 +18,7 @@
 #include <asm/exception.h>
 #include <plat/irq.h>
 #include <plat/orion-gpio.h>
+#include <mach/hardware.h>
 #include <mach/bridge-regs.h>
 
 #ifdef CONFIG_MULTI_IRQ_HANDLER
