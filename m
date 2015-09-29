From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 30 Sep 2015 01:14:13 +0300
Subject: [PATCH v5 16/23] arm64: add support for starting ILP32 (ELFCLASS32)
 binaries
In-Reply-To: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
References: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1443564860-31208-17-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

Handle ILP32 (AArch64, but ELFCLASS32) binaries on ARM64.

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index d4d53c91a..9a854f9 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -134,7 +134,11 @@ typedef struct user_fpsimd_state elf_fpregset_t;
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
@@ -167,6 +171,9 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 #define COMPAT_ELF_ET_DYN_BASE		(2 * TASK_SIZE_32 / 3)
 
 
+extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
+				      int uses_interp);
+
 #ifdef CONFIG_AARCH32_EL0
 
 /* AArch32 registers. */
@@ -176,27 +183,23 @@ typedef compat_a32_elf_greg_t		compat_a32_elf_gregset_t[COMPAT_A32_ELF_NGREG];
 
 /* AArch32 EABI. */
 #define EF_ARM_EABI_MASK		0xff000000
-#define compat_elf_check_arch(x)	(((x)->e_machine == EM_ARM) && \
+#define compat_a32_elf_check_arch(x)	(((x)->e_machine == EM_ARM) && \
 					 ((x)->e_flags & EF_ARM_EABI_MASK))
 
 #define compat_start_thread		compat_start_thread
-#define COMPAT_SET_PERSONALITY(ex)	set_thread_flag(TIF_32BIT);
-#define COMPAT_ARCH_DLINFO
-
-
-extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
-				      int uses_interp);
-#define compat_arch_setup_additional_pages \
-					aarch32_setup_vectors_page
+#define COMPAT_A32_SET_PERSONALITY(ex)		\
+do {						\
+	clear_thread_flag(TIF_32BIT_AARCH64);	\
+	set_thread_flag(TIF_32BIT);		\
+} while (0)
+#define COMPAT_A32_ARCH_DLINFO		do {} while (0)
 
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
 #endif
 
 /* If ILP32 is turned on, we want to define the compat_elf_greg_t to the non compat
@@ -217,7 +220,46 @@ typedef compat_a32_elf_greg_t compat_elf_greg_t;
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
 
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 26352a6..b239b9b 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -107,6 +107,14 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
 
 	return PTR_ERR_OR_ZERO(ret);
 }
+#else
+int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
+{
+	(void) bprm;
+	(void) uses_interp;
+
+	return -EINVAL;
+}
 #endif /* CONFIG_AARCH32_EL0 */
 
 static struct vm_special_mapping vdso_spec[2];
-- 
2.1.4
