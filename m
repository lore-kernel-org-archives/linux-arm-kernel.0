From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Jun 2016 11:15:15 +0100
Subject: [PATCH 2/2] arm64: simplify dump_mem
In-Reply-To: <1465812915-19801-1-git-send-email-mark.rutland@arm.com>
References: <1465812915-19801-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1465812915-19801-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently dump_mem attempts to dump memory in 64-bit chunks when
reporting a failure in 64-bit code, or 32-bit chunks when reporting a
failure in 32-bit code. We added code to handle these two cases
separately in commit e147ae6d7f908412 ("arm64: modify the dump mem for
64 bit addresses").

However, in all cases dump_mem is called, the failing context is a
kernel rather than user context. Additionally dump_mem is assumed to
only be used for kernel contexts, as internally it switches to
KERNEL_DS, and its callers pass kernel stack bounds.

This patch removes the redundant 32-bit chunk logic and associated
compat parameter, largely reverting the aforementioned commit. For the
call in __die(), the check of in_interrupt() is removed also, as __die()
is only called in response to faults from the kernel's exception level,
and thus the !user_mode(regs) check is sufficient. Were this not the
case, the used of task_stack_page(tsk) to generate the stack bounds
would be erroneous.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/traps.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 2a43012..d9da2c5 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -52,15 +52,14 @@ static const char *handler[]= {
 int show_unhandled_signals = 1;
 
 /*
- * Dump out the contents of some memory nicely...
+ * Dump out the contents of some kernel memory nicely...
  */
 static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
-		     unsigned long top, bool compat)
+		     unsigned long top)
 {
 	unsigned long first;
 	mm_segment_t fs;
 	int i;
-	unsigned int width = compat ? 4 : 8;
 
 	/*
 	 * We need to switch to kernel mode so that we can use __get_user
@@ -78,22 +77,15 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
 		memset(str, ' ', sizeof(str));
 		str[sizeof(str) - 1] = '\0';
 
-		for (p = first, i = 0; i < (32 / width)
-					&& p < top; i++, p += width) {
+		for (p = first, i = 0; i < (32 / 8)
+					&& p < top; i++, p += 8) {
 			if (p >= bottom && p < top) {
 				unsigned long val;
 
-				if (width == 8) {
-					if (__get_user(val, (unsigned long *)p) == 0)
-						sprintf(str + i * 17, " %016lx", val);
-					else
-						sprintf(str + i * 17, " ????????????????");
-				} else {
-					if (__get_user(val, (unsigned int *)p) == 0)
-						sprintf(str + i * 9, " %08lx", val);
-					else
-						sprintf(str + i * 9, " ????????");
-				}
+				if (__get_user(val, (unsigned long *)p) == 0)
+					sprintf(str + i * 17, " %016lx", val);
+				else
+					sprintf(str + i * 17, " ????????????????");
 			}
 		}
 		printk("%s%04lx:%s\n", lvl, first & 0xffff, str);
@@ -216,7 +208,7 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 				stack = IRQ_STACK_TO_TASK_STACK(irq_stack_ptr);
 
 			dump_mem("", "Exception stack", stack,
-				 stack + sizeof(struct pt_regs), false);
+				 stack + sizeof(struct pt_regs));
 		}
 	}
 }
@@ -254,10 +246,9 @@ static int __die(const char *str, int err, struct thread_info *thread,
 	pr_emerg("Process %.*s (pid: %d, stack limit = 0x%p)\n",
 		 TASK_COMM_LEN, tsk->comm, task_pid_nr(tsk), thread + 1);
 
-	if (!user_mode(regs) || in_interrupt()) {
+	if (!user_mode(regs)) {
 		dump_mem(KERN_EMERG, "Stack: ", regs->sp,
-			 THREAD_SIZE + (unsigned long)task_stack_page(tsk),
-			 compat_user_mode(regs));
+			 THREAD_SIZE + (unsigned long)task_stack_page(tsk));
 		dump_backtrace(regs, tsk);
 		dump_instr(KERN_EMERG, regs);
 	}
-- 
1.9.1
