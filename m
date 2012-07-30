From: chris.smith@st.com (Chris Smith)
Date: Mon, 30 Jul 2012 15:32:11 +0100
Subject: [PATCH 1/2] genirq: Provide an accessor for IRQ_PER_CPU flag.
Message-ID: <1343658732-31080-1-git-send-email-chris.smith@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds an accessor function, irq_is_per_cpu(), for the flag IRQ_PER_CPU.

This is useful if you have an IRQ that is per-cpu in some hardware
implementations, and not in others (example: ARM PMU Interrupts), and
you want to handle both cases.

Signed-off-by: Chris Smith <chris.smith@st.com>
---
 include/linux/irqdesc.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index f1e2527..771cb35 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -154,6 +154,14 @@ static inline int irq_balancing_disabled(unsigned int irq)
 	return desc->status_use_accessors & IRQ_NO_BALANCING_MASK;
 }
 
+static inline int irq_is_per_cpu(unsigned int irq)
+{
+	struct irq_desc *desc;
+
+	desc = irq_to_desc(irq);
+	return desc->status_use_accessors & IRQ_PER_CPU;
+}
+
 static inline void
 irq_set_lockdep_class(unsigned int irq, struct lock_class_key *class)
 {
-- 
1.7.6.5
