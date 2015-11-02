From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 3 Nov 2015 02:30:33 +0300
Subject: [PATCH v6 04/17] arm64: change some CONFIG_COMPAT over to use
 CONFIG_AARCH32_EL0 instead
In-Reply-To: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1446507046-24604-5-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Reviewed-by: David Daney <david.daney@cavium.com>
---
 arch/arm64/include/asm/elf.h       | 20 +++++++++++++++++---
 arch/arm64/include/asm/fpsimd.h    |  2 +-
 arch/arm64/include/asm/processor.h |  4 ++--
 arch/arm64/include/asm/ptrace.h    |  2 +-
 arch/arm64/include/asm/signal32.h  | 19 +++++++++++++++++++
 arch/arm64/include/asm/stat.h      |  2 ++
 arch/arm64/include/asm/unistd.h    |  4 +++-
 arch/arm64/kernel/Makefile         |  2 +-
 arch/arm64/kernel/asm-offsets.c    |  2 +-
 arch/arm64/kernel/entry.S          |  6 +++---
 arch/arm64/kernel/head.S           |  2 +-
 arch/arm64/kernel/ptrace.c         | 27 ++++++++++++++++++++-------
 arch/arm64/kernel/signal.c         | 16 ++++++++++++++++
 arch/arm64/kernel/traps.c          |  2 +-
 arch/arm64/kernel/vdso.c           |  4 ++--
 15 files changed, 90 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index faad6df..663f25d 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -166,14 +166,16 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 
 #define COMPAT_ELF_ET_DYN_BASE		(2 * TASK_SIZE_32 / 3)
 
+#ifdef CONFIG_AARCH32_EL0
+
 /* AArch32 registers. */
-#define COMPAT_ELF_NGREG		18
+#define COMPAT_A32_ELF_NGREG		18
 typedef unsigned int			compat_elf_greg_t;
-typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
+typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_A32_ELF_NGREG];
 
 /* AArch32 EABI. */
 #define EF_ARM_EABI_MASK		0xff000000
-#define compat_elf_check_arch(x)	(((x)->e_machine == EM_ARM) && \
+#define compat_a32_elf_check_arch(x)	(((x)->e_machine == EM_ARM) && \
 					 ((x)->e_flags & EF_ARM_EABI_MASK))
 
 #define compat_start_thread		compat_start_thread
@@ -184,6 +186,18 @@ extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
 #define compat_arch_setup_additional_pages \
 					aarch32_setup_vectors_page
 
+#else
+
+typedef elf_greg_t			compat_elf_greg_t;
+typedef elf_gregset_t			compat_elf_gregset_t;
+#define compat_a32_elf_check_arch(x)	0
+#define COMPAT_SET_PERSONALITY(ex)
+#define COMPAT_ARCH_DLINFO
+
+#endif
+
+#define compat_elf_check_arch(x)	compat_a32_elf_check_arch(x)
+
 #endif /* CONFIG_COMPAT */
 
 #endif
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 50f559f..63b19f1 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -52,7 +52,7 @@ struct fpsimd_partial_state {
 };
 
 
-#if defined(__KERNEL__) && defined(CONFIG_COMPAT)
+#if defined(__KERNEL__) && defined(CONFIG_AARCH32_EL0)
 /* Masks for extracting the FPSR and FPCR from the FPSCR */
 #define VFP_FPSCR_STAT_MASK	0xf800009f
 #define VFP_FPSCR_CTRL_MASK	0x07f79f00
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 98f3235..ff4abec 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -79,7 +79,7 @@ struct cpu_context {
 struct thread_struct {
 	struct cpu_context	cpu_context;	/* cpu context */
 	unsigned long		tp_value;	/* TLS register */
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	unsigned long		tp2_value;
 #endif
 	struct fpsimd_state	fpsimd_state;
@@ -88,7 +88,7 @@ struct thread_struct {
 	struct debug_info	debug;		/* debugging */
 };
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 #define task_user_tls(t)						\
 ({									\
 	unsigned long *__tls;						\
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 536274e..1059b3f 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -120,7 +120,7 @@ struct pt_regs {
 
 #define arch_has_single_step()	(1)
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 #define compat_thumb_mode(regs) \
 	(((regs)->pstate & COMPAT_PSR_T_BIT))
 #else
diff --git a/arch/arm64/include/asm/signal32.h b/arch/arm64/include/asm/signal32.h
index eeaa975..7097718 100644
--- a/arch/arm64/include/asm/signal32.h
+++ b/arch/arm64/include/asm/signal32.h
@@ -20,6 +20,7 @@
 #ifdef CONFIG_COMPAT
 #include <linux/compat.h>
 
+#ifdef CONFIG_AARCH32_EL0
 #define AARCH32_KERN_SIGRET_CODE_OFFSET	0x500
 
 extern const compat_ulong_t aarch32_sigret_code[6];
@@ -47,6 +48,24 @@ static inline int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t
 static inline void compat_setup_restart_syscall(struct pt_regs *regs)
 {
 }
+#endif /* CONFIG_AARCH32_EL0 */
+#else
+static inline void compat_setup_restart_syscall(struct pt_regs *regs)
+{
+}
+
+static inline int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
+					struct pt_regs *regs)
+{
+	return -ENOSYS;
+}
+
+static inline int compat_setup_frame(int usid, struct ksignal *ksig,
+				     sigset_t *set, struct pt_regs *regs)
+{
+	return -ENOSYS;
+}
+
 #endif /* CONFIG_COMPAT */
 #endif /* __KERNEL__ */
 #endif /* __ASM_SIGNAL32_H */
diff --git a/arch/arm64/include/asm/stat.h b/arch/arm64/include/asm/stat.h
index 15e3559..af04276 100644
--- a/arch/arm64/include/asm/stat.h
+++ b/arch/arm64/include/asm/stat.h
@@ -22,6 +22,7 @@
 
 #include <asm/compat.h>
 
+#ifdef CONFIG_AARCH32_EL0
 /*
  * struct stat64 is needed for compat tasks only. Its definition is different
  * from the generic struct stat64.
@@ -59,3 +60,4 @@ struct stat64 {
 
 #endif
 #endif
+#endif
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 41e58fe..4c2cbbc 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -13,7 +13,7 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 #define __ARCH_WANT_COMPAT_SYS_GETDENTS64
 #define __ARCH_WANT_COMPAT_STAT64
 #define __ARCH_WANT_SYS_GETHOSTNAME
@@ -26,7 +26,9 @@
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
+#endif
 
+#ifdef CONFIG_COMPAT
 /*
  * Compat syscall numbers used by the AArch64 kernel.
  */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 22dc9bc..1470332 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -20,7 +20,7 @@ arm64-obj-y		:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
 			   smp.o smp_spin_table.o topology.o
 
-arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
+arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o		\
 					   ../../arm/kernel/opcodes.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 8d89cf8..e3bcf77 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -51,7 +51,7 @@ int main(void)
   DEFINE(S_X7,			offsetof(struct pt_regs, regs[7]));
   DEFINE(S_LR,			offsetof(struct pt_regs, regs[30]));
   DEFINE(S_SP,			offsetof(struct pt_regs, sp));
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
   DEFINE(S_COMPAT_SP,		offsetof(struct pt_regs, compat_sp));
 #endif
   DEFINE(S_PSTATE,		offsetof(struct pt_regs, pstate));
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 4306c93..52be5c8 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -212,7 +212,7 @@ ENTRY(vectors)
 	ventry	el0_fiq_invalid			// FIQ 64-bit EL0
 	ventry	el0_error_invalid		// Error 64-bit EL0
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	ventry	el0_sync_compat			// Synchronous 32-bit EL0
 	ventry	el0_irq_compat			// IRQ 32-bit EL0
 	ventry	el0_fiq_invalid_compat		// FIQ 32-bit EL0
@@ -252,7 +252,7 @@ el0_error_invalid:
 	inv_entry 0, BAD_ERROR
 ENDPROC(el0_error_invalid)
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 el0_fiq_invalid_compat:
 	inv_entry 0, BAD_FIQ, 32
 ENDPROC(el0_fiq_invalid_compat)
@@ -414,7 +414,7 @@ el0_sync:
 	b.ge	el0_dbg
 	b	el0_inv
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	.align	6
 el0_sync_compat:
 	kernel_entry 0, 32
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 90d09ed..d11d0b2 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -519,7 +519,7 @@ CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
 	mov	x0, #0x33ff
 	msr	cptr_el2, x0			// Disable copro. traps to EL2
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	msr	hstr_el2, xzr			// Disable CP15 traps to EL2
 #endif
 
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 1971f49..2a39b5d 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -76,7 +76,7 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 		.si_addr	= (void __user *)(bkpt->trigger),
 	};
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	int i;
 
 	if (!is_compat_task())
@@ -651,7 +651,7 @@ static const struct user_regset_view user_aarch64_view = {
 	.regsets = aarch64_regsets, .n = ARRAY_SIZE(aarch64_regsets)
 };
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 #include <linux/compat.h>
 
 enum compat_regset {
@@ -853,7 +853,7 @@ static int compat_tls_set(struct task_struct *target,
 static const struct user_regset aarch32_regsets[] = {
 	[REGSET_COMPAT_GPR] = {
 		.core_note_type = NT_PRSTATUS,
-		.n = COMPAT_ELF_NGREG,
+		.n = COMPAT_A32_ELF_NGREG,
 		.size = sizeof(compat_elf_greg_t),
 		.align = sizeof(compat_elf_greg_t),
 		.get = compat_gpr_get,
@@ -877,7 +877,7 @@ static const struct user_regset_view user_aarch32_view = {
 static const struct user_regset aarch32_ptrace_regsets[] = {
 	[REGSET_GPR] = {
 		.core_note_type = NT_PRSTATUS,
-		.n = COMPAT_ELF_NGREG,
+		.n = COMPAT_A32_ELF_NGREG,
 		.size = sizeof(compat_elf_greg_t),
 		.align = sizeof(compat_elf_greg_t),
 		.get = compat_gpr_get,
@@ -1109,7 +1109,7 @@ static int compat_ptrace_sethbpregs(struct task_struct *tsk, compat_long_t num,
 }
 #endif	/* CONFIG_HAVE_HW_BREAKPOINT */
 
-long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
+long compat_a32_arch_ptrace(struct task_struct *child, compat_long_t request,
 			compat_ulong_t caddr, compat_ulong_t cdata)
 {
 	unsigned long addr = caddr;
@@ -1186,11 +1186,24 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 	return ret;
 }
-#endif /* CONFIG_COMPAT */
+#else /* !CONFIG_AARCH32_EL0 */
+#define compat_a32_arch_ptrace(child, request, caddr, cdata) (-1)
+#endif /* !CONFIG_AARCH32_EL0 */
+
+#ifdef CONFIG_COMPAT
+long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
+			compat_ulong_t caddr, compat_ulong_t cdata)
+{
+	if (is_compat_task())
+		return compat_a32_arch_ptrace(child, request, caddr, cdata);
+	return compat_ptrace_request(child, request, caddr, cdata);
+}
+#endif
+
 
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 {
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	/*
 	 * Core dumping of 32-bit tasks or compat ptrace requests must use the
 	 * user_aarch32_view compatible with arm32. Native ptrace requests on
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index e18c48c..1e3593c 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -414,3 +414,19 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 		fpsimd_restore_current_state();
 
 }
+
+/*
+ * Some functions are needed for compat ptrace but we don't define
+ * them if we don't have AARCH32 support compiled in
+ */
+#if defined CONFIG_COMPAT && !defined CONFIG_AARCH32_EL0
+int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
+{
+	return -EFAULT;
+}
+
+int copy_siginfo_from_user32(siginfo_t *to, compat_siginfo_t __user *from)
+{
+	return -EFAULT;
+}
+#endif
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index f93aae5..9ce9894 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -363,7 +363,7 @@ long compat_arm_syscall(struct pt_regs *regs);
 
 asmlinkage long do_ni_syscall(struct pt_regs *regs)
 {
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	long ret;
 	if (is_compat_task()) {
 		ret = compat_arm_syscall(regs);
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 97bc68f..26352a6 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -49,7 +49,7 @@ static union {
 } vdso_data_store __page_aligned_data;
 struct vdso_data *vdso_data = &vdso_data_store.data;
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 /*
  * Create and map the vectors page for AArch32 tasks.
  */
@@ -107,7 +107,7 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
 
 	return PTR_ERR_OR_ZERO(ret);
 }
-#endif /* CONFIG_COMPAT */
+#endif /* CONFIG_AARCH32_EL0 */
 
 static struct vm_special_mapping vdso_spec[2];
 
-- 
2.1.4
