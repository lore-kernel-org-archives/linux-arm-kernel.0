From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Wed, 29 Dec 2010 21:29:20 -0800
Subject: [PATCH] GIC: Assign correct flow handler type in set_type callback
Message-ID: <1293686960-12581-1-git-send-email-adharmap@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some interrupts that are true edge triggered in nature. If not
marked IRQ_PENDING, when disabled, they will be lost.

Use the set_type callback to assign the correct flow type handler for
shared peripheral interrupts.

Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
---
This came to light when a edge triggered interrupt was supposed to wakeup the
sytem. The flow handler was set to the default handle_level_irq. On the resume
path the flow handler was invoked right after the I bit was cleared but before
each individual interrupts were enabled. This made the handle_level_irq ignore
the interrupt (mask_ack it) and it was lost. handle_edge_irq does the right
thing by marking the interrupt as IRQ_PENDING and when the resume code gets to
enabling each interrupt this interrupt is resent again.

 arch/arm/common/gic.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index e6388dc..a83594a 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -136,6 +136,9 @@ static int gic_set_type(unsigned int irq, unsigned int type)
 
 	spin_unlock(&irq_controller_lock);
 
+	if ((type & IRQ_TYPE_EDGE_RISING) && gicirq > 31)
+		__set_irq_handler_unlocked(irq, handle_edge_irq);
+
 	return 0;
 }
 
-- 
1.7.1
Sent by an employee of Qualcomm Innovation Center, Inc. Qualcomm Innovation
Center, Inc. is a member of Code Aurora Forum.
