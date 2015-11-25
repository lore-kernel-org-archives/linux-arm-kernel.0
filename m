From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 17:06:54 +0100
Subject: [PATCH 09/10] ARM: s3c64xx: multiplatform support
In-Reply-To: <1448467615-447097-1-git-send-email-arnd@arndb.de>
References: <1448467615-447097-1-git-send-email-arnd@arndb.de>
Message-ID: <1448467615-447097-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After all preparation work is done, we can finally move the Kconfig
option for s3c64xx into ARCH_MULTIPLATFORM. This implies allowing
SAMSUNG_ATAGS for multiplatform again, but now disallowing the
ADC driver below it, as that still has dependencies on header files.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                    | 27 ---------------------------
 arch/arm/configs/multi_v7_defconfig |  3 +++
 arch/arm/configs/s3c6400_defconfig  |  2 ++
 arch/arm/mach-s3c64xx/Kconfig       | 22 +++++++++++++++++++++-
 arch/arm/mach-s3c64xx/Makefile      |  3 +++
 arch/arm/plat-samsung/Kconfig       |  2 +-
 arch/arm/plat-samsung/Makefile      |  3 ++-
 7 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1ec6a153d8e5..f08306499a82 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -626,33 +626,6 @@ config ARCH_S3C24XX
 	  (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or the
 	  Samsung SMDK2410 development board (and derivatives).
 
-config ARCH_S3C64XX
-	bool "Samsung S3C64XX"
-	select ARCH_REQUIRE_GPIOLIB
-	select ARM_AMBA
-	select ARM_VIC
-	select ATAGS
-	select CLKDEV_LOOKUP
-	select CLKSRC_SAMSUNG_PWM
-	select COMMON_CLK_SAMSUNG
-	select CPU_V6K
-	select GENERIC_CLOCKEVENTS
-	select GPIO_SAMSUNG
-	select HAVE_S3C2410_I2C if I2C
-	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-	select HAVE_TCM
-	select NO_IOPORT_MAP
-	select PLAT_SAMSUNG
-	select PM_GENERIC_DOMAINS if PM
-	select S3C_DEV_NAND
-	select S3C_GPIO_TRACK
-	select SAMSUNG_ATAGS
-	select SAMSUNG_WAKEMASK
-	select SAMSUNG_WDT_RESET
-	select SPARSE_IRQ
-	help
-	  Samsung S3C64XX series based systems
-
 config ARCH_DAVINCI
 	bool "TI DaVinci"
 	select ARCH_HAS_HOLES_MEMORYMODEL
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index c8953e102a7c..44f0f2a8124d 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -11,6 +11,9 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_CMDLINE_PARTITION=y
+CONFIG_ARCH_MULTI_V7=y
+# CONFIG_ARCH_MULTI_V5 is not set
+# CONFIG_ARCH_MULTI_V4 is not set
 CONFIG_ARCH_VIRT=y
 CONFIG_ARCH_ALPINE=y
 CONFIG_ARCH_MVEBU=y
diff --git a/arch/arm/configs/s3c6400_defconfig b/arch/arm/configs/s3c6400_defconfig
index e2f9fa5bb54b..e0f66936ae02 100644
--- a/arch/arm/configs/s3c6400_defconfig
+++ b/arch/arm/configs/s3c6400_defconfig
@@ -5,6 +5,8 @@ CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
+CONFIG_ARCH_MULTI_V6=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_S3C64XX=y
 CONFIG_S3C_BOOT_ERROR_RESET=y
 CONFIG_MACH_SMDK6400=y
diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 28c7097e8506..caf71a99389e 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -2,6 +2,27 @@
 #	Simtec Electronics, Ben Dooks <ben@simtec.co.uk>
 #
 # Licensed under GPLv2
+menuconfig ARCH_S3C64XX
+	bool "Samsung S3C64XX" if ARCH_MULTI_V6
+	select ARCH_REQUIRE_GPIOLIB
+	select ARM_AMBA
+	select ARM_VIC
+	select ATAGS
+	select CLKSRC_SAMSUNG_PWM
+	select COMMON_CLK_SAMSUNG
+	select GPIO_SAMSUNG
+	select HAVE_S3C2410_I2C if I2C
+	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select HAVE_TCM
+	select PLAT_SAMSUNG
+	select PM_GENERIC_DOMAINS if PM
+	select S3C_DEV_NAND
+	select S3C_GPIO_TRACK
+	select SAMSUNG_ATAGS
+	select SAMSUNG_WAKEMASK if PM
+	select SAMSUNG_WDT_RESET
+	help
+	  Samsung S3C64XX series based systems
 
 if ARCH_S3C64XX
 
@@ -310,7 +331,6 @@ config MACH_S3C64XX_DT
 	select CPU_S3C6410
 	select PINCTRL
 	select PINCTRL_S3C64XX
-	select USE_OF
 	help
 	  Machine support for Samsung S3C6400/S3C6410 machines with Device Tree
 	  enabled.
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index bb233f342f31..04cdcd40e23c 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -5,6 +5,9 @@
 #
 # Licensed under GPLv2
 
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include -I$(srctree)/arch/arm/plat-samsung/include
+asflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include -I$(srctree)/arch/arm/plat-samsung/include
+
 # Core
 
 obj-y				+= common.o
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 83697414bfa0..aa78c72fcecd 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -39,7 +39,6 @@ config S3C_LOWLEVEL_UART_PORT
 
 config SAMSUNG_ATAGS
 	def_bool n
-	depends on !ARCH_MULTIPLATFORM
 	depends on ATAGS
 	help
 	   This option enables ATAGS based boot support code for
@@ -70,6 +69,7 @@ config S3C_GPIO_TRACK
 
 config S3C_ADC
 	bool "ADC common driver support"
+	depends on !ARCH_MULTIPLATFORM
 	help
 	  Core support for the ADC block found in the Samsung SoC systems
 	  for drivers such as the touchscreen and hwmon to use to share
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index aeb19e3288b9..be172efec15c 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -4,7 +4,8 @@
 #
 # Licensed under GPLv2
 
-ccflags-$(CONFIG_ARCH_MULTI_V7) += -I$(srctree)/$(src)/include
+ccflags-$(CONFIG_ARCH_S3C64XX) := -I$(srctree)/arch/arm/mach-s3c64xx/include
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/$(src)/include
 
 # Objects we always build independent of SoC choice
 
-- 
2.1.0.rc2
