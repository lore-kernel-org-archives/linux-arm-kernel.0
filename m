From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 12 Jul 2017 15:44:21 +0100
Subject: [RFC PATCH 08/10] arm64/kernel: dump entire stack if sp points
 elsewhere
In-Reply-To: <20170712144424.19528-1-ard.biesheuvel@linaro.org>
References: <20170712144424.19528-1-ard.biesheuvel@linaro.org>
Message-ID: <20170712144424.19528-9-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before adding handling for out of bounds stack accesses, update the
stack dumping logic to disregard regs->sp if it does not point into
the task stack anymore, and simply dump the entire stack instead.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/traps.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index c7c7088097be..017c92b2d707 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -257,7 +257,14 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 		 end_of_stack(tsk));
 
 	if (!user_mode(regs)) {
-		dump_mem(KERN_EMERG, "Stack: ", regs->sp,
+		u64 task_sp = regs->sp;
+
+		/* dump the entire stack if sp no longer points into it */
+		if (task_sp < (u64)task_stack_page(tsk) ||
+		    task_sp > (u64)task_stack_page(tsk) + THREAD_SIZE)
+			task_sp = (u64)task_stack_page(tsk);
+
+		dump_mem(KERN_EMERG, "Stack: ", task_sp,
 			 THREAD_SIZE + (unsigned long)task_stack_page(tsk));
 		dump_backtrace(regs, tsk);
 		dump_instr(KERN_EMERG, regs);
-- 
2.9.3
