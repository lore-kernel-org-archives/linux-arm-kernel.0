From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 28 Jun 2016 12:51:46 +0200
Subject: [PATCH 88/92] clocksource/drivers/integrator-ap: Add the COMPILE_TEST
 option
In-Reply-To: <1467111111-12587-1-git-send-email-daniel.lezcano@linaro.org>
References: <577251A4.7030508@linaro.org>
 <1467111111-12587-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467111111-12587-13-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the Kconfig option logic to fullfil with the current approach.

A new Kconfig option is added, CONFIG_INTEGRATOR_AP_TIMER and is selected
by the platform. Then the clocksource's Kconfig is changed to make this
option selectable by the user if the COMPILE_TEST option is set. Otherwise,
it is up to the platform's Kconfig to select the timer.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-integrator/Kconfig | 2 +-
 drivers/clocksource/Kconfig      | 7 +++++++
 drivers/clocksource/Makefile     | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index b2a85ba..291262e 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -20,7 +20,7 @@ if ARCH_INTEGRATOR
 
 config ARCH_INTEGRATOR_AP
 	bool "Support Integrator/AP and Integrator/PP2 platforms"
-	select CLKSRC_MMIO
+	select INTEGRATOR_AP_TIMER
 	select MIGHT_HAVE_PCI
 	select SERIAL_AMBA_PL010 if TTY
 	select SERIAL_AMBA_PL010_CONSOLE if TTY
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 7e5709a..8055b37 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -214,6 +214,13 @@ config KEYSTONE_TIMER
 	help
 	  Enables support for the Keystone timer.
 
+config INTEGRATOR_AP_TIMER
+	bool "Integrator-ap timer driver" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
+	select CLKSRC_MMIO
+	help
+	  Enables support for the Integrator-ap timer.
+
 config CLKSRC_DBX500_PRCMU_SCHED_CLOCK
 	bool "Clocksource PRCMU Timer sched_clock"
 	depends on (CLKSRC_DBX500_PRCMU && !CLKSRC_NOMADIK_MTU_SCHED_CLOCK)
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index a818431..fd9d6df 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -57,7 +57,7 @@ obj-$(CONFIG_ARM_TIMER_SP804)		+= timer-sp804.o
 obj-$(CONFIG_CLKSRC_METAG_GENERIC)	+= metag_generic.o
 obj-$(CONFIG_ARCH_HAS_TICK_BROADCAST)	+= dummy_timer.o
 obj-$(CONFIG_KEYSTONE_TIMER)		+= timer-keystone.o
-obj-$(CONFIG_ARCH_INTEGRATOR_AP)	+= timer-integrator-ap.o
+obj-$(CONFIG_INTEGRATOR_AP_TIMER)	+= timer-integrator-ap.o
 obj-$(CONFIG_CLKSRC_VERSATILE)		+= versatile.o
 obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
 obj-$(CONFIG_CLKSRC_TANGO_XTAL)		+= tango_xtal.o
-- 
1.9.1
