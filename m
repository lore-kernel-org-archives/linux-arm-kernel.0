From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 16 Feb 2012 07:55:45 +0900
Subject: [PATCH 11/12] ARM: S3C2443: move mach-s3c2443/* into mach-s3c24xx/
In-Reply-To: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
References: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1329346545-16373-12-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves S3C2443 stuff into mach-s3c24xx/ directory
so that we can merge the s3c24 series' directories to the
just one mach-s3c24xx/ directory.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/Kconfig                                   |    1 -
 arch/arm/Makefile                                  |    2 +-
 arch/arm/mach-s3c2443/Kconfig                      |   32 --------------------
 arch/arm/mach-s3c2443/Makefile                     |   20 ------------
 arch/arm/mach-s3c24xx/Kconfig                      |   29 ++++++++++++++++++
 arch/arm/mach-s3c24xx/Makefile                     |    5 +++
 .../clock.c => mach-s3c24xx/clock-s3c2443.c}       |    0
 .../dma.c => mach-s3c24xx/dma-s3c2443.c}           |    0
 .../irq.c => mach-s3c24xx/irq-s3c2443.c}           |    0
 .../{mach-s3c2443 => mach-s3c24xx}/mach-smdk2443.c |    0
 arch/arm/{mach-s3c2443 => mach-s3c24xx}/s3c2443.c  |    0
 11 files changed, 35 insertions(+), 54 deletions(-)
 delete mode 100644 arch/arm/mach-s3c2443/Kconfig
 delete mode 100644 arch/arm/mach-s3c2443/Makefile
 rename arch/arm/{mach-s3c2443/clock.c => mach-s3c24xx/clock-s3c2443.c} (100%)
 rename arch/arm/{mach-s3c2443/dma.c => mach-s3c24xx/dma-s3c2443.c} (100%)
 rename arch/arm/{mach-s3c2443/irq.c => mach-s3c24xx/irq-s3c2443.c} (100%)
 rename arch/arm/{mach-s3c2443 => mach-s3c24xx}/mach-smdk2443.c (100%)
 rename arch/arm/{mach-s3c2443 => mach-s3c24xx}/s3c2443.c (100%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f8044e9..22d6db3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1072,7 +1072,6 @@ if ARCH_S3C24XX
 source "arch/arm/mach-s3c2412/Kconfig"
 source "arch/arm/mach-s3c2416/Kconfig"
 source "arch/arm/mach-s3c2440/Kconfig"
-source "arch/arm/mach-s3c2443/Kconfig"
 endif
 
 if ARCH_S3C64XX
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 59d9df4..f3f6d97 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -175,7 +175,7 @@ machine-$(CONFIG_ARCH_PRIMA2)		:= prima2
 machine-$(CONFIG_ARCH_PXA)		:= pxa
 machine-$(CONFIG_ARCH_REALVIEW)		:= realview
 machine-$(CONFIG_ARCH_RPC)		:= rpc
-machine-$(CONFIG_ARCH_S3C24XX)		:= s3c24xx s3c2412 s3c2416 s3c2440 s3c2443
+machine-$(CONFIG_ARCH_S3C24XX)		:= s3c24xx s3c2412 s3c2416 s3c2440
 machine-$(CONFIG_ARCH_S3C64XX)		:= s3c64xx
 machine-$(CONFIG_ARCH_S5P64X0)		:= s5p64x0
 machine-$(CONFIG_ARCH_S5PC100)		:= s5pc100
diff --git a/arch/arm/mach-s3c2443/Kconfig b/arch/arm/mach-s3c2443/Kconfig
deleted file mode 100644
index 793a0fe..0000000
--- a/arch/arm/mach-s3c2443/Kconfig
+++ /dev/null
@@ -1,32 +0,0 @@
-# Copyright 2007 Simtec Electronics
-#
-# Licensed under GPLv2
-
-config CPU_S3C2443
-	bool
-	depends on ARCH_S3C24XX
-	select CPU_ARM920T
-	select S3C2443_DMA if S3C2410_DMA
-	select CPU_LLSERIAL_S3C2440
-	select SAMSUNG_CLKSRC
-	select S3C2443_CLOCK
-	help
-	  Support for the S3C2443 SoC from the S3C24XX line
-
-config S3C2443_DMA
-	bool
-	depends on CPU_S3C2443
-	help
-	  Internal config node for S3C2443 DMA support
-
-menu "S3C2443 Machines"
-
-config MACH_SMDK2443
-	bool "SMDK2443"
-	select CPU_S3C2443
-	select MACH_SMDK
-	select S3C_DEV_HSMMC1
-	help
-	  Say Y here if you are using an SMDK2443
-
-endmenu
diff --git a/arch/arm/mach-s3c2443/Makefile b/arch/arm/mach-s3c2443/Makefile
deleted file mode 100644
index d1843c9..0000000
--- a/arch/arm/mach-s3c2443/Makefile
+++ /dev/null
@@ -1,20 +0,0 @@
-# arch/arm/mach-s3c2443/Makefile
-#
-# Copyright 2007 Simtec Electronics
-#
-# Licensed under GPLv2
-
-obj-y				:=
-obj-m				:=
-obj-n				:=
-obj-				:=
-
-obj-$(CONFIG_CPU_S3C2443)	+= s3c2443.o
-obj-$(CONFIG_CPU_S3C2443)	+= irq.o
-obj-$(CONFIG_CPU_S3C2443)	+= clock.o
-
-obj-$(CONFIG_S3C2443_DMA)	+= dma.o
-
-# Machine support
-
-obj-$(CONFIG_MACH_SMDK2443)	+= mach-smdk2443.o
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index aa295f8..e537577 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -70,6 +70,17 @@ config CPU_S3C244X
 	def_bool y
 	depends on CPU_S3C2440 || CPU_S3C2442
 
+config CPU_S3C2443
+	bool "SAMSUNG S3C2443"
+	depends on ARCH_S3C24XX
+	select CPU_ARM920T
+	select CPU_LLSERIAL_S3C2440
+	select SAMSUNG_CLKSRC
+	select S3C2443_CLOCK
+	select S3C2443_DMA if S3C24XX_DMA
+	help
+	  Support for the S3C2443 SoC from the S3C24XX line
+
 if CPU_S3C2410
 
 config S3C2410_DMA
@@ -459,6 +470,24 @@ config SMDK2440_CPU2442
 
 endif	# CPU_S3C2440
 
+if CPU_S3C2443
+
+config S3C2443_DMA
+	bool
+	help
+	  Internal config node for S3C2443 DMA support
+
+comment "S3C2443 Boards"
+
+config MACH_SMDK2443
+	bool "SMDK2443"
+	select MACH_SMDK
+	select S3C_DEV_HSMMC1
+	help
+	  Say Y here if you are using an SMDK2443
+
+endif	# CPU_S3C2443
+
 endmenu	# SAMSUNG S3C24XX SoCs Support
 
 endif	# ARCH_S3C24XX
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index f458cf2..08b44a3 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -31,6 +31,9 @@ obj-$(CONFIG_CPU_S3C2442)	+= s3c2442.o
 obj-$(CONFIG_CPU_S3C244X)	+= s3c244x.o irq-s3c244x.o clock-s3c244x.o
 obj-$(CONFIG_S3C2440_DMA)	+= dma-s3c2440.o
 
+obj-$(CONFIG_CPU_S3C2443)	+= s3c2443.o irq-s3c2443.o clock-s3c2443.o
+obj-$(CONFIG_S3C2443_DMA)	+= dma-s3c2443.o
+
 #
 # machine support
 # following is ordered alphabetically by option text.
@@ -66,6 +69,8 @@ obj-$(CONFIG_ARCH_S3C2440)		+= mach-smdk2440.o
 obj-$(CONFIG_MACH_NEO1973_GTA02)	+= mach-gta02.o
 obj-$(CONFIG_MACH_RX1950)		+= mach-rx1950.o
 
+obj-$(CONFIG_MACH_SMDK2443)		+= mach-smdk2443.o
+
 # common bits of machine support
 
 obj-$(CONFIG_SIMTEC_NOR)		+= nor-simtec.o
diff --git a/arch/arm/mach-s3c2443/clock.c b/arch/arm/mach-s3c24xx/clock-s3c2443.c
similarity index 100%
rename from arch/arm/mach-s3c2443/clock.c
rename to arch/arm/mach-s3c24xx/clock-s3c2443.c
diff --git a/arch/arm/mach-s3c2443/dma.c b/arch/arm/mach-s3c24xx/dma-s3c2443.c
similarity index 100%
rename from arch/arm/mach-s3c2443/dma.c
rename to arch/arm/mach-s3c24xx/dma-s3c2443.c
diff --git a/arch/arm/mach-s3c2443/irq.c b/arch/arm/mach-s3c24xx/irq-s3c2443.c
similarity index 100%
rename from arch/arm/mach-s3c2443/irq.c
rename to arch/arm/mach-s3c24xx/irq-s3c2443.c
diff --git a/arch/arm/mach-s3c2443/mach-smdk2443.c b/arch/arm/mach-s3c24xx/mach-smdk2443.c
similarity index 100%
rename from arch/arm/mach-s3c2443/mach-smdk2443.c
rename to arch/arm/mach-s3c24xx/mach-smdk2443.c
diff --git a/arch/arm/mach-s3c2443/s3c2443.c b/arch/arm/mach-s3c24xx/s3c2443.c
similarity index 100%
rename from arch/arm/mach-s3c2443/s3c2443.c
rename to arch/arm/mach-s3c24xx/s3c2443.c
-- 
1.7.4.4
