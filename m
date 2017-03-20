From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 20 Mar 2017 17:48:27 +0000
Subject: [PATCH v2 16/18] arm64: arch_timer: Workaround for Cortex-A73 erratum
 858921
In-Reply-To: <20170320174829.28182-1-marc.zyngier@arm.com>
References: <20170320174829.28182-1-marc.zyngier@arm.com>
Message-ID: <20170320174829.28182-17-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cortex-A73 (all versions) counter read can return a wrong value
when the counter crosses a 32bit boundary.

The workaround involves performing the read twice, and to return
one or the other depending on whether a transition has taken place.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/clocksource/Kconfig          | 11 +++++++++++
 drivers/clocksource/arm_arch_timer.c | 19 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 3356ab821624..af80a7c44faf 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -366,6 +366,17 @@ config HISILICON_ERRATUM_161010101
 	  161010101. The workaround will be active if the hisilicon,erratum-161010101
 	  property is found in the timer node.
 
+config ARM64_ERRATUM_858921
+	bool "Workaround for Cortex-A73 erratum 858921"
+	default y
+	select ARM_ARCH_TIMER_OOL_WORKAROUND
+	depends on ARM_ARCH_TIMER && ARM64
+	help
+	  This option enables a workaround applicable to Cortex-A73
+	  (all versions), whose counter may return incorrect values.
+	  The workaround will be dynamically enabled when an affected
+	  core is detected.
+
 config ARM_GLOBAL_TIMER
 	bool "Support for the ARM global timer" if COMPILE_TEST
 	select CLKSRC_OF if OF
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index eccff0fedf2c..ba4be5859aa4 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -266,6 +266,17 @@ static u64 notrace hisi_161010101_read_cntvct_el0(void)
 }
 #endif
 
+#ifdef CONFIG_ARM64_ERRATUM_858921
+static u64 notrace arm64_858921_read_cntvct_el0(void)
+{
+	u64 old, new;
+
+	old = read_sysreg(cntvct_el0);
+	new = read_sysreg(cntvct_el0);
+	return (((old ^ new) >> 32) & 1) ? old : new;
+}
+#endif
+
 #ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
 DEFINE_PER_CPU(const struct arch_timer_erratum_workaround *,
 	       timer_unstable_counter_workaround);
@@ -331,6 +342,14 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.set_next_event_virt = erratum_set_next_event_tval_virt,
 	},
 #endif
+#ifdef CONFIG_ARM64_ERRATUM_858921
+	{
+		.match_type = ate_match_local_cap_id,
+		.id = (void *)ARM64_WORKAROUND_858921,
+		.desc = "ARM erratum 858921",
+		.read_cntvct_el0 = arm64_858921_read_cntvct_el0,
+	},
+#endif
 };
 
 typedef bool (*ate_match_fn_t)(const struct arch_timer_erratum_workaround *,
-- 
2.11.0
