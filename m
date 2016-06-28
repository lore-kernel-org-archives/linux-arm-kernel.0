From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 28 Jun 2016 12:51:43 +0200
Subject: [PATCH 85/92] clocksource/drivers/u300: Add the COMPILE_TEST option
In-Reply-To: <1467111111-12587-1-git-send-email-daniel.lezcano@linaro.org>
References: <577251A4.7030508@linaro.org>
 <1467111111-12587-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467111111-12587-10-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the Kconfig option logic to fullfil with the current approach.

A new Kconfig option is added, CONFIG_U300_TIMER and is selected by the
platform. Then the clocksource's Kconfig is changed to make this option
selectable by the user if the COMPILE_TEST option is set. Otherwise, it is
up to the platform's Kconfig to select the timer.

Due on the delay specific code, this driver will compile only on the ARM
architecture.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-u300/Kconfig   | 2 +-
 drivers/clocksource/Kconfig  | 8 ++++++++
 drivers/clocksource/Makefile | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-u300/Kconfig b/arch/arm/mach-u300/Kconfig
index 301a984..4fdc342 100644
--- a/arch/arm/mach-u300/Kconfig
+++ b/arch/arm/mach-u300/Kconfig
@@ -4,7 +4,7 @@ menuconfig ARCH_U300
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select ARM_VIC
-	select CLKSRC_MMIO
+	select U300_TIMER
 	select CPU_ARM926T
 	select HAVE_TCM
 	select PINCTRL
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index c350fbd..d425f80 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -191,6 +191,14 @@ config PRIMA2_TIMER
 	help
 	  Enables support for the Prima2 timer.
 
+config U300_TIMER
+	bool "U300 timer driver" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
+	depends on ARM
+	select CLKSRC_MMIO
+	help
+	  Enables support for the U300 timer.
+
 config CLKSRC_DBX500_PRCMU_SCHED_CLOCK
 	bool "Clocksource PRCMU Timer sched_clock"
 	depends on (CLKSRC_DBX500_PRCMU && !CLKSRC_NOMADIK_MTU_SCHED_CLOCK)
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index b419d5d..adbc3a8 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -26,7 +26,7 @@ obj-$(CONFIG_MOXART_TIMER)	+= moxart_timer.o
 obj-$(CONFIG_MXS_TIMER)		+= mxs_timer.o
 obj-$(CONFIG_CLKSRC_PXA)	+= pxa_timer.o
 obj-$(CONFIG_PRIMA2_TIMER)	+= timer-prima2.o
-obj-$(CONFIG_ARCH_U300)		+= timer-u300.o
+obj-$(CONFIG_U300_TIMER)	+= timer-u300.o
 obj-$(CONFIG_SUN4I_TIMER)	+= sun4i_timer.o
 obj-$(CONFIG_SUN5I_HSTIMER)	+= timer-sun5i.o
 obj-$(CONFIG_MESON6_TIMER)	+= meson6_timer.o
-- 
1.9.1
