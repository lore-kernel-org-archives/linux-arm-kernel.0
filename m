From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 17:32:19 +0100
Subject: [PATCH 06/10] ARM: realview: enable multiplatform
In-Reply-To: <1448469143-447355-1-git-send-email-arnd@arndb.de>
References: <1448469143-447355-1-git-send-email-arnd@arndb.de>
Message-ID: <1448469143-447355-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All obstacles are out of the way by now, so we can finally move realview
to multiplatform.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/Kconfig                | 14 -----------
 arch/arm/mach-realview/Kconfig  | 55 ++++++++++++++++++++++++++++++++---------
 arch/arm/mach-realview/Makefile |  7 +++++-
 3 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 05e0bb54d3cd..c1598ea2ba56 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -342,20 +342,6 @@ config ARM_SINGLE_ARMV7M
 	select SPARSE_IRQ
 	select USE_OF
 
-config ARCH_REALVIEW
-	bool "ARM Ltd. RealView family"
-	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select ARM_AMBA
-	select ARM_TIMER_SP804
-	select COMMON_CLK
-	select COMMON_CLK_VERSATILE
-	select GENERIC_CLOCKEVENTS
-	select GPIO_PL061 if GPIOLIB
-	select ICST
-	select PLAT_VERSATILE
-	select PLAT_VERSATILE_SCHED_CLOCK
-	help
-	  This enables support for ARM Ltd RealView boards.
 
 config ARCH_VERSATILE
 	bool "ARM Ltd. Versatile family"
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index 055e7355ec14..0c10e4a2bace 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -1,9 +1,21 @@
-menu "RealView platform type"
-	depends on ARCH_REALVIEW
+menuconfig ARCH_REALVIEW
+	bool "ARM Ltd. RealView family" if ARCH_MULTI_V5 || ARCH_MULTI_V6 || ARCH_MULTI_V7
+	select ARM_AMBA
+	select ARM_TIMER_SP804
+	select COMMON_CLK_VERSATILE
+	select GPIO_PL061 if GPIOLIB
+	select ICST
+	select PLAT_VERSATILE
+	select PLAT_VERSATILE_SCHED_CLOCK
+	help
+	  This enables support for ARM Ltd RealView boards.
+
+if ARCH_REALVIEW
 
 config REALVIEW_DT
 	bool "Support RealView(R) Device Tree based boot"
 	select ARM_GIC
+	select MACH_REALVIEW_EB if ARCH_MULTI_V5
 	select MFD_SYSCON
 	select POWER_RESET
 	select POWER_RESET_VERSATILE
@@ -17,14 +29,32 @@ config REALVIEW_DT
 config MACH_REALVIEW_EB
 	bool "Support RealView(R) Emulation Baseboard"
 	select ARM_GIC
+	select CPU_ARM926T if ARCH_MULTI_V5
 	help
 	  Include support for the ARM(R) RealView(R) Emulation Baseboard
-	  platform.
+	  platform. On an ARMv5 kernel, this will include support for
+	  the ARM926EJ-S core tile, while on an ARMv6/v7 kernel, at least
+	  one of the ARM1136, ARM1176, ARM11MPCore or Cortex-A9MPCore
+	  core tile options should be enabled.
+
+config REALVIEW_EB_ARM1136
+	bool "Support ARM1136J(F)-S Tile"
+	depends on MACH_REALVIEW_EB && ARCH_MULTI_V6
+	select CPU_V6
+	help
+	  Enable support for the ARM1136 tile fitted to the
+	  Realview(R) Emulation Baseboard platform.
+
+config REALVIEW_EB_ARM1176
+	bool "Support ARM1176JZ(F)-S Tile"
+	depends on MACH_REALVIEW_EB && ARCH_MULTI_V6
+	help
+	  Enable support for the ARM1176 tile fitted to the
+	  Realview(R) Emulation Baseboard platform.
 
 config REALVIEW_EB_A9MP
 	bool "Support Multicore Cortex-A9 Tile"
-	depends on MACH_REALVIEW_EB
-	select CPU_V7
+	depends on MACH_REALVIEW_EB && ARCH_MULTI_V7
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select HAVE_SMP
@@ -35,8 +65,7 @@ config REALVIEW_EB_A9MP
 
 config REALVIEW_EB_ARM11MP
 	bool "Support ARM11MPCore Tile"
-	depends on MACH_REALVIEW_EB
-	select CPU_V6K
+	depends on MACH_REALVIEW_EB && ARCH_MULTI_V6
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select HAVE_SMP
@@ -47,7 +76,7 @@ config REALVIEW_EB_ARM11MP
 
 config REALVIEW_EB_ARM11MP_REVB
 	bool "Support ARM11MPCore RevB Tile"
-	depends on REALVIEW_EB_ARM11MP
+	depends on REALVIEW_EB_ARM11MP && ARCH_MULTI_V6
 	help
 	  Enable support for the ARM11MPCore Revision B tile on the
 	  Realview(R) Emulation Baseboard platform. Since there are device
@@ -56,8 +85,8 @@ config REALVIEW_EB_ARM11MP_REVB
 
 config MACH_REALVIEW_PB11MP
 	bool "Support RealView(R) Platform Baseboard for ARM11MPCore"
+	depends on ARCH_MULTI_V6
 	select ARM_GIC
-	select CPU_V6K
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select HAVE_PATA_PLATFORM
@@ -71,6 +100,7 @@ config MACH_REALVIEW_PB11MP
 # ARMv6 CPU without K extensions, but does have the new exclusive ops
 config MACH_REALVIEW_PB1176
 	bool "Support RealView(R) Platform Baseboard for ARM1176JZF-S"
+	depends on ARCH_MULTI_V6
 	select ARM_GIC
 	select CPU_V6
 	select HAVE_TCM
@@ -90,8 +120,8 @@ config REALVIEW_PB1176_SECURE_FLASH
 
 config MACH_REALVIEW_PBA8
 	bool "Support RealView(R) Platform Baseboard for Cortex(tm)-A8 platform"
+	depends on ARCH_MULTI_V7
 	select ARM_GIC
-	select CPU_V7
 	select HAVE_PATA_PLATFORM
 	help
 	  Include support for the ARM(R) RealView Platform Baseboard for
@@ -99,7 +129,8 @@ config MACH_REALVIEW_PBA8
 	  support for PCI-E and Compact Flash.
 
 config MACH_REALVIEW_PBX
-	bool "Support RealView(R) Platform Baseboard Explore"
+	bool "Support RealView(R) Platform Baseboard Explore for Cortex-A9"
+	depends on ARCH_MULTI_V7
 	select ARM_GIC
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
@@ -123,4 +154,4 @@ config REALVIEW_HIGH_PHYS_OFFSET
 	  offset. On the PBX board, disabling this option allows 1GB of
 	  RAM to be used with HIGHMEM.
 
-endmenu
+endif
diff --git a/arch/arm/mach-realview/Makefile b/arch/arm/mach-realview/Makefile
index e07fdf7ae8a7..ee0dfaedfa1f 100644
--- a/arch/arm/mach-realview/Makefile
+++ b/arch/arm/mach-realview/Makefile
@@ -1,13 +1,18 @@
 #
 # Makefile for the linux kernel.
 #
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
+	-I$(srctree)/arch/arm/plat-versatile/include
+
 
-obj-y					:= core.o
 obj-$(CONFIG_REALVIEW_DT)		+= realview-dt.o
+ifdef $(CONFIG_ATAGS)
+obj-y					:= core.o
 obj-$(CONFIG_MACH_REALVIEW_EB)		+= realview_eb.o
 obj-$(CONFIG_MACH_REALVIEW_PB11MP)	+= realview_pb11mp.o
 obj-$(CONFIG_MACH_REALVIEW_PB1176)	+= realview_pb1176.o
 obj-$(CONFIG_MACH_REALVIEW_PBA8)	+= realview_pba8.o
 obj-$(CONFIG_MACH_REALVIEW_PBX)		+= realview_pbx.o
+endif
 obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
-- 
2.1.0.rc2
