From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 6 Mar 2012 10:59:00 +0100
Subject: [PATCH 2/4] ARM: S3C24XX: move simtec-specific code to mach directory
In-Reply-To: <201203061057.15815.heiko@sntech.de>
References: <201203061057.15815.heiko@sntech.de>
Message-ID: <201203061059.00751.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This includes a rename of the pm-simtec.c to keep the simtec
extensions together a bit and also better naming of the Kconfig
options.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/Kconfig                      |   23 +++++++++++++++----
 arch/arm/mach-s3c24xx/Makefile                     |    2 +
 .../{plat-s3c24xx => mach-s3c24xx}/simtec-audio.c  |    0
 .../pm-simtec.c => mach-s3c24xx/simtec-pm.c}       |    0
 arch/arm/plat-s3c24xx/Kconfig                      |   13 -----------
 arch/arm/plat-s3c24xx/Makefile                     |    5 ----
 6 files changed, 20 insertions(+), 23 deletions(-)
 rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/simtec-audio.c (100%)
 rename arch/arm/{plat-s3c24xx/pm-simtec.c => mach-s3c24xx/simtec-pm.c} (100%)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 7dede07..115cc50 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -88,6 +88,19 @@ config S3C24XX_SMDK
 	help
 	  Common machine code for SMDK2410 and SMDK2440
 
+config S3C24XX_SIMTEC_AUDIO
+	bool
+	depends on (ARCH_BAST || MACH_VR1000 || MACH_OSIRIS || MACH_ANUBIS)
+	default y
+	help
+	  Add audio devices for common Simtec S3C24XX boards
+
+config S3C24XX_SIMTEC_PM
+	bool
+	help
+	  Common power management code for systems that are
+	  compatible with the Simtec style of power management
+
 # cpu-specific sections
 
 if CPU_S3C2410
@@ -125,7 +138,7 @@ comment "S3C2410 Boards"
 
 config MACH_AML_M5900
 	bool "AML M5900 Series"
-	select PM_SIMTEC if PM
+	select S3C24XX_SIMTEC_PM if PM
 	select S3C_DEV_USB_HOST
 	help
 	  Say Y here if you are using the American Microsystems M5900 Series
@@ -134,7 +147,7 @@ config MACH_AML_M5900
 config ARCH_BAST
 	bool "Simtec Electronics BAST (EB2410ITX)"
 	select S3C2410_IOTIMING if S3C2410_CPUFREQ
-	select PM_SIMTEC if PM
+	select S3C24XX_SIMTEC_PM if PM
 	select SIMTEC_NOR
 	select MACH_BAST_IDE
 	select S3C24XX_DCLK
@@ -215,7 +228,7 @@ config MACH_TCT_HAMMER
 
 config MACH_VR1000
 	bool "Thorcom VR1000"
-	select PM_SIMTEC if PM
+	select S3C24XX_SIMTEC_PM if PM
 	select S3C24XX_DCLK
 	select SIMTEC_NOR
 	select MACH_BAST_IDE
@@ -355,7 +368,7 @@ comment "S3C2440 Boards"
 config MACH_ANUBIS
 	bool "Simtec Electronics ANUBIS"
 	select S3C24XX_DCLK
-	select PM_SIMTEC if PM
+	select S3C24XX_SIMTEC_PM if PM
 	select HAVE_PATA_PLATFORM
 	select S3C24XX_GPIO_EXTRA64
 	select S3C2440_XTAL_12000000
@@ -395,7 +408,7 @@ config MACH_NEXCODER_2440
 config MACH_OSIRIS
 	bool "Simtec IM2440D20 (OSIRIS) module"
 	select S3C24XX_DCLK
-	select PM_SIMTEC if PM
+	select S3C24XX_SIMTEC_PM if PM
 	select S3C24XX_GPIO_EXTRA128
 	select S3C2440_XTAL_12000000
 	select S3C2410_IOTIMING if S3C2440_CPUFREQ
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index b1c3c6f..fedbdb8 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -79,6 +79,8 @@ obj-$(CONFIG_MACH_SMDK2443)		+= mach-smdk2443.o
 
 obj-$(CONFIG_S3C24XX_SMDK)		+= common-smdk.o
 obj-$(CONFIG_SIMTEC_NOR)		+= nor-simtec.o
+obj-$(CONFIG_S3C24XX_SIMTEC_AUDIO)	+= simtec-audio.o
+obj-$(CONFIG_S3C24XX_SIMTEC_PM)		+= simtec-pm.o
 
 # machine additions
 
diff --git a/arch/arm/plat-s3c24xx/simtec-audio.c b/arch/arm/mach-s3c24xx/simtec-audio.c
similarity index 100%
rename from arch/arm/plat-s3c24xx/simtec-audio.c
rename to arch/arm/mach-s3c24xx/simtec-audio.c
diff --git a/arch/arm/plat-s3c24xx/pm-simtec.c b/arch/arm/mach-s3c24xx/simtec-pm.c
similarity index 100%
rename from arch/arm/plat-s3c24xx/pm-simtec.c
rename to arch/arm/mach-s3c24xx/simtec-pm.c
diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
index 73ebc40..0338d20 100644
--- a/arch/arm/plat-s3c24xx/Kconfig
+++ b/arch/arm/plat-s3c24xx/Kconfig
@@ -70,12 +70,6 @@ config S3C24XX_GPIO_EXTRA128
 	  Add an extra 128 gpio numbers to the available GPIO pool. This is
 	  available for boards that need extra gpios for external devices.
 
-config PM_SIMTEC
-	bool
-	help
-	  Common power management code for systems that are
-	  compatible with the Simtec style of power management
-
 config S3C24XX_DMA
 	bool "S3C2410 DMA support"
 	depends on ARCH_S3C24XX
@@ -119,13 +113,6 @@ config S3C2412_IOTIMING
 	  Intel node to select io timing code that is common to the s3c2412
 	  and the s3c2443.
 
-config S3C24XX_SIMTEC_AUDIO
-	bool
-	depends on (ARCH_BAST || MACH_VR1000 || MACH_OSIRIS || MACH_ANUBIS)
-	default y
-	help
-	  Add audio devices for common Simtec S3C24XX boards
-
 config S3C2410_SETUP_TS
 	bool
 	help
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
index 8dca10a..27dd9c5 100644
--- a/arch/arm/plat-s3c24xx/Makefile
+++ b/arch/arm/plat-s3c24xx/Makefile
@@ -23,7 +23,6 @@ obj-$(CONFIG_CPU_FREQ_S3C24XX_DEBUGFS) += cpu-freq-debugfs.o
 
 # Architecture dependent builds
 
-obj-$(CONFIG_PM_SIMTEC)		+= pm-simtec.o
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_PM)		+= irq-pm.o
 obj-$(CONFIG_PM)		+= sleep.o
@@ -36,7 +35,3 @@ obj-$(CONFIG_S3C2410_CPUFREQ_UTILS) += s3c2410-cpufreq-utils.o
 # device specific setup and/or initialisation
 obj-$(CONFIG_ARCH_S3C24XX)	+= setup-i2c.o
 obj-$(CONFIG_S3C2410_SETUP_TS)	+= setup-ts.o
-
-# machine common support
-
-obj-$(CONFIG_S3C24XX_SIMTEC_AUDIO)	+= simtec-audio.o
-- 
1.7.5.4
