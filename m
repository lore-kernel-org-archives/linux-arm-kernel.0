From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 08 Oct 2018 14:50:06 +0200
Subject: [PATCH 4/7] clocksource: arch_timer: Add support for
 not-fw-configured timer on ARM64
In-Reply-To: <20181008125009.3721-1-m.szyprowski@samsung.com>
References: <20181008125009.3721-1-m.szyprowski@samsung.com>
 <CGME20181008125048eucas1p229a94c202596ddd0a65009c15d9e3001@eucas1p2.samsung.com>
Message-ID: <20181008125009.3721-5-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use common infrastructure for ARM Architected Timers erratum to enable
support for systems with broken CPU firmware (timer registers not
properly configured). This mode has been already availabled on ARM
(32bits) architecture. This enables to run Linux kernel on ARM64 boards
using physical architected timers instead of the virtual ones. Examples
of such system with broken firmware are Samsung Exynos5433 SoC based
TM2(e) boards, which is already deployed for years and updating firmware
is not possible.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clocksource/Kconfig          | 11 +++++++++++
 drivers/clocksource/arm_arch_timer.c | 15 ++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a11f4ba98b05..a30752579b03 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -364,6 +364,17 @@ config ARM64_ERRATUM_858921
 	  The workaround will be dynamically enabled when an affected
 	  core is detected.
 
+config ARCH_TIMER_REGISTERS_NOT_FW_CONFIGURED
+	bool "Workaround for arch timer registers not configured by firmware"
+	default y
+	select ARM_ARCH_TIMER_OOL_WORKAROUND
+	depends on ARM_ARCH_TIMER && ARM64
+	help
+	  This option enables a workaround for boards, on which arch timer
+	  registers are not properly configured by the board firmware.
+	  The workaround will be dynamically enabled when an affected
+	  board is detected.
+
 config ARM_GLOBAL_TIMER
 	bool "Support for the ARM global timer" if COMPILE_TEST
 	select TIMER_OF if OF
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9a7d4dc00b6e..b6f109654daf 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -423,6 +423,14 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.read_cntvct_el0 = arm64_1188873_read_cntvct_el0,
 	},
 #endif
+#ifdef CONFIG_ARCH_TIMER_REGISTERS_NOT_FW_CONFIGURED
+	{
+		.match_type = ate_match_dt,
+		.id = "arm,cpu-registers-not-fw-configured",
+		.desc = "broken CPU firmware (timer registers not configured)",
+		.read_cntvct_el0 = arch_counter_get_cntpct,
+	},
+#endif
 };
 
 typedef bool (*ate_match_fn_t)(const struct arch_timer_erratum_workaround *,
@@ -1234,9 +1242,10 @@ static int __init arch_timer_of_init(struct device_node *np)
 	 * If we cannot rely on firmware initializing the timer registers then
 	 * we should use the physical timers instead.
 	 */
-	if (IS_ENABLED(CONFIG_ARM) &&
-	    of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
-		arch_timer_uses_ppi = ARCH_TIMER_PHYS_SECURE_PPI;
+	if (of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
+		arch_timer_uses_ppi = IS_ENABLED(CONFIG_ARM64) ?
+					ARCH_TIMER_PHYS_NONSECURE_PPI :
+					ARCH_TIMER_PHYS_SECURE_PPI;
 	else
 		arch_timer_uses_ppi = arch_timer_select_ppi();
 
-- 
2.17.1
