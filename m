From: behanw@converseincode.com (behanw at converseincode.com)
Date: Fri,  5 Sep 2014 17:06:14 -0700
Subject: [PATCH v2 4/7] arm: LLVMLinux: Use current_stack_pointer in
 save_stack_trace_tsk
In-Reply-To: <1409961977-11762-1-git-send-email-behanw@converseincode.com>
References: <1409961977-11762-1-git-send-email-behanw@converseincode.com>
Message-ID: <1409961977-11762-5-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Behan Webster <behanw@converseincode.com>

Use the global current_stack_pointer to get the value of the stack pointer.
This change supports being able to compile the kernel with both gcc and clang.

Signed-off-by: Behan Webster <behanw@converseincode.com>
Signed-off-by: Mark Charlebois <charlebm@gmail.com>
Reviewed-by: Jan-Simon M?ller <dl9pf@gmx.de>
---
 arch/arm/kernel/stacktrace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index f065eb0..92b7237 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -134,12 +134,10 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
 		frame.pc = thread_saved_pc(tsk);
 #endif
 	} else {
-		register unsigned long current_sp asm ("sp");
-
 		/* We don't want this function nor the caller */
 		data.skip += 2;
 		frame.fp = (unsigned long)__builtin_frame_address(0);
-		frame.sp = current_sp;
+		frame.sp = current_stack_pointer;
 		frame.lr = (unsigned long)__builtin_return_address(0);
 		frame.pc = (unsigned long)__save_stack_trace;
 	}
-- 
1.9.1
