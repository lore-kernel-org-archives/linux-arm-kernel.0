From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Apr 2013 23:26:17 +0200
Subject: [PATCHv1 4/5] irqchip: armada-370-xp: slightly cleanup irq controller
 driver
In-Reply-To: <1365542778-27959-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1365542778-27959-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1365542778-27959-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for the introduction of MSI support in the IRQ
controller driver, we clarify the implementation of IPI using
additional defines for the manipulation of doorbells. Just like IPIs
are implemented using doorbells, MSIs will also use doorbells, so it
makes sense to do this preparatory cleanup first.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 1115bf8..ad1e642 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -48,7 +48,9 @@
 
 #define ARMADA_370_XP_TIMER0_PER_CPU_IRQ	(5)
 
-#define ACTIVE_DOORBELLS			(8)
+#define IPI_DOORBELL_START                      (0)
+#define IPI_DOORBELL_END                        (8)
+#define IPI_DOORBELL_MASK                       0xFF
 
 static DEFINE_RAW_SPINLOCK(irq_controller_lock);
 
@@ -192,7 +194,7 @@ void armada_xp_mpic_smp_cpu_init(void)
 	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
 
 	/* Enable first 8 IPIs */
-	writel((1 << ACTIVE_DOORBELLS) - 1, per_cpu_int_base +
+	writel(IPI_DOORBELL_MASK, per_cpu_int_base +
 		ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
 
 	/* Unmask IPI interrupt */
@@ -231,13 +233,14 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 
 			ipimask = readl_relaxed(per_cpu_int_base +
 						ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS)
-				& 0xFF;
+				& IPI_DOORBELL_MASK;
 
-			writel(0x0, per_cpu_int_base +
+			writel(~IPI_DOORBELL_MASK, per_cpu_int_base +
 				ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
 
 			/* Handle all pending doorbells */
-			for (ipinr = 0; ipinr < ACTIVE_DOORBELLS; ipinr++) {
+			for (ipinr = IPI_DOORBELL_START;
+			     ipinr < IPI_DOORBELL_END; ipinr++) {
 				if (ipimask & (0x1 << ipinr))
 					handle_IPI(ipinr, regs);
 			}
-- 
1.7.9.5
