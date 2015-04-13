From: philipp.tomsich@theobroma-systems.com (Philipp Tomsich)
Date: Mon, 13 Apr 2015 21:44:32 +0200
Subject: [PATCH v4 22/24] arm64:ilp32: use compat for stack_t
In-Reply-To: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
Message-ID: <09081413bd99e0a04e9783dc44fcd52eaeab1af1.1428953303.git.philipp.tomsich@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We use a 'natively sized' stack_t in glibc (i.e. having a 32bit pointer for
ss_sp), which requires the invocation of the compat layer for the following
functionality:
 * sigaltstack
 * saving and restoring uc_stack during signal setup and returns

As the userspace stack_t is natively sized, we avoid code duplication in the
syscall table and can use the compat-functions to zero-extend the pointers
involved.

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 arch/arm64/kernel/signal.c    | 19 +++++++++++++++++++
 arch/arm64/kernel/sys_ilp32.c | 44 +------------------------------------------
 2 files changed, 20 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 99e36be..b3f6e52 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -34,6 +34,7 @@
 #include <asm/fpsimd.h>
 #include <asm/signal32.h>
 #include <asm/vdso.h>
+#include <asm/syscalls.h>
 
 /*
  * Do a signal return; undo the signal stack. These are aligned to 128-bit.
@@ -148,9 +149,22 @@ asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
 	if (restore_sigframe(regs, frame))
 		goto badframe;
 
+
+#if defined(CONFIG_ARM64_ILP32)
+	if (is_ilp32_compat_task()) {
+	        /* For ILP32, we have a different stack_t (the ss_sp
+		   field will be only 32bit sized), which fits into
+		   the memory area reserved for the (larger) LP64
+		   stack_t and which we place into uc_stack: this
+		   implies padding after the ILP32 stack_t. */
+	        if (compat_restore_altstack((compat_stack_t*)&frame->uc.uc_stack))
+	                goto badframe;
+	} else
+#endif
 	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
+
 	return regs->regs[0];
 
 badframe:
@@ -264,6 +278,11 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 	__put_user_error(0, &frame->uc.uc_flags, err);
 	__put_user_error(NULL, &frame->uc.uc_link, err);
 
+#if defined(CONFIG_ARM64_ILP32)
+	if (is_ilp32_compat_task())
+		err |= __compat_save_altstack((compat_stack_t*)&frame->uc.uc_stack, regs->sp);
+	else
+#endif
 	err |= __save_altstack(&frame->uc.uc_stack, regs->sp);
 	err |= setup_sigframe(frame, regs, set);
 	if (err == 0) {
diff --git a/arch/arm64/kernel/sys_ilp32.c b/arch/arm64/kernel/sys_ilp32.c
index 3471f27..31f82ca 100644
--- a/arch/arm64/kernel/sys_ilp32.c
+++ b/arch/arm64/kernel/sys_ilp32.c
@@ -77,6 +77,7 @@
 
 /* Pointer in struct */
 #define sys_mount               compat_sys_mount
+#define sys_sigaltstack         compat_sys_sigaltstack
 
 /* NUMA */
 /* unsigned long bitmaps */
@@ -122,49 +123,6 @@ asmlinkage long ilp32_sys_mq_notify(mqd_t mqdes, const struct sigevent __user *u
    but need special handling due to padding for SIGEV_THREAD.  */
 #define sys_mq_notify		ilp32_sys_mq_notify
 
-
-/* sigaltstack needs some special handling as the
-   padding for stack_t might not be non-zero. */
-long ilp32_sys_sigaltstack(const stack_t __user *uss_ptr,
-			   stack_t __user *uoss_ptr)
-{
-	stack_t uss, uoss;
-	int ret;
-	mm_segment_t seg;
-
-	if (uss_ptr) {
-		if (!access_ok(VERIFY_READ, uss_ptr, sizeof(*uss_ptr)))
-			return -EFAULT;
-		if (__get_user(uss.ss_sp, &uss_ptr->ss_sp) |
-			__get_user(uss.ss_flags, &uss_ptr->ss_flags) |
-			__get_user(uss.ss_size, &uss_ptr->ss_size))
-			return -EFAULT;
-		/* Zero extend the sp address and the size. */
-		uss.ss_sp = (void *)(uintptr_t)(unsigned int)(uintptr_t)uss.ss_sp;
-		uss.ss_size = (size_t)(unsigned int)uss.ss_size;
-	}
-	seg = get_fs();
-	set_fs(KERNEL_DS);
-	/* Note we need to use uoss as we have changed the segment to the
-	   kernel one so passing an user one around is wrong. */
-	ret = sys_sigaltstack((stack_t __force __user *) (uss_ptr ? &uss : NULL),
-			      (stack_t __force __user *) &uoss);
-	set_fs(seg);
-	if (ret >= 0 && uoss_ptr)  {
-		if (!access_ok(VERIFY_WRITE, uoss_ptr, sizeof(stack_t)) ||
-		    __put_user(uoss.ss_sp, &uoss_ptr->ss_sp) ||
-		    __put_user(uoss.ss_flags, &uoss_ptr->ss_flags) ||
-		    __put_user(uoss.ss_size, &uoss_ptr->ss_size))
-			ret = -EFAULT;
-	}
-	return ret;
-}
-
-/* sigaltstack needs some special handling as the padding
-   for stack_t might not be non-zero. */
-#define sys_sigaltstack		ilp32_sys_sigaltstack
-
-
 #include <asm/syscalls.h>
 
 #undef __SYSCALL
-- 
1.9.1
