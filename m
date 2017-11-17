From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Nov 2017 18:21:55 +0000
Subject: [PATCH 12/18] arm64: entry: Explicitly pass exception level to
 kernel_ventry macro
In-Reply-To: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
References: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
Message-ID: <1510942921-12564-13-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We will need to treat exceptions from EL0 differently in kernel_ventry,
so rework the macro to take the exception level as an argument and
construct the branch target using that.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index d850af724c8c..e98cf3064509 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -70,7 +70,7 @@
 #define BAD_FIQ		2
 #define BAD_ERROR	3
 
-	.macro kernel_ventry	label
+	.macro kernel_ventry, el, label, regsize = 64
 	.align 7
 	sub	sp, sp, #S_FRAME_SIZE
 #ifdef CONFIG_VMAP_STACK
@@ -83,7 +83,7 @@
 	tbnz	x0, #THREAD_SHIFT, 0f
 	sub	x0, sp, x0			// x0'' = sp' - x0' = (sp + x0) - sp = x0
 	sub	sp, sp, x0			// sp'' = sp' - x0 = (sp + x0) - x0 = sp
-	b	\label
+	b	el\()\el\()_\label
 
 0:
 	/*
@@ -115,7 +115,7 @@
 	sub	sp, sp, x0
 	mrs	x0, tpidrro_el0
 #endif
-	b	\label
+	b	el\()\el\()_\label
 	.endm
 
 	.macro	kernel_entry, el, regsize = 64
@@ -366,31 +366,31 @@ tsk	.req	x28		// current thread_info
 
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
-	kernel_ventry	el1_error_invalid		// Error EL1h
+	kernel_ventry	1, sync				// Synchronous EL1h
+	kernel_ventry	1, irq				// IRQ EL1h
+	kernel_ventry	1, fiq_invalid			// FIQ EL1h
+	kernel_ventry	1, error_invalid		// Error EL1h
 
-	kernel_ventry	el0_sync			// Synchronous 64-bit EL0
-	kernel_ventry	el0_irq				// IRQ 64-bit EL0
-	kernel_ventry	el0_fiq_invalid			// FIQ 64-bit EL0
-	kernel_ventry	el0_error_invalid		// Error 64-bit EL0
+	kernel_ventry	0, sync				// Synchronous 64-bit EL0
+	kernel_ventry	0, irq				// IRQ 64-bit EL0
+	kernel_ventry	0, fiq_invalid			// FIQ 64-bit EL0
+	kernel_ventry	0, error_invalid		// Error 64-bit EL0
 
 #ifdef CONFIG_COMPAT
-	kernel_ventry	el0_sync_compat			// Synchronous 32-bit EL0
-	kernel_ventry	el0_irq_compat			// IRQ 32-bit EL0
-	kernel_ventry	el0_fiq_invalid_compat		// FIQ 32-bit EL0
-	kernel_ventry	el0_error_invalid_compat	// Error 32-bit EL0
+	kernel_ventry	0, sync_compat, 32		// Synchronous 32-bit EL0
+	kernel_ventry	0, irq_compat, 32		// IRQ 32-bit EL0
+	kernel_ventry	0, fiq_invalid_compat, 32	// FIQ 32-bit EL0
+	kernel_ventry	0, error_invalid_compat, 32	// Error 32-bit EL0
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
2.1.4
