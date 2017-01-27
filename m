From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 27 Jan 2017 16:15:38 +0000
Subject: [PATCH] arm64: handle sys and undef traps consistently
Message-ID: <1485533738-30062-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If an EL0 instruction in the SYS class triggers an exception, do_sysintr
looks for a sys64_hook matching the instruction, and if none is found,
injects a SIGILL. This mirrors what we do for undefined instruction
encodings in do_undefinstr, where we look for an undef_hook matching the
instruction, and if none is found, inject a SIGILL.

Over time, new SYS instruction encodings may be allocated. Prior to
allocation, exceptions resulting from these would be handled by
do_undefinstr, whereas after allocation these may be handled by
do_sysintr.

To ensure that we have consistent behaviour if and when this happens, it
would be beneficial to have do_sysinstr fall back to do_undefinstr.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/traps.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 8187229..7c3fc06 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -531,7 +531,12 @@ asmlinkage void __exception do_sysinstr(unsigned int esr, struct pt_regs *regs)
 			return;
 		}
 
-	force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
+	/*
+	 * New SYS instructions may previously have been undefined at EL0. Fall
+	 * back to our usual undefined instruction handler so that we handle
+	 * these consistently.
+	 */
+	do_undefinstr(regs);
 }
 
 long compat_arm_syscall(struct pt_regs *regs);
-- 
1.9.1
