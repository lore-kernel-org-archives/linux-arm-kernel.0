From: stefan@agner.ch (Stefan Agner)
Date: Sat, 16 May 2015 11:44:14 +0200
Subject: [PATCH v7 02/13] genirq: Add irq_chip_(enable|disable)_parent
In-Reply-To: <1431769465-26867-1-git-send-email-stefan@agner.ch>
References: <1431769465-26867-1-git-send-email-stefan@agner.ch>
Message-ID: <1431769465-26867-3-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add helper irq_chip_enable_parent and irq_chip_disable_parent. The
helper implement the default behavior in case irq_enable or irq_disable
is not implemented for the parent interrupt chip, which is calling the
irq_mask or irq_unmask respectively.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 include/linux/irq.h |  2 ++
 kernel/irq/chip.c   | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 62c6901..2633061 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -458,6 +458,8 @@ extern void handle_nested_irq(unsigned int irq);
 
 extern int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
+extern void irq_chip_enable_parent(struct irq_data *data);
+extern void irq_chip_disable_parent(struct irq_data *data);
 extern void irq_chip_ack_parent(struct irq_data *data);
 extern int irq_chip_retrigger_hierarchy(struct irq_data *data);
 extern void irq_chip_mask_parent(struct irq_data *data);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index eb9a4ea..2456fe8 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -876,6 +876,34 @@ void irq_cpu_offline(void)
 
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 /**
+ * irq_chip_enable_parent - Enable the parent interrupt (defaults to unmask if
+ * NULL)
+ * @data:	Pointer to interrupt specific data
+ */
+void irq_chip_enable_parent(struct irq_data *data)
+{
+	data = data->parent_data;
+	if (data->chip->irq_enable)
+		data->chip->irq_enable(data);
+	else
+		data->chip->irq_unmask(data);
+}
+
+/**
+ * irq_chip_disable_parent - Disable the parent interrupt (defaults to mask if
+ * NULL)
+ * @data:	Pointer to interrupt specific data
+ */
+void irq_chip_disable_parent(struct irq_data *data)
+{
+	data = data->parent_data;
+	if (data->chip->irq_disable)
+		data->chip->irq_disable(data);
+	else
+		data->chip->irq_mask(data);
+}
+
+/**
  * irq_chip_ack_parent - Acknowledge the parent interrupt
  * @data:	Pointer to interrupt specific data
  */
-- 
2.4.1
