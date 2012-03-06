From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 6 Mar 2012 10:58:19 +0100
Subject: [PATCH 1/4] ARM: S3C24XX: Move common-smdk code to mach directory
In-Reply-To: <201203061057.15815.heiko@sntech.de>
References: <201203061057.15815.heiko@sntech.de>
Message-ID: <201203061058.19529.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This code is used by boards based on the S3C2410/S3C2440/S3C2416.
The patch includes also a rename of the option, as the smdk code
is not a mach itself, but only an extension with common code.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/Kconfig                      |   19 ++++++++++++++-----
 arch/arm/mach-s3c24xx/Makefile                     |    1 +
 .../{plat-s3c24xx => mach-s3c24xx}/common-smdk.c   |    0
 arch/arm/plat-s3c24xx/Kconfig                      |    5 -----
 arch/arm/plat-s3c24xx/Makefile                     |    1 -
 5 files changed, 15 insertions(+), 11 deletions(-)
 rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/common-smdk.c (100%)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 48af6fc..7dede07 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -81,6 +81,15 @@ config CPU_S3C2443
 	help
 	  Support for the S3C2443 SoC from the S3C24XX line
 
+# common code
+
+config S3C24XX_SMDK
+	bool
+	help
+	  Common machine code for SMDK2410 and SMDK2440
+
+# cpu-specific sections
+
 if CPU_S3C2410
 
 config S3C2410_DMA
@@ -192,7 +201,7 @@ config MACH_QT2410
 
 config ARCH_SMDK2410
 	bool "SMDK2410/A9M2410"
-	select MACH_SMDK
+	select S3C24XX_SMDK
 	help
 	  Say Y here if you are using the SMDK2410 or the derived module A9M2410
 	  <http://www.fsforth.de>
@@ -279,7 +288,7 @@ config MACH_SMDK2412
 config MACH_SMDK2413
 	bool "SMDK2413"
 	select MACH_S3C2413
-	select MACH_SMDK
+	select S3C24XX_SMDK
 	select S3C_DEV_USB_HOST
 	select S3C_DEV_NAND
 	help
@@ -317,7 +326,7 @@ comment "S3C2416 Boards"
 
 config MACH_SMDK2416
 	bool "SMDK2416"
-	select MACH_SMDK
+	select S3C24XX_SMDK
 	select S3C_DEV_FB
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
@@ -420,7 +429,7 @@ config MACH_RX3715
 config ARCH_S3C2440
 	bool "SMDK2440"
 	select S3C2440_XTAL_16934400
-	select MACH_SMDK
+	select S3C24XX_SMDK
 	select S3C_DEV_USB_HOST
 	select S3C_DEV_NAND
 	help
@@ -492,7 +501,7 @@ comment "S3C2443 Boards"
 
 config MACH_SMDK2443
 	bool "SMDK2443"
-	select MACH_SMDK
+	select S3C24XX_SMDK
 	select S3C_DEV_HSMMC1
 	help
 	  Say Y here if you are using an SMDK2443
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 876e5e5..b1c3c6f 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_MACH_SMDK2443)		+= mach-smdk2443.o
 
 # common bits of machine support
 
+obj-$(CONFIG_S3C24XX_SMDK)		+= common-smdk.o
 obj-$(CONFIG_SIMTEC_NOR)		+= nor-simtec.o
 
 # machine additions
diff --git a/arch/arm/plat-s3c24xx/common-smdk.c b/arch/arm/mach-s3c24xx/common-smdk.c
similarity index 100%
rename from arch/arm/plat-s3c24xx/common-smdk.c
rename to arch/arm/mach-s3c24xx/common-smdk.c
diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
index 74f76e0..73ebc40 100644
--- a/arch/arm/plat-s3c24xx/Kconfig
+++ b/arch/arm/plat-s3c24xx/Kconfig
@@ -119,11 +119,6 @@ config S3C2412_IOTIMING
 	  Intel node to select io timing code that is common to the s3c2412
 	  and the s3c2443.
 
-config MACH_SMDK
-	bool
-	help
-	  Common machine code for SMDK2410 and SMDK2440
-
 config S3C24XX_SIMTEC_AUDIO
 	bool
 	depends on (ARCH_BAST || MACH_VR1000 || MACH_OSIRIS || MACH_ANUBIS)
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
index a7e8843..8dca10a 100644
--- a/arch/arm/plat-s3c24xx/Makefile
+++ b/arch/arm/plat-s3c24xx/Makefile
@@ -39,5 +39,4 @@ obj-$(CONFIG_S3C2410_SETUP_TS)	+= setup-ts.o
 
 # machine common support
 
-obj-$(CONFIG_MACH_SMDK)		+= common-smdk.o
 obj-$(CONFIG_S3C24XX_SIMTEC_AUDIO)	+= simtec-audio.o
-- 
1.7.5.4
