From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 12 Nov 2018 11:57:14 +0000
Subject: [PATCH v6 23/24] arm64: Skip irqflags tracing for NMI in IRQs
 disabled context
In-Reply-To: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1542023835-21446-24-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When an NMI is raised while interrupts where disabled, the IRQ tracing
already is in the correct state (i.e. hardirqs_off) and should be left
as such when returning to the interrupted context.

Check whether PMR was masking interrupts when the NMI was raised and
skip IRQ tracing if necessary.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/entry.S | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index e02ee55..f175f18 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -629,7 +629,17 @@ el1_irq:
 	kernel_entry 1
 	enable_da_f
 #ifdef CONFIG_TRACE_IRQFLAGS
+#ifdef CONFIG_ARM64_PSEUDO_NMI
+alternative_if ARM64_HAS_IRQ_PRIO_MASKING
+	ldr	x20, [sp, #S_PMR_SAVE]
+alternative_else
+	mov	x20, #GIC_PRIO_IRQON
+alternative_endif
+	/* Irqs were disabled, don't trace */
+	tbz	x20, GIC_PRIO_STATUS_SHIFT, 1f
+#endif
 	bl	trace_hardirqs_off
+1:
 #endif
 
 	irq_handler
@@ -651,8 +661,17 @@ alternative_else_nop_endif
 1:
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
+#ifdef CONFIG_ARM64_PSEUDO_NMI
+	/*
+	 * if IRQs were disabled when we received the interrupt, we have an NMI
+	 * and we are not re-enabling interrupt upon eret. Skip tracing.
+	 */
+	tbz	x20, GIC_PRIO_STATUS_SHIFT, 1f
+#endif
 	bl	trace_hardirqs_on
+1:
 #endif
+
 	kernel_exit 1
 ENDPROC(el1_irq)
 
-- 
1.9.1
