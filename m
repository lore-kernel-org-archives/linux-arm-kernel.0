From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Wed, 21 Oct 2015 11:47:27 -0700
Subject: [PATCH V3 4/6] irqdomain: Introduce
 irq_domain_get_irqchip_fwnode_name helper function
In-Reply-To: <1445453249-32557-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1445453249-32557-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1445453249-32557-5-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds an accessor function to retrieve struct irqchip_fwid.name.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 include/linux/irqdomain.h |  1 +
 kernel/irq/irqdomain.c    | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 4950a71..006633d 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -187,6 +187,7 @@ static inline struct device_node *irq_domain_get_of_node(struct irq_domain *d)
 #ifdef CONFIG_IRQ_DOMAIN
 struct fwnode_handle *irq_domain_alloc_fwnode(void *data);
 void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
+const char *irq_domain_get_irqchip_fwnode_name(struct fwnode_handle *fwnode);
 struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 				    irq_hw_number_t hwirq_max, int direct_max,
 				    const struct irq_domain_ops *ops,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 7f34d98..a8c1cf6 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -79,6 +79,24 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode)
 }
 
 /**
+ * irq_domain_get_irqchip_fwnode_name - Retrieve associated name of
+ *                                      specified irqchip fwnode
+ * @fwnode: Specified fwnode_handle
+ *
+ * Returns associated name of the specified fwnode, or NULL on failure.
+ */
+const char *irq_domain_get_irqchip_fwnode_name(struct fwnode_handle *fwnode)
+{
+	struct irqchip_fwid *fwid;
+
+	if (!is_fwnode_irqchip(fwnode))
+		return NULL;
+
+	fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
+	return fwid->name;
+}
+
+/**
  * __irq_domain_add() - Allocate a new irq_domain data structure
  * @of_node: optional device-tree node of the interrupt controller
  * @size: Size of linear map; 0 for radix mapping only
-- 
2.1.0
