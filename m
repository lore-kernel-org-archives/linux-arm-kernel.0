From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 16 Feb 2012 07:55:43 +0900
Subject: [PATCH 09/12] ARM: S3C2416: move mach-s3c2416/* into mach-s3c24xx/
In-Reply-To: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
References: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1329346545-16373-10-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves S3C2416 stuff into mach-s3c24xx/ directory
so that we can merge the s3c24 series' directories to the
just one mach-s3c24xx/ directory.

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2416/Kconfig                      |   46 -------------------
 arch/arm/mach-s3c2416/Makefile                     |   10 ----
 arch/arm/mach-s3c24xx/Kconfig                      |   47 ++++++++++++++++++++
 arch/arm/mach-s3c24xx/Makefile                     |    9 ++++
 .../clock.c => mach-s3c24xx/clock-s3c2416.c}       |    0
 .../irq.c => mach-s3c24xx/irq-s3c2416.c}           |    0
 .../{mach-s3c2416 => mach-s3c24xx}/mach-smdk2416.c |    0
 .../pm.c => mach-s3c24xx/pm-s3c2416.c}             |    0
 arch/arm/{mach-s3c2416 => mach-s3c24xx}/s3c2416.c  |    0
 .../setup-sdhci-gpio.c                             |    0
 10 files changed, 56 insertions(+), 56 deletions(-)
 rename arch/arm/{mach-s3c2416/clock.c => mach-s3c24xx/clock-s3c2416.c} (100%)
 rename arch/arm/{mach-s3c2416/irq.c => mach-s3c24xx/irq-s3c2416.c} (100%)
 rename arch/arm/{mach-s3c2416 => mach-s3c24xx}/mach-smdk2416.c (100%)
 rename arch/arm/{mach-s3c2416/pm.c => mach-s3c24xx/pm-s3c2416.c} (100%)
 rename arch/arm/{mach-s3c2416 => mach-s3c24xx}/s3c2416.c (100%)
 rename arch/arm/{mach-s3c2416 => mach-s3c24xx}/setup-sdhci-gpio.c (100%)

diff --git a/arch/arm/mach-s3c2416/Kconfig b/arch/arm/mach-s3c2416/Kconfig
index 53d5c2b..faaa289 100644
--- a/arch/arm/mach-s3c2416/Kconfig
+++ b/arch/arm/mach-s3c2416/Kconfig
@@ -7,54 +7,8 @@
 # note, this also supports the S3C2450 which is so similar it has the same
 # ID code as the S3C2416.
 
-config CPU_S3C2416
-	bool
-	depends on ARCH_S3C24XX
-	select CPU_ARM926T
-	select S3C2416_DMA if S3C2410_DMA
-	select CPU_LLSERIAL_S3C2440
-	select SAMSUNG_CLKSRC
-	select S3C2443_CLOCK
-	help
-	  Support for the S3C2416 SoC from the S3C24XX line
-
 config S3C2416_DMA
 	bool
 	depends on CPU_S3C2416
 	help
 	  Internal config node for S3C2416 DMA support
-
-config S3C2416_PM
-	bool
-	select S3C2412_PM_SLEEP
-	help
-	  Internal config node to apply S3C2416 power management
-
-config S3C2416_SETUP_SDHCI
-	bool
-	select S3C2416_SETUP_SDHCI_GPIO
-	help
-	  Internal helper functions for S3C2416 based SDHCI systems
-
-config S3C2416_SETUP_SDHCI_GPIO
-	bool
-	help
-	  Common setup code for SDHCI gpio.
-
-menu "S3C2416 Machines"
-
-config MACH_SMDK2416
-	bool "SMDK2416"
-	select CPU_S3C2416
-	select MACH_SMDK
-	select S3C_DEV_FB
-	select S3C_DEV_HSMMC
-	select S3C_DEV_HSMMC1
-	select S3C_DEV_NAND
-	select S3C_DEV_USB_HOST
-	select S3C2416_SETUP_SDHCI
-	select S3C2416_PM if PM
-	help
-	  Say Y here if you are using an SMDK2416
-
-endmenu
diff --git a/arch/arm/mach-s3c2416/Makefile b/arch/arm/mach-s3c2416/Makefile
index ca0cd22..3299f19 100644
--- a/arch/arm/mach-s3c2416/Makefile
+++ b/arch/arm/mach-s3c2416/Makefile
@@ -9,14 +9,4 @@ obj-m				:=
 obj-n				:=
 obj-				:=
 
-obj-$(CONFIG_CPU_S3C2416)	+= s3c2416.o clock.o
-obj-$(CONFIG_CPU_S3C2416)	+= irq.o
-obj-$(CONFIG_S3C2416_PM)	+= pm.o
 #obj-$(CONFIG_S3C2416_DMA)	+= dma.o
-
-# Device setup
-obj-$(CONFIG_S3C2416_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
-
-# Machine support
-
-obj-$(CONFIG_MACH_SMDK2416)	+= mach-smdk2416.o
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index c130d5f..69529dd 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -35,6 +35,18 @@ config CPU_S3C2412
 	help
 	  Support for the S3C2412 and S3C2413 SoCs from the S3C24XX line
 
+config CPU_S3C2416
+	bool "SAMSUNG S3C2416/S3C2450"
+	depends on ARCH_S3C24XX
+	select CPU_ARM926T
+	select CPU_LLSERIAL_S3C2440
+	select SAMSUNG_CLKSRC
+	select S3C2443_CLOCK
+	select S3C2416_DMA if S3C24XX_DMA
+	select S3C2416_PM if PM
+	help
+	  Support for the S3C2416 SoC from the S3C24XX line
+
 if CPU_S3C2410
 
 config S3C2410_DMA
@@ -247,6 +259,41 @@ config MACH_VSTMS
 
 endif	# CPU_S3C2412
 
+if CPU_S3C2416
+
+config S3C2416_PM
+	bool
+	select S3C2412_PM_SLEEP
+	help
+	  Internal config node to apply S3C2416 power management
+
+config S3C2416_SETUP_SDHCI
+	bool
+	select S3C2416_SETUP_SDHCI_GPIO
+	help
+	  Internal helper functions for S3C2416 based SDHCI systems
+
+config S3C2416_SETUP_SDHCI_GPIO
+	bool
+	help
+	  Common setup code for SDHCI gpio.
+
+comment "S3C2416 Boards"
+
+config MACH_SMDK2416
+	bool "SMDK2416"
+	select MACH_SMDK
+	select S3C_DEV_FB
+	select S3C_DEV_HSMMC
+	select S3C_DEV_HSMMC1
+	select S3C_DEV_NAND
+	select S3C_DEV_USB_HOST
+	select S3C2416_SETUP_SDHCI
+	help
+	  Say Y here if you are using an SMDK2416
+
+endif	# CPU_S3C2416
+
 endmenu	# SAMSUNG S3C24XX SoCs Support
 
 endif	# ARCH_S3C24XX
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index f5af4af..789aa5c 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -23,6 +23,9 @@ obj-$(CONFIG_S3C2412_DMA)	+= dma-s3c2412.o
 obj-$(CONFIG_S3C2412_PM)	+= pm-s3c2412.o
 obj-$(CONFIG_S3C2412_PM_SLEEP)	+= sleep-s3c2412.o
 
+obj-$(CONFIG_CPU_S3C2416)	+= s3c2416.o irq-s3c2416.o clock-s3c2416.o
+obj-$(CONFIG_S3C2416_PM)	+= pm-s3c2416.o
+
 #
 # machine support
 # following is ordered alphabetically by option text.
@@ -45,6 +48,8 @@ obj-$(CONFIG_MACH_JIVE)			+= mach-jive.o
 obj-$(CONFIG_MACH_SMDK2413)		+= mach-smdk2413.o
 obj-$(CONFIG_MACH_VSTMS)		+= mach-vstms.o
 
+obj-$(CONFIG_MACH_SMDK2416)		+= mach-smdk2416.o
+
 # common bits of machine support
 
 obj-$(CONFIG_SIMTEC_NOR)		+= nor-simtec.o
@@ -52,3 +57,7 @@ obj-$(CONFIG_SIMTEC_NOR)		+= nor-simtec.o
 # machine additions
 
 obj-$(CONFIG_MACH_BAST_IDE)		+= bast-ide.o
+
+# device setup
+
+obj-$(CONFIG_S3C2416_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
diff --git a/arch/arm/mach-s3c2416/clock.c b/arch/arm/mach-s3c24xx/clock-s3c2416.c
similarity index 100%
rename from arch/arm/mach-s3c2416/clock.c
rename to arch/arm/mach-s3c24xx/clock-s3c2416.c
diff --git a/arch/arm/mach-s3c2416/irq.c b/arch/arm/mach-s3c24xx/irq-s3c2416.c
similarity index 100%
rename from arch/arm/mach-s3c2416/irq.c
rename to arch/arm/mach-s3c24xx/irq-s3c2416.c
diff --git a/arch/arm/mach-s3c2416/mach-smdk2416.c b/arch/arm/mach-s3c24xx/mach-smdk2416.c
similarity index 100%
rename from arch/arm/mach-s3c2416/mach-smdk2416.c
rename to arch/arm/mach-s3c24xx/mach-smdk2416.c
diff --git a/arch/arm/mach-s3c2416/pm.c b/arch/arm/mach-s3c24xx/pm-s3c2416.c
similarity index 100%
rename from arch/arm/mach-s3c2416/pm.c
rename to arch/arm/mach-s3c24xx/pm-s3c2416.c
diff --git a/arch/arm/mach-s3c2416/s3c2416.c b/arch/arm/mach-s3c24xx/s3c2416.c
similarity index 100%
rename from arch/arm/mach-s3c2416/s3c2416.c
rename to arch/arm/mach-s3c24xx/s3c2416.c
diff --git a/arch/arm/mach-s3c2416/setup-sdhci-gpio.c b/arch/arm/mach-s3c24xx/setup-sdhci-gpio.c
similarity index 100%
rename from arch/arm/mach-s3c2416/setup-sdhci-gpio.c
rename to arch/arm/mach-s3c24xx/setup-sdhci-gpio.c
-- 
1.7.4.4
