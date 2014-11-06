From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Thu,  6 Nov 2014 22:20:18 +0800
Subject: [Patch Part2 v5 05/31] genirq: Add IRQ_SET_MASK_OK_DONE to support
 stacked irqchip
In-Reply-To: <1415283644-2559-1-git-send-email-jiang.liu@linux.intel.com>
References: <1415283644-2559-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <1415283644-2559-6-git-send-email-jiang.liu@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add IRQ_SET_MASK_OK_DONE in addition to IRQ_SET_MASK_OK and
IRQ_SET_MASK_OK_NOCOPY to support stacked irqchip. IRQ_SET_MASK_OK_DONE
is the same as IRQ_SET_MASK_OK to irq core. To stacked irqchip, it means
that ascendant irqchips have done all the work and no more handling
needed in descendant irqchips.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/irq.h |    4 ++++
 kernel/irq/manage.c |    2 ++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 536b7fc6c8f4..041edd6dc409 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -114,10 +114,14 @@ enum {
  *
  * IRQ_SET_MASK_OK	- OK, core updates irq_data.affinity
  * IRQ_SET_MASK_NOCPY	- OK, chip did update irq_data.affinity
+ * IRQ_SET_MASK_OK_DONE	- Same as IRQ_SET_MASK_OK for core. Special code to
+ *			  support stacked irqchips, which indicates skipping
+ *			  all descendent irqchips.
  */
 enum {
 	IRQ_SET_MASK_OK = 0,
 	IRQ_SET_MASK_OK_NOCOPY,
+	IRQ_SET_MASK_OK_DONE,
 };
 
 struct msi_desc;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 0a9104b4608b..80692373abd6 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -183,6 +183,7 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	ret = chip->irq_set_affinity(data, mask, force);
 	switch (ret) {
 	case IRQ_SET_MASK_OK:
+	case IRQ_SET_MASK_OK_DONE:
 		cpumask_copy(data->affinity, mask);
 	case IRQ_SET_MASK_OK_NOCOPY:
 		irq_set_thread_affinity(desc);
@@ -600,6 +601,7 @@ int __irq_set_trigger(struct irq_desc *desc, unsigned int irq,
 
 	switch (ret) {
 	case IRQ_SET_MASK_OK:
+	case IRQ_SET_MASK_OK_DONE:
 		irqd_clear(&desc->irq_data, IRQD_TRIGGER_MASK);
 		irqd_set(&desc->irq_data, flags);
 
-- 
1.7.10.4
