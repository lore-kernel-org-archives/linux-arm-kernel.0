From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 12 Jan 2010 17:49:24 +0900
Subject: [PATCH v4 5/8] ARM: S5P6440: Add new Kconfig and Makefiles
Message-ID: <1263286164-21406-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the Kconfig and Makefile for the new S5P6440 machine
and platform directories. It also updates arch/arm Kconfig and Makefiles
to include the support for the new S5P6440 CPU.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/Kconfig                    |   12 +++++++++-
 arch/arm/Makefile                   |    2 +
 arch/arm/mach-s5p6440/Kconfig       |   16 ++++++++++++++
 arch/arm/mach-s5p6440/Makefile      |   19 +++++++++++++++++
 arch/arm/mach-s5p6440/Makefile.boot |    2 +
 arch/arm/plat-s5p/Kconfig           |   39 +++++++++++++++++++++++++++++++++++
 arch/arm/plat-s5p/Makefile          |   24 +++++++++++++++++++++
 7 files changed, 113 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-s5p6440/Kconfig
 create mode 100644 arch/arm/mach-s5p6440/Makefile
 create mode 100644 arch/arm/mach-s5p6440/Makefile.boot
 create mode 100644 arch/arm/plat-s5p/Kconfig
 create mode 100644 arch/arm/plat-s5p/Makefile

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 233a222..2d7c2e9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -631,6 +631,13 @@ config ARCH_S3C64XX
 	help
 	  Samsung S3C64XX series based systems
 
+config ARCH_S5P6440
+	bool "Samsung S5P6440"
+	select GENERIC_GPIO
+	select HAVE_CLK
+	help
+	  Samsung S5P6440 CPU based systems
+
 config ARCH_S5PC1XX
 	bool "Samsung S5PC1XX"
 	select GENERIC_GPIO
@@ -775,6 +782,7 @@ source "arch/arm/plat-samsung/Kconfig"
 source "arch/arm/plat-s3c24xx/Kconfig"
 source "arch/arm/plat-s3c64xx/Kconfig"
 source "arch/arm/plat-s3c/Kconfig"
+source "arch/arm/plat-s5p/Kconfig"
 source "arch/arm/plat-s5pc1xx/Kconfig"
 
 if ARCH_S3C2410
@@ -791,6 +799,8 @@ source "arch/arm/mach-s3c6400/Kconfig"
 source "arch/arm/mach-s3c6410/Kconfig"
 endif
 
+source "arch/arm/mach-s5p6440/Kconfig"
+
 source "arch/arm/plat-stmp3xxx/Kconfig"
 
 if ARCH_S5PC1XX
@@ -1071,7 +1081,7 @@ source kernel/Kconfig.preempt
 config HZ
 	int
 	default 128 if ARCH_L7200
-	default 200 if ARCH_EBSA110 || ARCH_S3C2410
+	default 200 if ARCH_EBSA110 || ARCH_S3C2410 || ARCH_S5P6440
 	default OMAP_32K_TIMER_HZ if ARCH_OMAP && OMAP_32K_TIMER
 	default AT91_TIMER_HZ if ARCH_AT91
 	default 100
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index e9da084..bbcd512 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -161,6 +161,7 @@ machine-$(CONFIG_ARCH_RPC)		:= rpc
 machine-$(CONFIG_ARCH_S3C2410)		:= s3c2410 s3c2400 s3c2412 s3c2440 s3c2442 s3c2443
 machine-$(CONFIG_ARCH_S3C24A0)		:= s3c24a0
 machine-$(CONFIG_ARCH_S3C64XX)		:= s3c6400 s3c6410
+machine-$(CONFIG_ARCH_S5P6440)		:= s5p6440
 machine-$(CONFIG_ARCH_S5PC1XX)		:= s5pc100
 machine-$(CONFIG_ARCH_SA1100)		:= sa1100
 machine-$(CONFIG_ARCH_SHARK)		:= shark
@@ -184,6 +185,7 @@ plat-$(CONFIG_PLAT_PXA)		:= pxa
 plat-$(CONFIG_PLAT_S3C24XX)	:= s3c24xx s3c samsung
 plat-$(CONFIG_PLAT_S3C64XX)	:= s3c64xx s3c samsung
 plat-$(CONFIG_PLAT_S5PC1XX)	:= s5pc1xx s3c samsung
+plat-$(CONFIG_PLAT_S5P)		:= s5p samsung s3c
 plat-$(CONFIG_ARCH_STMP3XXX)	:= stmp3xxx
 
 ifeq ($(CONFIG_ARCH_EBSA110),y)
diff --git a/arch/arm/mach-s5p6440/Kconfig b/arch/arm/mach-s5p6440/Kconfig
new file mode 100644
index 0000000..60f0985
--- /dev/null
+++ b/arch/arm/mach-s5p6440/Kconfig
@@ -0,0 +1,16 @@
+if ARCH_S5P6440
+
+config CPU_S5P6440
+	bool
+	select CPU_S5P6440_INIT
+	select CPU_S5P6440_CLOCK
+	help
+	  Enable S5P6440 CPU support
+
+config MACH_SMDK6440
+	bool "SMDK6440"
+	select CPU_S5P6440
+	help
+	  Machine support for the Samsung SMDK6440
+
+endif
diff --git a/arch/arm/mach-s5p6440/Makefile b/arch/arm/mach-s5p6440/Makefile
new file mode 100644
index 0000000..a3ffda9
--- /dev/null
+++ b/arch/arm/mach-s5p6440/Makefile
@@ -0,0 +1,19 @@
+# arch/arm/mach-s5p6440/Makefile
+#
+# Copyright (c) 2009 Samsung Electronics Co., Ltd.
+# 		http://www.samsung.com/
+#
+# Licensed under GPLv2
+
+obj-y				:=
+obj-m				:=
+obj-n				:=
+obj-				:=
+
+# Core support for S5P6440 system
+
+obj-$(CONFIG_CPU_S5P6440)	+= cpu.o
+
+# machine support
+
+obj-$(CONFIG_MACH_SMDK6440)	+= mach-smdk6440.o
diff --git a/arch/arm/mach-s5p6440/Makefile.boot b/arch/arm/mach-s5p6440/Makefile.boot
new file mode 100644
index 0000000..ff90aa1
--- /dev/null
+++ b/arch/arm/mach-s5p6440/Makefile.boot
@@ -0,0 +1,2 @@
+   zreladdr-y	:= 0x20008000
+params_phys-y	:= 0x20000100
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
new file mode 100644
index 0000000..664085c
--- /dev/null
+++ b/arch/arm/plat-s5p/Kconfig
@@ -0,0 +1,39 @@
+# arch/arm/plat-s5p/Kconfig
+#
+# Copyright (c) 2009 Samsung Electronics Co., Ltd.
+#		http://www.samsung.com/
+#
+# Licensed under GPLv2
+
+config PLAT_S5P
+	bool
+	depends on ARCH_S5P6440
+	default y
+	select CPU_V6
+	select PLAT_S3C
+	select ARM_VIC
+	select NO_IOPORT
+	select ARCH_REQUIRE_GPIOLIB
+	select S3C_GPIO_TRACK
+	select PLAT_SAMSUNG
+	select SAMSUNG_CLKSRC
+	select SAMSUNG_IRQ_VIC_TIMER
+	select SAMSUNG_IRQ_UART
+	help
+	  Base platform code for Samsung's S5P series SoC.
+
+if PLAT_S5P
+
+# Configuration options shared by all S5P64XX implementations
+
+config CPU_S5P6440_INIT
+	bool
+	help
+	 Initialisation code for the S5P6440.
+
+config CPU_S5P6440_CLOCK
+	bool
+	help
+	  Clock support code for the S5P6440.
+
+endif
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
new file mode 100644
index 0000000..92b6474
--- /dev/null
+++ b/arch/arm/plat-s5p/Makefile
@@ -0,0 +1,24 @@
+# arch/arm/plat-s5p/Makefile
+#
+# Copyright (c) 2009 Samsung Electronics Co., Ltd.
+# 		http://www.samsung.com/
+#
+# Licensed under GPLv2
+
+obj-y				:=
+obj-m				:=
+obj-n				:= dummy.o
+obj-				:=
+
+# Core files
+
+obj-y				+= dev-uart.o
+obj-y				+= cpu.o
+obj-y				+= clock.o
+obj-y				+= irq.o
+obj-y				+= setup-i2c0.o
+
+# CPU support
+
+obj-$(CONFIG_CPU_S5P6440_INIT)	+= s5p6440-init.o
+obj-$(CONFIG_CPU_S5P6440_CLOCK)	+= s5p6440-clock.o
-- 
1.6.2.5
