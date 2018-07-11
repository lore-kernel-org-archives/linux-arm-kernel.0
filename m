From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Jul 2018 14:56:46 +0100
Subject: [PATCHv5 11/21] arm64: don't restore GPRs when context tracking
In-Reply-To: <20180711135656.20670-1-mark.rutland@arm.com>
References: <20180711135656.20670-1-mark.rutland@arm.com>
Message-ID: <20180711135656.20670-12-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that syscalls are invoked with pt_regs, we no longer need to ensure
that the argument regsiters are live in the entry assembly, and it's
fine to not restore them after context_tracking_user_exit() has
corrupted them.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 156c4e3fd1a4..c41b84d06644 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -41,19 +41,9 @@
  * Context tracking subsystem.  Used to instrument transitions
  * between user and kernel mode.
  */
-	.macro ct_user_exit, syscall = 0
+	.macro ct_user_exit
 #ifdef CONFIG_CONTEXT_TRACKING
 	bl	context_tracking_user_exit
-	.if \syscall == 1
-	/*
-	 * Save/restore needed during syscalls.  Restore syscall arguments from
-	 * the values already saved on stack during kernel_entry.
-	 */
-	ldp	x0, x1, [sp]
-	ldp	x2, x3, [sp, #S_X2]
-	ldp	x4, x5, [sp, #S_X4]
-	ldp	x6, x7, [sp, #S_X6]
-	.endif
 #endif
 	.endm
 
-- 
2.11.0
