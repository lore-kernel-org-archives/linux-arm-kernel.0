From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 Jun 2014 10:28:42 +0100
Subject: [RFC PATCH 1/9] genirq: Add IRQD_IRQ_FORWARDED flag and accessors
In-Reply-To: <1403688530-23273-1-git-send-email-marc.zyngier@arm.com>
References: <1403688530-23273-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1403688530-23273-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some interrupt controllers support a split EOI behaviour, where
an active interrupt can be forwarded to a VM, and directly EOIed
from the guest.

Allow the irq_data to carry a flag describing this setup.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irq.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 0d998d8..b4b3120 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -186,6 +186,7 @@ enum {
 	IRQD_IRQ_DISABLED		= (1 << 16),
 	IRQD_IRQ_MASKED			= (1 << 17),
 	IRQD_IRQ_INPROGRESS		= (1 << 18),
+	IRQD_IRQ_FORWARDED		= (1 << 19),
 };
 
 static inline bool irqd_is_setaffinity_pending(struct irq_data *d)
@@ -272,6 +273,21 @@ static inline void irqd_clr_chained_irq_inprogress(struct irq_data *d)
 	d->state_use_accessors &= ~IRQD_IRQ_INPROGRESS;
 }
 
+static inline void irqd_set_irq_forwarded(struct irq_data *d)
+{
+	d->state_use_accessors |= IRQD_IRQ_FORWARDED;
+}
+
+static inline void irqd_clr_irq_forwarded(struct irq_data *d)
+{
+	d->state_use_accessors &= ~IRQD_IRQ_FORWARDED;
+}
+
+static inline bool irqd_irq_forwarded(struct irq_data *d)
+{
+	return d->state_use_accessors & IRQD_IRQ_FORWARDED;
+}
+
 static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
 {
 	return d->hwirq;
-- 
1.8.3.4
