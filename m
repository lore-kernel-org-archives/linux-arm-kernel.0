From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 13 Apr 2016 16:59:27 +0100
Subject: [PATCH v2] sunxi-irq: Fix Kconfig dependency on GENERIC_IRQ_CHIP
Message-ID: <1460563167-18517-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sunxi-nmi and sun4i irq chips are selected by ARCH_SUNXI on both arm
and arm64 (recently added). However on arm64, we don't explicitly select
GENERIC_IRQ_CHIP which is required by the sunxi-nmi irq chip driver and
causes build breaks on 4.6-rc1 :

  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
drivers/built-in.o: In function `sunxi_sc_nmi_set_type':
drivers/irqchip/irq-sunxi-nmi.c:114: undefined reference to `irq_setup_alt_chip'
drivers/built-in.o: In function `irq_domain_add_linear':
include/linux/irqdomain.h:253: undefined reference to `irq_generic_chip_ops'
include/linux/irqdomain.h:253: undefined reference to `irq_generic_chip_ops'
drivers/built-in.o: In function `sunxi_sc_nmi_irq_init':
drivers/irqchip/irq-sunxi-nmi.c:146: undefined reference to `irq_alloc_domain_generic_chips'
drivers/irqchip/irq-sunxi-nmi.c:161: undefined reference to `irq_get_domain_generic_chip'
drivers/irqchip/irq-sunxi-nmi.c:170: undefined reference to `irq_gc_mask_clr_bit'
drivers/irqchip/irq-sunxi-nmi.c:171: undefined reference to `irq_gc_mask_set_bit'
drivers/irqchip/irq-sunxi-nmi.c:172: undefined reference to `irq_gc_ack_set_bit'
drivers/irqchip/irq-sunxi-nmi.c:170: undefined reference to `irq_gc_mask_clr_bit'

This patch fixes the dependency by introducing a separate Kconfig
symbol for sunxi irqchips which does the proper dependency selections.

Build tested on arm and arm64.

Fixes: commit ce3dd55b99b1 ("arm64: Introduce Allwinner SoC config option")
Suggested-by: Olof Johansson <olof@lixom.net>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/mach-sunxi/Kconfig  |    2 +-
 arch/arm64/Kconfig.platforms |    1 +
 drivers/irqchip/Kconfig      |    6 ++++++
 drivers/irqchip/Makefile     |    4 ++--
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index c124d65..7a4fc8c 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -4,9 +4,9 @@ menuconfig ARCH_SUNXI
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_RESET_CONTROLLER
 	select CLKSRC_MMIO
-	select GENERIC_IRQ_CHIP
 	select PINCTRL
 	select SUN4I_TIMER
+	select SUNXI_IRQCHIP
 	select RESET_CONTROLLER
 
 if ARCH_SUNXI
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index efa77c1..c77ad2d 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -2,6 +2,7 @@ menu "Platform selection"
 
 config ARCH_SUNXI
 	bool "Allwinner sunxi 64-bit SoC Family"
+	select SUNXI_IRQCHIP
 	help
 	  This enables support for Allwinner sunxi based SoCs like the A64.
 
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 3e12479..772c8ba 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -165,6 +165,12 @@ config ST_IRQCHIP
 	help
 	  Enables SysCfg Controlled IRQs on STi based platforms.
 
+config SUNXI_IRQCHIP
+	bool
+	select GENERIC_IRQ_CHIP
+	help
+		Support for Allwinner A1x/A20/A31 SoCs NMI IRQ chip driver
+
 config TANGO_IRQ
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index b03cfcb..c9626f4 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -19,8 +19,8 @@ obj-$(CONFIG_CLPS711X_IRQCHIP)		+= irq-clps711x.o
 obj-$(CONFIG_OR1K_PIC)			+= irq-or1k-pic.o
 obj-$(CONFIG_ORION_IRQCHIP)		+= irq-orion.o
 obj-$(CONFIG_OMAP_IRQCHIP)		+= irq-omap-intc.o
-obj-$(CONFIG_ARCH_SUNXI)		+= irq-sun4i.o
-obj-$(CONFIG_ARCH_SUNXI)		+= irq-sunxi-nmi.o
+obj-$(CONFIG_SUNXI_IRQCHIP)		+= irq-sun4i.o
+obj-$(CONFIG_SUNXI_IRQCHIP)		+= irq-sunxi-nmi.o
 obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-shirq.o
 obj-$(CONFIG_ARM_GIC)			+= irq-gic.o irq-gic-common.o
 obj-$(CONFIG_REALVIEW_DT)		+= irq-gic-realview.o
-- 
1.7.9.5
