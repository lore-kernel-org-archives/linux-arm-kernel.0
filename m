From: jassisinghbrar@gmail.com (jassisinghbrar at gmail.com)
Date: Thu, 28 Jan 2010 17:32:54 +0900
Subject: [PATCH] ARM: S3C64XX: Audio: Make platform device compilation
	selectable
Message-ID: <1264667574-24982-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

The I2S/AC97/PCM controller platform devices should be compiled
in independent of the driver support, otherwise we might end up
with dev-spi built as kernel module.
Change this to make every machine select if it has some Audio
device and wants to build device definitions.

Since, currently only smdk_6400/6410 with S3C64xx SoC has audio
drivers, we enable AUDIO support for only these boards.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s3c6400/Kconfig  |    1 +
 arch/arm/mach-s3c6410/Kconfig  |    1 +
 arch/arm/plat-s3c64xx/Makefile |    4 +++-
 arch/arm/plat-samsung/Kconfig  |    6 ++++++
 4 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c6400/Kconfig b/arch/arm/mach-s3c6400/Kconfig
index a250bf6..d988664 100644
--- a/arch/arm/mach-s3c6400/Kconfig
+++ b/arch/arm/mach-s3c6400/Kconfig
@@ -23,6 +23,7 @@ config S3C6400_SETUP_SDHCI
 config MACH_SMDK6400
        bool "SMDK6400"
 	select CPU_S3C6400
+	select S3C64XX_DEV_AUDIO
 	select S3C_DEV_HSMMC
 	select S3C_DEV_NAND
 	select S3C6400_SETUP_SDHCI
diff --git a/arch/arm/mach-s3c6410/Kconfig b/arch/arm/mach-s3c6410/Kconfig
index 162f456..779e5f0 100644
--- a/arch/arm/mach-s3c6410/Kconfig
+++ b/arch/arm/mach-s3c6410/Kconfig
@@ -29,6 +29,7 @@ config MACH_ANW6410
 config MACH_SMDK6410
 	bool "SMDK6410"
 	select CPU_S3C6410
+	select S3C64XX_DEV_AUDIO
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_I2C1
diff --git a/arch/arm/plat-s3c64xx/Makefile b/arch/arm/plat-s3c64xx/Makefile
index e60bde3..2ea0977 100644
--- a/arch/arm/plat-s3c64xx/Makefile
+++ b/arch/arm/plat-s3c64xx/Makefile
@@ -40,6 +40,9 @@ obj-$(CONFIG_S3C64XX_DMA)	+= dma.o
 
 obj-$(CONFIG_S3C_ADC)		+= dev-adc.o
 
+# Audio support
+obj-$(CONFIG_S3C64XX_DEV_AUDIO) += dev-audio.o
+
 # SPI support
 obj-$(CONFIG_S3C64XX_DEV_SPI) += dev-spi.o
 
@@ -49,4 +52,3 @@ obj-$(CONFIG_S3C64XX_SETUP_I2C0) += setup-i2c0.o
 obj-$(CONFIG_S3C64XX_SETUP_I2C1) += setup-i2c1.o
 obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
 obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
-obj-$(CONFIG_SND_S3C24XX_SOC) += dev-audio.o
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 72da646..de119fd 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -138,6 +138,12 @@ config S3C64XX_DEV_SPI
 	  Compile in platform device definitions for S3C64XX's type
 	  SPI controllers.
 
+config S3C64XX_DEV_AUDIO
+	bool
+	help
+	  Compile in platform device definition for I2S/AC97/PCM controllers
+	  of S3C64XX
+
 comment "Power management"
 
 config SAMSUNG_PM_DEBUG
-- 
1.6.2.5
