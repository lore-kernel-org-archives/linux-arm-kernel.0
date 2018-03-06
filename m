From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  6 Mar 2018 17:15:35 +0000
Subject: [PATCH v4 5/5] arm64/kernel: enable A53 erratum #8434319 handling at
 runtime
In-Reply-To: <20180306171535.25681-1-ard.biesheuvel@linaro.org>
References: <20180306171535.25681-1-ard.biesheuvel@linaro.org>
Message-ID: <20180306171535.25681-6-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Omit patching of ADRP instruction at module load time if the current
CPUs are not susceptible to the erratum.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/cpucaps.h |  3 ++-
 arch/arm64/kernel/cpu_errata.c   | 10 ++++++++++
 arch/arm64/kernel/module-plts.c  |  3 ++-
 arch/arm64/kernel/module.c       |  1 +
 4 files changed, 15 insertions(+), 2 deletions(-)

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
index b161abdd6e27..e18023e5deb9 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -298,6 +298,16 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 			   MIDR_CPU_VAR_REV(1, 2)),
 	},
 #endif
+#ifdef CONFIG_ARM64_ERRATUM_843419
+	{
+	/* Cortex-A53 r0p[01234] */
+		.desc = "ARM erratum 843419",
+		.capability = ARM64_WORKAROUND_843419,
+		.def_scope = SCOPE_LOCAL_CPU,
+		MIDR_RANGE(MIDR_CORTEX_A53, 0x00, 0x04),
+		MIDR_FIXED(0x4, BIT(8)),
+	},
+#endif
 #ifdef CONFIG_ARM64_ERRATUM_845719
 	{
 	/* Cortex-A53 r0p[01234] */
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index 534bf1d47119..1a583ccace00 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -158,7 +158,8 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
 			break;
 		case R_AARCH64_ADR_PREL_PG_HI21_NC:
 		case R_AARCH64_ADR_PREL_PG_HI21:
-			if (!IS_ENABLED(CONFIG_ARM64_ERRATUM_843419))
+			if (!IS_ENABLED(CONFIG_ARM64_ERRATUM_843419) ||
+			    !cpus_have_const_cap(ARM64_WORKAROUND_843419))
 				break;
 
 			/*
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 89217704944e..47b40aaa1a5d 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -201,6 +201,7 @@ static int reloc_insn_imm(enum aarch64_reloc_op op, __le32 *place, u64 val,
 static int reloc_insn_adrp(struct module *mod, __le32 *place, u64 val)
 {
 	if (!IS_ENABLED(CONFIG_ARM64_ERRATUM_843419) ||
+	    !cpus_have_const_cap(ARM64_WORKAROUND_843419) ||
 	    ((u64)place & 0xfff) < 0xff8)
 		return reloc_insn_imm(RELOC_OP_PAGE, place, val, 12, 21,
 				      AARCH64_INSN_IMM_ADR);
-- 
2.11.0
