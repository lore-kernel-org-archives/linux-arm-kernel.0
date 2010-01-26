From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 07:03:02 +0000
Subject: [PATCH] ARM: S3C64XX: Move CPUfreq and DMA support to the
	mach-s3c64xx directory
In-Reply-To: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
References: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264489385-13345-12-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move CPUfreq and DMA support to mach-s3c64xx as it is unlikely to be
used outside of this directory

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c64xx/Kconfig                     |    4 ++++
 arch/arm/mach-s3c64xx/Makefile                    |    8 ++++++++
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/cpufreq.c |    0
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/dma.c     |    0
 arch/arm/plat-s3c64xx/Kconfig                     |    4 ----
 arch/arm/plat-s3c64xx/Makefile                    |    6 ------
 6 files changed, 12 insertions(+), 10 deletions(-)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/cpufreq.c (100%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/dma.c (100%)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 495b6e3..33d82b1 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -17,6 +17,10 @@ config CPU_S3C6410
 	help
 	  Enable S3C6410 CPU support
 
+config S3C64XX_DMA
+	bool "S3C64XX DMA"
+	select S3C_DMA
+
 config S3C64XX_SETUP_SDHCI
 	select S3C64XX_SETUP_SDHCI_GPIO
 	bool
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index ef8bec8..4417f1a 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -23,6 +23,14 @@ obj-$(CONFIG_CPU_S3C6410)	+= s3c6410.o
 obj-y				+= irq.o
 obj-y				+= irq-eint.o
 
+# CPU frequency scaling
+
+obj-$(CONFIG_CPU_FREQ_S3C64XX)  += cpufreq.o
+
+# DMA support
+
+obj-$(CONFIG_S3C64XX_DMA)	+= dma.o
+
 # Device setup
 
 obj-$(CONFIG_S3C64XX_SETUP_I2C0) += setup-i2c0.o
diff --git a/arch/arm/plat-s3c64xx/cpufreq.c b/arch/arm/mach-s3c64xx/cpufreq.c
similarity index 100%
rename from arch/arm/plat-s3c64xx/cpufreq.c
rename to arch/arm/mach-s3c64xx/cpufreq.c
diff --git a/arch/arm/plat-s3c64xx/dma.c b/arch/arm/mach-s3c64xx/dma.c
similarity index 100%
rename from arch/arm/plat-s3c64xx/dma.c
rename to arch/arm/mach-s3c64xx/dma.c
diff --git a/arch/arm/plat-s3c64xx/Kconfig b/arch/arm/plat-s3c64xx/Kconfig
index 6998f85..cc30089 100644
--- a/arch/arm/plat-s3c64xx/Kconfig
+++ b/arch/arm/plat-s3c64xx/Kconfig
@@ -36,8 +36,4 @@ config CPU_S3C6400_CLOCK
 	  Common clock support code for the S3C6400 that is shared
 	  by other CPUs in the series, such as the S3C6410.
 
-config S3C64XX_DMA
-	bool "S3C64XX DMA"
-	select S3C_DMA
-
 endif
diff --git a/arch/arm/plat-s3c64xx/Makefile b/arch/arm/plat-s3c64xx/Makefile
index 1d9513c..62fc253 100644
--- a/arch/arm/plat-s3c64xx/Makefile
+++ b/arch/arm/plat-s3c64xx/Makefile
@@ -13,9 +13,3 @@ obj-				:=
 # CPU support
 
 obj-$(CONFIG_CPU_S3C6400_CLOCK)	+= s3c6400-clock.o
-obj-$(CONFIG_CPU_FREQ_S3C64XX)  += cpufreq.o
-
-# DMA support
-
-obj-$(CONFIG_S3C64XX_DMA)	+= dma.o
-
-- 
1.6.0.4
