From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 3 Nov 2015 02:30:39 +0300
Subject: [PATCH v6 10/17] arm64:ilp32: support core dump generation for ILP32
In-Reply-To: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1446507046-24604-11-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

This patch supports core dumping on ILP32.
We need a few extra macros (COMPAT_PR_REG_SIZE and COMPAT_PRSTATUS_SIZE) due
to size differences of the register sets.

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Reviewed-by: David Daney <david.daney@cavium.com>
---
 arch/arm64/include/asm/elf.h | 87 ++++++++++++++++++++++++++++++++++++++------
 arch/arm64/kernel/ptrace.c   | 12 +++---
 arch/arm64/kernel/vdso.c     |  8 ++++
 3 files changed, 89 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 01e032c..8f13dac 100644
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
@@ -166,12 +170,15 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 
 #define COMPAT_ELF_ET_DYN_BASE		(2 * TASK_SIZE_32 / 3)
 
+extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
+				      int uses_interp);
+
 #ifdef CONFIG_AARCH32_EL0
 
 /* AArch32 registers. */
 #define COMPAT_A32_ELF_NGREG		18
-typedef unsigned int			compat_elf_greg_t;
-typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_A32_ELF_NGREG];
+typedef unsigned int			compat_a32_elf_greg_t;
+typedef compat_a32_elf_greg_t		compat_a32_elf_gregset_t[COMPAT_A32_ELF_NGREG];
 
 /* AArch32 EABI. */
 #define EF_ARM_EABI_MASK		0xff000000
@@ -179,24 +186,80 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_A32_ELF_NGREG];
 					 ((x)->e_flags & EF_ARM_EABI_MASK))
 
 #define compat_start_thread		compat_start_thread
-#define COMPAT_SET_PERSONALITY(ex)	set_thread_flag(TIF_32BIT);
-#define COMPAT_ARCH_DLINFO
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
 
 typedef elf_greg_t			compat_elf_greg_t;
 typedef elf_gregset_t			compat_elf_gregset_t;
 #define compat_a32_elf_check_arch(x)	0
-#define COMPAT_SET_PERSONALITY(ex)
-#define COMPAT_ARCH_DLINFO
+#define COMPAT_A32_SET_PERSONALITY(ex)	do {} while (0)
+#define COMPAT_A32_ARCH_DLINFO		do {} while (0)
+#endif
+
+/* If ILP32 is turned on, we want to define the compat_elf_greg_t to the non compat
+   one and define PR_REG_SIZE/PRSTATUS_SIZE/SET_PR_FPVALID so we pick up the correct
+   ones for AARCH32. Note also the definition of the macros have to be correct for
+   LP64 as this file is included in the standard binfmt_elf.c. */
+#ifdef CONFIG_ARM64_ILP32
+typedef elf_greg_t			compat_elf_greg_t;
+typedef elf_gregset_t			compat_elf_gregset_t;
+#define PR_REG_SIZE(S)			(is_a32_compat_task() ? 72 : 272)
+#define PRSTATUS_SIZE(S)		(is_a32_compat_task() ? 124 : (is_ilp32_compat_task() ? 352 : 392))
+#define SET_PR_FPVALID(S, V)							\
+do {										\
+	*(int *) (((void *) &((S)->pr_reg)) + PR_REG_SIZE((S)->pr_reg)) = (V);	\
+} while (0)
+#else
+typedef compat_a32_elf_greg_t compat_elf_greg_t;
+typedef compat_a32_elf_gregset_t compat_elf_gregset_t;
+#endif
 
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
 #endif
 
-#define compat_elf_check_arch(x)	compat_a32_elf_check_arch(x)
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
 
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index d2e428c..22d0d5e 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -854,8 +854,8 @@ static const struct user_regset aarch32_regsets[] = {
 	[REGSET_COMPAT_GPR] = {
 		.core_note_type = NT_PRSTATUS,
 		.n = COMPAT_A32_ELF_NGREG,
-		.size = sizeof(compat_elf_greg_t),
-		.align = sizeof(compat_elf_greg_t),
+		.size = sizeof(compat_a32_elf_greg_t),
+		.align = sizeof(compat_a32_elf_greg_t),
 		.get = compat_gpr_get,
 		.set = compat_gpr_set
 	},
@@ -946,7 +946,7 @@ static int compat_ptrace_read_user(struct task_struct *tsk, compat_ulong_t off,
 		tmp = tsk->mm->start_data;
 	else if (off == COMPAT_PT_TEXT_END_ADDR)
 		tmp = tsk->mm->end_code;
-	else if (off < sizeof(compat_elf_gregset_t))
+	else if (off < sizeof(compat_a32_elf_gregset_t))
 		return copy_regset_to_user(tsk, &user_aarch32_view,
 					   REGSET_COMPAT_GPR, off,
 					   sizeof(compat_ulong_t), ret);
@@ -967,7 +967,7 @@ static int compat_ptrace_write_user(struct task_struct *tsk, compat_ulong_t off,
 	if (off & 3 || off >= COMPAT_USER_SZ)
 		return -EIO;
 
-	if (off >= sizeof(compat_elf_gregset_t))
+	if (off >= sizeof(compat_a32_elf_gregset_t))
 		return 0;
 
 	set_fs(KERNEL_DS);
@@ -1130,7 +1130,7 @@ long compat_a32_arch_ptrace(struct task_struct *child, compat_long_t request,
 			ret = copy_regset_to_user(child,
 						  &user_aarch32_view,
 						  REGSET_COMPAT_GPR,
-						  0, sizeof(compat_elf_gregset_t),
+						  0, sizeof(compat_a32_elf_gregset_t),
 						  datap);
 			break;
 
@@ -1138,7 +1138,7 @@ long compat_a32_arch_ptrace(struct task_struct *child, compat_long_t request,
 			ret = copy_regset_from_user(child,
 						    &user_aarch32_view,
 						    REGSET_COMPAT_GPR,
-						    0, sizeof(compat_elf_gregset_t),
+						    0, sizeof(compat_a32_elf_gregset_t),
 						    datap);
 			break;
 
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
