From: eric@anholt.net (Eric Anholt)
Date: Tue, 21 Apr 2015 11:09:54 -0700
Subject: [PATCH 7/9] ARM: Add Kconfig support for bcm2836.
In-Reply-To: <1429639796-2169-1-git-send-email-eric@anholt.net>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
Message-ID: <1429639796-2169-8-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This port to the Raspberry Pi 2 comes up with SD card and network
working.  It doesn't yet support SMP, the ARM local timer, or PMU
events, and serial is fixed in a follow-on patch.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/Kconfig.debug     |  8 +++++++-
 arch/arm/boot/dts/Makefile |  2 ++
 arch/arm/mach-bcm/Kconfig  | 18 +++++++++++++-----
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 970de75..7da2061 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -137,6 +137,11 @@ choice
 		depends on ARCH_BCM2835
 		select DEBUG_UART_PL01X
 
+	config DEBUG_BCM2836
+		bool "Kernel low-level debugging on BCM2836 PL011 UART"
+		depends on ARCH_BCM2836
+		select DEBUG_UART_PL01X
+
 	config DEBUG_BCM_5301X
 		bool "Kernel low-level debugging on BCM5301X UART1"
 		depends on ARCH_BCM_5301X
@@ -1369,6 +1374,7 @@ config DEBUG_UART_PHYS
 	default 0x20064000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
 	default 0x20068000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
 	default 0x20201000 if DEBUG_BCM2835
+	default 0x3f201000 if DEBUG_BCM2836
 	default 0x3e000000 if DEBUG_BCM_KONA_UART
 	default 0x4000e400 if DEBUG_LL_UART_EFM32
 	default 0x40090000 if ARCH_LPC32XX
@@ -1450,7 +1456,7 @@ config DEBUG_UART_VIRT
 	default 0xf0000be0 if ARCH_EBSA110
 	default 0xf0010000 if DEBUG_ASM9260_UART
 	default 0xf01fb000 if DEBUG_NOMADIK_UART
-	default 0xf0201000 if DEBUG_BCM2835
+	default 0xf0201000 if DEBUG_BCM2835 || DEBUG_BCM2836
 	default 0xf1000300 if DEBUG_BCM_5301X
 	default 0xf1002000 if DEBUG_MT8127_UART0
 	default 0xf1006000 if DEBUG_MT6589_UART0
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a1c776b..72b476d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -52,6 +52,8 @@ dtb-$(CONFIG_ARCH_AXXIA) += \
 dtb-$(CONFIG_ARCH_BCM2835) += \
 	bcm2835-rpi-b.dtb \
 	bcm2835-rpi-b-plus.dtb
+dtb-$(CONFIG_ARCH_BCM2836) += \
+	bcm2836-rpi-2-b.dtb
 dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm4708-buffalo-wzr-1750dhp.dtb \
 	bcm4708-luxul-xwc-1000.dtb \
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 7c438b2..751ea08 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -109,6 +109,12 @@ comment "Other Architectures"
 
 config ARCH_BCM283X
 	bool
+	select ARCH_REQUIRE_GPIOLIB
+	select ARM_AMBA
+	select PINCTRL
+	select PINCTRL_BCM2835
+	select CLKSRC_OF
+	select CLKSRC_MMIO
 	help
 	  This option should be selected by the 2835 and 2836 chips to
 	  enable common platform features.
@@ -116,17 +122,19 @@ config ARCH_BCM283X
 config ARCH_BCM2835
 	bool "Broadcom BCM2835 family" if ARCH_MULTI_V6
 	select ARCH_BCM283X
-	select ARCH_REQUIRE_GPIOLIB
-	select ARM_AMBA
 	select ARM_ERRATA_411920
 	select ARM_TIMER_SP804
-	select CLKSRC_OF
-	select PINCTRL
-	select PINCTRL_BCM2835
 	help
 	  This enables support for the Broadcom BCM2835 SoC. This SoC is
 	  used in the Raspberry Pi and Roku 2 devices.
 
+config ARCH_BCM2836
+	bool "Broadcom BCM2836 family" if ARCH_MULTI_V7
+	select ARCH_BCM283X
+	help
+	  This enables support for the Broadcom BCM2836 SoC. This SoC is
+	  used in the Raspberry Pi 2
+
 config ARCH_BCM_63XX
 	bool "Broadcom BCM63xx DSL SoC" if ARCH_MULTI_V7
 	depends on MMU
-- 
2.1.4
