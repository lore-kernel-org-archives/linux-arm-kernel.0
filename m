From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 16:49:17 +0100
Subject: [PATCH 5/5] ARM: orion: multiplatform support
In-Reply-To: <1448466557-435335-1-git-send-email-arnd@arndb.de>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
Message-ID: <1448466557-435335-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All three remaining orion based platforms are now ready to
be enabled for multiplatform support, this patch does the
switch over by modifying the Kconfig file, the defconfig and
removing the last mach/*.h header that becomes obsolete with
this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                                | 46 -------------------------
 arch/arm/configs/dove_defconfig                 |  2 ++
 arch/arm/configs/mv78xx0_defconfig              |  3 ++
 arch/arm/configs/orion5x_defconfig              |  3 ++
 arch/arm/mach-dove/Kconfig                      | 15 +++++---
 arch/arm/mach-dove/Makefile                     |  2 ++
 arch/arm/mach-dove/include/mach/uncompress.h    | 34 ------------------
 arch/arm/mach-mv78xx0/Kconfig                   | 15 +++++---
 arch/arm/mach-mv78xx0/Makefile                  |  2 ++
 arch/arm/mach-mv78xx0/include/mach/uncompress.h | 44 -----------------------
 arch/arm/mach-orion5x/Kconfig                   | 18 +++++++---
 arch/arm/mach-orion5x/Makefile                  |  2 ++
 arch/arm/mach-orion5x/include/mach/uncompress.h | 46 -------------------------
 13 files changed, 50 insertions(+), 182 deletions(-)
 delete mode 100644 arch/arm/mach-dove/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-orion5x/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index efb94d4b71c1..987911008610 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -462,52 +462,6 @@ config ARCH_IXP4XX
 	help
 	  Support for Intel's IXP4XX (XScale) family of processors.
 
-config ARCH_DOVE
-	bool "Marvell Dove"
-	select ARCH_REQUIRE_GPIOLIB
-	select CPU_PJ4
-	select GENERIC_CLOCKEVENTS
-	select MIGHT_HAVE_PCI
-	select MULTI_IRQ_HANDLER
-	select MVEBU_MBUS
-	select PINCTRL
-	select PINCTRL_DOVE
-	select PLAT_ORION_LEGACY
-	select SPARSE_IRQ
-	help
-	  Support for the Marvell Dove SoC 88AP510
-
-config ARCH_MV78XX0
-	bool "Marvell MV78xx0"
-	select ARCH_REQUIRE_GPIOLIB
-	select CPU_FEROCEON
-	select GENERIC_CLOCKEVENTS
-	select MVEBU_MBUS
-	select MULTI_IRQ_HANDLER
-	select PCI
-	select PLAT_ORION_LEGACY
-	select SPARSE_IRQ
-	help
-	  Support for the following Marvell MV78xx0 series SoCs:
-	  MV781x0, MV782x0.
-
-config ARCH_ORION5X
-	bool "Marvell Orion"
-	depends on MMU
-	select ARCH_REQUIRE_GPIOLIB
-	select CPU_FEROCEON
-	select GENERIC_CLOCKEVENTS
-	select MVEBU_MBUS
-	select MULTI_IRQ_HANDLER
-	select PCI
-	select PLAT_ORION_LEGACY
-	select MULTI_IRQ_HANDLER
-	select SPARSE_IRQ
-	help
-	  Support for the following Marvell Orion 5x series SoCs:
-	  Orion-1 (5181), Orion-VoIP (5181L), Orion-NAS (5182),
-	  Orion-2 (5281), Orion-1-90 (6183).
-
 config ARCH_KS8695
 	bool "Micrel/Kendin KS8695"
 	select ARCH_REQUIRE_GPIOLIB
diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index 701677f9248c..8a5409cafb49 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -9,6 +9,8 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ARCH_MULTI_V6 is not set
+CONFIG_ARCH_MULTI_V7=y
 CONFIG_ARCH_DOVE=y
 CONFIG_MACH_DOVE_DB=y
 CONFIG_MACH_CM_A510=y
diff --git a/arch/arm/configs/mv78xx0_defconfig b/arch/arm/configs/mv78xx0_defconfig
index 85d10d2e3d66..fcdffa7d9d78 100644
--- a/arch/arm/configs/mv78xx0_defconfig
+++ b/arch/arm/configs/mv78xx0_defconfig
@@ -11,6 +11,9 @@ CONFIG_KPROBES=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
+CONFIG_ARCH_MULTI_V5=y
+# CONFIG_ARCH_MULTI_V6 is not set
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MV78XX0=y
 CONFIG_MACH_DB78X00_BP=y
 CONFIG_MACH_RD78X00_MASA=y
diff --git a/arch/arm/configs/orion5x_defconfig b/arch/arm/configs/orion5x_defconfig
index 8099417a9466..6ddca8875cb5 100644
--- a/arch/arm/configs/orion5x_defconfig
+++ b/arch/arm/configs/orion5x_defconfig
@@ -13,6 +13,9 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_BSD_DISKLABEL=y
+CONFIG_ARCH_MULTI_V5=y
+# CONFIG_ARCH_MULTI_V6 is not set
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_ORION5X=y
 CONFIG_ARCH_ORION5X_DT=y
 CONFIG_MACH_DB88F5281=y
diff --git a/arch/arm/mach-dove/Kconfig b/arch/arm/mach-dove/Kconfig
index d8c439c89ea9..331591c4f9cc 100644
--- a/arch/arm/mach-dove/Kconfig
+++ b/arch/arm/mach-dove/Kconfig
@@ -1,6 +1,15 @@
-if ARCH_DOVE
+menuconfig ARCH_DOVE
+	bool "Marvell Dove" if ARCH_MULTI_V7
+	select ARCH_REQUIRE_GPIOLIB
+	select CPU_PJ4
+	select MVEBU_MBUS
+	select PINCTRL
+	select PINCTRL_DOVE
+	select PLAT_ORION_LEGACY
+	help
+	  Support for the Marvell Dove SoC 88AP510
 
-menu "Marvell Dove Implementations"
+if ARCH_DOVE
 
 config DOVE_LEGACY
 	bool
@@ -20,6 +29,4 @@ config MACH_CM_A510
 	  Say 'Y' here if you want your kernel to support the
 	  CompuLab CM-A510 Board.
 
-endmenu
-
 endif
diff --git a/arch/arm/mach-dove/Makefile b/arch/arm/mach-dove/Makefile
index b608a21919fb..2ed6970cbacc 100644
--- a/arch/arm/mach-dove/Makefile
+++ b/arch/arm/mach-dove/Makefile
@@ -1,3 +1,5 @@
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-orion/include
+
 obj-y				+= common.o
 obj-$(CONFIG_DOVE_LEGACY)	+= irq.o mpp.o
 obj-$(CONFIG_PCI)		+= pcie.o
diff --git a/arch/arm/mach-dove/include/mach/uncompress.h b/arch/arm/mach-dove/include/mach/uncompress.h
deleted file mode 100644
index 7a4bd8838036..000000000000
--- a/arch/arm/mach-dove/include/mach/uncompress.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#define UART0_PHYS_BASE (0xf1000000 + 0x12000)
-
-#define UART_THR ((volatile unsigned char *)(UART0_PHYS_BASE + 0x0))
-#define UART_LSR ((volatile unsigned char *)(UART0_PHYS_BASE + 0x14))
-
-#define LSR_THRE	0x20
-
-static void putc(const char c)
-{
-	int i;
-
-	for (i = 0; i < 0x1000; i++) {
-		/* Transmit fifo not full? */
-		if (*UART_LSR & LSR_THRE)
-			break;
-	}
-
-	*UART_THR = c;
-}
-
-static void flush(void)
-{
-}
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-mv78xx0/Kconfig b/arch/arm/mach-mv78xx0/Kconfig
index f2d309d0619e..a32575fa3fba 100644
--- a/arch/arm/mach-mv78xx0/Kconfig
+++ b/arch/arm/mach-mv78xx0/Kconfig
@@ -1,6 +1,15 @@
-if ARCH_MV78XX0
+menuconfig ARCH_MV78XX0
+	bool "Marvell MV78xx0" if ARCH_MULTI_V5
+	select ARCH_REQUIRE_GPIOLIB
+	select CPU_FEROCEON
+	select MVEBU_MBUS
+	select PCI
+	select PLAT_ORION_LEGACY
+	help
+	  Support for the following Marvell MV78xx0 series SoCs:
+	  MV781x0, MV782x0.
 
-menu "Marvell MV78xx0 Implementations"
+if ARCH_MV78XX0
 
 config MACH_DB78X00_BP
 	bool "Marvell DB-78x00-BP Development Board"
@@ -20,6 +29,4 @@ config MACH_TERASTATION_WXL
 	  Say 'Y' here if you want your kernel to support the
 	  Buffalo WXL Nas.
 
-endmenu
-
 endif
diff --git a/arch/arm/mach-mv78xx0/Makefile b/arch/arm/mach-mv78xx0/Makefile
index 7cd04634d302..ddb3aa98a3c7 100644
--- a/arch/arm/mach-mv78xx0/Makefile
+++ b/arch/arm/mach-mv78xx0/Makefile
@@ -1,3 +1,5 @@
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-orion/include
+
 obj-y				+= common.o mpp.o irq.o pcie.o
 obj-$(CONFIG_MACH_DB78X00_BP)	+= db78x00-bp-setup.o
 obj-$(CONFIG_MACH_RD78X00_MASA)	+= rd78x00-masa-setup.o
diff --git a/arch/arm/mach-mv78xx0/include/mach/uncompress.h b/arch/arm/mach-mv78xx0/include/mach/uncompress.h
deleted file mode 100644
index 2787ef392262..000000000000
--- a/arch/arm/mach-mv78xx0/include/mach/uncompress.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/serial_reg.h>
-
-#define UART0_PHYS_BASE (0xf1000000 + 0x12000)
-#define SERIAL_BASE	((unsigned char *)UART0_PHYS_BASE)
-
-static void putc(const char c)
-{
-	unsigned char *base = SERIAL_BASE;
-	int i;
-
-	for (i = 0; i < 0x1000; i++) {
-		if (base[UART_LSR << 2] & UART_LSR_THRE)
-			break;
-		barrier();
-	}
-
-	base[UART_TX << 2] = c;
-}
-
-static void flush(void)
-{
-	unsigned char *base = SERIAL_BASE;
-	unsigned char mask;
-	int i;
-
-	mask = UART_LSR_TEMT | UART_LSR_THRE;
-
-	for (i = 0; i < 0x1000; i++) {
-		if ((base[UART_LSR << 2] & mask) == mask)
-			break;
-		barrier();
-	}
-}
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
index 66f1c952c048..a9ad95f000a1 100644
--- a/arch/arm/mach-orion5x/Kconfig
+++ b/arch/arm/mach-orion5x/Kconfig
@@ -1,6 +1,18 @@
-if ARCH_ORION5X
+menuconfig ARCH_ORION5X
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
 
-menu "Orion Implementations"
+if ARCH_ORION5X
 
 config ARCH_ORION5X_DT
 	bool "Marvell Orion5x Flattened Device Tree"
@@ -163,6 +175,4 @@ config MACH_RD88F6183AP_GE
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell Orion-1-90 (88F6183) AP GE RD.
 
-endmenu
-
 endif
diff --git a/arch/arm/mach-orion5x/Makefile b/arch/arm/mach-orion5x/Makefile
index a1e0fbe6a7a1..4b2502b4ca0d 100644
--- a/arch/arm/mach-orion5x/Makefile
+++ b/arch/arm/mach-orion5x/Makefile
@@ -1,3 +1,5 @@
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-orion/include
+
 obj-y				+= common.o pci.o irq.o mpp.o
 obj-$(CONFIG_MACH_DB88F5281)	+= db88f5281-setup.o
 obj-$(CONFIG_MACH_RD88F5182)	+= rd88f5182-setup.o
diff --git a/arch/arm/mach-orion5x/include/mach/uncompress.h b/arch/arm/mach-orion5x/include/mach/uncompress.h
deleted file mode 100644
index 25e5cb98fecc..000000000000
--- a/arch/arm/mach-orion5x/include/mach/uncompress.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * Tzachi Perelstein <tzachi@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/serial_reg.h>
-
-#define UART0_PHYS_BASE (0xf1000000 + 0x12000)
-#define SERIAL_BASE	((unsigned char *)UART0_PHYS_BASE)
-
-static void putc(const char c)
-{
-	unsigned char *base = SERIAL_BASE;
-	int i;
-
-	for (i = 0; i < 0x1000; i++) {
-		if (base[UART_LSR << 2] & UART_LSR_THRE)
-			break;
-		barrier();
-	}
-
-	base[UART_TX << 2] = c;
-}
-
-static void flush(void)
-{
-	unsigned char *base = SERIAL_BASE;
-	unsigned char mask;
-	int i;
-
-	mask = UART_LSR_TEMT | UART_LSR_THRE;
-
-	for (i = 0; i < 0x1000; i++) {
-		if ((base[UART_LSR << 2] & mask) == mask)
-			break;
-		barrier();
-	}
-}
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
-- 
2.1.0.rc2
