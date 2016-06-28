From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 28 Jun 2016 12:51:37 +0200
Subject: [PATCH 79/92] clocksource/drivers/atlas7: Add the COMPILE_TEST option
In-Reply-To: <1467111111-12587-1-git-send-email-daniel.lezcano@linaro.org>
References: <577251A4.7030508@linaro.org>
 <1467111111-12587-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467111111-12587-4-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the Kconfig option logic to fullfil with the current approach.

A new Kconfig option is added, CONFIG_ATLAS7_TIMER and is selected by the
platform. Then the clocksource's Kconfig is changed to make this option
selectable by the user if the COMPILE_TEST option is set. Otherwise, it is
up to the platform's Kconfig to select the timer.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-prima2/Kconfig | 1 +
 drivers/clocksource/Kconfig  | 7 +++++++
 drivers/clocksource/Makefile | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index 0cf4426..2db8d24 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -28,6 +28,7 @@ config ARCH_ATLAS7
 	default y
 	select ARM_GIC
 	select CPU_V7
+	select ATLAS7_TIMER
 	select HAVE_ARM_SCU if SMP
 	select HAVE_SMP
 	help
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index f41eef2..669dd3c 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -162,6 +162,13 @@ config CLPS711X_TIMER
 	help
 	  Enables support for the Cirrus Logic PS711 timer.
 
+config ATLAS7_TIMER
+	bool "Atlas7 timer driver" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
+	select CLKSRC_MMIO
+	help
+	  Enables support for the Atlas7 timer.
+
 config CLKSRC_DBX500_PRCMU_SCHED_CLOCK
 	bool "Clocksource PRCMU Timer sched_clock"
 	depends on (CLKSRC_DBX500_PRCMU && !CLKSRC_NOMADIK_MTU_SCHED_CLOCK)
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 25e599c..7abf144 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -21,7 +21,7 @@ obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
 obj-$(CONFIG_ORION_TIMER)	+= time-orion.o
 obj-$(CONFIG_BCM2835_TIMER)	+= bcm2835_timer.o
 obj-$(CONFIG_CLPS711X_TIMER)	+= clps711x-timer.o
-obj-$(CONFIG_ARCH_ATLAS7)	+= timer-atlas7.o
+obj-$(CONFIG_ATLAS7_TIMER)	+= timer-atlas7.o
 obj-$(CONFIG_ARCH_MOXART)	+= moxart_timer.o
 obj-$(CONFIG_ARCH_MXS)		+= mxs_timer.o
 obj-$(CONFIG_CLKSRC_PXA)	+= pxa_timer.o
-- 
1.9.1
