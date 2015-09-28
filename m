From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 28 Sep 2015 17:42:56 +0100
Subject: [PATCH v4 3/9] genirq/irqdomain: Add a fwnode_handle allocator
In-Reply-To: <1443458582-7497-1-git-send-email-marc.zyngier@arm.com>
References: <1443458582-7497-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1443458582-7497-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to be able to reference an irqdomain from ACPI, we need
to be able to create an identifier, which is a struct device_node.

This device node does't really fit the ACPI infrastructure, so
we cunningly hide it by returning the contained fwnode_handle.
This will help a (still hypothetical) further migration of
irqdomain from device_node to fwnode_handle.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irqdomain.h |  2 ++
 kernel/irq/irqdomain.c    | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index d3ca792..3193c61 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -162,6 +162,8 @@ enum {
 };
 
 #ifdef CONFIG_IRQ_DOMAIN
+struct fwnode_handle *irq_domain_alloc_fwnode(void *data);
+void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
 struct irq_domain *__irq_domain_add(struct device_node *of_node, int size,
 				    irq_hw_number_t hwirq_max, int direct_max,
 				    const struct irq_domain_ops *ops,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index e5c1e4c..5e7214a 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -29,6 +29,36 @@ static int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
 static void irq_domain_check_hierarchy(struct irq_domain *domain);
 
 /**
+ * irq_domain_alloc_fwnode - Allocate a OF-backed fwnode_handle suitable for
+ *                           identifying an irq domain
+ * @data: optional user-provided data
+ *
+ * Allocate a struct device_node, and return a poiner to the embedded
+ * fwnode_handle (or NULL on failure).
+ */
+struct fwnode_handle *irq_domain_alloc_fwnode(void *data)
+{
+	struct device_node *of_node;
+
+	of_node = of_node_alloc("irqdomain@%p", data);
+	if (!of_node)
+		return NULL;
+
+	of_node->data = data;
+	return &of_node->fwnode;
+}
+
+/**
+ * irq_domain_free_fwnode - Free a OF-backed fwnode_handle
+ *
+ * Free a fwnode_handle allocated with irq_domain_alloc_fwnode.
+ */
+void irq_domain_free_fwnode(struct fwnode_handle *fwnode)
+{
+	of_node_put(to_of_node(fwnode));
+}
+
+/**
  * __irq_domain_add() - Allocate a new irq_domain data structure
  * @of_node: optional device-tree node of the interrupt controller
  * @size: Size of linear map; 0 for radix mapping only
-- 
2.1.4
