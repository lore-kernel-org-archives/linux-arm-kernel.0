From: yingjoe.chen@mediatek.com (Joe.C)
Date: Thu, 9 Oct 2014 22:29:35 +0800
Subject: [PATCH v3 2/7] genirq: Add more helper functions to support stacked
 irq_chip
In-Reply-To: <1412864980-20273-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1412864980-20273-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1412864980-20273-3-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Joe.C" <yingjoe.chen@mediatek.com>

Add more helper function for stacked irq_chip to just call parent's
function.

Signed-off-by: Joe.C <yingjoe.chen@mediatek.com>
---
 include/linux/irq.h |  5 +++++
 kernel/irq/chip.c   | 28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 07abf5a..6159256 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -437,6 +437,11 @@ extern void handle_nested_irq(unsigned int irq);
 
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 extern void irq_chip_ack_parent(struct irq_data *data);
+extern void irq_chip_mask_parent(struct irq_data *data);
+extern void irq_chip_unmask_parent(struct irq_data *data);
+extern void irq_chip_eoi_parent(struct irq_data *data);
+extern int irq_chip_set_affinity_parent(struct irq_data *data,
+				const struct cpumask *dest, bool force);
 extern int irq_chip_retrigger_hierarchy(struct irq_data *data);
 #endif
 
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 58ed9ed..0ecc270 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -829,6 +829,34 @@ void irq_chip_ack_parent(struct irq_data *data)
 	data->chip->irq_ack(data);
 }
 
+void irq_chip_mask_parent(struct irq_data *data)
+{
+	data = data->parent_data;
+	data->chip->irq_mask(data);
+}
+
+void irq_chip_unmask_parent(struct irq_data *data)
+{
+	data = data->parent_data;
+	data->chip->irq_unmask(data);
+}
+
+void irq_chip_eoi_parent(struct irq_data *data)
+{
+	data = data->parent_data;
+	data->chip->irq_eoi(data);
+}
+
+int irq_chip_set_affinity_parent(struct irq_data *data,
+				 const struct cpumask *dest, bool force)
+{
+	data = data->parent_data;
+	if (data->chip->irq_set_affinity)
+		return data->chip->irq_set_affinity(data, dest, force);
+
+	return -ENOSYS;
+}
+
 int irq_chip_retrigger_hierarchy(struct irq_data *data)
 {
 	for (data = data->parent_data; data; data = data->parent_data)
-- 
1.8.1.1.dirty
