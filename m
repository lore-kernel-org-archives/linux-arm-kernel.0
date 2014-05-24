From: apinski@cavium.com (Andrew Pinski)
Date: Sat, 24 May 2014 00:02:12 -0700
Subject: [PATCH 17/24] ARM64:ILP32: Support core dump for ILP32.
In-Reply-To: <1400914939-9708-1-git-send-email-apinski@cavium.com>
References: <1400914939-9708-1-git-send-email-apinski@cavium.com>
Message-ID: <1400914939-9708-18-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch supports core dumping on ILP32.  We need a few extra macros (PR_REG_SIZE and PRSTATUS_SIZE) due to size differences of the register sets.

Thanks,
Andrew Pinski

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 arch/arm64/include/asm/elf.h |   22 ++++++++++++++++++++--
 arch/arm64/kernel/ptrace.c   |   12 ++++++------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 8180511..4106386 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -176,8 +176,8 @@ extern unsigned long arch_randomize_brk(struct mm_struct *mm);
 
 /* AArch32 registers. */
 #define COMPAT_A32_ELF_NGREG		18
-typedef unsigned int			compat_elf_greg_t;
-typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_A32_ELF_NGREG];
+typedef unsigned int			compat_a32_elf_greg_t;
+typedef compat_a32_elf_greg_t		compat_a32_elf_gregset_t[COMPAT_A32_ELF_NGREG];
 
 /* AArch32 EABI. */
 #define EF_ARM_EABI_MASK		0xff000000
@@ -204,6 +204,24 @@ typedef elf_gregset_t			compat_elf_gregset_t;
 
 #endif
 
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
+
 #define compat_elf_check_arch(x)	compat_a32_elf_check_arch(x)
 
 #endif /* CONFIG_COMPAT */
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 7fb1377..7890f95 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -771,8 +771,8 @@ static const struct user_regset aarch32_regsets[] = {
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
@@ -805,7 +805,7 @@ static int compat_ptrace_read_user(struct task_struct *tsk, compat_ulong_t off,
 		tmp = tsk->mm->start_data;
 	else if (off == COMPAT_PT_TEXT_END_ADDR)
 		tmp = tsk->mm->end_code;
-	else if (off < sizeof(compat_elf_gregset_t))
+	else if (off < sizeof(compat_a32_elf_gregset_t))
 		return copy_regset_to_user(tsk, &user_aarch32_view,
 					   REGSET_COMPAT_GPR, off,
 					   sizeof(compat_ulong_t), ret);
@@ -825,7 +825,7 @@ static int compat_ptrace_write_user(struct task_struct *tsk, compat_ulong_t off,
 	if (off & 3 || off >= COMPAT_USER_SZ)
 		return -EIO;
 
-	if (off >= sizeof(compat_elf_gregset_t))
+	if (off >= sizeof(compat_a32_elf_gregset_t))
 		return 0;
 
 	ret = copy_regset_from_user(tsk, &user_aarch32_view,
@@ -985,7 +985,7 @@ long compat_a32_arch_ptrace(struct task_struct *child, compat_long_t request,
 			ret = copy_regset_to_user(child,
 						  &user_aarch32_view,
 						  REGSET_COMPAT_GPR,
-						  0, sizeof(compat_elf_gregset_t),
+						  0, sizeof(compat_a32_elf_gregset_t),
 						  datap);
 			break;
 
@@ -993,7 +993,7 @@ long compat_a32_arch_ptrace(struct task_struct *child, compat_long_t request,
 			ret = copy_regset_from_user(child,
 						    &user_aarch32_view,
 						    REGSET_COMPAT_GPR,
-						    0, sizeof(compat_elf_gregset_t),
+						    0, sizeof(compat_a32_elf_gregset_t),
 						    datap);
 			break;
 
-- 
1.7.2.5
