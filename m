From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 28 Jan 2010 16:08:44 +0900
Subject: [PATCH] ARM: S3C64XX: Move to using library build for device definitions
Message-ID: <mailman.177.1264667007.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To improve the build coverage and to remove the numerous CONFIG_S3C_DEV
defines, try moving the plat-s3c64xx device definition files to be part
of a library.

Due to the fact it seems to be impossible to add libs-y in a platform or
device makefile, we need to add libs-y to arch/arm depending on the
CONFIG_PLAT_S3C64XX. We move the .c files to arch/arm/plat-s3c64xx/devs
as any directories added to libs-y also have their obj-y added to the
build.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/Makefile                            |    1 +
 arch/arm/plat-s3c64xx/Makefile               |    6 ------
 arch/arm/plat-s3c64xx/{ => devs}/dev-adc.c   |    0
 arch/arm/plat-s3c64xx/{ => devs}/dev-audio.c |    0
 arch/arm/plat-s3c64xx/{ => devs}/dev-spi.c   |    0
 5 files changed, 1 insertions(+), 6 deletions(-)
 rename arch/arm/plat-s3c64xx/{ => devs}/dev-adc.c (100%)
 rename arch/arm/plat-s3c64xx/{ => devs}/dev-audio.c (100%)
 rename arch/arm/plat-s3c64xx/{ => devs}/dev-spi.c (100%)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index bbcd512..8f53aa5 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -232,6 +232,7 @@ core-$(CONFIG_VFP)		+= arch/arm/vfp/
 drivers-$(CONFIG_OPROFILE)      += arch/arm/oprofile/
 
 libs-y				:= arch/arm/lib/ $(libs-y)
+libs-$(CONFIG_PLAT_S3C64XX)	+= arch/arm/plat-s3c64xx/devs/
 
 # Default target when executing plain make
 ifeq ($(CONFIG_XIP_KERNEL),y)
diff --git a/arch/arm/plat-s3c64xx/Makefile b/arch/arm/plat-s3c64xx/Makefile
index 80255a5..fd3d0b4 100644
--- a/arch/arm/plat-s3c64xx/Makefile
+++ b/arch/arm/plat-s3c64xx/Makefile
@@ -36,15 +36,9 @@ obj-$(CONFIG_PM)		+= irq-pm.o
 
 obj-$(CONFIG_S3C64XX_DMA)	+= dma.o
 
-# ADC support
-
-obj-$(CONFIG_S3C_ADC)		+= dev-adc.o
-
 # Device setup
 
 obj-$(CONFIG_S3C64XX_SETUP_I2C0) += setup-i2c0.o
 obj-$(CONFIG_S3C64XX_SETUP_I2C1) += setup-i2c1.o
 obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
 obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
-obj-$(CONFIG_SND_S3C24XX_SOC) += dev-audio.o
-obj-$(CONFIG_SPI_S3C64XX) += dev-spi.o
diff --git a/arch/arm/plat-s3c64xx/dev-adc.c b/arch/arm/plat-s3c64xx/devs/dev-adc.c
similarity index 100%
rename from arch/arm/plat-s3c64xx/dev-adc.c
rename to arch/arm/plat-s3c64xx/devs/dev-adc.c
diff --git a/arch/arm/plat-s3c64xx/dev-audio.c b/arch/arm/plat-s3c64xx/devs/dev-audio.c
similarity index 100%
rename from arch/arm/plat-s3c64xx/dev-audio.c
rename to arch/arm/plat-s3c64xx/devs/dev-audio.c
diff --git a/arch/arm/plat-s3c64xx/dev-spi.c b/arch/arm/plat-s3c64xx/devs/dev-spi.c
similarity index 100%
rename from arch/arm/plat-s3c64xx/dev-spi.c
rename to arch/arm/plat-s3c64xx/devs/dev-spi.c
-- 
1.6.0.4


-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
