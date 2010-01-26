From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 07:02:59 +0000
Subject: [PATCH] ARM: S3C64XX: Move device setup support to mach-s3c64xx
In-Reply-To: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
References: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264489385-13345-9-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move device setup support to mach-s3c64xx as it is unlikely to be used
outside of this directory

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c64xx/Kconfig                      |   26 ++++++++++++++++++++
 arch/arm/mach-s3c64xx/Makefile                     |    6 ++++-
 .../setup-fb-24bpp.c                               |    0
 .../{plat-s3c64xx => mach-s3c64xx}/setup-i2c0.c    |    0
 .../{plat-s3c64xx => mach-s3c64xx}/setup-i2c1.c    |    0
 .../setup-sdhci-gpio.c                             |    0
 arch/arm/plat-s3c64xx/Kconfig                      |   26 --------------------
 arch/arm/plat-s3c64xx/Makefile                     |    6 ----
 8 files changed, 31 insertions(+), 33 deletions(-)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/setup-fb-24bpp.c (100%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/setup-i2c0.c (100%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/setup-i2c1.c (100%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/setup-sdhci-gpio.c (100%)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index ce32e49..15e065e 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -26,6 +26,32 @@ config S3C64XX_SETUP_SDHCI
 	  Internal configuration for default SDHCI setup for S3C6400 and
 	  S3C6410 SoCs.
 
+# platform specific device setup
+
+config S3C64XX_SETUP_I2C0
+	bool
+	default y
+	help
+	  Common setup code for i2c bus 0.
+
+	  Note, currently since i2c0 is always compiled, this setup helper
+	  is always compiled with it.
+
+config S3C64XX_SETUP_I2C1
+	bool
+	help
+	  Common setup code for i2c bus 1.
+
+config S3C64XX_SETUP_FB_24BPP
+	bool
+	help
+	  Common setup code for S3C64XX with an 24bpp RGB display helper.
+
+config S3C64XX_SETUP_SDHCI_GPIO
+	bool
+	help
+	  Common setup code for S3C64XX SDHCI GPIO configurations
+
 # S36400 Macchine support
 
 config MACH_SMDK6400
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index 129f0a8..49b71d5 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -18,9 +18,13 @@ obj-$(CONFIG_CPU_S3C6410)	+= s3c6410.o
 obj-y				+= irq.o
 obj-y				+= irq-eint.o
 
-# setup support
+# Device setup
 
+obj-$(CONFIG_S3C64XX_SETUP_I2C0) += setup-i2c0.o
+obj-$(CONFIG_S3C64XX_SETUP_I2C1) += setup-i2c1.o
 obj-$(CONFIG_S3C64XX_SETUP_SDHCI) += setup-sdhci.o
+obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
+obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
 
 # PM
 
diff --git a/arch/arm/plat-s3c64xx/setup-fb-24bpp.c b/arch/arm/mach-s3c64xx/setup-fb-24bpp.c
similarity index 100%
rename from arch/arm/plat-s3c64xx/setup-fb-24bpp.c
rename to arch/arm/mach-s3c64xx/setup-fb-24bpp.c
diff --git a/arch/arm/plat-s3c64xx/setup-i2c0.c b/arch/arm/mach-s3c64xx/setup-i2c0.c
similarity index 100%
rename from arch/arm/plat-s3c64xx/setup-i2c0.c
rename to arch/arm/mach-s3c64xx/setup-i2c0.c
diff --git a/arch/arm/plat-s3c64xx/setup-i2c1.c b/arch/arm/mach-s3c64xx/setup-i2c1.c
similarity index 100%
rename from arch/arm/plat-s3c64xx/setup-i2c1.c
rename to arch/arm/mach-s3c64xx/setup-i2c1.c
diff --git a/arch/arm/plat-s3c64xx/setup-sdhci-gpio.c b/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
similarity index 100%
rename from arch/arm/plat-s3c64xx/setup-sdhci-gpio.c
rename to arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
diff --git a/arch/arm/plat-s3c64xx/Kconfig b/arch/arm/plat-s3c64xx/Kconfig
index 37b4519..4edb580 100644
--- a/arch/arm/plat-s3c64xx/Kconfig
+++ b/arch/arm/plat-s3c64xx/Kconfig
@@ -46,30 +46,4 @@ config S3C64XX_DMA
 	bool "S3C64XX DMA"
 	select S3C_DMA
 
-# platform specific device setup
-
-config S3C64XX_SETUP_I2C0
-	bool
-	default y
-	help
-	  Common setup code for i2c bus 0.
-
-	  Note, currently since i2c0 is always compiled, this setup helper
-	  is always compiled with it.
-
-config S3C64XX_SETUP_I2C1
-	bool
-	help
-	  Common setup code for i2c bus 1.
-
-config S3C64XX_SETUP_FB_24BPP
-	bool
-	help
-	  Common setup code for S3C64XX with an 24bpp RGB display helper.
-
-config S3C64XX_SETUP_SDHCI_GPIO
-	bool
-	help
-	  Common setup code for S3C64XX SDHCI GPIO configurations
-
 endif
diff --git a/arch/arm/plat-s3c64xx/Makefile b/arch/arm/plat-s3c64xx/Makefile
index d7852ba..187b779 100644
--- a/arch/arm/plat-s3c64xx/Makefile
+++ b/arch/arm/plat-s3c64xx/Makefile
@@ -30,9 +30,3 @@ obj-$(CONFIG_PM)		+= sleep.o
 
 obj-$(CONFIG_S3C64XX_DMA)	+= dma.o
 
-# Device setup
-
-obj-$(CONFIG_S3C64XX_SETUP_I2C0) += setup-i2c0.o
-obj-$(CONFIG_S3C64XX_SETUP_I2C1) += setup-i2c1.o
-obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
-obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
-- 
1.6.0.4
