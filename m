From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Aug 2016 14:40:30 +0200
Subject: [PATCH 5/5] ARM: realview: imply device tree boot
In-Reply-To: <1470832830-10274-1-git-send-email-linus.walleij@linaro.org>
References: <1470832830-10274-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1470832830-10274-6-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reduces the Kconfig for the RealView by assuming we are
always booting from the device tree, and removing all the uses
of CONFIG_REALVIEW_DT and replacing with CONFIG_ARCH_REALVIEW.

Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
MTD, irqchip folks: please ACK this so we can merge the entire
cleanup series through ARM SoC.
---
 arch/arm/mach-realview/Kconfig  | 23 ++++++++---------------
 arch/arm/mach-realview/Makefile |  2 +-
 drivers/irqchip/Makefile        |  2 +-
 drivers/mtd/maps/Kconfig        |  2 +-
 4 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index 5f194c42bbdf..f25940fcbe61 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -2,22 +2,12 @@ menuconfig ARCH_REALVIEW
 	bool "ARM Ltd. RealView family"
 	depends on ARCH_MULTI_V5 || ARCH_MULTI_V6 || ARCH_MULTI_V7
 	select ARM_AMBA
-	select ARM_TIMER_SP804
-	select COMMON_CLK_VERSATILE
-	select GPIO_PL061 if GPIOLIB
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
 	select ARM_GIC
 	select CLK_SP810
+	select ARM_TIMER_SP804
+	select COMMON_CLK_VERSATILE
 	select CPU_ARM926T if ARCH_MULTI_V5
+	select GPIO_PL061 if GPIOLIB
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select HAVE_PATA_PLATFORM
@@ -25,6 +15,8 @@ config REALVIEW_DT
 	select HAVE_TCM
 	select ICST
 	select MFD_SYSCON
+	select PLAT_VERSATILE
+	select PLAT_VERSATILE_SCHED_CLOCK
 	select POWER_RESET
 	select POWER_RESET_VERSATILE
 	select POWER_SUPPLY
@@ -32,8 +24,9 @@ config REALVIEW_DT
 	select USE_OF
 	select ZONE_DMA
 	help
-	  Include support for booting the ARM(R) RealView(R) evaluation
-	  boards using a device tree machine description.
+	  This enables support for ARM Ltd RealView boards.
+
+if ARCH_REALVIEW
 
 config REALVIEW_HIGH_PHYS_OFFSET
 	bool "High physical base address for the RealView platform"
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
