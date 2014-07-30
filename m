From: behanw@converseincode.com (behanw at converseincode.com)
Date: Wed, 30 Jul 2014 16:57:27 -0700
Subject: [PATCH 2/4] arm64: LLVMLinux: Use current_stack_pointer in
 save_stack_trace_tsk
In-Reply-To: <1406764649-20326-1-git-send-email-behanw@converseincode.com>
References: <1406764649-20326-1-git-send-email-behanw@converseincode.com>
Message-ID: <1406764649-20326-3-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Behan Webster <behanw@converseincode.com>

Use the global current_stack_pointer to get the value of the stack pointer.
This change supports being able to compile the kernel with both gcc and clang.

Signed-off-by: Behan Webster <behanw@converseincode.com>
Signed-off-by: Mark Charlebois <charlebm@gmail.com>
Reviewed-by: Jan-Simon M??ller <dl9pf@gmx.de>
---
 arch/arm64/kernel/stacktrace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 55437ba..407991b 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -111,10 +111,9 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 		frame.sp = thread_saved_sp(tsk);
 		frame.pc = thread_saved_pc(tsk);
 	} else {
-		register unsigned long current_sp asm("sp");
 		data.no_sched_functions = 0;
 		frame.fp = (unsigned long)__builtin_frame_address(0);
-		frame.sp = current_sp;
+		frame.sp = current_stack_pointer;
 		frame.pc = (unsigned long)save_stack_trace_tsk;
 	}
 
-- 
1.9.1
