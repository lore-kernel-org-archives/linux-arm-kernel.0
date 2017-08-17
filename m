From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 17 Aug 2017 03:23:43 -0400
Subject: [PATCH v2 4/8] ARM: signal handling support for FDPIC_FUNCPTRS
 functions
In-Reply-To: <20170817072347.19990-1-nicolas.pitre@linaro.org>
References: <20170817072347.19990-1-nicolas.pitre@linaro.org>
Message-ID: <20170817072347.19990-5-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signal handlers are not direct function pointers but pointers to function
descriptor in that case. Therefore we must retrieve the actual function
address and load the GOT value into r9 from the descriptor before branching
to the actual handler.

If a restorer is provided, we also have to load its address and GOT from
its descriptor. That descriptor address and the code to load it is pushed
onto the stack to be executed as soon as the signal handler returns.

However, to be compatible with NX stacks, the FDPIC bounce code is also
copied to the signal page along with the other code stubs. Therefore this
code must get at the descriptor address whether it executes from the stack
or the signal page. To do so we use the stack pointer which points at the
signal stack frame where the descriptor address was stored. Because the
rt signal frame is different from the simpler frame, two versions of the
bounce code are needed, and two variants (ARM and Thumb) as well. The
asm-offsets facility is used to determine the actual offset in the signal
frame for each version, meaning that struct sigframe and rt_sigframe had
to be moved to a separate file.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/ucontext.h   |  1 +
 arch/arm/kernel/asm-offsets.c     |  4 +++
 arch/arm/kernel/signal.c          | 53 +++++++++++++++++++++++++-----------
 arch/arm/kernel/signal.h          | 11 ++++++++
 arch/arm/kernel/sigreturn_codes.S | 56 +++++++++++++++++++++++++++++++++++----
 5 files changed, 105 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm/kernel/signal.h

diff --git a/arch/arm/include/asm/ucontext.h b/arch/arm/include/asm/ucontext.h
index 921d827485..b42c75ae0d 100644
--- a/arch/arm/include/asm/ucontext.h
+++ b/arch/arm/include/asm/ucontext.h
@@ -2,6 +2,7 @@
 #define _ASMARM_UCONTEXT_H
 
 #include <asm/fpstate.h>
+#include <asm/user.h>
 
 /*
  * struct sigcontext only has room for the basic registers, but struct
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 608008229c..13c1558508 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -28,6 +28,7 @@
 #include <asm/vdso_datapage.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <linux/kbuild.h>
+#include "signal.h"
 
 /*
  * Make sure that the compiler and target are compatible.
@@ -112,6 +113,9 @@ int main(void)
   DEFINE(SVC_ADDR_LIMIT,	offsetof(struct svc_pt_regs, addr_limit));
   DEFINE(SVC_REGS_SIZE,		sizeof(struct svc_pt_regs));
   BLANK();
+  DEFINE(SIGFRAME_RC3_OFFSET,	offsetof(struct sigframe, retcode[3]));
+  DEFINE(RT_SIGFRAME_RC3_OFFSET, offsetof(struct rt_sigframe, sig.retcode[3]));
+  BLANK();
 #ifdef CONFIG_CACHE_L2X0
   DEFINE(L2X0_R_PHY_BASE,	offsetof(struct l2x0_regs, phy_base));
   DEFINE(L2X0_R_AUX_CTRL,	offsetof(struct l2x0_regs, aux_ctrl));
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 5814298ef0..1f3574ec4f 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -18,11 +18,12 @@
 #include <asm/elf.h>
 #include <asm/cacheflush.h>
 #include <asm/traps.h>
-#include <asm/ucontext.h>
 #include <asm/unistd.h>
 #include <asm/vfp.h>
 
-extern const unsigned long sigreturn_codes[7];
+#include "signal.h"
+
+extern const unsigned long sigreturn_codes[17];
 
 static unsigned long signal_return_offset;
 
@@ -171,15 +172,6 @@ static int restore_vfp_context(char __user **auxp)
 /*
  * Do a signal return; undo the signal stack.  These are aligned to 64-bit.
  */
-struct sigframe {
-	struct ucontext uc;
-	unsigned long retcode[2];
-};
-
-struct rt_sigframe {
-	struct siginfo info;
-	struct sigframe sig;
-};
 
 static int restore_sigframe(struct pt_regs *regs, struct sigframe __user *sf)
 {
@@ -365,9 +357,20 @@ setup_return(struct pt_regs *regs, struct ksignal *ksig,
 	     unsigned long __user *rc, void __user *frame)
 {
 	unsigned long handler = (unsigned long)ksig->ka.sa.sa_handler;
+	unsigned long handler_fdpic_GOT = 0;
 	unsigned long retcode;
-	int thumb = 0;
+	unsigned int idx, thumb = 0;
 	unsigned long cpsr = regs->ARM_cpsr & ~(PSR_f | PSR_E_BIT);
+	bool fdpic = IS_ENABLED(CONFIG_BINFMT_ELF_FDPIC) &&
+		     (current->personality & FDPIC_FUNCPTRS);
+
+	if (fdpic) {
+		unsigned long __user *fdpic_func_desc =
+					(unsigned long __user *)handler;
+		if (__get_user(handler, &fdpic_func_desc[0]) ||
+		    __get_user(handler_fdpic_GOT, &fdpic_func_desc[1]))
+			return 1;
+	}
 
 	cpsr |= PSR_ENDSTATE;
 
@@ -407,9 +410,26 @@ setup_return(struct pt_regs *regs, struct ksignal *ksig,
 
 	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
 		retcode = (unsigned long)ksig->ka.sa.sa_restorer;
+		if (fdpic) {
+			/*
+			 * We need code to load the function descriptor.
+			 * That code follows the standard sigreturn code
+			 * (6 words), and is made of 3 + 2 words for each
+			 * variant. The 4th copied word is the actual FD
+			 * address that the assembly code expects.
+			 */
+			idx = 6 + thumb * 3;
+			if (ksig->ka.sa.sa_flags & SA_SIGINFO)
+				idx += 5;
+			if (__put_user(sigreturn_codes[idx],   rc  ) ||
+			    __put_user(sigreturn_codes[idx+1], rc+1) ||
+			    __put_user(sigreturn_codes[idx+2], rc+2) ||
+			    __put_user(retcode,                rc+3))
+				return 1;
+			goto rc_finish;
+		}
 	} else {
-		unsigned int idx = thumb << 1;
-
+		idx = thumb << 1;
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO)
 			idx += 3;
 
@@ -421,6 +441,7 @@ setup_return(struct pt_regs *regs, struct ksignal *ksig,
 		    __put_user(sigreturn_codes[idx+1], rc+1))
 			return 1;
 
+rc_finish:
 #ifdef CONFIG_MMU
 		if (cpsr & MODE32_BIT) {
 			struct mm_struct *mm = current->mm;
@@ -440,7 +461,7 @@ setup_return(struct pt_regs *regs, struct ksignal *ksig,
 			 * the return code written onto the stack.
 			 */
 			flush_icache_range((unsigned long)rc,
-					   (unsigned long)(rc + 2));
+					   (unsigned long)(rc + 3));
 
 			retcode = ((unsigned long)rc) + thumb;
 		}
@@ -450,6 +471,8 @@ setup_return(struct pt_regs *regs, struct ksignal *ksig,
 	regs->ARM_sp = (unsigned long)frame;
 	regs->ARM_lr = retcode;
 	regs->ARM_pc = handler;
+	if (fdpic)
+		regs->ARM_r9 = handler_fdpic_GOT;
 	regs->ARM_cpsr = cpsr;
 
 	return 0;
diff --git a/arch/arm/kernel/signal.h b/arch/arm/kernel/signal.h
new file mode 100644
index 0000000000..b7b838b052
--- /dev/null
+++ b/arch/arm/kernel/signal.h
@@ -0,0 +1,11 @@
+#include <asm/ucontext.h>
+
+struct sigframe {
+	struct ucontext uc;
+	unsigned long retcode[4];
+};
+
+struct rt_sigframe {
+	struct siginfo info;
+	struct sigframe sig;
+};
diff --git a/arch/arm/kernel/sigreturn_codes.S b/arch/arm/kernel/sigreturn_codes.S
index b84d0cb136..2c7b22e321 100644
--- a/arch/arm/kernel/sigreturn_codes.S
+++ b/arch/arm/kernel/sigreturn_codes.S
@@ -14,6 +14,8 @@
  * GNU General Public License for more details.
  */
 
+#include <asm/assembler.h>
+#include <asm/asm-offsets.h>
 #include <asm/unistd.h>
 
 /*
@@ -51,6 +53,17 @@ ARM_OK(	.arm	)
 	.thumb
 	.endm
 
+	.macro arm_fdpic_slot n
+	.org	sigreturn_codes + 24 + 20 * (\n)
+ARM_OK(	.arm	)
+	.endm
+
+	.macro thumb_fdpic_slot n
+	.org	sigreturn_codes + 24 + 20 * (\n) + 12
+	.thumb
+	.endm
+
+
 #if __LINUX_ARM_ARCH__ <= 4
 	/*
 	 * Note we manually set minimally required arch that supports
@@ -90,13 +103,46 @@ ARM_OK(	swi	#(__NR_rt_sigreturn)|(__NR_OABI_SYSCALL_BASE)	)
 	movs	r7, #(__NR_rt_sigreturn - __NR_SYSCALL_BASE)
 	swi	#0
 
+	/* ARM sigreturn restorer FDPIC bounce code snippet */
+	arm_fdpic_slot 0
+ARM_OK(	ldr	r3, [sp, #SIGFRAME_RC3_OFFSET] )
+ARM_OK(	ldmia	r3, {r3, r9} )
+#ifdef CONFIG_ARM_THUMB
+ARM_OK(	bx	r3 )
+#else
+ARM_OK(	ret	r3 )
+#endif
+
+	/* Thumb sigreturn restorer FDPIC bounce code snippet */
+	thumb_fdpic_slot 0
+	ldr	r3, [sp, #SIGFRAME_RC3_OFFSET]
+	ldmia	r3, {r2, r3}
+	mov	r9, r3
+	bx	r2
+
+	/* ARM sigreturn_rt restorer FDPIC bounce code snippet */
+	arm_fdpic_slot 1
+ARM_OK(	ldr	r3, [sp, #RT_SIGFRAME_RC3_OFFSET] )
+ARM_OK(	ldmia	r3, {r3, r9} )
+#ifdef CONFIG_ARM_THUMB
+ARM_OK(	bx	r3 )
+#else
+ARM_OK(	ret	r3 )
+#endif
+
+	/* Thumb sigreturn_rt restorer FDPIC bounce code snippet */
+	thumb_fdpic_slot 1
+	ldr	r3, [sp, #RT_SIGFRAME_RC3_OFFSET]
+	ldmia	r3, {r2, r3}
+	mov	r9, r3
+	bx	r2
+
 	/*
-	 * Note on addtional space: setup_return in signal.c
-	 * algorithm uses two words copy regardless whether
-	 * it is thumb case or not, so we need additional
-	 * word after real last entry.
+	 * Note on additional space: setup_return in signal.c
+	 * always copies the same number of words regardless whether
+	 * it is thumb case or not, so we need one additional padding
+	 * word after the last entry.
 	 */
-	arm_slot 2
 	.space	4
 
 	.size	sigreturn_codes, . - sigreturn_codes
-- 
2.9.5
