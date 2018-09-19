From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 18 Sep 2018 23:51:39 -0700
Subject: [PATCH v3 4/9] x86: add support for 64-bit place relative relocations
In-Reply-To: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
References: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
Message-ID: <20180919065144.25010-5-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for R_X86_64_PC64 relocations, which operate on 64-bit
quantities holding a relative symbol reference. Also remove the
definition of R_X86_64_NUM: given that it is currently unused, it
is unclear what the new value should be.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/include/asm/elf.h |  3 +--
 arch/x86/kernel/module.c   |  6 ++++++
 arch/x86/tools/relocs.c    | 10 ++++++++++
 arch/x86/um/asm/elf.h      |  3 +--
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 0d157d2a1e2a..a357031d85b5 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -62,8 +62,7 @@ typedef struct user_fxsr_struct elf_fpxregset_t;
 #define R_X86_64_PC16		13	/* 16 bit sign extended pc relative */
 #define R_X86_64_8		14	/* Direct 8 bit sign extended  */
 #define R_X86_64_PC8		15	/* 8 bit sign extended pc relative */
-
-#define R_X86_64_NUM		16
+#define R_X86_64_PC64		24	/* Place relative 64-bit signed */
 
 /*
  * These are used to set parameters in the core dumps.
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index f58336af095c..b052e883dd8c 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -201,6 +201,12 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 				goto overflow;
 #endif
 			break;
+		case R_X86_64_PC64:
+			if (*(u64 *)loc != 0)
+				goto invalid_relocation;
+			val -= (u64)loc;
+			*(u64 *)loc = val;
+			break;
 		default:
 			pr_err("%s: Unknown rela relocation: %llu\n",
 			       me->name, ELF64_R_TYPE(rel[i].r_info));
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 3a6c8ebc8032..0b08067c45f3 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -196,6 +196,7 @@ static const char *rel_type(unsigned type)
 #if ELF_BITS == 64
 		REL_TYPE(R_X86_64_NONE),
 		REL_TYPE(R_X86_64_64),
+		REL_TYPE(R_X86_64_PC64),
 		REL_TYPE(R_X86_64_PC32),
 		REL_TYPE(R_X86_64_GOT32),
 		REL_TYPE(R_X86_64_PLT32),
@@ -782,6 +783,15 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 			add_reloc(&relocs32neg, offset);
 		break;
 
+	case R_X86_64_PC64:
+		/*
+		 * Only used by jump labels
+		 */
+		if (is_percpu_sym(sym, symname))
+			die("Invalid R_X86_64_PC64 relocation against per-CPU symbol %s\n",
+			    symname);
+		break;
+
 	case R_X86_64_32:
 	case R_X86_64_32S:
 	case R_X86_64_64:
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index 548197212a45..413f3519d9a1 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -116,8 +116,7 @@ do {								\
 #define R_X86_64_PC16		13	/* 16 bit sign extended pc relative */
 #define R_X86_64_8		14	/* Direct 8 bit sign extended  */
 #define R_X86_64_PC8		15	/* 8 bit sign extended pc relative */
-
-#define R_X86_64_NUM		16
+#define R_X86_64_PC64		24	/* Place relative 64-bit signed */
 
 /*
  * This is used to ensure we don't load something for the wrong architecture.
-- 
2.17.1
