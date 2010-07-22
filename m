From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Thu, 22 Jul 2010 15:57:30 -0700
Subject: [PATCH] GIC: Dont disable INT in ack callback
Message-ID: <1279839450-6477-1-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abhijeet Dharmapurikar <adharmap@codeaurora.org>

Unless gic_ack_irq is called from __do_IRQ, interrupt should not
be disabled in the ack function. Disabling the interrupt causes
handle_edge_irq to never enable it again.

Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
---
 arch/arm/common/gic.c |   31 ++++++++++++++++++-------------
 1 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 337741f..1ac2f31 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -67,25 +67,30 @@ static inline unsigned int gic_irq(unsigned int irq)
 
 /*
  * Routines to acknowledge, disable and enable interrupts
- *
- * Linux assumes that when we're done with an interrupt we need to
- * unmask it, in the same way we need to unmask an interrupt when
- * we first enable it.
- *
- * The GIC has a separate notion of "end of interrupt" to re-enable
- * an interrupt after handling, in order to support hardware
- * prioritisation.
- *
- * We can make the GIC behave in the way that Linux expects by making
- * our "acknowledge" routine disable the interrupt, then mark it as
- * complete.
  */
 static void gic_ack_irq(unsigned int irq)
 {
-	u32 mask = 1 << (irq % 32);
 
 	spin_lock(&irq_controller_lock);
+
+#ifndef CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ
+	u32 mask = 1 << (irq % 32);
+
+	 /*
+	  * Linux assumes that when we're done with an interrupt we need to
+	  * unmask it, in the same way we need to unmask an interrupt when
+	  * we first enable it.
+	  *
+	  * The GIC has a separate notion of "end of interrupt" to re-enable
+	  * an interrupt after handling, in order to support hardware
+	  * prioritisation.
+	  *
+	  * We can make the GIC behave in the way that Linux expects by making
+	  * our "acknowledge" routine disable the interrupt, then mark it as
+	  * complete.
+	  */
 	writel(mask, gic_dist_base(irq) + GIC_DIST_ENABLE_CLEAR + (gic_irq(irq) / 32) * 4);
+#endif
 	writel(gic_irq(irq), gic_cpu_base(irq) + GIC_CPU_EOI);
 	spin_unlock(&irq_controller_lock);
 }
-- 
1.7.1
