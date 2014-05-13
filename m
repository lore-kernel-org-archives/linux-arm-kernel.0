From: Nikolay.Borisov@arm.com (Nikolay Borisov)
Date: Tue, 13 May 2014 10:46:57 +0100
Subject: [PATCH 6/7] ARM: traps: Make use of the frame_pointer macro
In-Reply-To: <1399974418-4995-1-git-send-email-Nikolay.Borisov@arm.com>
References: <1399974418-4995-1-git-send-email-Nikolay.Borisov@arm.com>
Message-ID: <1399974418-4995-7-git-send-email-Nikolay.Borisov@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the newly-introduced frame_pointer macro to extract
the correct FP based on whether we are in THUMB2 mode or not.

Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
---
 arch/arm/kernel/traps.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index abd2fc0..c8e4bb7 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -31,11 +31,13 @@
 #include <asm/exception.h>
 #include <asm/unistd.h>
 #include <asm/traps.h>
+#include <asm/ptrace.h>
 #include <asm/unwind.h>
 #include <asm/tls.h>
 #include <asm/system_misc.h>
 #include <asm/opcodes.h>
 
+
 static const char *handler[]= {
 	"prefetch abort",
 	"data abort",
@@ -184,7 +186,7 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		tsk = current;
 
 	if (regs) {
-		fp = regs->ARM_fp;
+		fp = frame_pointer(regs);
 		mode = processor_mode(regs);
 	} else if (tsk != current) {
 		fp = thread_saved_fp(tsk);
@@ -719,7 +721,7 @@ asmlinkage int arm_syscall(int no, struct pt_regs *regs)
 		dump_instr("", regs);
 		if (user_mode(regs)) {
 			__show_regs(regs);
-			c_backtrace(regs->ARM_fp, processor_mode(regs));
+			c_backtrace(frame_pointer(regs), processor_mode(regs));
 		}
 	}
 #endif
-- 
1.8.1.5
