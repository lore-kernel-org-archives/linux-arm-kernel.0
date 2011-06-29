From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:21:14 +0100
Subject: [PATCH 07/23] ARM: entry: no need to increase preempt count for IRQ
	handlers
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <E1QbqxO-0002F8-Gm@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

irq_enter() and irq_exit() already take care of the preempt_count
handling for interrupts, which increment and decrement the hardirq
bits of the preempt count.  So we can remove the preempt count handing
in our IRQ entry/exit assembly, like x86 did some 9 years ago.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/entry-armv.S |   27 ++++-----------------------
 1 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 6855f6d..1e5f387 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -220,16 +220,12 @@ __irq_svc:
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_off
 #endif
-#ifdef CONFIG_PREEMPT
-	get_thread_info tsk
-	ldr	r8, [tsk, #TI_PREEMPT]		@ get preempt count
-	add	r7, r8, #1			@ increment it
-	str	r7, [tsk, #TI_PREEMPT]
-#endif
 
 	irq_handler
+
 #ifdef CONFIG_PREEMPT
-	str	r8, [tsk, #TI_PREEMPT]		@ restore preempt count
+	get_thread_info tsk
+	ldr	r8, [tsk, #TI_PREEMPT]		@ get preempt count
 	ldr	r0, [tsk, #TI_FLAGS]		@ get flags
 	teq	r8, #0				@ if preempt count != 0
 	movne	r0, #0				@ force flags to 0
@@ -432,23 +428,8 @@ __irq_usr:
 	bl	trace_hardirqs_off
 #endif
 
-	get_thread_info tsk
-#ifdef CONFIG_PREEMPT
-	ldr	r8, [tsk, #TI_PREEMPT]		@ get preempt count
-	add	r7, r8, #1			@ increment it
-	str	r7, [tsk, #TI_PREEMPT]
-#endif
-
 	irq_handler
-#ifdef CONFIG_PREEMPT
-	ldr	r0, [tsk, #TI_PREEMPT]
-	str	r8, [tsk, #TI_PREEMPT]
-	teq	r0, r7
- ARM(	strne	r0, [r0, -r0]	)
- THUMB(	movne	r0, #0		)
- THUMB(	strne	r0, [r0]	)
-#endif
-
+	get_thread_info tsk
 	mov	why, #0
 	b	ret_to_user_from_irq
  UNWIND(.fnend		)
-- 
1.7.4.4
