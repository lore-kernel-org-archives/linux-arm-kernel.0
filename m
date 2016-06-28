From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 28 Jun 2016 12:51:38 +0200
Subject: [PATCH 80/92] clocksource/drivers/moxart: Add the COMPILE_TEST option
In-Reply-To: <1467111111-12587-1-git-send-email-daniel.lezcano@linaro.org>
References: <577251A4.7030508@linaro.org>
 <1467111111-12587-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467111111-12587-5-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the Kconfig option logic to fullfil with the current approach.

A new Kconfig option is added, CONFIG_MOXART_TIMER and is selected by the
platform. Then the clocksource's Kconfig is changed to make this option
selectable by the user if the COMPILE_TEST option is set. Otherwise, it is
up to the platform's Kconfig to select the timer.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-moxart/Kconfig | 2 +-
 drivers/clocksource/Kconfig  | 7 +++++++
 drivers/clocksource/Makefile | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-moxart/Kconfig b/arch/arm/mach-moxart/Kconfig
index 180d9d2..ddc79ce 100644
--- a/arch/arm/mach-moxart/Kconfig
+++ b/arch/arm/mach-moxart/Kconfig
@@ -3,7 +3,7 @@ menuconfig ARCH_MOXART
 	depends on ARCH_MULTI_V4
 	select CPU_FA526
 	select ARM_DMA_MEM_BUFFERABLE
-	select CLKSRC_MMIO
+	select MOXART_TIMER
 	select GENERIC_IRQ_CHIP
 	select ARCH_REQUIRE_GPIOLIB
 	select PHYLIB if NETDEVICES
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 669dd3c..db2c5ff 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -169,6 +169,13 @@ config ATLAS7_TIMER
 	help
 	  Enables support for the Atlas7 timer.
 
+config MOXART_TIMER
+	bool "Moxart timer driver" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
+	select CLKSRC_MMIO
+	help
+	  Enables support for the Moxart timer.
+
 config CLKSRC_DBX500_PRCMU_SCHED_CLOCK
 	bool "Clocksource PRCMU Timer sched_clock"
 	depends on (CLKSRC_DBX500_PRCMU && !CLKSRC_NOMADIK_MTU_SCHED_CLOCK)
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 7abf144..e64e37a 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -22,7 +22,7 @@ obj-$(CONFIG_ORION_TIMER)	+= time-orion.o
 obj-$(CONFIG_BCM2835_TIMER)	+= bcm2835_timer.o
 obj-$(CONFIG_CLPS711X_TIMER)	+= clps711x-timer.o
 obj-$(CONFIG_ATLAS7_TIMER)	+= timer-atlas7.o
-obj-$(CONFIG_ARCH_MOXART)	+= moxart_timer.o
+obj-$(CONFIG_MOXART_TIMER)	+= moxart_timer.o
 obj-$(CONFIG_ARCH_MXS)		+= mxs_timer.o
 obj-$(CONFIG_CLKSRC_PXA)	+= pxa_timer.o
 obj-$(CONFIG_ARCH_PRIMA2)	+= timer-prima2.o
-- 
1.9.1
