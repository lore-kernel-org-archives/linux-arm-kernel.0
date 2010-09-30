From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 30 Sep 2010 12:58:07 -0700
Subject: [PATCH] GIC: Dont disable INT in ack callback
Message-ID: <1285876687-2253-1-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abhijeet Dharmapurikar <adharmap@codeaurora.org>

Masking in the ack callback fails to work with handle_percpu_irq and handle_edge_irq.
The interrupt stays disabled after the first invocation since percpu and edge irq do
not unmask an interrupt after handling it. For handle_level_irq masking in the ack
is redundant because ack is always called after mask in the mask_ack function.

Masking in the ack function is required only when __do_IRQ was used instead of flow
handlers, but using __do_IRQ has been deprecated.

Remove the masking of interrupt from the ack callback.

Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/common/gic.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 7dfa9a8..ada6359 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -67,25 +67,11 @@ static inline unsigned int gic_irq(unsigned int irq)
 
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
-	writel(mask, gic_dist_base(irq) + GIC_DIST_ENABLE_CLEAR + (gic_irq(irq) / 32) * 4);
 	writel(gic_irq(irq), gic_cpu_base(irq) + GIC_CPU_EOI);
 	spin_unlock(&irq_controller_lock);
 }
-- 
1.7.1

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
