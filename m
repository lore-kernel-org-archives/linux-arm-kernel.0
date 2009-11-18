From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 18 Nov 2009 14:33:02 +0100
Subject: [PATCH 07/19] ARM: S5PC1XX: move s5pc100 specific device helpers to
	mach-s5pc100 dir
In-Reply-To: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
References: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1258551194-16018-8-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

All device helpers that are defined in plat-s5pc1xx are S5PC100
specific. This patch moves them to mach-s5pc100 directory to make use of
newly created sub-platform support.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

---
 arch/arm/mach-s5pc100/Kconfig                      |   32 +++++++++++++++++--
 arch/arm/mach-s5pc100/Makefile                     |    4 ++
 .../setup-fb-24bpp.c                               |    0
 .../{plat-s5pc1xx => mach-s5pc100}/setup-i2c0.c    |    0
 .../{plat-s5pc1xx => mach-s5pc100}/setup-i2c1.c    |    0
 .../setup-sdhci-gpio.c                             |    0
 arch/arm/plat-s5pc1xx/Kconfig                      |   24 ---------------
 arch/arm/plat-s5pc1xx/Makefile                     |    4 --
 8 files changed, 32 insertions(+), 32 deletions(-)
 rename arch/arm/{plat-s5pc1xx => mach-s5pc100}/setup-fb-24bpp.c (100%)
 rename arch/arm/{plat-s5pc1xx => mach-s5pc100}/setup-i2c0.c (100%)
 rename arch/arm/{plat-s5pc1xx => mach-s5pc100}/setup-i2c1.c (100%)
 rename arch/arm/{plat-s5pc1xx => mach-s5pc100}/setup-sdhci-gpio.c (100%)

diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index d72f881..7f73353 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -16,12 +16,36 @@ config CPU_S5PC100
 	help
 	  Enable S5PC100 CPU support
 
+config S5PC100_SETUP_FB_24BPP
+	bool
+	help
+          Common setup code for S5PC1XX with an 24bpp RGB display helper.
+
+config S5PC100_SETUP_I2C0
+	bool
+	default y
+	help
+	  Common setup code for i2c bus 0.
+
+	  Note, currently since i2c0 is always compiled, this setup helper
+	  is always compiled with it.
+
+config S5PC100_SETUP_I2C1
+	bool
+	help
+	  Common setup code for i2c bus 1.
+
 config S5PC100_SETUP_SDHCI
         bool
-        select S5PC1XX_SETUP_SDHCI_GPIO
+        select S5PC100_SETUP_SDHCI_GPIO
         help
           Internal helper functions for S5PC100 based SDHCI systems
 
+config S5PC100_SETUP_SDHCI_GPIO
+	bool
+	help
+	  Common setup code for SDHCI gpio.
+
 config MACH_SMDKC100
 	bool "SMDKC100"
 	select CPU_S5PC100
@@ -30,9 +54,9 @@ config MACH_SMDKC100
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
-	select S5PC1XX_SETUP_I2C0
-	select S5PC1XX_SETUP_I2C1
-	select S5PC1XX_SETUP_FB_24BPP
+	select S5PC100_SETUP_I2C0
+	select S5PC100_SETUP_I2C1
+	select S5PC100_SETUP_FB_24BPP
 	select S5PC100_SETUP_SDHCI
 	help
 	  Machine support for the Samsung SMDKC100
diff --git a/arch/arm/mach-s5pc100/Makefile b/arch/arm/mach-s5pc100/Makefile
index 809ff10..8846169 100644
--- a/arch/arm/mach-s5pc100/Makefile
+++ b/arch/arm/mach-s5pc100/Makefile
@@ -15,7 +15,11 @@ obj-$(CONFIG_CPU_S5PC100)	+= cpu.o
 
 # Helper and device support
 
+obj-$(CONFIG_S5PC100_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
+obj-$(CONFIG_S5PC100_SETUP_I2C0)	+= setup-i2c0.o
+obj-$(CONFIG_S5PC100_SETUP_I2C1)	+= setup-i2c1.o
 obj-$(CONFIG_S5PC100_SETUP_SDHCI)       += setup-sdhci.o
+obj-$(CONFIG_S5PC100_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
 
 # machine support
 obj-$(CONFIG_MACH_SMDKC100)	+= mach-smdkc100.o
diff --git a/arch/arm/plat-s5pc1xx/setup-fb-24bpp.c b/arch/arm/mach-s5pc100/setup-fb-24bpp.c
similarity index 100%
rename from arch/arm/plat-s5pc1xx/setup-fb-24bpp.c
rename to arch/arm/mach-s5pc100/setup-fb-24bpp.c
diff --git a/arch/arm/plat-s5pc1xx/setup-i2c0.c b/arch/arm/mach-s5pc100/setup-i2c0.c
similarity index 100%
rename from arch/arm/plat-s5pc1xx/setup-i2c0.c
rename to arch/arm/mach-s5pc100/setup-i2c0.c
diff --git a/arch/arm/plat-s5pc1xx/setup-i2c1.c b/arch/arm/mach-s5pc100/setup-i2c1.c
similarity index 100%
rename from arch/arm/plat-s5pc1xx/setup-i2c1.c
rename to arch/arm/mach-s5pc100/setup-i2c1.c
diff --git a/arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c b/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
similarity index 100%
rename from arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c
rename to arch/arm/mach-s5pc100/setup-sdhci-gpio.c
diff --git a/arch/arm/plat-s5pc1xx/Kconfig b/arch/arm/plat-s5pc1xx/Kconfig
index eee2abb..9f76a9b 100644
--- a/arch/arm/plat-s5pc1xx/Kconfig
+++ b/arch/arm/plat-s5pc1xx/Kconfig
@@ -47,28 +47,4 @@ config CPU_S5PC100_CLOCK
 
 # platform specific device setup
 
-config S5PC1XX_SETUP_FB_24BPP
-	bool
-	help
-          Common setup code for S5PC1XX with an 24bpp RGB display helper.
-
-config S5PC1XX_SETUP_I2C0
-	bool
-	default y
-	help
-	  Common setup code for i2c bus 0.
-
-	  Note, currently since i2c0 is always compiled, this setup helper
-	  is always compiled with it.
-
-config S5PC1XX_SETUP_I2C1
-	bool
-	help
-	  Common setup code for i2c bus 1.
-
-config S5PC1XX_SETUP_SDHCI_GPIO
-	bool
-	help
-	  Common setup code for SDHCI gpio.
-
 endif
diff --git a/arch/arm/plat-s5pc1xx/Makefile b/arch/arm/plat-s5pc1xx/Makefile
index 5da300e..cc06606 100644
--- a/arch/arm/plat-s5pc1xx/Makefile
+++ b/arch/arm/plat-s5pc1xx/Makefile
@@ -24,7 +24,3 @@ obj-$(CONFIG_CPU_S5PC100_CLOCK)	+= s5pc100-plls.o s5pc100-clocks.o
 # Device setup
 
 obj-$(CONFIG_S5P_GPIO_CFG_S5PC1XX) += gpio-config.o
-obj-$(CONFIG_S5PC1XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
-obj-$(CONFIG_S5PC1XX_SETUP_I2C0) += setup-i2c0.o
-obj-$(CONFIG_S5PC1XX_SETUP_I2C1) += setup-i2c1.o
-obj-$(CONFIG_S5PC1XX_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
-- 
1.6.4
