From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 15 Aug 2017 13:50:36 +0100
Subject: [PATCHv2 01/14] arm64: remove __die()'s stack dump
In-Reply-To: <1502801449-29246-1-git-send-email-mark.rutland@arm.com>
References: <1502801449-29246-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1502801449-29246-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our __die() implementation tries to dump the stack memory, in addition
to a backtrace, which is problematic.

For contemporary 16K stacks, this can be a lot of data, which can take a
long time to dump, and can push other useful context out of the kernel's
printk ringbuffer (and/or a user's scrollback buffer on an attached
console).

Additionally, the code implicitly assumes that the SP is on the task's
stack, and tries to dump everything between the SP and the highest task
stack address. When the SP points at an IRQ stack (or is corrupted),
this makes the kernel attempt to dump vast amounts of VA space. With
vmap'd stacks, this may result in erroneous accesses to peripherals.

This patch removes the memory dump, leaving us to rely on the backtrace,
and other means of dumping stack memory such as kdump.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/traps.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index c2a81bf..9633773 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -237,8 +237,6 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 		 end_of_stack(tsk));
 
 	if (!user_mode(regs)) {
-		dump_mem(KERN_EMERG, "Stack: ", regs->sp,
-			 THREAD_SIZE + (unsigned long)task_stack_page(tsk));
 		dump_backtrace(regs, tsk);
 		dump_instr(KERN_EMERG, regs);
 	}
-- 
1.9.1
