From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 13 Oct 2015 12:51:30 +0100
Subject: [PATCH v2 02/17] irqdomain: Convert irqdomain->of_node to fwnode
In-Reply-To: <1444737105-31573-1-git-send-email-marc.zyngier@arm.com>
References: <1444737105-31573-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1444737105-31573-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have everyone accessing the of_node field via the
irq_domain_get_of_node accessor, it is pretty easy to swap it
for a pointer to a fwnode_handle.

This translates into a few limited changes in __irq_domain_add,
and an updated irq_domain_get_of_node.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irqdomain.h | 5 +++--
 kernel/irq/irqdomain.c    | 6 +++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index f644fdb..2f508f4 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -34,6 +34,7 @@
 
 #include <linux/types.h>
 #include <linux/irqhandler.h>
+#include <linux/of.h>
 #include <linux/radix-tree.h>
 
 struct device_node;
@@ -130,7 +131,7 @@ struct irq_domain {
 	unsigned int flags;
 
 	/* Optional data */
-	struct device_node *of_node;
+	struct fwnode_handle *fwnode;
 	enum irq_domain_bus_token bus_token;
 	struct irq_domain_chip_generic *gc;
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
@@ -163,7 +164,7 @@ enum {
 
 static inline struct device_node *irq_domain_get_of_node(struct irq_domain *d)
 {
-	return d->of_node;
+	return to_of_node(d->fwnode);
 }
 
 #ifdef CONFIG_IRQ_DOMAIN
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 8f8b538..1aee5c1 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -46,17 +46,21 @@ struct irq_domain *__irq_domain_add(struct device_node *of_node, int size,
 				    void *host_data)
 {
 	struct irq_domain *domain;
+	struct fwnode_handle *fwnode;
 
 	domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
 			      GFP_KERNEL, of_node_to_nid(of_node));
 	if (WARN_ON(!domain))
 		return NULL;
 
+	of_node_get(of_node);
+	fwnode = of_node ? &of_node->fwnode : NULL;
+
 	/* Fill structure */
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
 	domain->ops = ops;
 	domain->host_data = host_data;
-	domain->of_node = of_node_get(of_node);
+	domain->fwnode = fwnode;
 	domain->hwirq_max = hwirq_max;
 	domain->revmap_size = size;
 	domain->revmap_direct_max_irq = direct_max;
-- 
2.1.4
