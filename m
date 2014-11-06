From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Thu,  6 Nov 2014 22:20:17 +0800
Subject: [Patch Part2 v5 04/31] genirq: Introduce
 irq_chip.irq_compose_msi_msg() to support stacked irqchip
In-Reply-To: <1415283644-2559-1-git-send-email-jiang.liu@linux.intel.com>
References: <1415283644-2559-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <1415283644-2559-5-git-send-email-jiang.liu@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add callback irq_compose_msi_msg to struct irq_chip, which will be used
to support stacked irqchip.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/irq.h |    5 +++++
 kernel/irq/chip.c   |   17 +++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 0adcbbbf2e87..536b7fc6c8f4 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -29,6 +29,7 @@ struct seq_file;
 struct module;
 struct irq_desc;
 struct irq_data;
+struct msi_msg;
 typedef	void (*irq_flow_handler_t)(unsigned int irq,
 					    struct irq_desc *desc);
 typedef	void (*irq_preflow_handler_t)(struct irq_data *data);
@@ -320,6 +321,7 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
  *				any other callback related to this irq
  * @irq_release_resources:	optional to release resources acquired with
  *				irq_request_resources
+ * @irq_compose_msi_msg:	optional to compose message content for MSI
  * @flags:		chip specific flags
  */
 struct irq_chip {
@@ -356,6 +358,8 @@ struct irq_chip {
 	int		(*irq_request_resources)(struct irq_data *data);
 	void		(*irq_release_resources)(struct irq_data *data);
 
+	void		(*irq_compose_msi_msg)(struct irq_data *data, struct msi_msg *msg);
+
 	unsigned long	flags;
 };
 
@@ -443,6 +447,7 @@ extern void handle_percpu_devid_irq(unsigned int irq, struct irq_desc *desc);
 extern void handle_bad_irq(unsigned int irq, struct irq_desc *desc);
 extern void handle_nested_irq(unsigned int irq);
 
+extern int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 extern void irq_chip_ack_parent(struct irq_data *data);
 extern int irq_chip_retrigger_hierarchy(struct irq_data *data);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 12f3e72449eb..8f362db17a8a 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -867,3 +867,20 @@ int irq_chip_retrigger_hierarchy(struct irq_data *data)
 	return -ENOSYS;
 }
 #endif
+
+int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct irq_data *pos = NULL;
+
+#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
+	for (; data; data = data->parent_data)
+#endif
+		if (data->chip && data->chip->irq_compose_msi_msg)
+			pos = data;
+	if (!pos)
+		return -ENOSYS;
+
+	pos->chip->irq_compose_msi_msg(pos, msg);
+
+	return 0;
+}
-- 
1.7.10.4
