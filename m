From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 25 May 2018 10:49:15 +0100
Subject: [PATCH v4 09/26] arm64: Use daifflag_restore after bp_hardening
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1527241772-48007-10-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For EL0 entries requiring bp_hardening, daif status is kept at
DAIF_PROCCTX_NOIRQ until after hardening has been done. Then interrupts
are enabled through local_irq_enable().

Before using local_irq_* functions, daifflags should be properly restored
to a state where IRQs are enabled.

Enable IRQs by restoring DAIF_PROCCTX state after bp hardening.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 arch/arm64/mm/fault.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Note:
This doesn't introduce a real change in behaviour, but once PMR
is used for interrupt masking, PSR.I bit needs to be cleared and
local_irq_enable won't do that anymore.

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 4165485..7a18634 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -37,6 +37,7 @@
 #include <asm/cmpxchg.h>
 #include <asm/cpufeature.h>
 #include <asm/exception.h>
+#include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
 #include <asm/esr.h>
 #include <asm/sysreg.h>
@@ -712,7 +713,7 @@ asmlinkage void __exception do_el0_ia_bp_hardening(unsigned long addr,
 	if (addr > TASK_SIZE)
 		arm64_apply_bp_hardening();

-	local_irq_enable();
+	local_daif_restore(DAIF_PROCCTX);
 	do_mem_abort(addr, esr, regs);
 }

@@ -726,7 +727,7 @@ asmlinkage void __exception do_sp_pc_abort(unsigned long addr,
 	if (user_mode(regs)) {
 		if (instruction_pointer(regs) > TASK_SIZE)
 			arm64_apply_bp_hardening();
-		local_irq_enable();
+		local_daif_restore(DAIF_PROCCTX);
 	}

 	info.si_signo = SIGBUS;
--
1.9.1
