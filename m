From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Jul 2014 23:05:49 +0200
Subject: [PATCH] ARM: mvebu: fix build without platforms selected
Message-ID: <7339332.ZE2mWIdyDh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building a multiplatform kernel that enables 'ARCH_MVEBU' but
none of the individual options under it, we get this link error:

arch/arm/mach-mvebu/built-in.o: In function `mvebu_armada375_smp_wa_init':
:(.text+0x190): undefined reference to `mvebu_setup_boot_addr_wa'

The best solution seems to be to ensure that in this configuration,
we don't actually build any of the mvebu code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 955d4a3afabd..c1e4567a5ab3 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -14,11 +14,15 @@ menuconfig ARCH_MVEBU
 
 if ARCH_MVEBU
 
+config MACH_MVEBU_ANY
+	bool
+
 config MACH_MVEBU_V7
 	bool
 	select ARMADA_370_XP_TIMER
 	select CACHE_L2X0
 	select ARM_CPU_SUSPEND
+	select MACH_MVEBU_ANY
 
 config MACH_ARMADA_370
 	bool "Marvell Armada 370 boards" if ARCH_MULTI_V7
@@ -75,6 +79,7 @@ config MACH_DOVE
 	select CACHE_L2X0
 	select CPU_PJ4
 	select DOVE_CLK
+	select MACH_MVEBU_ANY
 	select ORION_IRQCHIP
 	select ORION_TIMER
 	select PINCTRL_DOVE
@@ -87,6 +92,7 @@ config MACH_KIRKWOOD
 	select ARCH_REQUIRE_GPIOLIB
 	select CPU_FEROCEON
 	select KIRKWOOD_CLK
+	select MACH_MVEBU_ANY
 	select ORION_IRQCHIP
 	select ORION_TIMER
 	select PCI
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index bc7689e530a4..e24136b42765 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -4,7 +4,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
 CFLAGS_pmsu.o			:= -march=armv7-a
 
-obj-y				 += system-controller.o mvebu-soc-id.o
+obj-$(CONFIG_MACH_MVEBU_ANY)	 += system-controller.o mvebu-soc-id.o
 
 ifeq ($(CONFIG_MACH_MVEBU_V7),y)
 obj-y				 += cpu-reset.o board-v7.o coherency.o coherency_ll.o pmsu.o pmsu_ll.o
