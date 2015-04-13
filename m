From: philipp.tomsich@theobroma-systems.com (Philipp Tomsich)
Date: Mon, 13 Apr 2015 21:44:26 +0200
Subject: [PATCH v4 16/24] arm64: add support for starting ILP32 (ELFCLASS32)
 binaries
In-Reply-To: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
Message-ID: <18db2e585cfbc0e2048c13097eff08fdf2dbbba3.1428953303.git.philipp.tomsich@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

Handle ILP32 (AArch64, but ELFCLASS32) binaries on ARM64.

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 arch/arm64/include/asm/elf.h | 66 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 8218925..ff005d9 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -135,7 +135,11 @@ extern unsigned long randomize_et_dyn(unsigned long base);
  */
 #define ELF_PLAT_INIT(_r, load_addr)	(_r)->regs[0] = 0
 
-#define SET_PERSONALITY(ex)		clear_thread_flag(TIF_32BIT);
+#define SET_PERSONALITY(ex)			\
+do {						\
+	clear_thread_flag(TIF_32BIT_AARCH64);	\
+	clear_thread_flag(TIF_32BIT);		\
+} while (0)
 
 #define ARCH_DLINFO							\
 do {									\
@@ -185,25 +189,28 @@ typedef compat_a32_elf_greg_t		compat_a32_elf_gregset_t[COMPAT_A32_ELF_NGREG];
 					 ((x)->e_flags & EF_ARM_EABI_MASK))
 
 #define compat_start_thread		compat_start_thread
-#define COMPAT_SET_PERSONALITY(ex)	set_thread_flag(TIF_32BIT);
-#define COMPAT_ARCH_DLINFO
+#define COMPAT_A32_SET_PERSONALITY(ex)		\
+do {						\
+	clear_thread_flag(TIF_32BIT_AARCH64);	\
+	set_thread_flag(TIF_32BIT);		\
+} while (0)
+#define COMPAT_A32_ARCH_DLINFO		do {} while (0)
 
 
 extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
 				      int uses_interp);
-#define compat_arch_setup_additional_pages \
-					aarch32_setup_vectors_page
 
 #else
-
 typedef elf_greg_t			compat_elf_greg_t;
 typedef elf_gregset_t			compat_elf_gregset_t;
 #define compat_a32_elf_check_arch(x)	0
-#define COMPAT_SET_PERSONALITY(ex)
-#define COMPAT_ARCH_DLINFO
-
+#define COMPAT_A32_SET_PERSONALITY(ex)	do {} while (0)
+#define COMPAT_A32_ARCH_DLINFO		do {} while (0)
+#define aarch32_setup_vectors_page(x, y) -EINVAL
 #endif
 
+
+
 /* If ILP32 is turned on, we want to define the compat_elf_greg_t to the non compat
    one and define PR_REG_SIZE/PRSTATUS_SIZE/SET_PR_FPVALID so we pick up the correct
    ones for AARCH32. Note also the definition of the macros have to be correct for
@@ -222,7 +229,46 @@ typedef compat_a32_elf_greg_t compat_elf_greg_t;
 typedef compat_a32_elf_gregset_t compat_elf_gregset_t;
 #endif
 
-#define compat_elf_check_arch(x)	compat_a32_elf_check_arch(x)
+#ifdef CONFIG_ARM64_ILP32
+#define compat_ilp32_elf_check_arch(x) ((x)->e_machine == EM_AARCH64)
+#define COMPAT_ILP32_SET_PERSONALITY(ex)	\
+do {						\
+	set_thread_flag(TIF_32BIT_AARCH64);	\
+	clear_thread_flag(TIF_32BIT);		\
+} while (0)
+#define COMPAT_ILP32_ARCH_DLINFO					\
+do {									\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
+		    (elf_addr_t)(long)current->mm->context.vdso);	\
+} while (0)
+#else
+#define compat_ilp32_elf_check_arch(x) 0
+#define COMPAT_ILP32_SET_PERSONALITY(ex)	do {} while (0)
+#define COMPAT_ILP32_ARCH_DLINFO		do {} while (0)
+#endif
+
+#define compat_elf_check_arch(x)	(compat_a32_elf_check_arch(x) || compat_ilp32_elf_check_arch(x))
+#define COMPAT_SET_PERSONALITY(ex)			\
+do {							\
+	if (compat_a32_elf_check_arch(&ex))		\
+		COMPAT_A32_SET_PERSONALITY(ex);		\
+	else						\
+		COMPAT_ILP32_SET_PERSONALITY(ex);	\
+} while (0)
+
+/* ILP32 uses the "LP64-like" vdso pages */
+#define compat_arch_setup_additional_pages	\
+	(is_a32_compat_task()			\
+	 ? &aarch32_setup_vectors_page		\
+	 : &(arch_setup_additional_pages))
+
+#define COMPAT_ARCH_DLINFO			\
+do {						\
+	if (is_a32_compat_task())		\
+		COMPAT_A32_ARCH_DLINFO;		\
+	else					\
+		COMPAT_ILP32_ARCH_DLINFO;	\
+} while (0)
 
 #endif /* CONFIG_COMPAT */
 
-- 
1.9.1
