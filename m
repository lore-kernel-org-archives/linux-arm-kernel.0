From: keescook@chromium.org (Kees Cook)
Date: Wed,  4 Mar 2015 13:10:54 -0800
Subject: [PATCH v4 10/10] mm: fold arch_randomize_brk into
 ARCH_HAS_ELF_RANDOMIZE
In-Reply-To: <1425503454-7531-1-git-send-email-keescook@chromium.org>
References: <1425503454-7531-1-git-send-email-keescook@chromium.org>
Message-ID: <1425503454-7531-11-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arch_randomize_brk() function is used on several architectures,
even those that don't support ET_DYN ASLR. To avoid bulky extern/#define
tricks, consolidate the support under CONFIG_ARCH_HAS_ELF_RANDOMIZE for
the architectures that support it, while still handling CONFIG_COMPAT_BRK.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/Kconfig                   |  1 +
 arch/arm/include/asm/elf.h     |  4 ----
 arch/arm64/include/asm/elf.h   |  4 ----
 arch/mips/include/asm/elf.h    |  4 ----
 arch/powerpc/include/asm/elf.h |  4 ----
 arch/s390/include/asm/elf.h    |  3 ---
 arch/x86/include/asm/elf.h     |  3 ---
 fs/binfmt_elf.c                |  4 +---
 include/linux/elf-randomize.h  | 12 ++++++++++++
 9 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 9ff5aa8fa2c1..d4f270a54fe6 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -490,6 +490,7 @@ config ARCH_HAS_ELF_RANDOMIZE
 	  An architecture supports choosing randomized locations for
 	  stack, mmap, brk, and ET_DYN. Defined functions:
 	  - arch_mmap_rnd()
+	  - arch_randomize_brk()
 
 #
 # ABI hall of shame
diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index afb9cafd3786..c1ff8ab12914 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -125,10 +125,6 @@ int dump_task_regs(struct task_struct *t, elf_gregset_t *elfregs);
 extern void elf_set_personality(const struct elf32_hdr *);
 #define SET_PERSONALITY(ex)	elf_set_personality(&(ex))
 
-struct mm_struct;
-extern unsigned long arch_randomize_brk(struct mm_struct *mm);
-#define arch_randomize_brk arch_randomize_brk
-
 #ifdef CONFIG_MMU
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
 struct linux_binprm;
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index f724db00b235..faad6df49e5b 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -156,10 +156,6 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 #define STACK_RND_MASK			(0x3ffff >> (PAGE_SHIFT - 12))
 #endif
 
-struct mm_struct;
-extern unsigned long arch_randomize_brk(struct mm_struct *mm);
-#define arch_randomize_brk arch_randomize_brk
-
 #ifdef CONFIG_COMPAT
 
 #ifdef __AARCH64EB__
diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index 535f196ffe02..31d747d46a23 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -410,10 +410,6 @@ struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 				       int uses_interp);
 
-struct mm_struct;
-extern unsigned long arch_randomize_brk(struct mm_struct *mm);
-#define arch_randomize_brk arch_randomize_brk
-
 struct arch_elf_state {
 	int fp_abi;
 	int interp_fp_abi;
diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index 57d289acb803..ee46ffef608e 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -128,10 +128,6 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 	(0x7ff >> (PAGE_SHIFT - 12)) : \
 	(0x3ffff >> (PAGE_SHIFT - 12)))
 
-extern unsigned long arch_randomize_brk(struct mm_struct *mm);
-#define arch_randomize_brk arch_randomize_brk
-
-
 #ifdef CONFIG_SPU_BASE
 /* Notes used in ET_CORE. Note name is "SPU/<fd>/<filename>". */
 #define NT_SPU		1
diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index d0db9d944b6d..fdda72e56404 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -226,9 +226,6 @@ struct linux_binprm;
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
 int arch_setup_additional_pages(struct linux_binprm *, int);
 
-extern unsigned long arch_randomize_brk(struct mm_struct *mm);
-#define arch_randomize_brk arch_randomize_brk
-
 void *fill_cpu_elf_notes(void *ptr, struct save_area *sa, __vector128 *vxrs);
 
 #endif
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index ca3347a9dab5..bbdace22daf8 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -338,9 +338,6 @@ extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
 					      int uses_interp);
 #define compat_arch_setup_additional_pages compat_arch_setup_additional_pages
 
-extern unsigned long arch_randomize_brk(struct mm_struct *mm);
-#define arch_randomize_brk arch_randomize_brk
-
 /*
  * True on X86_32 or when emulating IA32 on X86_64
  */
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 6f08f5fa99dc..a115da230ce0 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1043,15 +1043,13 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	current->mm->end_data = end_data;
 	current->mm->start_stack = bprm->p;
 
-#ifdef arch_randomize_brk
 	if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) {
 		current->mm->brk = current->mm->start_brk =
 			arch_randomize_brk(current->mm);
-#ifdef CONFIG_COMPAT_BRK
+#ifdef compat_brk_randomized
 		current->brk_randomized = 1;
 #endif
 	}
-#endif
 
 	if (current->personality & MMAP_PAGE_ZERO) {
 		/* Why this, you ask???  Well SVr4 maps page 0 as read-only,
diff --git a/include/linux/elf-randomize.h b/include/linux/elf-randomize.h
index 7a4eda02d2b1..b5f0bda9472e 100644
--- a/include/linux/elf-randomize.h
+++ b/include/linux/elf-randomize.h
@@ -1,10 +1,22 @@
 #ifndef _ELF_RANDOMIZE_H
 #define _ELF_RANDOMIZE_H
 
+struct mm_struct;
+
 #ifndef CONFIG_ARCH_HAS_ELF_RANDOMIZE
 static inline unsigned long arch_mmap_rnd(void) { return 0; }
+# if defined(arch_randomize_brk) && defined(CONFIG_COMPAT_BRK)
+#  define compat_brk_randomized
+# endif
+# ifndef arch_randomize_brk
+#  define arch_randomize_brk(mm)	(mm->brk)
+# endif
 #else
 extern unsigned long arch_mmap_rnd(void);
+extern unsigned long arch_randomize_brk(struct mm_struct *mm);
+# ifdef CONFIG_COMPAT_BRK
+#  define compat_brk_randomized
+# endif
 #endif
 
 #endif
-- 
1.9.1
