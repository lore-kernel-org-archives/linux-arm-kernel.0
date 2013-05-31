From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:19:03 +0200
Subject: [PATCH 28/39] ARM: u300: convert to multiplatform
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-29-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Now that we removed our dependency on <mach/*> the U300
can be converted to mutliplatform. Remove the invalid restriction
that U300 would not support AUTO_ZRELADDR (it does) and update
the defconfig in the process.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                | 21 +--------------------
 arch/arm/configs/u300_defconfig | 11 ++++-------
 arch/arm/mach-u300/Kconfig      | 31 +++++++++++++++++++++++++------
 3 files changed, 30 insertions(+), 33 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2689643..b6f9ce6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -812,25 +812,6 @@ config ARCH_SHARK
 	  Support for the StrongARM based Digital DNARD machine, also known
 	  as "Shark" (<http://www.shark-linux.de/shark.html>).
 
-config ARCH_U300
-	bool "ST-Ericsson U300 Series"
-	depends on MMU
-	select ARCH_REQUIRE_GPIOLIB
-	select ARM_AMBA
-	select ARM_PATCH_PHYS_VIRT
-	select ARM_VIC
-	select CLKDEV_LOOKUP
-	select CLKSRC_MMIO
-	select CLKSRC_OF
-	select COMMON_CLK
-	select CPU_ARM926T
-	select GENERIC_CLOCKEVENTS
-	select HAVE_TCM
-	select SPARSE_IRQ
-	select USE_OF
-	help
-	  Support for ST-Ericsson U300 series mobile platforms.
-
 config ARCH_DAVINCI
 	bool "TI DaVinci"
 	select ARCH_HAS_HOLES_MEMORYMODEL
@@ -2041,7 +2022,7 @@ config CRASH_DUMP
 
 config AUTO_ZRELADDR
 	bool "Auto calculation of the decompressed kernel image address"
-	depends on !ZBOOT_ROM && !ARCH_U300
+	depends on !ZBOOT_ROM
 	help
 	  ZRELADDR is the physical address where the decompressed kernel
 	  image will be placed. If AUTO_ZRELADDR is selected, the address
diff --git a/arch/arm/configs/u300_defconfig b/arch/arm/configs/u300_defconfig
index 374000e..a5fa0d9 100644
--- a/arch/arm/configs/u300_defconfig
+++ b/arch/arm/configs/u300_defconfig
@@ -1,7 +1,8 @@
-CONFIG_EXPERIMENTAL=y
 # CONFIG_LOCALVERSION_AUTO is not set
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
 # CONFIG_AIO is not set
@@ -11,12 +12,9 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_CFQ is not set
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_U300=y
-CONFIG_MACH_U300=y
-CONFIG_MACH_U300_BS335=y
 CONFIG_MACH_U300_SPIDUMMY=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
@@ -44,11 +42,11 @@ CONFIG_I2C=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_FB=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 # CONFIG_LCD_CLASS_DEVICE is not set
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
-# CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
 CONFIG_MMC_CLKGATE=y
@@ -70,4 +68,3 @@ CONFIG_DEBUG_FS=y
 CONFIG_TIMER_STATS=y
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_DEBUG_INFO=y
-# CONFIG_CRC32 is not set
diff --git a/arch/arm/mach-u300/Kconfig b/arch/arm/mach-u300/Kconfig
index 1f59764..e2f350f 100644
--- a/arch/arm/mach-u300/Kconfig
+++ b/arch/arm/mach-u300/Kconfig
@@ -1,24 +1,45 @@
-if ARCH_U300
-
 menu "ST-Ericsson AB U300/U335 Platform"
 
 comment "ST-Ericsson Mobile Platform Products"
 
-config MACH_U300
-	bool "U300"
+config ARCH_U300
+	bool "ST-Ericsson U300 Series"
+	depends on MMU
+	select ARCH_REQUIRE_GPIOLIB
+	select ARM_AMBA
+	select ARM_PATCH_PHYS_VIRT
+	select ARM_VIC
+	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
+	select CLKSRC_OF
+	select COMMON_CLK
+	select CPU_ARM926T
+	select GENERIC_CLOCKEVENTS
+	select HAVE_TCM
 	select PINCTRL
 	select PINCTRL_COH901
 	select PINCTRL_U300
+	select SPARSE_IRQ
+	select USE_OF
+	help
+	  Support for ST-Ericsson U300 series mobile platforms.
 
 comment "ST-Ericsson U300/U335 Feature Selections"
 
+config MACH_U300
+	depends on ARCH_U300
+	bool "U300"
+	default y
+
 config U300_DEBUG
+	depends on ARCH_U300
 	bool "Debug support for U300"
 	depends on PM
 	help
 		Debug support for U300 in sysfs, procfs etc.
 
 config MACH_U300_SPIDUMMY
+	depends on ARCH_U300
 	bool "SSP/SPI dummy chip"
 	select SPI
 	select SPI_MASTER
@@ -31,5 +52,3 @@ config MACH_U300_SPIDUMMY
 		SPI framework and ARM PL022 support.
 
 endmenu
-
-endif
-- 
1.7.11.3
