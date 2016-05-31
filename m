From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 May 2016 12:07:47 +0100
Subject: [PATCH] arm64: report CPU number in bad_mode
Message-ID: <1464692867-339-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we take an exception we don't expect (e.g. SError), we report this in
the bad_mode handler with pr_crit. Depending on the configured log
level, we may or may not log additional information in functions called
subsequently. Notably, the messages in dump_stack (including the CPU
number) are printed with KERN_DEFAULT and may not appear.

Some exceptions have an IMPLEMENTATION DEFINED ESR_ELx.ISS encoding, and
knowing the CPU number is crucial to correctly decode them. To ensure
that this is always possible, we should log the CPU number along with
the ESR_ELx value, so we are not reliant on subsequent logs or
additional printk configuration options.

This patch logs the CPU number in bad_mode such that it is possible for
a developer to decode these exceptions, provided access to sufficient
documentation.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Al Grant <Al.Grant@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Martin <dave.martin@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/traps.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index c539208..f7cf463 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -477,8 +477,9 @@ asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr)
 	void __user *pc = (void __user *)instruction_pointer(regs);
 	console_verbose();
 
-	pr_crit("Bad mode in %s handler detected, code 0x%08x -- %s\n",
-		handler[reason], esr, esr_get_class_string(esr));
+	pr_crit("Bad mode in %s handler detected on CPU%d, code 0x%08x -- %s\n",
+		handler[reason], smp_processor_id(), esr,
+		esr_get_class_string(esr));
 	__show_regs(regs);
 
 	info.si_signo = SIGILL;
-- 
1.9.1
