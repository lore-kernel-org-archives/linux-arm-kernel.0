From: james.morse@arm.com (James Morse)
Date: Fri,  4 Dec 2015 11:02:28 +0000
Subject: [PATCH v8 4/4] arm64: switch to irq_stack during softirq
In-Reply-To: <1449226948-14251-1-git-send-email-james.morse@arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
Message-ID: <1449226948-14251-5-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

do_softirq_own_stack() was added in a previous patch, but was only used
to increase the irq_count value before __do_softirq() re-enables interrupts.

This patch adds a helper to call __do_softirq() on the irq stack. This means
do_softirq() can be called by a task that is running out of stack space,
as the work will be done on the irq_stack.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/irq.h |  2 ++
 arch/arm64/kernel/entry.S    | 25 +++++++++++++++++++++++++
 arch/arm64/kernel/irq.c      |  4 +---
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index fa2a8d0e4792..6fd25ab534ca 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -31,6 +31,8 @@ DECLARE_PER_CPU(unsigned long [IRQ_STACK_SIZE/sizeof(long)], irq_stack);
 
 extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
 
+void __do_softirq_on_irqstack(void);
+
 static inline int nr_legacy_irqs(void)
 {
 	return 0;
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 81cc5380977d..2963050e5e9e 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -779,3 +779,28 @@ ENTRY(sys_rt_sigreturn_wrapper)
 	mov	x0, sp
 	b	sys_rt_sigreturn
 ENDPROC(sys_rt_sigreturn_wrapper)
+
+ENTRY(__do_softirq_on_irqstack)
+	push	x19, lr
+	push	x25, x26
+
+	irq_stack_entry lr
+
+	/* irq_stack_entry leaves irq_count in x25 */
+	ldr	x1, [x25]
+	add	x1, x1, #1
+	str	x1, [x25]
+
+	bl	__do_softirq
+
+	ldr	x1, [x25]
+	sub	x1, x1, #1
+	str	x1, [x25]
+
+	irq_stack_exit
+
+	pop x25, x26
+	pop x19, lr
+	ret
+ENDPROC(__do_softirq_on_irqstack)
+
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index ff7ebb710e51..cbf1f00993ef 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -75,8 +75,6 @@ void __init init_IRQ(void)
  *
  * Called with interrupts disabled, so we don't worry about moving cpu, or
  * being interrupted while modifying irq_count.
- *
- * This function doesn't actually switch stack.
  */
 void do_softirq_own_stack(void)
 {
@@ -89,6 +87,6 @@ void do_softirq_own_stack(void)
 		__do_softirq();
 		IRQ_COUNT()--;
 	} else {
-		__do_softirq();
+		__do_softirq_on_irqstack();
 	}
 }
-- 
2.6.2
