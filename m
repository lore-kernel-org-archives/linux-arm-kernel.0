From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu,  2 Jun 2016 23:41:36 +0200
Subject: [PATCH 5/6] clocksource/drivers/bcm_kona: Add the COMPILE_TEST option
In-Reply-To: <1464903697-3802-1-git-send-email-daniel.lezcano@linaro.org>
References: <1464903697-3802-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1464903697-3802-5-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the Kconfig option logic to fullfil with the current approach.

A new Kconfig option is added, CONFIG_BCM_KONA_TIMER and is selected by the
platform. Then the clocksource's Kconfig is changed to make this option
selectable by the user if the COMPILE_TEST option is set. Otherwise, it is
up to the platform's Kconfig to select the timer.

The timer uses <asm/mach/time.h>, which is now only for ARM, so this
driver will depend on ARM.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-bcm/Kconfig    | 1 +
 drivers/clocksource/Kconfig  | 7 +++++++
 drivers/clocksource/Makefile | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index b7414df..e32ef5b 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -89,6 +89,7 @@ config ARCH_BCM_MOBILE
 	select HAVE_ARM_ARCH_TIMER
 	select PINCTRL
 	select ARCH_BCM_MOBILE_SMP if SMP
+	select BCM_KONA_TIMER
 	help
 	  This enables support for systems based on Broadcom mobile SoCs.
 
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a1e0cf9..6714a22 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -34,6 +34,13 @@ config BCM2835_TIMER
 	help
 	  Enables the support for the BCM2835 timer driver.
 
+config BCM_KONA_TIMER
+	bool "BCM mobile timer driver" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
+	select CLKSRC_MMIO
+	help
+	  Enables the support for the BCM Kona mobile timer driver.
+
 config DIGICOLOR_TIMER
 	bool "Digicolor timer driver" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 6e278d4..662a87c 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -33,7 +33,7 @@ obj-$(CONFIG_MESON6_TIMER)	+= meson6_timer.o
 obj-$(CONFIG_TEGRA_TIMER)	+= tegra20_timer.o
 obj-$(CONFIG_VT8500_TIMER)	+= vt8500_timer.o
 obj-$(CONFIG_ARCH_NSPIRE)	+= zevio-timer.o
-obj-$(CONFIG_ARCH_BCM_MOBILE)	+= bcm_kona_timer.o
+obj-$(CONFIG_BCM_KONA_TIMER)	+= bcm_kona_timer.o
 obj-$(CONFIG_CADENCE_TTC_TIMER)	+= cadence_ttc_timer.o
 obj-$(CONFIG_CLKSRC_EFM32)	+= time-efm32.o
 obj-$(CONFIG_CLKSRC_STM32)	+= timer-stm32.o
-- 
1.9.1
