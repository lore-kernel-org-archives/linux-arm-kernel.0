From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 12 Aug 2016 15:25:55 +0200
Subject: [PATCH v2] ARM: realview: imply device tree boot
Message-ID: <1471008355-18269-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reduces the Kconfig for the RealView by assuming we are
always booting from the device tree, and removing all the uses
of CONFIG_REALVIEW_DT and replacing with CONFIG_ARCH_REALVIEW.

Further:

- Drop REALVIEW_HIGH_PHYS_OFFSET: we don't use this with device
  tree.

- Drop the REALVIEW_EB_ARM11MP_REVB option: we now handle this
  by simply using another device tree.

- Drop the PB1176 secure flash option: this is defined in the
  PB1176 device tree but marked as "disabled", so users who
  want to use it can simply enable it in the device tree and
  go hacking around.

Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebased on not dropping the individual board configs from
  Kconfig, so we keep the CPU selection granularity.
- Drop a few other options selectively. (Described in the commit).
- Also drop REALVIEW_HIGH_PHYS_OFFSET.

MTD, irqchip folks: please ACK this so we can merge the entire
cleanup series through ARM SoC.
---
 arch/arm/Kconfig                |  3 +-
 arch/arm/mach-realview/Kconfig  | 71 +++++++----------------------------------
 arch/arm/mach-realview/Makefile |  2 +-
 drivers/irqchip/Makefile        |  2 +-
 drivers/mtd/maps/Kconfig        |  2 +-
 5 files changed, 15 insertions(+), 65 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2d601d769a1c..8e440c9654cb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -277,10 +277,9 @@ config PHYS_OFFSET
 			ARCH_INTEGRATOR || \
 			ARCH_IOP13XX || \
 			ARCH_KS8695 || \
-			(ARCH_REALVIEW && !REALVIEW_HIGH_PHYS_OFFSET)
+			ARCH_REALVIEW
 	default 0x10000000 if ARCH_OMAP1 || ARCH_RPC
 	default 0x20000000 if ARCH_S5PV210
-	default 0x70000000 if REALVIEW_HIGH_PHYS_OFFSET
 	default 0xc0000000 if ARCH_SA1100
 	help
 	  Please provide the physical address corresponding to the
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index 739800e8101f..1d7c83e73ffb 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -2,33 +2,29 @@ menuconfig ARCH_REALVIEW
 	bool "ARM Ltd. RealView family"
 	depends on ARCH_MULTI_V5 || ARCH_MULTI_V6 || ARCH_MULTI_V7
 	select ARM_AMBA
+	select ARM_GIC
 	select ARM_TIMER_SP804
+	select CLK_SP810
 	select COMMON_CLK_VERSATILE
 	select GPIO_PL061 if GPIOLIB
-	select ICST
-	select PLAT_VERSATILE
-	select PLAT_VERSATILE_SCHED_CLOCK
-	help
-	  This enables support for ARM Ltd RealView boards.
-
-if ARCH_REALVIEW
-
-config REALVIEW_DT
-	bool "Support RealView(R) Device Tree based boot"
-	select ARM_GIC
-	select CLK_SP810
-	select HAVE_SMP
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if SMP
+	select HAVE_PATA_PLATFORM
+	select HAVE_TCM
 	select ICST
 	select MACH_REALVIEW_EB if ARCH_MULTI_V5
 	select MFD_SYSCON
+	select PLAT_VERSATILE
+	select PLAT_VERSATILE_SCHED_CLOCK
 	select POWER_RESET
 	select POWER_RESET_VERSATILE
 	select POWER_SUPPLY
 	select SOC_REALVIEW
 	select USE_OF
 	help
-	  Include support for booting the ARM(R) RealView(R) evaluation
-	  boards using a device tree machine description.
+	  This enables support for ARM Ltd RealView boards.
+
+if ARCH_REALVIEW
 
 config MACH_REALVIEW_EB
 	bool "Support RealView(R) Emulation Baseboard"
@@ -59,8 +55,6 @@ config REALVIEW_EB_ARM1176
 config REALVIEW_EB_A9MP
 	bool "Support Multicore Cortex-A9 Tile"
 	depends on MACH_REALVIEW_EB && ARCH_MULTI_V7
-	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if SMP
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
 	help
@@ -70,30 +64,15 @@ config REALVIEW_EB_A9MP
 config REALVIEW_EB_ARM11MP
 	bool "Support ARM11MPCore Tile"
 	depends on MACH_REALVIEW_EB && ARCH_MULTI_V6
-	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if SMP
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
 	help
 	  Enable support for the ARM11MPCore tile fitted to the Realview(R)
 	  Emulation Baseboard platform.
 
-config REALVIEW_EB_ARM11MP_REVB
-	bool "Support ARM11MPCore RevB Tile"
-	depends on REALVIEW_EB_ARM11MP && ARCH_MULTI_V6
-	help
-	  Enable support for the ARM11MPCore Revision B tile on the
-	  Realview(R) Emulation Baseboard platform. Since there are device
-	  address differences, a kernel built with this option enabled is
-	  not compatible with other revisions of the ARM11MPCore tile.
-
 config MACH_REALVIEW_PB11MP
 	bool "Support RealView(R) Platform Baseboard for ARM11MPCore"
 	depends on ARCH_MULTI_V6
-	select ARM_GIC
-	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if SMP
-	select HAVE_PATA_PLATFORM
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
 	help
@@ -105,7 +84,6 @@ config MACH_REALVIEW_PB11MP
 config MACH_REALVIEW_PB1176
 	bool "Support RealView(R) Platform Baseboard for ARM1176JZF-S"
 	depends on ARCH_MULTI_V6
-	select ARM_GIC
 	select CPU_V6
 	select HAVE_TCM
 	select MIGHT_HAVE_CACHE_L2X0
@@ -113,20 +91,9 @@ config MACH_REALVIEW_PB1176
 	  Include support for the ARM(R) RealView(R) Platform Baseboard for
 	  ARM1176JZF-S.
 
-config REALVIEW_PB1176_SECURE_FLASH
-	bool "Allow access to the secure flash memory block"
-	depends on MACH_REALVIEW_PB1176
-	default n
-	help
-	  Select this option if Linux will only run in secure mode on the
-	  RealView PB1176 platform and access to the secure flash memory
-	  block (64MB @ 0x3c000000) is required.
-
 config MACH_REALVIEW_PBA8
 	bool "Support RealView(R) Platform Baseboard for Cortex(tm)-A8 platform"
 	depends on ARCH_MULTI_V7
-	select ARM_GIC
-	select HAVE_PATA_PLATFORM
 	help
 	  Include support for the ARM(R) RealView Platform Baseboard for
 	  Cortex(tm)-A8.  This platform has an on-board Cortex-A8 and has
@@ -135,10 +102,6 @@ config MACH_REALVIEW_PBA8
 config MACH_REALVIEW_PBX
 	bool "Support RealView(R) Platform Baseboard Explore for Cortex-A9"
 	depends on ARCH_MULTI_V7
-	select ARM_GIC
-	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if SMP
-	select HAVE_PATA_PLATFORM
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
 	select ZONE_DMA
@@ -146,16 +109,4 @@ config MACH_REALVIEW_PBX
 	  Include support for the ARM(R) RealView(R) Platform Baseboard
 	  Explore.
 
-config REALVIEW_HIGH_PHYS_OFFSET
-	bool "High physical base address for the RealView platform"
-	depends on MMU && !MACH_REALVIEW_PB1176
-	default y
-	help
-	  RealView boards other than PB1176 have the RAM available at
-	  0x70000000, 256MB of which being mirrored at 0x00000000. If
-	  the board supports 512MB of RAM, this option allows the
-	  memory to be accessed contiguously at the high physical
-	  offset. On the PBX board, disabling this option allows 1GB of
-	  RAM to be used with HIGHMEM.
-
 endif
diff --git a/arch/arm/mach-realview/Makefile b/arch/arm/mach-realview/Makefile
index 97dab53daaf1..6df86c29bbc3 100644
--- a/arch/arm/mach-realview/Makefile
+++ b/arch/arm/mach-realview/Makefile
@@ -4,6 +4,6 @@
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 	-I$(srctree)/arch/arm/plat-versatile/include
 
-obj-$(CONFIG_REALVIEW_DT)		+= realview-dt.o
+obj-y					+= realview-dt.o
 obj-$(CONFIG_SMP)			+= platsmp-dt.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 4c203b6b8163..92fa06e16a17 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_ARCH_SUNXI)		+= irq-sunxi-nmi.o
 obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-shirq.o
 obj-$(CONFIG_ARM_GIC)			+= irq-gic.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_PM)		+= irq-gic-pm.o
-obj-$(CONFIG_REALVIEW_DT)		+= irq-gic-realview.o
+obj-$(CONFIG_ARCH_REALVIEW)		+= irq-gic-realview.o
 obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-pci-msi.o irq-gic-v3-its-platform-msi.o
diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 392f9eff5fb7..5bcc896a48c3 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -78,7 +78,7 @@ config MTD_PHYSMAP_OF_VERSATILE
 	bool "Support ARM Versatile physmap OF"
 	depends on MTD_PHYSMAP_OF
 	depends on MFD_SYSCON
-	default y if (ARCH_INTEGRATOR || ARCH_VERSATILE || REALVIEW_DT)
+	default y if (ARCH_INTEGRATOR || ARCH_VERSATILE || ARCH_REALVIEW)
 	help
 	  This provides some extra DT physmap parsing for the ARM Versatile
 	  platforms, basically to add a VPP (write protection) callback so
-- 
2.7.4
