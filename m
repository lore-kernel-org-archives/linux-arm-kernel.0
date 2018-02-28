From: alex.shi@linaro.org (Alex Shi)
Date: Wed, 28 Feb 2018 11:56:33 +0800
Subject: [PATCH 11/29] arm64: entry: Explicitly pass exception level to
 kernel_ventry macro
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519790211-16582-12-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

commit 5b1f7fe41909 upstream.

We will need to treat exceptions from EL0 differently in kernel_ventry,
so rework the macro to take the exception level as an argument and
construct the branch target using that.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	no vmap_stack in arch/arm64/kernel/entry.S
---
 arch/arm64/kernel/entry.S | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index f0c6b37..7b1be51 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -70,10 +70,10 @@
 #define BAD_FIQ		2
 #define BAD_ERROR	3
 
-	.macro kernel_ventry	label
+	.macro kernel_ventry, el, label, regsize = 64
 	.align 7
 	sub	sp, sp, #S_FRAME_SIZE
-	b	\label
+	b	el\()\el\()_\label
 	.endm
 
 	.macro	kernel_entry, el, regsize = 64
@@ -264,31 +264,31 @@ tsk	.req	x28		// current thread_info
 
 	.align	11
 ENTRY(vectors)
-	kernel_ventry	el1_sync_invalid		// Synchronous EL1t
-	kernel_ventry	el1_irq_invalid			// IRQ EL1t
-	kernel_ventry	el1_fiq_invalid			// FIQ EL1t
-	kernel_ventry	el1_error_invalid		// Error EL1t
+	kernel_ventry	1, sync_invalid			// Synchronous EL1t
+	kernel_ventry	1, irq_invalid			// IRQ EL1t
+	kernel_ventry	1, fiq_invalid			// FIQ EL1t
+	kernel_ventry	1, error_invalid		// Error EL1t
 
-	kernel_ventry	el1_sync			// Synchronous EL1h
-	kernel_ventry	el1_irq				// IRQ EL1h
-	kernel_ventry	el1_fiq_invalid			// FIQ EL1h
-	kernel_ventry	el1_error			// Error EL1h
+	kernel_ventry	1, sync				// Synchronous EL1h
+	kernel_ventry	1, irq				// IRQ EL1h
+	kernel_ventry	1, fiq_invalid			// FIQ EL1h
+	kernel_ventry	1, error			// Error EL1h
 
-	kernel_ventry	el0_sync			// Synchronous 64-bit EL0
-	kernel_ventry	el0_irq				// IRQ 64-bit EL0
-	kernel_ventry	el0_fiq_invalid			// FIQ 64-bit EL0
-	kernel_ventry	el0_error			// Error 64-bit EL0
+	kernel_ventry	0, sync				// Synchronous 64-bit EL0
+	kernel_ventry	0, irq				// IRQ 64-bit EL0
+	kernel_ventry	0, fiq_invalid			// FIQ 64-bit EL0
+	kernel_ventry	0, error			// Error 64-bit EL0
 
 #ifdef CONFIG_COMPAT
-	kernel_ventry	el0_sync_compat			// Synchronous 32-bit EL0
-	kernel_ventry	el0_irq_compat			// IRQ 32-bit EL0
-	kernel_ventry	el0_fiq_invalid_compat		// FIQ 32-bit EL0
-	kernel_ventry	el0_error_compat		// Error 32-bit EL0
+	kernel_ventry	0, sync_compat, 32		// Synchronous 32-bit EL0
+	kernel_ventry	0, irq_compat, 32		// IRQ 32-bit EL0
+	kernel_ventry	0, fiq_invalid_compat, 32	// FIQ 32-bit EL0
+	kernel_ventry	0, error_compat, 32		// Error 32-bit EL0
 #else
-	kernel_ventry	el0_sync_invalid		// Synchronous 32-bit EL0
-	kernel_ventry	el0_irq_invalid			// IRQ 32-bit EL0
-	kernel_ventry	el0_fiq_invalid			// FIQ 32-bit EL0
-	kernel_ventry	el0_error_invalid		// Error 32-bit EL0
+	kernel_ventry	0, sync_invalid, 32		// Synchronous 32-bit EL0
+	kernel_ventry	0, irq_invalid, 32		// IRQ 32-bit EL0
+	kernel_ventry	0, fiq_invalid, 32		// FIQ 32-bit EL0
+	kernel_ventry	0, error_invalid, 32		// Error 32-bit EL0
 #endif
 END(vectors)
 
-- 
2.7.4
