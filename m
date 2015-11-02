From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon,  2 Nov 2015 13:56:47 +0100
Subject: [PATCH 19/22] clocksource/drivers/prcmu: Fix Kconfig and add
 COMPILE_TEST option
In-Reply-To: <1446469011-22710-1-git-send-email-daniel.lezcano@linaro.org>
References: <1446469011-22710-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1446469011-22710-19-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the platform's Kconfig to select the clock instead of having a reverse
dependency from the driver to the platform options.

Add the COMPILE_TEST option for the compilation test coverage.

This change is debatable as the option itself in the Kconfig allows to
select the driver for the platform or not. This change will make the prcmu
timer always selected.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-ux500/Kconfig | 1 +
 drivers/clocksource/Kconfig | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index c9ac19b..5eacdd6 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -32,6 +32,7 @@ config UX500_SOC_DB8500
 	select PINCTRL_AB8540
 	select REGULATOR
 	select REGULATOR_DB8500_PRCMU
+	select CLKSRC_DBX500_PRCMU
 	select PM_GENERIC_DOMAINS if PM
 
 config MACH_MOP500
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 17674b4..916c36d 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -114,9 +114,7 @@ config CLKSRC_NOMADIK_MTU_SCHED_CLOCK
 	  Use the Multi Timer Unit as the sched_clock.
 
 config CLKSRC_DBX500_PRCMU
-	bool "Clocksource PRCMU Timer"
-	depends on UX500_SOC_DB8500
-	default y
+	bool "Clocksource PRCMU Timer" if COMPILE_TEST
 	help
 	  Use the always on PRCMU Timer as clocksource
 
-- 
1.9.1
