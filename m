From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu,  2 Jun 2016 23:41:37 +0200
Subject: [PATCH 6/6] clocksource/drivers/clps_711x: Add the COMPILE_TEST option
In-Reply-To: <1464903697-3802-1-git-send-email-daniel.lezcano@linaro.org>
References: <1464903697-3802-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1464903697-3802-6-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the Kconfig option logic to fullfil with the current approach.

A new Kconfig option is added, CONFIG_BCM_KONA_TIMER and is selected by the
platform. Then the clocksource's Kconfig is changed to make this option
selectable by the user if the COMPILE_TEST option is set. Otherwise, it is
up to the platform's Kconfig to select the timer.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/Kconfig             | 2 +-
 drivers/clocksource/Kconfig  | 7 +++++++
 drivers/clocksource/Makefile | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cdfa6c2..0c1f546 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -356,10 +356,10 @@ config ARCH_CLPS711X
 	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
 	select ARCH_REQUIRE_GPIOLIB
 	select AUTO_ZRELADDR
-	select CLKSRC_MMIO
 	select COMMON_CLK
 	select CPU_ARM720T
 	select GENERIC_CLOCKEVENTS
+	select CLPS711X_TIMER
 	select MFD_SYSCON
 	select SOC_BUS
 	help
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 6714a22..e92a814 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -155,6 +155,13 @@ config CLKSRC_DBX500_PRCMU
 	help
 	  Use the always on PRCMU Timer as clocksource
 
+config CLPS711X_TIMER
+	bool "Cirrus logic timer driver" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
+	select CLKSRC_MMIO
+	help
+	  Enables support for the Cirrus Logic PS711 timer.
+
 config CLKSRC_DBX500_PRCMU_SCHED_CLOCK
 	bool "Clocksource PRCMU Timer sched_clock"
 	depends on (CLKSRC_DBX500_PRCMU && !CLKSRC_NOMADIK_MTU_SCHED_CLOCK)
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 662a87c..ae6c09f 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
 obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
 obj-$(CONFIG_ORION_TIMER)	+= time-orion.o
 obj-$(CONFIG_BCM2835_TIMER)	+= bcm2835_timer.o
-obj-$(CONFIG_ARCH_CLPS711X)	+= clps711x-timer.o
+obj-$(CONFIG_CLPS711X_TIMER)	+= clps711x-timer.o
 obj-$(CONFIG_ARCH_ATLAS7)	+= timer-atlas7.o
 obj-$(CONFIG_ARCH_MOXART)	+= moxart_timer.o
 obj-$(CONFIG_ARCH_MXS)		+= mxs_timer.o
-- 
1.9.1
