From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  2 Dec 2015 22:27:07 +0100
Subject: [PATCH 5/7] ARM: mv78xx0: multiplatform support
In-Reply-To: <1449091629-2155735-1-git-send-email-arnd@arndb.de>
References: <1449091629-2155735-1-git-send-email-arnd@arndb.de>
Message-ID: <1449091629-2155735-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mv78xx0 platform is now ready to be enabled for multiplatform
support, this patch does the switch over by modifying the Kconfig file,
the defconfig and removing the last mach/*.h header that becomes obsolete
with this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/Kconfig                                | 14 --------
 arch/arm/configs/mv78xx0_defconfig              |  3 ++
 arch/arm/mach-mv78xx0/Kconfig                   | 15 ++++++---
 arch/arm/mach-mv78xx0/Makefile                  |  2 ++
 arch/arm/mach-mv78xx0/include/mach/uncompress.h | 44 -------------------------
 5 files changed, 16 insertions(+), 62 deletions(-)
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 99676c25536f..6a7ff25376bf 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -521,20 +521,6 @@ config ARCH_DOVE
 	help
 	  Support for the Marvell Dove SoC 88AP510
 
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
 config ARCH_ORION5X
 	bool "Marvell Orion"
 	depends on MMU
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
-- 
2.1.0.rc2
