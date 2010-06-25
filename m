From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 25 Jun 2010 23:27:15 +0900
Subject: [PATCH 6/8] ARM: S5PV310: Add new Kconfig and Makefiles
In-Reply-To: <1277476037-8806-1-git-send-email-kgene.kim@samsung.com>
References: <1277476037-8806-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1277476037-8806-7-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

This patch adds the Kconfig and Makefile for the new S5PV310 SoC.
It also updates arch/arm Kconfig, Makefile and arch/arm/mm/Kconfig
to include support for the new S5PV310.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/Kconfig                    |   24 +++++++++++++++++++-----
 arch/arm/Makefile                   |    1 +
 arch/arm/mach-s5pv310/Kconfig       |   26 ++++++++++++++++++++++++++
 arch/arm/mach-s5pv310/Makefile      |   20 ++++++++++++++++++++
 arch/arm/mach-s5pv310/Makefile.boot |    2 ++
 arch/arm/mm/Kconfig                 |    3 ++-
 arch/arm/plat-s5p/Kconfig           |    5 +++--
 7 files changed, 73 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/mach-s5pv310/Kconfig
 create mode 100644 arch/arm/mach-s5pv310/Makefile
 create mode 100644 arch/arm/mach-s5pv310/Makefile.boot

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1f254bd..a7a8040 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -704,6 +704,15 @@ config ARCH_S5PV210
 	help
 	  Samsung S5PV210/S5PC110 series based systems
 
+config ARCH_S5PV310
+	bool "Samsung S5PV310/S5PC210"
+	select CPU_V7
+	select GENERIC_GPIO
+	select HAVE_CLK
+	select GENERIC_CLOCKEVENTS
+	help
+	  Samsung S5PV310 series based systems
+
 config ARCH_SHARK
 	bool "Shark"
 	select CPU_SA110
@@ -904,6 +913,8 @@ source "arch/arm/mach-s5pc100/Kconfig"
 
 source "arch/arm/mach-s5pv210/Kconfig"
 
+source "arch/arm/mach-s5pv310/Kconfig"
+
 source "arch/arm/mach-shmobile/Kconfig"
 
 source "arch/arm/plat-stmp3xxx/Kconfig"
@@ -1099,10 +1110,11 @@ config SMP
 	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && (REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP ||\
 		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 ||\
-		 ARCH_U8500 || ARCH_VEXPRESS_CA9X4)
+		 ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_S5PV310)
 	depends on GENERIC_CLOCKEVENTS
 	select USE_GENERIC_SMP_HELPERS
-	select HAVE_ARM_SCU if (ARCH_REALVIEW || ARCH_OMAP4 || ARCH_U8500 || ARCH_VEXPRESS_CA9X4)
+	select HAVE_ARM_SCU if (ARCH_REALVIEW || ARCH_OMAP4 || ARCH_U8500 || ARCH_VEXPRESS_CA9X4 ||\
+			ARCH_S5PV310)
 	help
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, like most personal computers, say N. If
@@ -1171,9 +1183,10 @@ config HOTPLUG_CPU
 config LOCAL_TIMERS
 	bool "Use local timer interrupts"
 	depends on SMP && (REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || \
-		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || ARCH_U8500)
+		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
+		ARCH_U8500 || ARCH_S5PV310)
 	default y
-	select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_OMAP4 || ARCH_U8500)
+	select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_OMAP4 || ARCH_U8500 || ARCH_S5PV310)
 	help
 	  Enable support for local timers on SMP platforms, rather then the
 	  legacy IPI broadcast method.  Local timers allows the system
@@ -1185,7 +1198,8 @@ source kernel/Kconfig.preempt
 config HZ
 	int
 	default 128 if ARCH_L7200
-	default 200 if ARCH_EBSA110 || ARCH_S3C2410 || ARCH_S5P6440 || ARCH_S5P6442 || ARCH_S5PV210
+	default 200 if ARCH_EBSA110 || ARCH_S3C2410 || ARCH_S5P6440 || ARCH_S5P6442 || \
+		       ARCH_S5PV210 || ARCH_S5PV310
 	default OMAP_32K_TIMER_HZ if ARCH_OMAP && OMAP_32K_TIMER
 	default AT91_TIMER_HZ if ARCH_AT91
 	default 100
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 64ba313..d80c9f9 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -170,6 +170,7 @@ machine-$(CONFIG_ARCH_S5P6440)		:= s5p6440
 machine-$(CONFIG_ARCH_S5P6442)		:= s5p6442
 machine-$(CONFIG_ARCH_S5PC100)		:= s5pc100
 machine-$(CONFIG_ARCH_S5PV210)		:= s5pv210
+machine-$(CONFIG_ARCH_S5PV310)		:= s5pv310
 machine-$(CONFIG_ARCH_SA1100)		:= sa1100
 machine-$(CONFIG_ARCH_SHARK)		:= shark
 machine-$(CONFIG_ARCH_SHMOBILE) 	:= shmobile
diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
new file mode 100644
index 0000000..24ef3cd
--- /dev/null
+++ b/arch/arm/mach-s5pv310/Kconfig
@@ -0,0 +1,26 @@
+# arch/arm/mach-s5pv310/Kconfig
+#
+# Copyright (c) 2010 Samsung Electronics Co., Ltd.
+#		http://www.samsung.com/
+#
+# Licensed under GPLv2
+
+# Configuration options for the S5PV310
+
+if ARCH_S5PV310
+
+config CPU_S5PV310
+	bool
+	select PLAT_S5P
+	help
+	  Enable S5PV310 CPU support
+
+# machine support
+
+config MACH_SMDKV310
+	bool "SMDKV310"
+	select CPU_S5PV310
+	select ARCH_SPARSEMEM_ENABLE
+	help
+	  Machine support for Samsung SMDKV310
+endif
diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
new file mode 100644
index 0000000..1b263a5
--- /dev/null
+++ b/arch/arm/mach-s5pv310/Makefile
@@ -0,0 +1,20 @@
+# arch/arm/mach-s5pv310/Makefile
+#
+# Copyright (c) 2010 Samsung Electronics Co., Ltd.
+#		http://www.samsung.com/
+#
+# Licensed under GPLv2
+
+obj-y				:=
+obj-m				:=
+obj-n				:=
+obj-				:=
+
+# Core support for S5PV310 system
+
+obj-$(CONFIG_CPU_S5PV310)	+= cpu.o init.o clock.o irq-combiner.o
+obj-$(CONFIG_CPU_S5PV310)	+= setup-i2c0.o time.o
+
+obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
+obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
+obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
diff --git a/arch/arm/mach-s5pv310/Makefile.boot b/arch/arm/mach-s5pv310/Makefile.boot
new file mode 100644
index 0000000..d65956f
--- /dev/null
+++ b/arch/arm/mach-s5pv310/Makefile.boot
@@ -0,0 +1,2 @@
+   zreladdr-y	:= 0x40008000
+params_phys-y	:= 0x40000100
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 346ae14..45284c8 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -763,7 +763,8 @@ config CACHE_L2X0
 	bool "Enable the L2x0 outer cache controller"
 	depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
 		   REALVIEW_EB_A9MP || ARCH_MX35 || ARCH_MX31 || MACH_REALVIEW_PBX || \
-		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_U8500 || ARCH_VEXPRESS_CA9X4
+		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || \
+		   ARCH_S5PV310
 	default y
 	select OUTER_CACHE
 	select OUTER_CACHE_SYNC
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index 11d6a1b..907ac63 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -7,9 +7,10 @@
 
 config PLAT_S5P
 	bool
-	depends on (ARCH_S5P6440 || ARCH_S5P6442 || ARCH_S5PC100 || ARCH_S5PV210)
+	depends on (ARCH_S5P6440 || ARCH_S5P6442 || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_S5PV310)
 	default y
-	select ARM_VIC
+	select ARM_VIC if !ARCH_S5PV310
+	select ARM_GIC if ARCH_S5PV310
 	select NO_IOPORT
 	select ARCH_REQUIRE_GPIOLIB
 	select S3C_GPIO_TRACK
-- 
1.6.2.5
