From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 09 Sep 2012 20:34:13 +0100
Subject: [PATCH] ARM: Dove: allow PCI to be disabled
Message-ID: <E1TAnGn-00086i-Lb@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow PCI support for Dove to be disabled.  Some platforms do not have
anything connected to the PCIe ports, so requiring PCI support to be
built into the kernel just wastes space, and presents a lot more config
options than are necessary.

However, select USB_ARCH_HAS_EHCI so that we can still have EHCI
support.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig            |    3 ++-
 arch/arm/mach-dove/Makefile |    3 ++-
 arch/arm/mach-dove/common.h |    4 ++++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 27f5b2c..344d40e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -536,14 +536,15 @@ config ARCH_IXP4XX
 config ARCH_DOVE
 	bool "Marvell Dove"
 	select CPU_V7
-	select PCI
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
+	select MIGHT_HAVE_PCI
 	select NEED_MACH_IO_H
 	select PLAT_ORION
 	select CLKDEV_LOOKUP
 	select NEED_MACH_MEMORY_H
 	select COMMON_CLK
+	select USB_ARCH_HAS_EHCI
 	help
 	  Support for the Marvell Dove SoC 88AP510
 
diff --git a/arch/arm/mach-dove/Makefile b/arch/arm/mach-dove/Makefile
index 7d89269..b5a5773 100644
--- a/arch/arm/mach-dove/Makefile
+++ b/arch/arm/mach-dove/Makefile
@@ -1,4 +1,5 @@
-obj-y				+= common.o addr-map.o irq.o pcie.o mpp.o clock.o dump_cp15_regs.o
+obj-y				+= common.o addr-map.o irq.o mpp.o clock.o dump_cp15_regs.o
+obj-$(CONFIG_PCI)		+= pcie.o
 
 obj-$(CONFIG_MACH_DOVE_DB)	+= dove-db-setup.o
 obj-$(CONFIG_MACH_CM_A510)	+= cm-a510.o
diff --git a/arch/arm/mach-dove/common.h b/arch/arm/mach-dove/common.h
index 2ea271d..678ef0b 100644
--- a/arch/arm/mach-dove/common.h
+++ b/arch/arm/mach-dove/common.h
@@ -29,7 +29,11 @@ void dove_setup_cpu_mbus(void);
 void dove_ge00_init(struct mv643xx_eth_platform_data *eth_data);
 void dove_hwmon_init(void);
 void dove_sata_init(struct mv_sata_platform_data *sata_data);
+#ifdef CONFIG_PCI
 void dove_pcie_init(int init_port0, int init_port1);
+#else
+static inline void dove_pcie_init(int init_port0, int init_port1) { }
+#endif
 void dove_ehci0_init(void);
 void dove_ehci1_init(void);
 void dove_uart0_init(void);
-- 
1.7.4.4
