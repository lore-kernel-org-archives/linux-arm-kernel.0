From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu,  2 Jun 2016 23:41:34 +0200
Subject: [PATCH 3/6] clocksource/drivers/bcm2835: Add the COMPILE_TEST option
In-Reply-To: <1464903697-3802-1-git-send-email-daniel.lezcano@linaro.org>
References: <1464903697-3802-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1464903697-3802-3-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the Kconfig option logic to fullfil with the current approach.

A new Kconfig option is added, CONFIG_BCM2835_TIMER and is selected by the
platform. Then the clocksource's Kconfig is changed to make this option
selectable by the user if the COMPILE_TEST option is set. Otherwise, it
is up to the platform's Kconfig to select the timer.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-bcm/Kconfig    | 1 +
 drivers/clocksource/Kconfig  | 7 +++++++
 drivers/clocksource/Makefile | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 7ef1214..b7414df 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -143,6 +143,7 @@ config ARCH_BCM2835
 	select ARM_TIMER_SP804
 	select HAVE_ARM_ARCH_TIMER if ARCH_MULTI_V7
 	select CLKSRC_OF
+	select BCM2835_TIMER
 	select PINCTRL
 	select PINCTRL_BCM2835
 	help
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 6ff327a..34053ab 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -27,6 +27,13 @@ config CLKBLD_I8253
 config CLKSRC_MMIO
 	bool
 
+config BCM2835_TIMER
+	bool "BCM2835 timer driver" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
+	select CLKSRC_MMIO
+	help
+	  Enables the support for the BCM2835 timer driver.
+
 config DIGICOLOR_TIMER
 	bool "Digicolor timer driver" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index b0a3c96..6e278d4 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -19,7 +19,7 @@ obj-$(CONFIG_CLKSRC_NOMADIK_MTU)	+= nomadik-mtu.o
 obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
 obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
 obj-$(CONFIG_ORION_TIMER)	+= time-orion.o
-obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
+obj-$(CONFIG_BCM2835_TIMER)	+= bcm2835_timer.o
 obj-$(CONFIG_ARCH_CLPS711X)	+= clps711x-timer.o
 obj-$(CONFIG_ARCH_ATLAS7)	+= timer-atlas7.o
 obj-$(CONFIG_ARCH_MOXART)	+= moxart_timer.o
-- 
1.9.1
