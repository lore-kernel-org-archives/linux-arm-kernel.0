From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 8 Jan 2016 02:34:22 +0300
Subject: [PATCH v6 04/21] arm64: change some CONFIG_COMPAT over to use
 CONFIG_AARCH32_EL0 instead
In-Reply-To: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
References: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1452209679-19445-5-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Reviewed-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/arm64/include/asm/fpsimd.h    | 2 +-
 arch/arm64/include/asm/processor.h | 6 +++---
 arch/arm64/include/asm/ptrace.h    | 2 +-
 arch/arm64/include/asm/signal32.h  | 6 ++++--
 arch/arm64/include/asm/unistd.h    | 2 +-
 arch/arm64/kernel/Makefile         | 2 +-
 arch/arm64/kernel/asm-offsets.c    | 2 +-
 arch/arm64/kernel/entry.S          | 6 +++---
 arch/arm64/kernel/head.S           | 2 +-
 arch/arm64/kernel/ptrace.c         | 8 ++++----
 arch/arm64/kernel/traps.c          | 2 +-
 arch/arm64/kernel/vdso.c           | 4 ++--
 12 files changed, 23 insertions(+), 21 deletions(-)

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
index 4acb7ca..9c4d95d 100644
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
@@ -119,7 +119,7 @@ static inline void start_thread(struct pt_regs *regs, unsigned long pc,
 	regs->sp = sp;
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 static inline void compat_start_thread(struct pt_regs *regs, unsigned long pc,
 				       unsigned long sp)
 {
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index e9e5467..95eff51 100644
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
index eeaa975..e68fcce 100644
--- a/arch/arm64/include/asm/signal32.h
+++ b/arch/arm64/include/asm/signal32.h
@@ -17,7 +17,9 @@
 #define __ASM_SIGNAL32_H
 
 #ifdef __KERNEL__
-#ifdef CONFIG_COMPAT
+
+#ifdef CONFIG_AARCH32_EL0
+
 #include <linux/compat.h>
 
 #define AARCH32_KERN_SIGRET_CODE_OFFSET	0x500
@@ -47,6 +49,6 @@ static inline int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t
 static inline void compat_setup_restart_syscall(struct pt_regs *regs)
 {
 }
-#endif /* CONFIG_COMPAT */
+#endif /* CONFIG_AARCH32_EL0 */
 #endif /* __KERNEL__ */
 #endif /* __ASM_SIGNAL32_H */
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 41e58fe..2971dea 100644
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
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 474691f..bf75a7f 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -25,7 +25,7 @@ OBJCOPYFLAGS := --prefix-symbols=__efistub_
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
-arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
+arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o		\
 					   ../../arm/kernel/opcodes.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 25de8b2..0d4f1e7 100644
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
index 7ed3d75..5eb1bb7 100644
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
index 23cfc08..a554e3a 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -507,7 +507,7 @@ CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
 	mov	x0, #0x33ff
 	msr	cptr_el2, x0			// Disable copro. traps to EL2
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	msr	hstr_el2, xzr			// Disable CP15 traps to EL2
 #endif
 
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 1971f49..6b02f26 100644
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
@@ -1186,11 +1186,11 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 	return ret;
 }
-#endif /* CONFIG_COMPAT */
+#endif /* CONFIG_AARCH32_EL0 */
 
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 {
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	/*
 	 * Core dumping of 32-bit tasks or compat ptrace requests must use the
 	 * user_aarch32_view compatible with arm32. Native ptrace requests on
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index e9b9b53..b50fced 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -368,7 +368,7 @@ long compat_arm_syscall(struct pt_regs *regs);
 
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
2.5.0
