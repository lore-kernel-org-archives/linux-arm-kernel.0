From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 17 Sep 2015 21:38:55 +0200
Subject: [RFC PATCH 2/2] arm64: errata: add module load workaround for erratum
 #843419
In-Reply-To: <1442518735-16625-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1442518735-16625-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1442518735-16625-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to work around Cortex-A35 erratum #843419, this patch updates
the module loading logic to either change potentially problematic adrp
instructions into adr instructions (if the symbol turns out to be in
range), or emit a veneer that is guaranteed to be at an offset that does
not trigger the issue.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig               | 17 ++++++++++
 arch/arm64/include/asm/veneers.h | 19 +++++++++++
 arch/arm64/kernel/module.c       | 33 +++++++++++++++++++
 arch/arm64/kernel/veneers.c      | 34 ++++++++++++++++++++
 4 files changed, 103 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 115586d8299b..57e45e77d7e3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -338,6 +338,23 @@ config ARM64_MODULE_VENEERS
 	bool
 	depends on MODULES
 
+config ARM64_ERRATUM_843419
+	bool "Cortex-A53: 843419: A load or store might access an incorrect address"
+	depends on MODULES
+	select ARM64_MODULE_VENEERS
+	default y
+	help
+	  This option builds kernel modules using the large memory model in
+	  order to avoid the use of the ADRP instruction, which can cause
+	  a subsequent memory access to use an incorrect address on Cortex-A53
+	  parts up to r0p4.
+
+	  Note that the kernel itself must be linked with a version of ld
+	  which fixes potentially affected ADRP instructions through the
+	  use of veneers.
+
+	  If unsure, say Y.
+
 choice
 	prompt "Page size"
 	default ARM64_4K_PAGES
diff --git a/arch/arm64/include/asm/veneers.h b/arch/arm64/include/asm/veneers.h
new file mode 100644
index 000000000000..4ee6efe4f5a1
--- /dev/null
+++ b/arch/arm64/include/asm/veneers.h
@@ -0,0 +1,19 @@
+
+#include <linux/types.h>
+
+struct veneer_erratum_843419 {
+	u32	adrp;
+	u32	branch;
+};
+
+static inline bool erratum_843419_affects_adrp_insn(void *addr)
+{
+	/*
+	 * The workaround for erratum 843419 only needs to be
+	 * applied if the adrp instruction appears in either of
+	 * the last two instruction slots in the 4 KB page.
+	 */
+	return ((u64)addr % SZ_4K) >= (SZ_4K - 8);
+}
+
+void *emit_erratum_843419_veneer(struct module *mod, u32 *insn);
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 67bf4107f6ef..5307d08f15e8 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -28,6 +28,7 @@
 #include <asm/alternative.h>
 #include <asm/insn.h>
 #include <asm/sections.h>
+#include <asm/veneers.h>
 
 #define	AARCH64_INSN_IMM_MOVNZ		AARCH64_INSN_IMM_MAX
 #define	AARCH64_INSN_IMM_MOVK		AARCH64_INSN_IMM_16
@@ -335,6 +336,38 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 		case R_AARCH64_ADR_PREL_PG_HI21_NC:
 			overflow_check = false;
 		case R_AARCH64_ADR_PREL_PG_HI21:
+#ifdef CONFIG_ARM64_ERRATUM_843419
+			/*
+			 * TODO check for presence of affected A53 cores
+			 */
+			if (erratum_843419_affects_adrp_insn(loc)) {
+				struct veneer_erratum_843419 *v;
+
+				/*
+				 * This adrp instruction appears at an offset
+				 * that may be problematic on older Cortex-A53
+				 * cores. So first, try to convert it into a
+				 * simple adr instruction.
+				 */
+				ovf = reloc_insn_imm(RELOC_OP_PREL, loc,
+						     val & ~(SZ_4K - 1), 0, 21,
+						     AARCH64_INSN_IMM_ADR);
+				if (ovf == 0) {
+					/* success! convert adrp -> adr */
+					*(u32 *)loc &= 0x7fffffff;
+					break;
+				} else {
+					/* symbol out of range -> emit veneer */
+					v = emit_erratum_843419_veneer(me, loc);
+					*(u32 *)loc = aarch64_insn_gen_branch_imm(
+						      (unsigned long)loc,
+						      (unsigned long)v,
+						      AARCH64_INSN_BRANCH_NOLINK);
+					loc = &v->adrp;
+				}
+				/* fall through */
+			}
+#endif
 			ovf = reloc_insn_imm(RELOC_OP_PAGE, loc, val, 12, 21,
 					     AARCH64_INSN_IMM_ADR);
 			break;
diff --git a/arch/arm64/kernel/veneers.c b/arch/arm64/kernel/veneers.c
index 0a33a63a9b46..1b708d6a021a 100644
--- a/arch/arm64/kernel/veneers.c
+++ b/arch/arm64/kernel/veneers.c
@@ -10,6 +10,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 
+#include <asm/veneers.h>
+
 static bool in_init(const struct module *mod, u64 addr)
 {
 	return addr - (u64)mod->module_init < mod->init_size;
@@ -31,6 +33,30 @@ static void __maybe_unused *alloc_veneer(struct module *mod, u64 loc, int size)
 	return ret;
 }
 
+#ifdef CONFIG_ARM64_ERRATUM_843419
+void *emit_erratum_843419_veneer(struct module *mod, u32 *insn)
+{
+	struct veneer_erratum_843419 *veneer;
+
+	veneer = alloc_veneer(mod, (u64)insn, 2 * sizeof(*veneer));
+	if (erratum_843419_affects_adrp_insn(&veneer->adrp))
+		/*
+		 * We allocated a veneer that is susceptible to the same problem
+		 * as the original location. We allocated twice the space, so
+		 * just advance to the next slot.
+		 */
+		veneer++;
+
+	veneer->adrp = *insn;
+	veneer->branch = aarch64_insn_gen_branch_imm(
+				(unsigned long)&veneer->branch,
+				(unsigned long)(insn + 1),
+				AARCH64_INSN_BRANCH_NOLINK);
+
+	return veneer;
+}
+#endif
+
 /* estimate the maximum size of the veneer for this relocation */
 static unsigned long get_veneers_size(Elf64_Addr base, const Elf64_Rel *rel,
 				      int num)
@@ -40,6 +66,14 @@ static unsigned long get_veneers_size(Elf64_Addr base, const Elf64_Rel *rel,
 
 	for (i = 0; i < num; i++)
 		switch (ELF64_R_TYPE(rel[i].r_info)) {
+		case R_AARCH64_ADR_PREL_PG_HI21_NC:
+		case R_AARCH64_ADR_PREL_PG_HI21:
+#ifdef CONFIG_ARM64_ERRATUM_843419
+			if (erratum_843419_affects_adrp_insn((void *)base +
+							     rel[i].r_offset))
+				ret += 2 * sizeof(struct veneer_erratum_843419);
+#endif
+			break;
 		}
 	return ret;
 }
-- 
1.9.1
