From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Sep 2015 12:16:37 +0100
Subject: [PATCH] arm64: errata: add module build workaround for erratum #843419
Message-ID: <1442402197-20306-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cortex-A53 processors <= r0p4 are affected by erratum #843419 which can
lead to a memory access using an incorrect address in certain sequences
headed by an ADRP instruction.

There is a linker fix to generate veneers for ADRP instructions, but
this doesn't work for kernel modules which are built as unlinked ELF
objects.

This patch adds a new config option for the erratum which, when enabled,
builds kernel modules with the mcmodel=large flag. This uses absolute
addressing for all kernel symbols, thereby removing the use of ADRP as
a PC-relative form of addressing. The ADRP relocs are removed from the
module loader so that we fail to load any potentially affected modules.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig         | 16 ++++++++++++++++
 arch/arm64/Makefile        |  4 ++++
 arch/arm64/kernel/module.c |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7d95663c0160..11ff4d57c92a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -331,6 +331,22 @@ config ARM64_ERRATUM_845719
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_843419
+	bool "Cortex-A53: 843419: A load or store might access an incorrect address"
+	depends on MODULES
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
 endmenu
 
 
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 15ff5b4156fd..f9914d7c1bb0 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -41,6 +41,10 @@ endif
 
 CHECKFLAGS	+= -D__aarch64__
 
+ifeq ($(CONFIG_ARM64_ERRATUM_843419), y)
+CFLAGS_MODULE	+= -mcmodel=large
+endif
+
 # Default value
 head-y		:= arch/arm64/kernel/head.o
 
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 67bf4107f6ef..876eb8df50bf 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -332,12 +332,14 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			ovf = reloc_insn_imm(RELOC_OP_PREL, loc, val, 0, 21,
 					     AARCH64_INSN_IMM_ADR);
 			break;
+#ifndef CONFIG_ARM64_ERRATUM_843419
 		case R_AARCH64_ADR_PREL_PG_HI21_NC:
 			overflow_check = false;
 		case R_AARCH64_ADR_PREL_PG_HI21:
 			ovf = reloc_insn_imm(RELOC_OP_PAGE, loc, val, 12, 21,
 					     AARCH64_INSN_IMM_ADR);
 			break;
+#endif
 		case R_AARCH64_ADD_ABS_LO12_NC:
 		case R_AARCH64_LDST8_ABS_LO12_NC:
 			overflow_check = false;
-- 
2.1.4
