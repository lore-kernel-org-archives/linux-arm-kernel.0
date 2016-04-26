From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 26 Apr 2016 18:28:52 +0300
Subject: [PATCH v1] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
Message-ID: <1461684532-16848-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch intended to fix following cases:
- SoC-A has ARM GT, defines DT node for ARM GT and selects
ARM_GLOBAL_TIMER statically in Kconfig file. SoC-B has ARM GT and
defines DT node for ARM GT, but do not selects ARM_GLOBAL_TIMER
statically in Kconfig file. In case of multiplatform build ARM GT will
be implicitly enabled for SoC-B.

- There is no way to disable ARM GT without modifying Kconfig file,
once ARM_GLOBAL_TIMER is selected statically in Kconfig file.

Hence, fix above case by defining both HAVE_ARM_GLOBAL_TIMER and
ARM_GLOBAL_TIMER as recommended by 'Adding common features and make
the usage configurable' section in kconfig-language.txt. All places in
ARM folder where ARM_GLOBAL_TIMER was used now replaced on
HAVE_ARM_GLOBAL_TIMER.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Jun Nie <jun.nie@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Lars Persson <lars.persson@axis.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>
Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
Acked-by: Moritz Fischer <moritz.fischer@ettus.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
Changes is v1:
- updated mach-artpec
- rebased on top of tip: timers/core
  commit: 86d3473 time: Introduce do_sys_settimeofday64()

 arch/arm/mach-artpec/Kconfig   | 2 +-
 arch/arm/mach-bcm/Kconfig      | 4 ++--
 arch/arm/mach-hisi/Kconfig     | 2 +-
 arch/arm/mach-imx/Kconfig      | 2 +-
 arch/arm/mach-rockchip/Kconfig | 2 +-
 arch/arm/mach-sti/Kconfig      | 2 +-
 arch/arm/mach-uniphier/Kconfig | 2 +-
 arch/arm/mach-vexpress/Kconfig | 2 +-
 arch/arm/mach-zx/Kconfig       | 2 +-
 arch/arm/mach-zynq/Kconfig     | 2 +-
 drivers/clocksource/Kconfig    | 7 ++++++-
 11 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-artpec/Kconfig b/arch/arm/mach-artpec/Kconfig
index 6cbe5a2..6cbca77 100644
--- a/arch/arm/mach-artpec/Kconfig
+++ b/arch/arm/mach-artpec/Kconfig
@@ -9,7 +9,7 @@ config MACH_ARTPEC6
 	depends on ARCH_MULTI_V7
 	select ARM_AMBA
 	select ARM_GIC
-	select ARM_GLOBAL_TIMER
+	select HAVE_ARM_GLOBAL_TIMER
 	select ARM_PSCI
 	select HAVE_ARM_ARCH_TIMER
 	select HAVE_ARM_SCU
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 7ef1214..d4d079a7 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -14,7 +14,7 @@ config ARCH_BCM_IPROC
 	select CACHE_L2X0
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select ARM_GLOBAL_TIMER
+	select HAVE_ARM_GLOBAL_TIMER
 	select COMMON_CLK_IPROC
 	select CLKSRC_MMIO
 	select ARCH_REQUIRE_GPIOLIB
@@ -156,7 +156,7 @@ config ARCH_BCM_63XX
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_764369 if SMP
 	select ARM_GIC
-	select ARM_GLOBAL_TIMER
+	select HAVE_ARM_GLOBAL_TIMER
 	select CACHE_L2X0
 	select HAVE_ARM_ARCH_TIMER
 	select HAVE_ARM_TWD if SMP
diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index a3b091a..251bb03 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -28,7 +28,7 @@ config ARCH_HIP01
        depends on ARCH_MULTI_V7
        select HAVE_ARM_SCU if SMP
        select HAVE_ARM_TWD if SMP
-       select ARM_GLOBAL_TIMER
+       select HAVE_ARM_GLOBAL_TIMER
        help
          Support for Hisilicon HIP01 SoC family
 
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 8973fae..3fbf38c 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -602,7 +602,7 @@ choice
 	config VF_USE_ARM_GLOBAL_TIMER
 		bool "Use ARM Global Timer"
 		depends on ARCH_MULTI_V7
-		select ARM_GLOBAL_TIMER
+		select HAVE_ARM_GLOBAL_TIMER
 		select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 		help
 		  Use the ARM Global Timer as clocksource
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index cef42fd..a53b787 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -14,7 +14,7 @@ config ARCH_ROCKCHIP
 	select DW_APB_TIMER_OF
 	select REGULATOR if PM
 	select ROCKCHIP_TIMER
-	select ARM_GLOBAL_TIMER
+	select HAVE_ARM_GLOBAL_TIMER
 	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 	help
 	  Support for Rockchip's Cortex-A9 Single-to-Quad-Core-SoCs
diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index a196d14..c799f9d 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -3,7 +3,7 @@ menuconfig ARCH_STI
 	depends on ARCH_MULTI_V7
 	select ARM_GIC
 	select ST_IRQCHIP
-	select ARM_GLOBAL_TIMER
+	select HAVE_ARM_GLOBAL_TIMER
 	select CLKSRC_ST_LPC
 	select PINCTRL
 	select PINCTRL_ST
diff --git a/arch/arm/mach-uniphier/Kconfig b/arch/arm/mach-uniphier/Kconfig
index 82dddee..81bdf77 100644
--- a/arch/arm/mach-uniphier/Kconfig
+++ b/arch/arm/mach-uniphier/Kconfig
@@ -2,7 +2,7 @@ config ARCH_UNIPHIER
 	bool "Socionext UniPhier SoCs"
 	depends on ARCH_MULTI_V7
 	select ARM_AMBA
-	select ARM_GLOBAL_TIMER
+	select HAVE_ARM_GLOBAL_TIMER
 	select ARM_GIC
 	select HAVE_ARM_SCU
 	select HAVE_ARM_TWD if SMP
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 398a297..e89941d 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -5,7 +5,7 @@ menuconfig ARCH_VEXPRESS
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
-	select ARM_GLOBAL_TIMER
+	select HAVE_ARM_GLOBAL_TIMER
 	select ARM_TIMER_SP804
 	select COMMON_CLK_VERSATILE
 	select HAVE_ARM_SCU if SMP
diff --git a/arch/arm/mach-zx/Kconfig b/arch/arm/mach-zx/Kconfig
index 209c979..e84b0c2 100644
--- a/arch/arm/mach-zx/Kconfig
+++ b/arch/arm/mach-zx/Kconfig
@@ -11,7 +11,7 @@ if ARCH_ZX
 config SOC_ZX296702
 	def_bool y
 	select ARM_GIC
-	select ARM_GLOBAL_TIMER
+	select HAVE_ARM_GLOBAL_TIMER
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select PM_GENERIC_DOMAINS if PM
diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index fd0aeeb..3165720 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -5,7 +5,7 @@ config ARCH_ZYNQ
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
-	select ARM_GLOBAL_TIMER if !CPU_FREQ
+	select HAVE_ARM_GLOBAL_TIMER if !CPU_FREQ
 	select CADENCE_TTC_TIMER
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index c346be6..c686811 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -207,9 +207,14 @@ config ARM_ARCH_TIMER_EVTSTREAM
 	  This must be disabled for hardware validation purposes to detect any
 	  hardware anomalies of missing events.
 
-config ARM_GLOBAL_TIMER
+config HAVE_ARM_GLOBAL_TIMER
 	bool
+
+config ARM_GLOBAL_TIMER
+	bool "Support for ARM global timer unit"
 	select CLKSRC_OF if OF
+	default y
+	depends on HAVE_ARM_GLOBAL_TIMER
 	help
 	  This options enables support for the ARM global timer unit
 
-- 
2.8.0
