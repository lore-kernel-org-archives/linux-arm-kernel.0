From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat,  6 Dec 2014 13:46:12 +0000
Subject: [PATCH 1/5] genirq: Add irqchip_set_wake_parent
In-Reply-To: <1417873576-10463-1-git-send-email-marc.zyngier@arm.com>
References: <1417873576-10463-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1417873576-10463-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This proves to be usefull with stacked domains.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irq.h |  1 +
 kernel/irq/chip.c   | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 8badf34..7de85b8 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -459,6 +459,7 @@ extern void irq_chip_eoi_parent(struct irq_data *data);
 extern int irq_chip_set_affinity_parent(struct irq_data *data,
 					const struct cpumask *dest,
 					bool force);
+extern int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on);
 #endif
 
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 6f1c7a5..96c190b 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -948,6 +948,22 @@ int irq_chip_retrigger_hierarchy(struct irq_data *data)
 
 	return -ENOSYS;
 }
+
+/**
+ * irq_chip_set_wake - Set/reset wake-up on the parent interrupt
+ * @data:	Pointer to interrupt specific data
+ * @on:		Whether to set or reset the wake-up capability of this irq
+ *
+ * Conditional, as the underlying parent chip might not implement it.
+ */
+int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on)
+{
+	data = data->parent_data;
+	if (data->chip->irq_set_wake)
+		return data->chip->irq_set_wake(data, on);
+
+	return -ENOSYS;
+}
 #endif
 
 /**
-- 
2.1.3
