From: julien.thierry@arm.com (Julien Thierry)
Date: Tue, 28 Aug 2018 16:51:16 +0100
Subject: [PATCH v5 06/27] arm64: Delay daif masking for user return
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1535471497-38854-7-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Masking daif flags is done very early before returning to EL0.

Only toggle the interrupt masking while in the vector entry and mask daif
once in kernel_exit.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/entry.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 09dbea22..85ce06ac 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -259,9 +259,9 @@ alternative_else_nop_endif
 	.endm
 
 	.macro	kernel_exit, el
-	.if	\el != 0
 	disable_daif
 
+	.if	\el != 0
 	/* Restore the task's original addr_limit. */
 	ldr	x20, [sp, #S_ORIG_ADDR_LIMIT]
 	str	x20, [tsk, #TSK_TI_ADDR_LIMIT]
@@ -896,7 +896,7 @@ work_pending:
  * "slow" syscall return path.
  */
 ret_to_user:
-	disable_daif
+	disable_irq				// disable interrupts
 	ldr	x1, [tsk, #TSK_TI_FLAGS]
 	and	x2, x1, #_TIF_WORK_MASK
 	cbnz	x2, work_pending
-- 
1.9.1
