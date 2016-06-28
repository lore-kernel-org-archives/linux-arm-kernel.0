From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 28 Jun 2016 12:51:45 +0200
Subject: [PATCH 87/92] clocksource/drivers/keystone: Add the COMPILE_TEST
 option
In-Reply-To: <1467111111-12587-1-git-send-email-daniel.lezcano@linaro.org>
References: <577251A4.7030508@linaro.org>
 <1467111111-12587-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467111111-12587-12-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the Kconfig option logic to fullfil with the current approach.

A new Kconfig option is added, CONFIG_KEYSTONE_TIMER and is selected by the
platform. Then the clocksource's Kconfig is changed to make this option
selectable by the user if the COMPILE_TEST option is set. Otherwise, it is
up to the platform's Kconfig to select the timer.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-keystone/Kconfig | 2 +-
 drivers/clocksource/Kconfig    | 8 ++++++++
 drivers/clocksource/Makefile   | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index ea955f6db..bac577b 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -4,7 +4,7 @@ config ARCH_KEYSTONE
 	depends on ARM_PATCH_PHYS_VIRT
 	select ARM_GIC
 	select HAVE_ARM_ARCH_TIMER
-	select CLKSRC_MMIO
+	select KEYSTONE_TIMER
 	select ARM_ERRATA_798181 if SMP
 	select COMMON_CLK_KEYSTONE
 	select ARCH_SUPPORTS_BIG_ENDIAN
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 0cfc4bf..7e5709a 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -206,6 +206,14 @@ config NSPIRE_TIMER
 	help
 	  Enables support for the Nspire timer.
 
+config KEYSTONE_TIMER
+	bool "Keystone timer driver" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
+	depends on ARM || ARM64
+	select CLKSRC_MMIO
+	help
+	  Enables support for the Keystone timer.
+
 config CLKSRC_DBX500_PRCMU_SCHED_CLOCK
 	bool "Clocksource PRCMU Timer sched_clock"
 	depends on (CLKSRC_DBX500_PRCMU && !CLKSRC_NOMADIK_MTU_SCHED_CLOCK)
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index d888c98..a818431 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -56,7 +56,7 @@ obj-$(CONFIG_ARMV7M_SYSTICK)		+= armv7m_systick.o
 obj-$(CONFIG_ARM_TIMER_SP804)		+= timer-sp804.o
 obj-$(CONFIG_CLKSRC_METAG_GENERIC)	+= metag_generic.o
 obj-$(CONFIG_ARCH_HAS_TICK_BROADCAST)	+= dummy_timer.o
-obj-$(CONFIG_ARCH_KEYSTONE)		+= timer-keystone.o
+obj-$(CONFIG_KEYSTONE_TIMER)		+= timer-keystone.o
 obj-$(CONFIG_ARCH_INTEGRATOR_AP)	+= timer-integrator-ap.o
 obj-$(CONFIG_CLKSRC_VERSATILE)		+= versatile.o
 obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
-- 
1.9.1
