From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 18 Jul 2013 05:31:09 +0900
Subject: [PATCH 02/04] ARM: shmobile: Introduce ARCH_SHMOBILE_MULTI
In-Reply-To: <20130717203049.27542.78385.sendpatchset@w520>
References: <20130717203049.27542.78385.sendpatchset@w520>
Message-ID: <20130717203109.27542.77708.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add ARCH_SHMOBILE_MULTI to mach-shmobile that can be used
to enable ARCH_MULTIPLATFORM on selected SoCs and boards.

The headers stay under arch/arm/mach-shmobile/include/mach/
for now, they can and will be migrated independently over time.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/Makefile               |    1 +
 arch/arm/mach-shmobile/Kconfig  |   21 +++++++++++++++++++++
 arch/arm/mach-shmobile/Makefile |    2 ++
 3 files changed, 24 insertions(+)

--- 0001/arch/arm/Makefile
+++ work/arch/arm/Makefile	2013-07-08 19:17:00.000000000 +0900
@@ -181,6 +181,7 @@ machine-$(CONFIG_ARCH_EXYNOS)		+= exynos
 machine-$(CONFIG_ARCH_SA1100)		+= sa1100
 machine-$(CONFIG_ARCH_SHARK)		+= shark
 machine-$(CONFIG_ARCH_SHMOBILE) 	+= shmobile
+machine-$(CONFIG_ARCH_SHMOBILE_MULTI) 	+= shmobile
 machine-$(CONFIG_ARCH_TEGRA)		+= tegra
 machine-$(CONFIG_ARCH_U300)		+= u300
 machine-$(CONFIG_ARCH_U8500)		+= ux500
--- 0002/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-07-08 19:19:21.000000000 +0900
@@ -1,3 +1,24 @@
+config ARCH_SHMOBILE_MULTI
+	bool "SH-Mobile Series" if ARCH_MULTI_V7
+	depends on MMU
+	select CPU_V7
+	select GENERIC_CLOCKEVENTS
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if LOCAL_TIMERS
+	select HAVE_SMP
+	select ARM_GIC
+	select MIGHT_HAVE_CACHE_L2X0
+	select NO_IOPORT
+	select PINCTRL
+	select ARCH_REQUIRE_GPIOLIB
+	select CLKDEV_LOOKUP
+
+if ARCH_SHMOBILE_MULTI
+
+comment "SH-Mobile System Type"
+
+endif
+
 if ARCH_SHMOBILE
 
 comment "SH-Mobile System Type"
--- 0003/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-07-08 19:18:20.000000000 +0900
@@ -2,6 +2,8 @@
 # Makefile for the linux kernel.
 #
 
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/mach-shmobile/include
+
 # Common objects
 obj-y				:= timer.o console.o
 
