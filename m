From: manabian@gmail.com (Joachim Eastwood)
Date: Wed,  1 Apr 2015 23:20:38 +0200
Subject: [PATCH 1/6] ARM: lpc18xx: add basic support for NXP LPC18xx/43xx SoCs
In-Reply-To: <1427923243-26296-1-git-send-email-manabian@gmail.com>
References: <1427923243-26296-1-git-send-email-manabian@gmail.com>
Message-ID: <1427923243-26296-2-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for NXP's LPC18xx (Cortex-M3) and LPC43xx (Cortex-M4)
SoCs. These SoCs are NXP's high preformance MCU line and can run at
clock speeds up to 180 MHz for LPC18xx and 204 MHz for LPC43xx.

LPC43xx is more or less a LPC18xx with a Cortex-M4F core and a few
extra peripherals. The LPC43xx series also features one or two
Cortex-M0 cores that can be used to offload the main M4 core.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/Kconfig                    | 20 ++++++++++++++++++++
 arch/arm/Kconfig.debug              |  8 +++++---
 arch/arm/Makefile                   |  1 +
 arch/arm/mach-lpc18xx/Makefile      |  1 +
 arch/arm/mach-lpc18xx/Makefile.boot |  3 +++
 arch/arm/mach-lpc18xx/board-dt.c    | 24 ++++++++++++++++++++++++
 6 files changed, 54 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-lpc18xx/Makefile
 create mode 100644 arch/arm/mach-lpc18xx/Makefile.boot
 create mode 100644 arch/arm/mach-lpc18xx/board-dt.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cf4c0c99aa25..056921e6fccb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -593,6 +593,26 @@ config ARCH_W90X900
 	  <http://www.nuvoton.com/hq/enu/ProductAndSales/ProductLines/
 		ConsumerElectronicsIC/ARMMicrocontroller/ARMMicrocontroller>
 
+config ARCH_LPC18XX
+	bool "NXP LPC18xx/LPC43xx"
+	depends on !MMU
+	select ARCH_HAS_RESET_CONTROLLER
+	select ARCH_REQUIRE_GPIOLIB
+	select ARM_AMBA
+	select ARM_NVIC
+	select AUTO_ZRELADDR
+	select CLKSRC_OF
+	select COMMON_CLK
+	select CPU_V7M
+	select GENERIC_CLOCKEVENTS
+	select NO_IOPORT_MAP
+	select PINCTRL
+	select SPARSE_IRQ
+	select USE_OF
+	help
+	  Support for NXP's LPC18xx Cortex-M3 and LPC43xx Cortex-M4
+	  high performance microcontrollers.
+
 config ARCH_LPC32XX
 	bool "NXP LPC32XX"
 	select ARCH_REQUIRE_GPIOLIB
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 970de7518341..348adb414a66 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1329,8 +1329,9 @@ config DEBUG_UART_8250
 	def_bool ARCH_DOVE || ARCH_EBSA110 || \
 		(FOOTBRIDGE && !DEBUG_DC21285_PORT) || \
 		ARCH_GEMINI || ARCH_IOP13XX || ARCH_IOP32X || \
-		ARCH_IOP33X || ARCH_IXP4XX || \
-		ARCH_LPC32XX || ARCH_MV78XX0 || ARCH_ORION5X || ARCH_RPC
+		ARCH_IOP33X || ARCH_IXP4XX || ARCH_LPC18XX || \
+		ARCH_LPC32XX || ARCH_MV78XX0 || ARCH_ORION5X || \
+		ARCH_RPC
 
 # Compatibility options for BCM63xx
 config DEBUG_UART_BCM63XX
@@ -1371,6 +1372,7 @@ config DEBUG_UART_PHYS
 	default 0x20201000 if DEBUG_BCM2835
 	default 0x3e000000 if DEBUG_BCM_KONA_UART
 	default 0x4000e400 if DEBUG_LL_UART_EFM32
+	default 0x40081000 if ARCH_LPC18XX
 	default 0x40090000 if ARCH_LPC32XX
 	default 0x40100000 if DEBUG_PXA_UART1
 	default 0x42000000 if ARCH_GEMINI
@@ -1573,7 +1575,7 @@ config DEBUG_UNCOMPRESS
 config UNCOMPRESS_INCLUDE
 	string
 	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
-					PLAT_SAMSUNG || ARCH_EFM32
+					PLAT_SAMSUNG || ARCH_EFM32 || ARCH_LPC18XX
 	default "mach/uncompress.h"
 
 config EARLY_PRINTK
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index eb7bb511f853..0bf3fe30ac5e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -167,6 +167,7 @@ machine-$(CONFIG_ARCH_IOP33X)		+= iop33x
 machine-$(CONFIG_ARCH_IXP4XX)		+= ixp4xx
 machine-$(CONFIG_ARCH_KEYSTONE)		+= keystone
 machine-$(CONFIG_ARCH_KS8695)		+= ks8695
+machine-$(CONFIG_ARCH_LPC18XX)		+= lpc18xx
 machine-$(CONFIG_ARCH_LPC32XX)		+= lpc32xx
 machine-$(CONFIG_ARCH_MESON)		+= meson
 machine-$(CONFIG_ARCH_MMP)		+= mmp
diff --git a/arch/arm/mach-lpc18xx/Makefile b/arch/arm/mach-lpc18xx/Makefile
new file mode 100644
index 000000000000..bd0b7b5d6e9d
--- /dev/null
+++ b/arch/arm/mach-lpc18xx/Makefile
@@ -0,0 +1 @@
+obj-y += board-dt.o
diff --git a/arch/arm/mach-lpc18xx/Makefile.boot b/arch/arm/mach-lpc18xx/Makefile.boot
new file mode 100644
index 000000000000..eacfc3f5c33e
--- /dev/null
+++ b/arch/arm/mach-lpc18xx/Makefile.boot
@@ -0,0 +1,3 @@
+# Empty file waiting for deletion once Makefile.boot isn't needed any more.
+# Patch waits for application at
+# http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7889/1 .
diff --git a/arch/arm/mach-lpc18xx/board-dt.c b/arch/arm/mach-lpc18xx/board-dt.c
new file mode 100644
index 000000000000..082881aab49d
--- /dev/null
+++ b/arch/arm/mach-lpc18xx/board-dt.c
@@ -0,0 +1,24 @@
+/*
+ * Device Tree board file for NXP LPC18xx/43xx
+ *
+ * Copyright (C) 2015 Joachim Eastwood <manabian@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+
+#include <asm/v7m.h>
+#include <asm/mach/arch.h>
+
+static const char *const lpc18xx_43xx_compat[] __initconst = {
+	"ea,lpc4357-developers-kit",
+	NULL
+};
+
+DT_MACHINE_START(LPC18XXDT, "NXP LPC18xx/43xx (Device Tree Support)")
+	.dt_compat = lpc18xx_43xx_compat,
+	.restart = armv7m_restart,
+MACHINE_END
-- 
1.8.0
