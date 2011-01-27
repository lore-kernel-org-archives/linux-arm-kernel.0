From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 13:48:08 +0000
Subject: [PATCH 07/11] ARM: rationalize versatile family Kconfig/Makefile
In-Reply-To: <20110127134532.GE25968@n2100.arm.linux.org.uk>
References: <20110127134532.GE25968@n2100.arm.linux.org.uk>
Message-ID: <E1PiSCm-0003pH-JB@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move leds and sched_clock build conditionals out of the Makefile into
the Kconfig file.  Move selection of HAVE_SCHED_CLOCK into the
platform Kconfig rather than duplicating it three times in the main
architecture Kconfig.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig                 |    3 ---
 arch/arm/plat-versatile/Kconfig  |    8 ++++++++
 arch/arm/plat-versatile/Makefile |   10 +++-------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4f0e83e..fe8d6fa 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -236,7 +236,6 @@ config ARCH_REALVIEW
 	bool "ARM Ltd. RealView family"
 	select ARM_AMBA
 	select CLKDEV_LOOKUP
-	select HAVE_SCHED_CLOCK
 	select ICST
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
@@ -252,7 +251,6 @@ config ARCH_VERSATILE
 	select ARM_AMBA
 	select ARM_VIC
 	select CLKDEV_LOOKUP
-	select HAVE_SCHED_CLOCK
 	select ICST
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
@@ -270,7 +268,6 @@ config ARCH_VEXPRESS
 	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
 	select HAVE_CLK
-	select HAVE_SCHED_CLOCK
 	select HAVE_PATA_PLATFORM
 	select ICST
 	select PLAT_VERSATILE
diff --git a/arch/arm/plat-versatile/Kconfig b/arch/arm/plat-versatile/Kconfig
index 22540f5..c5e2cd0 100644
--- a/arch/arm/plat-versatile/Kconfig
+++ b/arch/arm/plat-versatile/Kconfig
@@ -3,4 +3,12 @@ if PLAT_VERSATILE
 config PLAT_VERSATILE_CLCD
 	bool
 
+config PLAT_VERSATILE_LEDS
+	def_bool y if LEDS_CLASS
+	depends on ARCH_REALVIEW || ARCH_VERSATILE
+
+config PLAT_VERSATILE_SCHED_CLOCK
+	def_bool y if !ARCH_INTEGRATOR
+	select HAVE_SCHED_CLOCK
+
 endif
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index 8b3341c..de6f42f 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -1,9 +1,5 @@
 obj-y	:= clock.o
-ifneq ($(CONFIG_ARCH_INTEGRATOR),y)
-obj-y	+= sched-clock.o
-endif
-ifeq ($(CONFIG_LEDS_CLASS),y)
-obj-$(CONFIG_ARCH_REALVIEW) += leds.o
-obj-$(CONFIG_ARCH_VERSATILE) += leds.o
-endif
 obj-$(CONFIG_PLAT_VERSATILE_CLCD) += clcd.o
+obj-$(CONFIG_PLAT_VERSATILE_LEDS) += leds.o
+obj-$(CONFIG_PLAT_VERSATILE_SCHED_CLOCK) += sched-clock.o
+
-- 
1.6.2.5
