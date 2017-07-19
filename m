From: opendmb@gmail.com (Doug Berger)
Date: Wed, 19 Jul 2017 12:07:29 -0700
Subject: [PATCH v2 1/6] genirq: generic chip: add
 irq_gc_mask_disable_and_ack_set()
In-Reply-To: <20170719190734.18566-1-opendmb@gmail.com>
References: <20170719190734.18566-1-opendmb@gmail.com>
Message-ID: <20170719190734.18566-2-opendmb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq_gc_mask_disable_reg_and_ack() function name implies that it
provides the combined functions of irq_gc_mask_disable_reg() and
irq_gc_ack().  However, the implementation does not actually do
that since it writes the mask instead of the disable register. It
also does not maintain the mask cache which makes it inappropriate
to use with other masking functions.

In addition, commit 659fb32d1b67 ("genirq: replace irq_gc_ack() with
{set,clr}_bit variants (fwd)") effectively renamed irq_gc_ack() to
irq_gc_ack_set_bit() so this function probably should have also been
renamed at that time.

The generic chip code currently provides three functions for use
with the irq_mask member of the irq_chip structure and two functions
for use with the irq_ack member of the irq_chip structure. These
functions could be combined into six functions for use with the
irq_mask_ack member of the irq_chip structure.  However, since only
one of the combinations is currently used, only the function
irq_gc_mask_disable_and_ack_set() is added by this commit.

The '_reg' and '_bit' portions of the base function name were left
out of the new combined function name in an attempt to keep the
function name length manageable with the 80 character source code
line length while still allowing the distinct aspects of each
combination to be captured by the name.

If other combinations are desired in the future please add them to
the irq generic chip library at that time.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 include/linux/irq.h       |  1 +
 kernel/irq/generic-chip.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 00db35b61e9e..5b27f65c47d0 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1003,6 +1003,7 @@ void irq_gc_unmask_enable_reg(struct irq_data *d);
 void irq_gc_ack_set_bit(struct irq_data *d);
 void irq_gc_ack_clr_bit(struct irq_data *d);
 void irq_gc_mask_disable_reg_and_ack(struct irq_data *d);
+void irq_gc_mask_disable_and_ack_set(struct irq_data *d);
 void irq_gc_eoi(struct irq_data *d);
 int irq_gc_set_wake(struct irq_data *d, unsigned int on);
 
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index f7086b78ad6e..7f61b6e9f5ca 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -151,6 +151,31 @@ void irq_gc_mask_disable_reg_and_ack(struct irq_data *d)
 }
 
 /**
+ * irq_gc_mask_disable_and_ack_set - Mask and ack pending interrupt
+ * @d: irq_data
+ *
+ * This generic implementation of the irq_mask_ack method is for chips
+ * with separate enable/disable registers instead of a single mask
+ * register and where a pending interrupt is acknowledged by setting a
+ * bit.
+ *
+ * Note: This is the only permutation currently used.  Similar generic
+ * functions should be added here if other permutations are required.
+ */
+void irq_gc_mask_disable_and_ack_set(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
+	u32 mask = d->mask;
+
+	irq_gc_lock(gc);
+	irq_reg_writel(gc, mask, ct->regs.disable);
+	*ct->mask_cache &= ~mask;
+	irq_reg_writel(gc, mask, ct->regs.ack);
+	irq_gc_unlock(gc);
+}
+
+/**
  * irq_gc_eoi - EOI interrupt
  * @d: irq_data
  */
-- 
2.13.0
