From: robh@kernel.org (Rob Herring)
Date: Sun, 12 Jul 2015 09:26:50 -0500
Subject: [PATCH v2 12/13] ARM: remove ununsed set_irq_flags
In-Reply-To: <1436711211-18223-1-git-send-email-robh@kernel.org>
References: <1436711211-18223-1-git-send-email-robh@kernel.org>
Message-ID: <1436711211-18223-13-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all users of set_irq_flags and custom flags are converted to
genirq functions, the ARM specific set_irq_flags can be removed.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Tested-by: Kevin Hilman <khilman@linaro.org>
---
 arch/arm/include/asm/hw_irq.h |  6 ------
 arch/arm/kernel/irq.c         | 20 --------------------
 2 files changed, 26 deletions(-)

diff --git a/arch/arm/include/asm/hw_irq.h b/arch/arm/include/asm/hw_irq.h
index af79da4..9beb929 100644
--- a/arch/arm/include/asm/hw_irq.h
+++ b/arch/arm/include/asm/hw_irq.h
@@ -11,12 +11,6 @@ static inline void ack_bad_irq(int irq)
 	pr_crit("unexpected IRQ trap at vector %02x\n", irq);
 }
 
-void set_irq_flags(unsigned int irq, unsigned int flags);
-
-#define IRQF_VALID	(1 << 0)
-#define IRQF_PROBE	(1 << 1)
-#define IRQF_NOAUTOEN	(1 << 2)
-
 #define ARCH_IRQ_INIT_FLAGS	(IRQ_NOREQUEST | IRQ_NOPROBE)
 
 #endif
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 350f188..4072266 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -78,26 +78,6 @@ asm_do_IRQ(unsigned int irq, struct pt_regs *regs)
 	handle_IRQ(irq, regs);
 }
 
-void set_irq_flags(unsigned int irq, unsigned int iflags)
-{
-	unsigned long clr = 0, set = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
-
-	if (irq >= nr_irqs) {
-		pr_err("Trying to set irq flags for IRQ%d\n", irq);
-		return;
-	}
-
-	if (iflags & IRQF_VALID)
-		clr |= IRQ_NOREQUEST;
-	if (iflags & IRQF_PROBE)
-		clr |= IRQ_NOPROBE;
-	if (!(iflags & IRQF_NOAUTOEN))
-		clr |= IRQ_NOAUTOEN;
-	/* Order is clear bits in "clr" then set bits in "set" */
-	irq_modify_status(irq, clr, set & ~clr);
-}
-EXPORT_SYMBOL_GPL(set_irq_flags);
-
 void __init init_IRQ(void)
 {
 	int ret;
-- 
2.1.0
