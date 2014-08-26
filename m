From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Aug 2014 11:03:40 +0100
Subject: [PATCH v2 25/26] arm64: get rid of handle_IRQ
In-Reply-To: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
References: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1409047421-27649-26-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the arm64 irqchip drivers have been converted to handle_domain_irq,
making it possible to remove the handle_IRQ stub entierely.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/hardirq.h |  2 --
 arch/arm64/kernel/irq.c          | 11 -----------
 2 files changed, 13 deletions(-)

diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index 0be6782..e8a3268 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -47,8 +47,6 @@ static inline void ack_bad_irq(unsigned int irq)
 	irq_err_count++;
 }
 
-extern void handle_IRQ(unsigned int, struct pt_regs *);
-
 /*
  * No arch-specific IRQ flags.
  */
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 2c0e2a7..67ca197 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -40,17 +40,6 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	return 0;
 }
 
-/*
- * handle_IRQ handles all hardware IRQ's.  Decoded IRQs should
- * not come via this function.  Instead, they should provide their
- * own 'handler'.  Used by platform code implementing C-based 1st
- * level decoding.
- */
-void handle_IRQ(unsigned int irq, struct pt_regs *regs)
-{
-	__handle_domain_irq(NULL, irq, false, regs);
-}
-
 void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
 {
 	if (handle_arch_irq)
-- 
2.0.4
