From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 17:06:48 +0100
Subject: [PATCH 03/10] gpio: samsung: move gpio-samsung driver back to
 platform code
In-Reply-To: <1448467615-447097-1-git-send-email-arnd@arndb.de>
References: <1448467615-447097-1-git-send-email-arnd@arndb.de>
Message-ID: <1448467615-447097-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio-samsung driver is special in the sense that it
interacts directly in multiple ways with the legacy platform
code for the s3c24xx and s3c64xx platforms. In contrast,
all devicetree based machines for Samsung, including the
ones on those two SoC families use a different driver.

The header files that define the interface between the platform
code and the gpio driver are not visible when building a
kernel for ARCH_MULTIPLATFORM, which prevents us from
turning on this option for s3c64xx.

To work around this, we now move the driver back into platform
code, from where it was originally moved to as part of commit
1b39d5f2cc5c28 ("gpio/samsung: gpio-samsung.c to support
Samsung GPIOs").

The long-term plan for this driver would be to remove it
entirely, after all Samsung machines have been converted
over to boot from DT, but there is currently no timeline
for when that might happen.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/plat-samsung/Kconfig                          | 3 +++
 arch/arm/plat-samsung/Makefile                         | 2 ++
 {drivers/gpio => arch/arm/plat-samsung}/gpio-samsung.c | 0
 drivers/gpio/Kconfig                                   | 7 -------
 drivers/gpio/Makefile                                  | 1 -
 5 files changed, 5 insertions(+), 8 deletions(-)
 rename {drivers/gpio => arch/arm/plat-samsung}/gpio-samsung.c (100%)

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 57729b915003..83697414bfa0 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -294,6 +294,9 @@ config SAMSUNG_WDT_RESET
 	  Compile support for system restart by triggering watchdog reset.
 	  Used on SoCs that do not provide dedicated reset control.
 
+config GPIO_SAMSUNG
+	def_bool SAMSUNG_ATAGS
+
 config DEBUG_S3C_UART
 	depends on PLAT_SAMSUNG
 	int
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 8c911760f55f..aeb19e3288b9 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -21,6 +21,8 @@ obj-$(CONFIG_SAMSUNG_ATAGS)	+= platformdata.o
 obj-$(CONFIG_SAMSUNG_ATAGS)	+= devs.o
 obj-$(CONFIG_SAMSUNG_ATAGS)	+= dev-uart.o
 
+obj-$(CONFIG_GPIO_SAMSUNG)     += gpio-samsung.o
+
 # PM support
 
 obj-$(CONFIG_PM_SLEEP)		+= pm-common.o
diff --git a/drivers/gpio/gpio-samsung.c b/arch/arm/plat-samsung/gpio-samsung.c
similarity index 100%
rename from drivers/gpio/gpio-samsung.c
rename to arch/arm/plat-samsung/gpio-samsung.c
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b18bea08ff25..5e4e9f5c8a64 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -344,13 +344,6 @@ config GPIO_RCAR
 	help
 	  Say yes here to support GPIO on Renesas R-Car SoCs.
 
-config GPIO_SAMSUNG
-	bool
-	depends on PLAT_SAMSUNG
-	help
-	  Legacy GPIO support. Use only for platforms without support for
-	  pinctrl.
-
 config GPIO_SPEAR_SPICS
 	bool "ST SPEAr13xx SPI Chip Select as GPIO support"
 	depends on PLAT_SPEAR
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 986dbd838cea..8555e947372e 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -79,7 +79,6 @@ obj-$(CONFIG_GPIO_PXA)		+= gpio-pxa.o
 obj-$(CONFIG_GPIO_RC5T583)	+= gpio-rc5t583.o
 obj-$(CONFIG_GPIO_RDC321X)	+= gpio-rdc321x.o
 obj-$(CONFIG_GPIO_RCAR)		+= gpio-rcar.o
-obj-$(CONFIG_GPIO_SAMSUNG)	+= gpio-samsung.o
 obj-$(CONFIG_ARCH_SA1100)	+= gpio-sa1100.o
 obj-$(CONFIG_GPIO_SCH)		+= gpio-sch.o
 obj-$(CONFIG_GPIO_SCH311X)	+= gpio-sch311x.o
-- 
2.1.0.rc2
