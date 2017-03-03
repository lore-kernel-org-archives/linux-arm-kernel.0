From: timur@codeaurora.org (Timur Tabi)
Date: Thu,  2 Mar 2017 18:19:15 -0600
Subject: [PATCH] arm64: mm: Add workaround for Qualcomm Technologies Falkor
 erratum E1029
Message-ID: <1488500355-7199-1-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Neil Leeder <nleeder@codeaurora.org>

The Falkor core includes support for generating interrupt requests from
CPU or L2 performance monitor events or cycle counter overflows,
resulting in an IRQ or FIQ asynchronous interrupt request.  In cases
where the CPU performance monitor interrupt request is generated in
close proximity to the instruction stream executing a WFI or WFE
instruction, the Falkor core may hang prior to entering the wait
state.

The workaround for this condition is to add a config option and
alternative_if processing in cpu_do_idle. For falkor v1 processors
this will read PMINTENSET (PMU interrupt enabled register), clear all
enabled interrupts by writing to PMINTENCLR, go into wfi
as usual and then restore the PMU interrupts.

For processors other than Falkor v1, these instructions are
replaced by nops.

Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 arch/arm64/Kconfig               |  8 ++++++++
 arch/arm64/include/asm/cpucaps.h |  3 ++-
 arch/arm64/kernel/cpu_errata.c   | 22 ++++++++++++++++++++++
 arch/arm64/mm/proc.S             | 24 +++++++++++++++++++++++-
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a39029b..4168583 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -508,6 +508,14 @@ config QCOM_FALKOR_ERRATUM_1009
 
 	  If unsure, say Y.
 
+config QCOM_FALKOR_ERRATUM_E1029
+	depends on PERF_EVENTS
+	bool "Falkor E1029: PMU interrupt during WFI may cause hang"
+	default y
+	help
+	  Falkor CPU may hang if PMU interrupt occurs during WFI.
+	  Turn off PMU interrupts during WFI in idle routine.
+
 endmenu
 
 
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index fb78a5d..86f5042 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -37,7 +37,8 @@
 #define ARM64_HAS_NO_FPSIMD			16
 #define ARM64_WORKAROUND_REPEAT_TLBI		17
 #define ARM64_WORKAROUND_QCOM_FALKOR_E1003	18
+#define ARM64_WORKAROUND_QCOM_FALKOR_E1029	19
 
-#define ARM64_NCAPS				19
+#define ARM64_NCAPS				20
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index f6cc67e..3e9fdbf 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -20,6 +20,7 @@
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/cpufeature.h>
+#include <asm/virt.h>
 
 static bool __maybe_unused
 is_affected_midr_range(const struct arm64_cpu_capabilities *entry, int scope)
@@ -46,6 +47,16 @@ static int cpu_enable_trap_ctr_access(void *__unused)
 	return 0;
 }
 
+#ifdef CONFIG_QCOM_FALKOR_ERRATUM_E1029
+static bool __maybe_unused
+ckeck_falkor_erratum_e1029(const struct arm64_cpu_capabilities *e, int scope)
+{
+	bool in_hyp = is_hyp_mode_available();
+
+	return in_hyp ? is_affected_midr_range(e, scope) : false;
+}
+#endif
+
 #define MIDR_RANGE(model, min, max) \
 	.def_scope = SCOPE_LOCAL_CPU, \
 	.matches = is_affected_midr_range, \
@@ -151,6 +162,17 @@ static int cpu_enable_trap_ctr_access(void *__unused)
 			   MIDR_CPU_VAR_REV(0, 0)),
 	},
 #endif
+#ifdef CONFIG_QCOM_FALKOR_ERRATUM_E1029
+	{
+		.desc = "Qualcomm Technologies Falkor erratum 1029",
+		.capability = ARM64_WORKAROUND_QCOM_FALKOR_E1029,
+		.def_scope = SCOPE_LOCAL_CPU,
+		.matches = ckeck_falkor_erratum_e1029,
+		.midr_model = MIDR_QCOM_FALKOR_V1,
+		.midr_range_min = 0x00,
+		.midr_range_max = 0x00
+	},
+#endif
 	{
 	}
 };
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 877d42f..04027f7 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -49,9 +49,31 @@
  *	Idle the processor (wait for interrupt).
  */
 ENTRY(cpu_do_idle)
-	dsb	sy				// WFI may enter a low-power mode
+#ifndef CONFIG_QCOM_FALKOR_ERRATUM_E1029
+	dsb	sy			// WFI may enter a low-power mode
 	wfi
 	ret
+#else
+alternative_if_not ARM64_WORKAROUND_QCOM_FALKOR_E1029
+	dsb	sy			// WFI may enter a low-power mode
+	wfi
+	ret
+	nop
+	nop
+	nop
+	nop
+	nop
+alternative_else
+	mrs	x2, pmintenset_el1
+	msr	pmintenclr_el1, x2
+	isb
+	dsb	sy			// WFI may enter a low-power mode
+	wfi
+	msr	pmintenset_el1, x2
+	isb
+	ret
+alternative_endif
+#endif
 ENDPROC(cpu_do_idle)
 
 #ifdef CONFIG_CPU_PM
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
