From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 29 Jan 2010 09:02:17 +0000
Subject: [PATCH] ARM: SAMSUNG: Move plat-s3c Kconfig entries to plat-samsung
	and plat-s3c24xx
In-Reply-To: <1264755741-16184-1-git-send-email-ben-linux@fluff.org>
References: <1264755741-16184-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264755741-16184-7-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the Kconfig entries from plat-s3c to plat-samsung and plat-s3c24xx
as necessary. The S3C_BOOT entries and the DMA configuration can go to
plat-samsung. The low-level UART configurations are currently S3C2XX
specific and can go to plat-s3c24xx.

Eliminating plat-s3c from the build process will be submitted seperately.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c/Kconfig     |   85 -----------------------------------------
 arch/arm/plat-s3c24xx/Kconfig |   22 +++++++++++
 arch/arm/plat-samsung/Kconfig |   59 ++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 85 deletions(-)

diff --git a/arch/arm/plat-s3c/Kconfig b/arch/arm/plat-s3c/Kconfig
index 2367908..6108ba9 100644
--- a/arch/arm/plat-s3c/Kconfig
+++ b/arch/arm/plat-s3c/Kconfig
@@ -9,88 +9,3 @@ config PLAT_S3C
 	select NO_IOPORT
 	help
 	  Base platform code for any Samsung S3C device
-
-# low-level serial option nodes
-
-if PLAT_S3C
-
-config CPU_LLSERIAL_S3C2410_ONLY
-	bool
-	default y if CPU_LLSERIAL_S3C2410 && !CPU_LLSERIAL_S3C2440
-
-config CPU_LLSERIAL_S3C2440_ONLY
-	bool
-	default y if CPU_LLSERIAL_S3C2440 && !CPU_LLSERIAL_S3C2410
-
-config CPU_LLSERIAL_S3C2410
-	bool
-	help
-	  Selected if there is an S3C2410 (or register compatible) serial
-	  low-level implementation needed
-
-config CPU_LLSERIAL_S3C2440
-	bool
-	help
-	  Selected if there is an S3C2440 (or register compatible) serial
-	  low-level implementation needed
-
-# boot configurations
-
-comment "Boot options"
-
-config S3C_BOOT_WATCHDOG
-	bool "S3C Initialisation watchdog"
-	depends on S3C2410_WATCHDOG
-	help
-	  Say y to enable the watchdog during the kernel decompression
-	  stage. If the kernel fails to uncompress, then the watchdog
-	  will trigger a reset and the system should restart.
-
-config S3C_BOOT_ERROR_RESET
-	bool "S3C Reboot on decompression error"
-	help
-	  Say y here to use the watchdog to reset the system if the
-	  kernel decompressor detects an error during decompression.
-
-config S3C_BOOT_UART_FORCE_FIFO
-       bool "Force UART FIFO on during boot process"
-       default y
-       help
-         Say Y here to force the UART FIFOs on during the kernel
-	 uncompressor
-
-
-config S3C_LOWLEVEL_UART_PORT
-	int "S3C UART to use for low-level messages"
-	default 0
-	help
-	  Choice of which UART port to use for the low-level messages,
-	  such as the `Uncompressing...` at start time. The value of
-	  this configuration should be between zero and two. The port
-	  must have been initialised by the boot-loader before use.
-
-# options for gpiolib support
-
-config S3C_GPIO_SPACE
-	int "Space between gpio banks"
-	default 0
-	help
-	  Add a number of spare GPIO entries between each bank for debugging
-	  purposes. This allows any problems where an counter overflows from
-	  one bank to another to be caught, at the expense of using a little
-	  more memory.
-
-config S3C_GPIO_TRACK
-	bool
-	help
-	  Internal configuration option to enable the s3c specific gpio
-	  chip tracking if the platform requires it.
-
-# DMA
-
-config S3C_DMA
-	bool
-	help
-	  Internal configuration for S3C DMA core
-
-endif
diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
index a806f35..d725739 100644
--- a/arch/arm/plat-s3c24xx/Kconfig
+++ b/arch/arm/plat-s3c24xx/Kconfig
@@ -14,6 +14,28 @@ config PLAT_S3C24XX
 
 if PLAT_S3C24XX
 
+# low-level serial option nodes
+
+config CPU_LLSERIAL_S3C2410_ONLY
+	bool
+	default y if CPU_LLSERIAL_S3C2410 && !CPU_LLSERIAL_S3C2440
+
+config CPU_LLSERIAL_S3C2440_ONLY
+	bool
+	default y if CPU_LLSERIAL_S3C2440 && !CPU_LLSERIAL_S3C2410
+
+config CPU_LLSERIAL_S3C2410
+	bool
+	help
+	  Selected if there is an S3C2410 (or register compatible) serial
+	  low-level implementation needed
+
+config CPU_LLSERIAL_S3C2440
+	bool
+	help
+	  Selected if there is an S3C2440 (or register compatible) serial
+	  low-level implementation needed
+
 # code that is shared between a number of the s3c24xx implementations
 
 config S3C2410_CLOCK
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 72da646..93bd893 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -13,6 +13,43 @@ config PLAT_SAMSUNG
 
 if PLAT_SAMSUNG
 
+# boot configurations
+
+comment "Boot options"
+
+config S3C_BOOT_WATCHDOG
+	bool "S3C Initialisation watchdog"
+	depends on S3C2410_WATCHDOG
+	help
+	  Say y to enable the watchdog during the kernel decompression
+	  stage. If the kernel fails to uncompress, then the watchdog
+	  will trigger a reset and the system should restart.
+
+config S3C_BOOT_ERROR_RESET
+	bool "S3C Reboot on decompression error"
+	help
+	  Say y here to use the watchdog to reset the system if the
+	  kernel decompressor detects an error during decompression.
+
+config S3C_BOOT_UART_FORCE_FIFO
+       bool "Force UART FIFO on during boot process"
+       default y
+       help
+         Say Y here to force the UART FIFOs on during the kernel
+	 uncompressor
+
+
+config S3C_LOWLEVEL_UART_PORT
+	int "S3C UART to use for low-level messages"
+	default 0
+	help
+	  Choice of which UART port to use for the low-level messages,
+	  such as the `Uncompressing...` at start time. The value of
+	  this configuration should be between zero and two. The port
+	  must have been initialised by the boot-loader before use.
+
+# clock options
+
 config SAMSUNG_CLKSRC
 	bool
 	help
@@ -81,6 +118,21 @@ config SAMSUNG_GPIO_EXTRA
 	  provides. This allows expanding the GPIO space for use with
 	  GPIO expanders.
 
+config S3C_GPIO_SPACE
+	int "Space between gpio banks"
+	default 0
+	help
+	  Add a number of spare GPIO entries between each bank for debugging
+	  purposes. This allows any problems where an counter overflows from
+	  one bank to another to be caught, at the expense of using a little
+	  more memory.
+
+config S3C_GPIO_TRACK
+	bool
+	help
+	  Internal configuration option to enable the s3c specific gpio
+	  chip tracking if the platform requires it.
+
 # ADC driver
 
 config S3C_ADC
@@ -138,6 +190,13 @@ config S3C64XX_DEV_SPI
 	  Compile in platform device definitions for S3C64XX's type
 	  SPI controllers.
 
+# DMA
+
+config S3C_DMA
+	bool
+	help
+	  Internal configuration for S3C DMA core
+
 comment "Power management"
 
 config SAMSUNG_PM_DEBUG
-- 
1.6.0.4
