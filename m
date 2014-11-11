From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 11 Nov 2014 15:47:59 +0000
Subject: [PATCH 01/15] genirq: Add a few more helper funtions to support
 stacked irq_chip
In-Reply-To: <1415720893-13371-1-git-send-email-marc.zyngier@arm.com>
References: <1415720893-13371-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1415720893-13371-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To follow-up on 9e310a9 (genirq: Introduce helper functions to support
stacked irq_chip), add a few additional helpers to deal with mask/unmask
and eoi.

This is required to support the standard ARM interrupt controllers
(GIC/GICv3).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irq.h |  6 ++++++
 kernel/irq/chip.c   | 31 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 041edd6..aec2145 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -454,6 +454,12 @@ extern void handle_nested_irq(unsigned int irq);
 extern int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 extern void irq_chip_ack_parent(struct irq_data *data);
+extern void irq_chip_mask_parent(struct irq_data *data);
+extern void irq_chip_unmask_parent(struct irq_data *data);
+extern void irq_chip_eoi_parent(struct irq_data *data);
+extern int irq_chip_set_affinity_parent(struct irq_data *data,
+					const struct cpumask *mask_val,
+					bool force);
 extern int irq_chip_retrigger_hierarchy(struct irq_data *data);
 #endif
 
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 8f362db..d028b34 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -858,6 +858,37 @@ void irq_chip_ack_parent(struct irq_data *data)
 	data->chip->irq_ack(data);
 }
 
+void irq_chip_mask_parent(struct irq_data *data)
+{
+	data = data->parent_data;
+	if (data && data->chip && data->chip->irq_mask)
+		data->chip->irq_mask(data);
+}
+
+void irq_chip_unmask_parent(struct irq_data *data)
+{
+	data = data->parent_data;
+	if (data && data->chip && data->chip->irq_unmask)
+		data->chip->irq_unmask(data);
+}
+
+void irq_chip_eoi_parent(struct irq_data *data)
+{
+	data = data->parent_data;
+	if (data && data->chip && data->chip->irq_eoi)
+		data->chip->irq_eoi(data);
+}
+
+int irq_chip_set_affinity_parent(struct irq_data *data,
+				 const struct cpumask *mask_val, bool force)
+{
+	data = data->parent_data;
+	if (data && data->chip && data->chip->irq_set_affinity)
+		return data->chip->irq_set_affinity(data, mask_val, force);
+
+	return -EINVAL;
+}
+
 int irq_chip_retrigger_hierarchy(struct irq_data *data)
 {
 	for (data = data->parent_data; data; data = data->parent_data)
-- 
2.0.4
