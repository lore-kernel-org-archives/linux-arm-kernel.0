From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 07:58:00 +0000
Subject: [PATCH] ARM: S3C24XX: Merge s3c2442 and s3c2440 machines into
	mach-s3c2440
In-Reply-To: <1264492686-16901-1-git-send-email-ben-linux@fluff.org>
References: <1264492686-16901-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264492686-16901-2-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the pair of machines in arch/arm/mach-s3c2442 into the mach-s3c2440
directory as the S3C2440 and S3C2442 are very close.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2440/Kconfig                      |   20 ++++++++++++++++-
 arch/arm/mach-s3c2440/Makefile                     |    1 +
 .../include/mach/gta02.h                           |    0
 .../{mach-s3c2442 => mach-s3c2440}/mach-gta02.c    |    0
 arch/arm/mach-s3c2442/Kconfig                      |   22 --------------------
 arch/arm/mach-s3c2442/Makefile                     |    2 -
 6 files changed, 19 insertions(+), 26 deletions(-)
 rename arch/arm/{mach-s3c2442 => mach-s3c2440}/include/mach/gta02.h (100%)
 rename arch/arm/{mach-s3c2442 => mach-s3c2440}/mach-gta02.c (100%)

diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
index 8087935..5486929 100644
--- a/arch/arm/mach-s3c2440/Kconfig
+++ b/arch/arm/mach-s3c2440/Kconfig
@@ -21,8 +21,7 @@ config S3C2440_DMA
 	help
 	  Support for S3C2440 specific DMA code5A
 
-
-menu "S3C2440 Machines"
+menu "S3C2440 and S3C2442 Machines"
 
 config MACH_ANUBIS
 	bool "Simtec Electronics ANUBIS"
@@ -37,6 +36,18 @@ config MACH_ANUBIS
 	  Say Y here if you are using the Simtec Electronics ANUBIS
 	  development system
 
+config MACH_NEO1973_GTA02
+	bool "Openmoko GTA02 / Freerunner phone"
+	select CPU_S3C2442
+	select MFD_PCF50633
+	select PCF50633_GPIO
+	select I2C
+	select POWER_SUPPLY
+	select MACH_NEO1973
+	select S3C2410_PWM
+	help
+	   Say Y here if you are using the Openmoko GTA02 / Freerunner GSM Phone
+
 config MACH_OSIRIS
 	bool "Simtec IM2440D20 (OSIRIS) module"
 	select CPU_S3C2440
@@ -99,6 +110,11 @@ config SMDK2440_CPU2440
 	select S3C2440_XTAL_16934400
 	select CPU_S3C2440
 
+config SMDK2440_CPU2442
+	bool "SMDM2440 with S3C2442 CPU module"
+	depends on ARCH_S3C2440
+	select CPU_S3C2442
+
 config MACH_AT2440EVB
 	bool "Avantech AT2440EVB development board"
 	select CPU_S3C2440
diff --git a/arch/arm/mach-s3c2440/Makefile b/arch/arm/mach-s3c2440/Makefile
index 5f32245..e51497c 100644
--- a/arch/arm/mach-s3c2440/Makefile
+++ b/arch/arm/mach-s3c2440/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_ARCH_S3C2440)	+= mach-smdk2440.o
 obj-$(CONFIG_MACH_NEXCODER_2440) += mach-nexcoder.o
 obj-$(CONFIG_MACH_AT2440EVB) += mach-at2440evb.o
 obj-$(CONFIG_MACH_MINI2440) += mach-mini2440.o
+obj-$(CONFIG_MACH_NEO1973_GTA02) += mach-gta02.o
 
 # extra machine support
 
diff --git a/arch/arm/mach-s3c2442/include/mach/gta02.h b/arch/arm/mach-s3c2440/include/mach/gta02.h
similarity index 100%
rename from arch/arm/mach-s3c2442/include/mach/gta02.h
rename to arch/arm/mach-s3c2440/include/mach/gta02.h
diff --git a/arch/arm/mach-s3c2442/mach-gta02.c b/arch/arm/mach-s3c2440/mach-gta02.c
similarity index 100%
rename from arch/arm/mach-s3c2442/mach-gta02.c
rename to arch/arm/mach-s3c2440/mach-gta02.c
diff --git a/arch/arm/mach-s3c2442/Kconfig b/arch/arm/mach-s3c2442/Kconfig
index 8d38118..4832cd6 100644
--- a/arch/arm/mach-s3c2442/Kconfig
+++ b/arch/arm/mach-s3c2442/Kconfig
@@ -13,25 +13,3 @@ config CPU_S3C2442
 	select CPU_LLSERIAL_S3C2440
 	help
 	  Support for S3C2442 Samsung Mobile CPU based systems.
-
-
-menu "S3C2442 Machines"
-
-config SMDK2440_CPU2442
-	bool "SMDM2440 with S3C2442 CPU module"
-	depends on ARCH_S3C2440
-	select CPU_S3C2442
-
-config MACH_NEO1973_GTA02
-	bool "Openmoko GTA02 / Freerunner phone"
-	select CPU_S3C2442
-	select MFD_PCF50633
-	select PCF50633_GPIO
-	select I2C
-	select POWER_SUPPLY
-	select MACH_NEO1973
-	select S3C2410_PWM
-	help
-	   Say Y here if you are using the Openmoko GTA02 / Freerunner GSM Phone
-
-endmenu
diff --git a/arch/arm/mach-s3c2442/Makefile b/arch/arm/mach-s3c2442/Makefile
index 2a19113..2a909c6 100644
--- a/arch/arm/mach-s3c2442/Makefile
+++ b/arch/arm/mach-s3c2442/Makefile
@@ -12,7 +12,5 @@ obj-				:=
 obj-$(CONFIG_CPU_S3C2442)	+= s3c2442.o
 obj-$(CONFIG_CPU_S3C2442)	+= clock.o
 
-obj-$(CONFIG_MACH_NEO1973_GTA02) += mach-gta02.o
-
 # Machine support
 
-- 
1.6.0.4
