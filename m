From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  2 Dec 2015 22:27:08 +0100
Subject: [PATCH 6/7] ARM: orion5x: clean up mach/*.h headers
In-Reply-To: <1449091629-2155735-1-git-send-email-arnd@arndb.de>
References: <1449091629-2155735-1-git-send-email-arnd@arndb.de>
Message-ID: <1449091629-2155735-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a simple move of all header files that are no longer
included by anything else from the include/mach directory
to the platform directory itself as preparation for
multiplatform support.

The mach/uncompress.h headers are left in place for now,
and are mildly modified to be independent of the other
headers. They will be removed entirely when ARCH_MULTIPLATFORM
gets enabled and they become obsolete.

Rather than updating the path names inside of the comments
of each header, I delete those comments to avoid having to
update them again, should they get moved or copied another
time.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-orion5x/board-d2net.c                    |  2 +-
 arch/arm/mach-orion5x/board-dt.c                       |  4 ++--
 arch/arm/mach-orion5x/board-mss2.c                     |  4 ++--
 arch/arm/mach-orion5x/board-rd88f5182.c                |  2 +-
 arch/arm/mach-orion5x/{include/mach => }/bridge-regs.h |  4 +---
 arch/arm/mach-orion5x/common.c                         |  6 +++---
 arch/arm/mach-orion5x/db88f5281-setup.c                |  2 +-
 arch/arm/mach-orion5x/dns323-setup.c                   |  2 +-
 arch/arm/mach-orion5x/include/mach/hardware.h          | 14 --------------
 arch/arm/mach-orion5x/include/mach/uncompress.h        |  4 +---
 arch/arm/mach-orion5x/irq.c                            |  2 +-
 arch/arm/mach-orion5x/{include/mach => }/irqs.h        |  2 --
 arch/arm/mach-orion5x/kurobox_pro-setup.c              |  2 +-
 arch/arm/mach-orion5x/ls-chl-setup.c                   |  2 +-
 arch/arm/mach-orion5x/ls_hgl-setup.c                   |  2 +-
 arch/arm/mach-orion5x/mpp.c                            |  2 +-
 arch/arm/mach-orion5x/mv2120-setup.c                   |  2 +-
 arch/arm/mach-orion5x/net2big-setup.c                  |  2 +-
 arch/arm/mach-orion5x/{include/mach => }/orion5x.h     |  4 +---
 arch/arm/mach-orion5x/pci.c                            |  2 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c           |  2 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c            |  2 +-
 arch/arm/mach-orion5x/rd88f5182-setup.c                |  2 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c           |  2 +-
 arch/arm/mach-orion5x/terastation_pro2-setup.c         |  2 +-
 arch/arm/mach-orion5x/ts209-setup.c                    |  2 +-
 arch/arm/mach-orion5x/ts409-setup.c                    |  2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c                   |  2 +-
 arch/arm/mach-orion5x/tsx09-common.c                   |  2 +-
 arch/arm/mach-orion5x/wnr854t-setup.c                  |  2 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c               |  2 +-
 31 files changed, 33 insertions(+), 55 deletions(-)
 rename arch/arm/mach-orion5x/{include/mach => }/bridge-regs.h (92%)
 delete mode 100644 arch/arm/mach-orion5x/include/mach/hardware.h
 rename arch/arm/mach-orion5x/{include/mach => }/irqs.h (97%)
 rename arch/arm/mach-orion5x/{include/mach => }/orion5x.h (98%)

diff --git a/arch/arm/mach-orion5x/board-d2net.c b/arch/arm/mach-orion5x/board-d2net.c
index 8a7284124153..a89376a5cd92 100644
--- a/arch/arm/mach-orion5x/board-d2net.c
+++ b/arch/arm/mach-orion5x/board-d2net.c
@@ -20,9 +20,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
 #include <plat/orion-gpio.h>
 #include "common.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * LaCie d2 Network Info
diff --git a/arch/arm/mach-orion5x/board-dt.c b/arch/arm/mach-orion5x/board-dt.c
index d0871786dd8a..6f4c2c4ae2a5 100644
--- a/arch/arm/mach-orion5x/board-dt.c
+++ b/arch/arm/mach-orion5x/board-dt.c
@@ -20,10 +20,10 @@
 #include <asm/system_misc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <mach/orion5x.h>
-#include <mach/bridge-regs.h>
 #include <plat/irq.h>
 #include <plat/time.h>
+#include "orion5x.h"
+#include "bridge-regs.h"
 #include "common.h"
 
 static struct of_dev_auxdata orion5x_auxdata_lookup[] __initdata = {
diff --git a/arch/arm/mach-orion5x/board-mss2.c b/arch/arm/mach-orion5x/board-mss2.c
index 66f9c3ba86cc..79202fd626df 100644
--- a/arch/arm/mach-orion5x/board-mss2.c
+++ b/arch/arm/mach-orion5x/board-mss2.c
@@ -17,8 +17,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
-#include <mach/bridge-regs.h>
+#include "orion5x.h"
+#include "bridge-regs.h"
 #include "common.h"
 
 /*****************************************************************************
diff --git a/arch/arm/mach-orion5x/board-rd88f5182.c b/arch/arm/mach-orion5x/board-rd88f5182.c
index 270824b0e50f..b7b0f52f4c0a 100644
--- a/arch/arm/mach-orion5x/board-rd88f5182.c
+++ b/arch/arm/mach-orion5x/board-rd88f5182.c
@@ -18,8 +18,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
 #include "common.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * RD-88F5182 Info
diff --git a/arch/arm/mach-orion5x/include/mach/bridge-regs.h b/arch/arm/mach-orion5x/bridge-regs.h
similarity index 92%
rename from arch/arm/mach-orion5x/include/mach/bridge-regs.h
rename to arch/arm/mach-orion5x/bridge-regs.h
index 5766e3fbff69..305598eaaee1 100644
--- a/arch/arm/mach-orion5x/include/mach/bridge-regs.h
+++ b/arch/arm/mach-orion5x/bridge-regs.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-orion5x/include/mach/bridge-regs.h
- *
  * Orion CPU Bridge Registers
  *
  * This file is licensed under the terms of the GNU General Public
@@ -11,7 +9,7 @@
 #ifndef __ASM_ARCH_BRIDGE_REGS_H
 #define __ASM_ARCH_BRIDGE_REGS_H
 
-#include <mach/orion5x.h>
+#include "orion5x.h"
 
 #define CPU_CONF		(ORION5X_BRIDGE_VIRT_BASE + 0x100)
 
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 2b7889e3b7bc..70c3366c8d03 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -27,14 +27,14 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
-#include <mach/bridge-regs.h>
-#include <mach/hardware.h>
-#include <mach/orion5x.h>
 #include <linux/platform_data/mtd-orion_nand.h>
 #include <linux/platform_data/usb-ehci-orion.h>
 #include <plat/time.h>
 #include <plat/common.h>
+
+#include "bridge-regs.h"
 #include "common.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * I/O Address Mapping
diff --git a/arch/arm/mach-orion5x/db88f5281-setup.c b/arch/arm/mach-orion5x/db88f5281-setup.c
index 698528fee39d..12f74b46e2ff 100644
--- a/arch/arm/mach-orion5x/db88f5281-setup.c
+++ b/arch/arm/mach-orion5x/db88f5281-setup.c
@@ -23,10 +23,10 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
 #include <linux/platform_data/mtd-orion_nand.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * DB-88F5281 on board devices
diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
index 96a8c50e7223..cd483bfb5ca8 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -33,8 +33,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <asm/system_info.h>
-#include <mach/orion5x.h>
 #include <plat/orion-gpio.h>
+#include "orion5x.h"
 #include "common.h"
 #include "mpp.h"
 
diff --git a/arch/arm/mach-orion5x/include/mach/hardware.h b/arch/arm/mach-orion5x/include/mach/hardware.h
deleted file mode 100644
index 395735482473..000000000000
--- a/arch/arm/mach-orion5x/include/mach/hardware.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * arch/arm/mach-orion5x/include/mach/hardware.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H
-
-#include "orion5x.h"
-
-#endif
diff --git a/arch/arm/mach-orion5x/include/mach/uncompress.h b/arch/arm/mach-orion5x/include/mach/uncompress.h
index abd26b542c3c..25e5cb98fecc 100644
--- a/arch/arm/mach-orion5x/include/mach/uncompress.h
+++ b/arch/arm/mach-orion5x/include/mach/uncompress.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-orion5x/include/mach/uncompress.h
- *
  * Tzachi Perelstein <tzachi@marvell.com>
  *
  * This file is licensed under the terms of the GNU General Public
@@ -9,8 +7,8 @@
  */
 
 #include <linux/serial_reg.h>
-#include <mach/orion5x.h>
 
+#define UART0_PHYS_BASE (0xf1000000 + 0x12000)
 #define SERIAL_BASE	((unsigned char *)UART0_PHYS_BASE)
 
 static void putc(const char c)
diff --git a/arch/arm/mach-orion5x/irq.c b/arch/arm/mach-orion5x/irq.c
index 8678db1eb1bd..de980ef9cda1 100644
--- a/arch/arm/mach-orion5x/irq.c
+++ b/arch/arm/mach-orion5x/irq.c
@@ -13,10 +13,10 @@
 #include <linux/kernel.h>
 #include <linux/irq.h>
 #include <linux/io.h>
-#include <mach/bridge-regs.h>
 #include <plat/orion-gpio.h>
 #include <plat/irq.h>
 #include <asm/exception.h>
+#include "bridge-regs.h"
 #include "common.h"
 
 static int __initdata gpio0_irqs[4] = {
diff --git a/arch/arm/mach-orion5x/include/mach/irqs.h b/arch/arm/mach-orion5x/irqs.h
similarity index 97%
rename from arch/arm/mach-orion5x/include/mach/irqs.h
rename to arch/arm/mach-orion5x/irqs.h
index 4b8703cd1ccb..506c8e0b30c4 100644
--- a/arch/arm/mach-orion5x/include/mach/irqs.h
+++ b/arch/arm/mach-orion5x/irqs.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-orion5x/include/mach/irqs.h
- *
  * IRQ definitions for Orion SoC
  *
  *  Maintainer: Tzachi Perelstein <tzachi@marvell.com>
diff --git a/arch/arm/mach-orion5x/kurobox_pro-setup.c b/arch/arm/mach-orion5x/kurobox_pro-setup.c
index b1ebb3721638..9dc3f59bed9c 100644
--- a/arch/arm/mach-orion5x/kurobox_pro-setup.c
+++ b/arch/arm/mach-orion5x/kurobox_pro-setup.c
@@ -23,10 +23,10 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
 #include <linux/platform_data/mtd-orion_nand.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * KUROBOX-PRO Info
diff --git a/arch/arm/mach-orion5x/ls-chl-setup.c b/arch/arm/mach-orion5x/ls-chl-setup.c
index cb8720e6d02b..dfdaa8a498a4 100644
--- a/arch/arm/mach-orion5x/ls-chl-setup.c
+++ b/arch/arm/mach-orion5x/ls-chl-setup.c
@@ -22,9 +22,9 @@
 #include <linux/gpio.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/orion5x.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * Linkstation LS-CHL Info
diff --git a/arch/arm/mach-orion5x/ls_hgl-setup.c b/arch/arm/mach-orion5x/ls_hgl-setup.c
index 0ddfa23821ec..47ba6e0502f5 100644
--- a/arch/arm/mach-orion5x/ls_hgl-setup.c
+++ b/arch/arm/mach-orion5x/ls_hgl-setup.c
@@ -21,9 +21,9 @@
 #include <linux/gpio.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/orion5x.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * Linkstation LS-HGL Info
diff --git a/arch/arm/mach-orion5x/mpp.c b/arch/arm/mach-orion5x/mpp.c
index 5b70026f478c..19ef18594415 100644
--- a/arch/arm/mach-orion5x/mpp.c
+++ b/arch/arm/mach-orion5x/mpp.c
@@ -11,8 +11,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <mach/hardware.h>
 #include <plat/mpp.h>
+#include "orion5x.h"
 #include "mpp.h"
 #include "common.h"
 
diff --git a/arch/arm/mach-orion5x/mv2120-setup.c b/arch/arm/mach-orion5x/mv2120-setup.c
index 11985dc45c47..2bf8ec75e908 100644
--- a/arch/arm/mach-orion5x/mv2120-setup.c
+++ b/arch/arm/mach-orion5x/mv2120-setup.c
@@ -21,9 +21,9 @@
 #include <linux/ata_platform.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/orion5x.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 
 #define MV2120_NOR_BOOT_BASE	0xf4000000
 #define MV2120_NOR_BOOT_SIZE	SZ_512K
diff --git a/arch/arm/mach-orion5x/net2big-setup.c b/arch/arm/mach-orion5x/net2big-setup.c
index e91abcc2213d..bf6be4cfd238 100644
--- a/arch/arm/mach-orion5x/net2big-setup.c
+++ b/arch/arm/mach-orion5x/net2big-setup.c
@@ -24,10 +24,10 @@
 #include <linux/delay.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/orion5x.h>
 #include <plat/orion-gpio.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * LaCie 2Big Network Info
diff --git a/arch/arm/mach-orion5x/include/mach/orion5x.h b/arch/arm/mach-orion5x/orion5x.h
similarity index 98%
rename from arch/arm/mach-orion5x/include/mach/orion5x.h
rename to arch/arm/mach-orion5x/orion5x.h
index 7be7c2e05465..3364df331f01 100644
--- a/arch/arm/mach-orion5x/include/mach/orion5x.h
+++ b/arch/arm/mach-orion5x/orion5x.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-orion5x/include/mach/orion5x.h
- *
  * Generic definitions of Orion SoC flavors:
  *  Orion-1, Orion-VoIP, Orion-NAS, Orion-2, and Orion-1-90.
  *
@@ -14,7 +12,7 @@
 #ifndef __ASM_ARCH_ORION5X_H
 #define __ASM_ARCH_ORION5X_H
 
-#include <mach/irqs.h>
+#include "irqs.h"
 
 /*****************************************************************************
  * Orion Address Maps
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index b02f3947be51..ecb998e7f8dc 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -19,8 +19,8 @@
 #include <asm/mach/pci.h>
 #include <plat/pcie.h>
 #include <plat/addr-map.h>
-#include <mach/orion5x.h>
 #include "common.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * Orion has one PCIe controller and one PCI controller.
diff --git a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
index 69a6e5b20b0b..c742e7b40b0d 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
@@ -20,9 +20,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * RD-88F5181L FXO Info
diff --git a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
index e19f8b7f87b3..7e977b794b0c 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
@@ -21,9 +21,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * RD-88F5181L GE Info
diff --git a/arch/arm/mach-orion5x/rd88f5182-setup.c b/arch/arm/mach-orion5x/rd88f5182-setup.c
index 180a4f972d3d..fe3e67c81fb8 100644
--- a/arch/arm/mach-orion5x/rd88f5182-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5182-setup.c
@@ -23,9 +23,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * RD-88F5182 Info
diff --git a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
index cc5bdbe70fa9..4bf80dd5478c 100644
--- a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
@@ -22,8 +22,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
 #include "common.h"
+#include "orion5x.h"
 
 static struct mv643xx_eth_platform_data rd88f6183ap_ge_eth_data = {
 	.phy_addr	= -1,
diff --git a/arch/arm/mach-orion5x/terastation_pro2-setup.c b/arch/arm/mach-orion5x/terastation_pro2-setup.c
index ad2057514deb..deb5e29ac669 100644
--- a/arch/arm/mach-orion5x/terastation_pro2-setup.c
+++ b/arch/arm/mach-orion5x/terastation_pro2-setup.c
@@ -22,9 +22,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * Terastation Pro 2/Live Info
diff --git a/arch/arm/mach-orion5x/ts209-setup.c b/arch/arm/mach-orion5x/ts209-setup.c
index 1cfc364c9b1e..7bd671b2854c 100644
--- a/arch/arm/mach-orion5x/ts209-setup.c
+++ b/arch/arm/mach-orion5x/ts209-setup.c
@@ -25,9 +25,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 #include "tsx09-common.h"
 
 #define QNAP_TS209_NOR_BOOT_BASE 0xf4000000
diff --git a/arch/arm/mach-orion5x/ts409-setup.c b/arch/arm/mach-orion5x/ts409-setup.c
index bc985cf44625..a77613b14db5 100644
--- a/arch/arm/mach-orion5x/ts409-setup.c
+++ b/arch/arm/mach-orion5x/ts409-setup.c
@@ -27,9 +27,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 #include "tsx09-common.h"
 
 /*****************************************************************************
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index 5a61a66ce012..b67ace446576 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -23,9 +23,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <mach/orion5x.h>
 #include "common.h"
 #include "mpp.h"
+#include "orion5x.h"
 #include "ts78xx-fpga.h"
 
 /*****************************************************************************
diff --git a/arch/arm/mach-orion5x/tsx09-common.c b/arch/arm/mach-orion5x/tsx09-common.c
index d42e006597c7..89774985d380 100644
--- a/arch/arm/mach-orion5x/tsx09-common.c
+++ b/arch/arm/mach-orion5x/tsx09-common.c
@@ -15,7 +15,7 @@
 #include <linux/mv643xx_eth.h>
 #include <linux/timex.h>
 #include <linux/serial_reg.h>
-#include <mach/orion5x.h>
+#include "orion5x.h"
 #include "tsx09-common.h"
 #include "common.h"
 
diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c b/arch/arm/mach-orion5x/wnr854t-setup.c
index bcc6e12dcdac..4e1e5c8f6111 100644
--- a/arch/arm/mach-orion5x/wnr854t-setup.c
+++ b/arch/arm/mach-orion5x/wnr854t-setup.c
@@ -19,7 +19,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
+#include "orion5x.h"
 #include "common.h"
 #include "mpp.h"
 
diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
index 4068d7a3e466..61e9027ef224 100644
--- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
+++ b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
@@ -22,7 +22,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
-#include <mach/orion5x.h>
+#include "orion5x.h"
 #include "common.h"
 #include "mpp.h"
 
-- 
2.1.0.rc2
