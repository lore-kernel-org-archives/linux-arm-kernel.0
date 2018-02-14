From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 14 Feb 2018 11:36:45 +0000
Subject: [RFC PATCH v3 3/3] arm64/kernel: enable A53 erratum #8434319 handling
 at runtime
In-Reply-To: <20180214113645.16793-1-ard.biesheuvel@linaro.org>
References: <20180214113645.16793-1-ard.biesheuvel@linaro.org>
Message-ID: <20180214113645.16793-4-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Omit patching of ADRP instruction at module load time if the current
CPUs are not susceptible to the erratum.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
Open question: how should we handle big.LITTLE configurations where affected
Cortex-A53s may appear late.

 arch/arm64/include/asm/cpucaps.h |  3 ++-
 arch/arm64/kernel/cpu_errata.c   | 26 ++++++++++++++++++++
 arch/arm64/kernel/module-plts.c  |  3 ++-
 arch/arm64/kernel/module.c       |  3 ++-
 4 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index bb263820de13..39134c46bb13 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -45,7 +45,8 @@
 #define ARM64_HARDEN_BRANCH_PREDICTOR		24
 #define ARM64_HARDEN_BP_POST_GUEST_EXIT		25
 #define ARM64_HAS_RAS_EXTN			26
+#define ARM64_WORKAROUND_843419			27
 
-#define ARM64_NCAPS				27
+#define ARM64_NCAPS				28
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 07823595b7f0..c065d5649b1b 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -228,6 +228,23 @@ static int qcom_enable_link_stack_sanitization(void *data)
 }
 #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
 
+static bool __maybe_unused
+needs_erratum_843419_workaround(const struct arm64_cpu_capabilities *entry,
+				int scope)
+{
+	u32 cpuid = read_cpuid_id();
+
+	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
+
+	if ((cpuid & MIDR_CPU_MODEL_MASK) != MIDR_CORTEX_A53)
+		return false;
+	else if ((cpuid & (MIDR_REVISION_MASK | MIDR_VARIANT_MASK)) == 0x4)
+		/* erratum was fixed in some versions of r0p4 */
+		return !(read_cpuid(REVIDR_EL1) & BIT(8));
+	else
+		return true;
+}
+
 #define MIDR_RANGE(model, min, max) \
 	.def_scope = SCOPE_LOCAL_CPU, \
 	.matches = is_affected_midr_range, \
@@ -283,6 +300,15 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 			   MIDR_CPU_VAR_REV(1, 2)),
 	},
 #endif
+#ifdef CONFIG_ARM64_ERRATUM_843419
+	{
+	/* Cortex-A53 r0p[01234] */
+		.desc = "ARM erratum 843419",
+		.capability = ARM64_WORKAROUND_843419,
+		.def_scope = SCOPE_LOCAL_CPU,
+		.matches = needs_erratum_843419_workaround,
+	},
+#endif
 #ifdef CONFIG_ARM64_ERRATUM_845719
 	{
 	/* Cortex-A53 r0p[01234] */
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index 93b808056cb4..0a208a49eb70 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -156,7 +156,8 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
 			break;
 		case R_AARCH64_ADR_PREL_PG_HI21_NC:
 		case R_AARCH64_ADR_PREL_PG_HI21:
-			if (!IS_ENABLED(CONFIG_ARM64_ERRATUM_843419))
+			if (!IS_ENABLED(CONFIG_ARM64_ERRATUM_843419) ||
+			    !cpus_have_const_cap(ARM64_WORKAROUND_843419))
 				break;
 
 			/*
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index d1bbdffd1e6c..5a05f84d575e 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -201,7 +201,8 @@ static int reloc_insn_imm(enum aarch64_reloc_op op, __le32 *place, u64 val,
 static bool reloc_adrp_erratum_843419(struct module *mod, __le32 *place,
 				      u64 val)
 {
-	if (!IS_ENABLED(CONFIG_ARM64_ERRATUM_843419))
+	if (!IS_ENABLED(CONFIG_ARM64_ERRATUM_843419) ||
+	    !cpus_have_const_cap(ARM64_WORKAROUND_843419))
 		return false;
 
 	/* only ADRP instructions at the end of a 4k page are affected */
-- 
2.11.0
