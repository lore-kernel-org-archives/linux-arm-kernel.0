From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 16 Feb 2012 07:55:42 +0900
Subject: [PATCH 08/12] ARM: S3C2412: move mach-s3c2412/* into mach/s3c24xx/
In-Reply-To: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
References: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1329346545-16373-9-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves S3C2412 stuff into mach-s3c24xx/ directory
so that we can merge the s3c24 series' directories to the
just one mach-s3c24xx/ directory.

And this patch is including following.
- re-ordered alphabetically by option text at Kconfig and Makefile

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2412/Kconfig                      |   85 -------------------
 arch/arm/mach-s3c2412/Makefile                     |   12 ---
 arch/arm/mach-s3c24xx/Kconfig                      |   89 +++++++++++++++++++-
 arch/arm/mach-s3c24xx/Makefile                     |    9 ++
 .../clock.c => mach-s3c24xx/clock-s3c2412.c}       |    0
 .../dma.c => mach-s3c24xx/dma-s3c2412.c}           |    0
 .../irq.c => mach-s3c24xx/irq-s3c2412.c}           |    0
 .../arm/{mach-s3c2412 => mach-s3c24xx}/mach-jive.c |    0
 .../{mach-s3c2412 => mach-s3c24xx}/mach-smdk2413.c |    0
 .../{mach-s3c2412 => mach-s3c24xx}/mach-vstms.c    |    0
 .../pm.c => mach-s3c24xx/pm-s3c2412.c}             |    0
 arch/arm/{mach-s3c2412 => mach-s3c24xx}/s3c2412.c  |    0
 .../sleep.S => mach-s3c24xx/sleep-s3c2412.S}       |    0
 13 files changed, 97 insertions(+), 98 deletions(-)
 rename arch/arm/{mach-s3c2412/clock.c => mach-s3c24xx/clock-s3c2412.c} (100%)
 rename arch/arm/{mach-s3c2412/dma.c => mach-s3c24xx/dma-s3c2412.c} (100%)
 rename arch/arm/{mach-s3c2412/irq.c => mach-s3c24xx/irq-s3c2412.c} (100%)
 rename arch/arm/{mach-s3c2412 => mach-s3c24xx}/mach-jive.c (100%)
 rename arch/arm/{mach-s3c2412 => mach-s3c24xx}/mach-smdk2413.c (100%)
 rename arch/arm/{mach-s3c2412 => mach-s3c24xx}/mach-vstms.c (100%)
 rename arch/arm/{mach-s3c2412/pm.c => mach-s3c24xx/pm-s3c2412.c} (100%)
 rename arch/arm/{mach-s3c2412 => mach-s3c24xx}/s3c2412.c (100%)
 rename arch/arm/{mach-s3c2412/sleep.S => mach-s3c24xx/sleep-s3c2412.S} (100%)

diff --git a/arch/arm/mach-s3c2412/Kconfig b/arch/arm/mach-s3c2412/Kconfig
index 41f3327..c5256f4 100644
--- a/arch/arm/mach-s3c2412/Kconfig
+++ b/arch/arm/mach-s3c2412/Kconfig
@@ -2,41 +2,6 @@
 #
 # Licensed under GPLv2
 
-config CPU_S3C2412
-	bool
-	depends on ARCH_S3C24XX
-	select CPU_ARM926T
-	select CPU_LLSERIAL_S3C2440
-	select S3C2412_PM if PM
-	select S3C2412_DMA if S3C2410_DMA
-	help
-	  Support for the S3C2412 and S3C2413 SoCs from the S3C24XX line
-
-config CPU_S3C2412_ONLY
-	bool
-	depends on ARCH_S3C24XX && !CPU_S3C2410 && \
-		   !CPU_S3C2416 && !CPU_S3C2440 && !CPU_S3C2442 && \
-		   !CPU_S3C2443 && CPU_S3C2412
-	default y if CPU_S3C2412
-
-config S3C2412_DMA
-	bool
-	depends on CPU_S3C2412
-	help
-	  Internal config node for S3C2412 DMA support
-
-config S3C2412_PM
-	bool
-	select S3C2412_PM_SLEEP
-	help
-	  Internal config node to apply S3C2412 power management
-
-config S3C2412_PM_SLEEP
-	bool
-	help
-	  Internal config node to apply sleep for S3C2412 power management.
-	  Can be selected by another SoCs with similar sleep procedure.
-
 # Note, the S3C2412 IOtiming support is in plat-s3c24xx
 
 config S3C2412_CPUFREQ
@@ -46,53 +11,3 @@ config S3C2412_CPUFREQ
 	default y
 	help
 	  CPU Frequency scaling support for S3C2412 and S3C2413 SoC CPUs.
-
-menu "S3C2412 Machines"
-
-config MACH_JIVE
-	bool "Logitech Jive"
-	select CPU_S3C2412
-	select S3C_DEV_USB_HOST
-	select S3C_DEV_NAND
-	help
-	  Say Y here if you are using the Logitech Jive.
-
-config MACH_JIVE_SHOW_BOOTLOADER
-	bool "Allow access to bootloader partitions in MTD (EXPERIMENTAL)"
-	depends on MACH_JIVE && EXPERIMENTAL
-
-config MACH_SMDK2413
-	bool "SMDK2413"
-	select CPU_S3C2412
-	select MACH_S3C2413
-	select MACH_SMDK
-	select S3C_DEV_USB_HOST
-	select S3C_DEV_NAND
-	help
-	  Say Y here if you are using an SMDK2413
-
-config MACH_S3C2413
-	bool
-	help
-	  Internal node for S3C2413 version of SMDK2413, so that
-	  machine_is_s3c2413() will work when MACH_SMDK2413 is
-	  selected
-
-config MACH_SMDK2412
-	bool "SMDK2412"
-	select MACH_SMDK2413
-	help
-	  Say Y here if you are using an SMDK2412
-
-	  Note, this shares support with SMDK2413, so will automatically
-	  select MACH_SMDK2413.
-
-config MACH_VSTMS
-	bool "VMSTMS"
-	select CPU_S3C2412
-	select S3C_DEV_USB_HOST
-	select S3C_DEV_NAND
-	help
-	  Say Y here if you are using an VSTMS board
-
-endmenu
diff --git a/arch/arm/mach-s3c2412/Makefile b/arch/arm/mach-s3c2412/Makefile
index 7e4d95f..41a6c27 100644
--- a/arch/arm/mach-s3c2412/Makefile
+++ b/arch/arm/mach-s3c2412/Makefile
@@ -9,16 +9,4 @@ obj-m				:=
 obj-n				:=
 obj-				:=
 
-obj-$(CONFIG_CPU_S3C2412)	+= s3c2412.o
-obj-$(CONFIG_CPU_S3C2412)	+= irq.o
-obj-$(CONFIG_CPU_S3C2412)	+= clock.o
-obj-$(CONFIG_S3C2412_DMA)	+= dma.o
-obj-$(CONFIG_S3C2412_PM)	+= pm.o
-obj-$(CONFIG_S3C2412_PM_SLEEP)	+= sleep.o
 obj-$(CONFIG_S3C2412_CPUFREQ)	+= cpu-freq.o
-
-# Machine support
-
-obj-$(CONFIG_MACH_JIVE)		+= mach-jive.o
-obj-$(CONFIG_MACH_SMDK2413)	+= mach-smdk2413.o
-obj-$(CONFIG_MACH_VSTMS)	+= mach-vstms.o
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 7f916c8..c130d5f 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -25,11 +25,21 @@ config CPU_S3C2410
 	  Support for S3C2410 and S3C2410A family from the S3C24XX line
 	  of Samsung Mobile CPUs.
 
+config CPU_S3C2412
+	bool "SAMSUNG S3C2412"
+	depends on ARCH_S3C24XX
+	select CPU_ARM926T
+	select CPU_LLSERIAL_S3C2440
+	select S3C2412_PM if PM
+	select S3C2412_DMA if S3C24XX_DMA
+	help
+	  Support for the S3C2412 and S3C2413 SoCs from the S3C24XX line
+
 if CPU_S3C2410
 
 config S3C2410_DMA
 	bool
-	depends on S3C2410_DMA && CPU_S3C2410
+	depends on S3C24XX_DMA && CPU_S3C2410
 	default y if CPU_S3C2410
 	help
 	  DMA device selection for S3C2410 and compatible CPUs
@@ -160,6 +170,83 @@ config MACH_VR1000
 
 endif	# CPU_S3C2410
 
+if CPU_S3C2412
+
+config CPU_S3C2412_ONLY
+	bool
+	depends on ARCH_S3C24XX && !CPU_S3C2410 && \
+		   !CPU_S3C2416 && !CPU_S3C2440 && !CPU_S3C2442 && \
+		   !CPU_S3C2443 && CPU_S3C2412
+	default y
+
+config S3C2412_DMA
+	bool
+	help
+	  Internal config node for S3C2412 DMA support
+
+config S3C2412_PM
+	bool
+	help
+	  Internal config node to apply S3C2412 power management
+
+config S3C2412_PM_SLEEP
+	bool
+	help
+	  Internal config node to apply sleep for S3C2412 power management.
+	  Can be selected by another SoCs with similar sleep procedure.
+
+comment "S3C2412 Boards"
+
+#
+# The "S3C2412 Boards" list is ordered alphabetically by option text.
+# (without ARCH_ or MACH_)
+#
+
+config MACH_JIVE
+	bool "Logitech Jive"
+	select S3C_DEV_USB_HOST
+	select S3C_DEV_NAND
+	help
+	  Say Y here if you are using the Logitech Jive.
+
+config MACH_JIVE_SHOW_BOOTLOADER
+	bool "Allow access to bootloader partitions in MTD (EXPERIMENTAL)"
+	depends on MACH_JIVE && EXPERIMENTAL
+
+config MACH_S3C2413
+	bool
+	help
+	  Internal node for S3C2413 version of SMDK2413, so that
+	  machine_is_s3c2413() will work when MACH_SMDK2413 is
+	  selected
+
+config MACH_SMDK2412
+	bool "SMDK2412"
+	select MACH_SMDK2413
+	help
+	  Say Y here if you are using an SMDK2412
+
+	  Note, this shares support with SMDK2413, so will automatically
+	  select MACH_SMDK2413.
+
+config MACH_SMDK2413
+	bool "SMDK2413"
+	select MACH_S3C2413
+	select MACH_SMDK
+	select S3C_DEV_USB_HOST
+	select S3C_DEV_NAND
+	help
+	  Say Y here if you are using an SMDK2413
+
+config MACH_VSTMS
+	bool "VMSTMS"
+	select S3C_DEV_USB_HOST
+	select S3C_DEV_NAND
+	help
+	  Say Y here if you are using an VSTMS board
+
+endif	# CPU_S3C2412
+
 endmenu	# SAMSUNG S3C24XX SoCs Support
 
 endif	# ARCH_S3C24XX
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index b6afbf84..f5af4af 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -18,6 +18,11 @@ obj-$(CONFIG_CPU_S3C2410)	+= s3c2410.o
 obj-$(CONFIG_S3C2410_DMA)	+= dma-s3c2410.o
 obj-$(CONFIG_S3C2410_PM)	+= pm-s3c2410.o sleep-s3c2410.o
 
+obj-$(CONFIG_CPU_S3C2412)	+= s3c2412.o irq-s3c2412.o clock-s3c2412.o
+obj-$(CONFIG_S3C2412_DMA)	+= dma-s3c2412.o
+obj-$(CONFIG_S3C2412_PM)	+= pm-s3c2412.o
+obj-$(CONFIG_S3C2412_PM_SLEEP)	+= sleep-s3c2412.o
+
 #
 # machine support
 # following is ordered alphabetically by option text.
@@ -36,6 +41,10 @@ obj-$(CONFIG_ARCH_SMDK2410)		+= mach-smdk2410.o
 obj-$(CONFIG_MACH_TCT_HAMMER)		+= mach-tct_hammer.o
 obj-$(CONFIG_MACH_VR1000)		+= mach-vr1000.o usb-simtec.o
 
+obj-$(CONFIG_MACH_JIVE)			+= mach-jive.o
+obj-$(CONFIG_MACH_SMDK2413)		+= mach-smdk2413.o
+obj-$(CONFIG_MACH_VSTMS)		+= mach-vstms.o
+
 # common bits of machine support
 
 obj-$(CONFIG_SIMTEC_NOR)		+= nor-simtec.o
diff --git a/arch/arm/mach-s3c2412/clock.c b/arch/arm/mach-s3c24xx/clock-s3c2412.c
similarity index 100%
rename from arch/arm/mach-s3c2412/clock.c
rename to arch/arm/mach-s3c24xx/clock-s3c2412.c
diff --git a/arch/arm/mach-s3c2412/dma.c b/arch/arm/mach-s3c24xx/dma-s3c2412.c
similarity index 100%
rename from arch/arm/mach-s3c2412/dma.c
rename to arch/arm/mach-s3c24xx/dma-s3c2412.c
diff --git a/arch/arm/mach-s3c2412/irq.c b/arch/arm/mach-s3c24xx/irq-s3c2412.c
similarity index 100%
rename from arch/arm/mach-s3c2412/irq.c
rename to arch/arm/mach-s3c24xx/irq-s3c2412.c
diff --git a/arch/arm/mach-s3c2412/mach-jive.c b/arch/arm/mach-s3c24xx/mach-jive.c
similarity index 100%
rename from arch/arm/mach-s3c2412/mach-jive.c
rename to arch/arm/mach-s3c24xx/mach-jive.c
diff --git a/arch/arm/mach-s3c2412/mach-smdk2413.c b/arch/arm/mach-s3c24xx/mach-smdk2413.c
similarity index 100%
rename from arch/arm/mach-s3c2412/mach-smdk2413.c
rename to arch/arm/mach-s3c24xx/mach-smdk2413.c
diff --git a/arch/arm/mach-s3c2412/mach-vstms.c b/arch/arm/mach-s3c24xx/mach-vstms.c
similarity index 100%
rename from arch/arm/mach-s3c2412/mach-vstms.c
rename to arch/arm/mach-s3c24xx/mach-vstms.c
diff --git a/arch/arm/mach-s3c2412/pm.c b/arch/arm/mach-s3c24xx/pm-s3c2412.c
similarity index 100%
rename from arch/arm/mach-s3c2412/pm.c
rename to arch/arm/mach-s3c24xx/pm-s3c2412.c
diff --git a/arch/arm/mach-s3c2412/s3c2412.c b/arch/arm/mach-s3c24xx/s3c2412.c
similarity index 100%
rename from arch/arm/mach-s3c2412/s3c2412.c
rename to arch/arm/mach-s3c24xx/s3c2412.c
diff --git a/arch/arm/mach-s3c2412/sleep.S b/arch/arm/mach-s3c24xx/sleep-s3c2412.S
similarity index 100%
rename from arch/arm/mach-s3c2412/sleep.S
rename to arch/arm/mach-s3c24xx/sleep-s3c2412.S
-- 
1.7.4.4
