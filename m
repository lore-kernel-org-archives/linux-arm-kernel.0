From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri,  3 Jul 2015 17:42:34 +0100
Subject: [PATCH] ARM: davinci: cp_intc: use IRQCHIP_SKIP_SET_WAKE instead of
 irq_set_wake callback
Message-ID: <1435941754-21102-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 60f96b41f71d ("genirq: Add IRQCHIP_SKIP_SET_WAKE flag")
introduced a new flag to skip the irq_set_wake callback in the irqchip
core to avoid adding dummy irq_set_wake in the irqchip implementations.

This patch removes the dummy callback and sets the IRQCHIP_SKIP_SET_WAKE
flags.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/mach-davinci/cp_intc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 006dae8dfe44..9fda75c18c04 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -85,23 +85,13 @@ static int cp_intc_set_irq_type(struct irq_data *d, unsigned int flow_type)
 	return 0;
 }
 
-/*
- * Faking this allows us to to work with suspend functions of
- * generic drivers which call {enable|disable}_irq_wake for
- * wake up interrupt sources (eg RTC on DA850).
- */
-static int cp_intc_set_wake(struct irq_data *d, unsigned int on)
-{
-	return 0;
-}
-
 static struct irq_chip cp_intc_irq_chip = {
 	.name		= "cp_intc",
 	.irq_ack	= cp_intc_ack_irq,
 	.irq_mask	= cp_intc_mask_irq,
 	.irq_unmask	= cp_intc_unmask_irq,
 	.irq_set_type	= cp_intc_set_irq_type,
-	.irq_set_wake	= cp_intc_set_wake,
+	.flags		= IRQCHIP_SKIP_SET_WAKE,
 };
 
 static struct irq_domain *cp_intc_domain;
-- 
1.9.1
