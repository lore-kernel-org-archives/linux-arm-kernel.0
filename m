From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  6 Mar 2017 11:26:20 +0000
Subject: [PATCH 15/17] arm64: arch_timer: Workaround for Cortex-A73 erratum
 858921
In-Reply-To: <20170306112622.13853-1-marc.zyngier@arm.com>
References: <20170306112622.13853-1-marc.zyngier@arm.com>
Message-ID: <20170306112622.13853-16-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cortex-A73 (all versions) counter read can return a wrong value
when the counter crosses a 32bit boundary.

The workaround involves performing the read twice, and to return
one or the other depending on whether a transition has taken place.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/include/asm/cpucaps.h       |  3 ++-
 arch/arm64/kernel/cpu_errata.c         |  8 ++++++++
 drivers/clocksource/Kconfig            | 11 +++++++++++
 drivers/clocksource/arm_arch_timer.c   | 19 +++++++++++++++++++
 5 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index a71b8095dbd8..e0b51bdef445 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -54,6 +54,7 @@ stable kernels.
 | ARM            | Cortex-A57      | #852523         | N/A                         |
 | ARM            | Cortex-A57      | #834220         | ARM64_ERRATUM_834220        |
 | ARM            | Cortex-A72      | #853709         | N/A                         |
+| ARM            | Cortex-A73      | #858921         | ARM64_ERRATUM_858921        |
 | ARM            | MMU-500         | #841119,#826419 | N/A                         |
 |                |                 |                 |                             |
 | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375        |
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index fb78a5d3b60b..b3aab8a17868 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -37,7 +37,8 @@
 #define ARM64_HAS_NO_FPSIMD			16
 #define ARM64_WORKAROUND_REPEAT_TLBI		17
 #define ARM64_WORKAROUND_QCOM_FALKOR_E1003	18
+#define ARM64_WORKAROUND_858921			19
 
-#define ARM64_NCAPS				19
+#define ARM64_NCAPS				20
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 2be1d1c05303..2ed2a7657711 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -158,6 +158,14 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 			   MIDR_CPU_VAR_REV(0, 0)),
 	},
 #endif
+#ifdef CONFIG_ARM64_ERRATUM_858921
+	{
+	/* Cortex-A73 all versions */
+		.desc = "ARM erratum 858921",
+		.capability = ARM64_WORKAROUND_858921,
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
+	},
+#endif
 	{
 	}
 };
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
index 8e3638397347..4eb1109da330 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -266,6 +266,17 @@ static u64 notrace hisi_161010101_read_cntvct_el0(void)
 }
 #endif
 
+#ifdef CONFIG_ARM64_ERRATUM_858921
+static u64 notrace arm64_858921_read_cntvct_el0(void)
+{
+	u64 _old, _new;
+
+	_old = read_sysreg(cntvct_el0);
+	_new = read_sysreg(cntvct_el0);
+	return (((_old ^ _new) >> 32) & 1) ? _old : _new;
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
+		.desc_str = "ARM erratum 858921",
+		.read_cntvct_el0 = arm64_858921_read_cntvct_el0,
+	},
+#endif
 };
 
 typedef bool (*ate_match_fn_t)(const struct arch_timer_erratum_workaround *,
-- 
2.11.0
