From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:13:22 +0900
Subject: [PATCH 04/15] ARM: mach-shmobile: sh73a0 external IRQ wake update
In-Reply-To: <1359080013-29189-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080013-29189-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080013-29189-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Use sh73a0_set_wake() for external IRQ signals on sh73a0.

The sh73a0 IRQ hardware for external IRQ pins consists of
the INTCA interrupt controller and the GIC together doing
their best to limp along. These external IRQ pins are
treated as a special case where interrupts need to be
managed in both interrupt controllers in parallel.

The ->irq_set_wake() callback for the external IRQ pins
can be dealt with in the same way as INTCA-only without
involving the GIC. So this patch updates the external
IRQ pin code for sh73a0 to no longer involve the GIC.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/intc-sh73a0.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/intc-sh73a0.c b/arch/arm/mach-shmobile/intc-sh73a0.c
index 9783699..45973b5 100644
--- a/arch/arm/mach-shmobile/intc-sh73a0.c
+++ b/arch/arm/mach-shmobile/intc-sh73a0.c
@@ -315,11 +315,6 @@ static int intca_gic_set_type(struct irq_data *data, unsigned int type)
 	return irq_cbp(irq_set_type, to_intca_reloc_irq(data), type);
 }
 
-static int intca_gic_set_wake(struct irq_data *data, unsigned int on)
-{
-	return irq_cbp(irq_set_wake, to_intca_reloc_irq(data), on);
-}
-
 #ifdef CONFIG_SMP
 static int intca_gic_set_affinity(struct irq_data *data,
 				  const struct cpumask *cpumask,
@@ -339,7 +334,7 @@ struct irq_chip intca_gic_irq_chip = {
 	.irq_disable		= intca_gic_disable,
 	.irq_shutdown		= intca_gic_disable,
 	.irq_set_type		= intca_gic_set_type,
-	.irq_set_wake		= intca_gic_set_wake,
+	.irq_set_wake		= sh73a0_set_wake,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= intca_gic_set_affinity,
 #endif
-- 
1.7.10.4
