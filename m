From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  6 Oct 2015 18:36:20 +0100
Subject: [PATCH 07/16] irqdomain: Introduce irq_domain_create_{linear,tree}
In-Reply-To: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com>
References: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1444152989-31726-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like we have irq_domain_add_{linear,tree} to create a irq domain
identified by an of_node, introduce irq_domain_create_{linear,tree}
that do the same thing, except that they take a struct fwnode_handle.

Existing functions get rewritten in terms of the new ones so that
everything keeps working as before (and __irq_domain_add is now
fwnode_handle based as well).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irqdomain.h | 31 +++++++++++++++++++++++++------
 kernel/irq/irqdomain.c    | 11 ++++++-----
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 7e7842e..995d4c5 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -188,7 +188,7 @@ static inline struct device_node *irq_domain_get_of_node(struct irq_domain *d)
 }
 
 #ifdef CONFIG_IRQ_DOMAIN
-struct irq_domain *__irq_domain_add(struct device_node *of_node, int size,
+struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 				    irq_hw_number_t hwirq_max, int direct_max,
 				    const struct irq_domain_ops *ops,
 				    void *host_data);
@@ -207,11 +207,15 @@ extern struct irq_domain *irq_find_matching_fwnode(struct fwnode_handle *fwnode,
 						   enum irq_domain_bus_token bus_token);
 extern void irq_set_default_host(struct irq_domain *host);
 
+static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *node)
+{
+	return node ? &node->fwnode : NULL;
+}
+
 static inline struct irq_domain *irq_find_matching_host(struct device_node *node,
 							enum irq_domain_bus_token bus_token)
 {
-	return irq_find_matching_fwnode(node ? &node->fwnode : NULL,
-					bus_token);
+	return irq_find_matching_fwnode(of_node_to_fwnode(node), bus_token);
 }
 
 static inline struct irq_domain *irq_find_host(struct device_node *node)
@@ -231,14 +235,14 @@ static inline struct irq_domain *irq_domain_add_linear(struct device_node *of_no
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node, size, size, 0, ops, host_data);
+	return __irq_domain_add(of_node_to_fwnode(of_node), size, size, 0, ops, host_data);
 }
 static inline struct irq_domain *irq_domain_add_nomap(struct device_node *of_node,
 					 unsigned int max_irq,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node, 0, max_irq, max_irq, ops, host_data);
+	return __irq_domain_add(of_node_to_fwnode(of_node), 0, max_irq, max_irq, ops, host_data);
 }
 static inline struct irq_domain *irq_domain_add_legacy_isa(
 				struct device_node *of_node,
@@ -252,7 +256,22 @@ static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_node
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node, 0, ~0, 0, ops, host_data);
+	return __irq_domain_add(of_node_to_fwnode(of_node), 0, ~0, 0, ops, host_data);
+}
+
+static inline struct irq_domain *irq_domain_create_linear(struct fwnode_handle *fwnode,
+					 unsigned int size,
+					 const struct irq_domain_ops *ops,
+					 void *host_data)
+{
+	return __irq_domain_add(fwnode, size, size, 0, ops, host_data);
+}
+
+static inline struct irq_domain *irq_domain_create_tree(struct fwnode_handle *fwnode,
+					 const struct irq_domain_ops *ops,
+					 void *host_data)
+{
+	return __irq_domain_add(fwnode, 0, ~0, 0, ops, host_data);
 }
 
 extern void irq_domain_remove(struct irq_domain *host);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 2adc84e..ea62f67 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -40,13 +40,15 @@ static void irq_domain_check_hierarchy(struct irq_domain *domain);
  * Allocates and initialize and irq_domain structure.
  * Returns pointer to IRQ domain, or NULL on failure.
  */
-struct irq_domain *__irq_domain_add(struct device_node *of_node, int size,
+struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 				    irq_hw_number_t hwirq_max, int direct_max,
 				    const struct irq_domain_ops *ops,
 				    void *host_data)
 {
 	struct irq_domain *domain;
-	struct fwnode_handle *fwnode;
+	struct device_node *of_node;
+
+	of_node = to_of_node(fwnode);
 
 	domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
 			      GFP_KERNEL, of_node_to_nid(of_node));
@@ -54,7 +56,6 @@ struct irq_domain *__irq_domain_add(struct device_node *of_node, int size,
 		return NULL;
 
 	of_node_get(of_node);
-	fwnode = of_node ? &of_node->fwnode : NULL;
 
 	/* Fill structure */
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
@@ -137,7 +138,7 @@ struct irq_domain *irq_domain_add_simple(struct device_node *of_node,
 {
 	struct irq_domain *domain;
 
-	domain = __irq_domain_add(of_node, size, size, 0, ops, host_data);
+	domain = __irq_domain_add(of_node_to_fwnode(of_node), size, size, 0, ops, host_data);
 	if (!domain)
 		return NULL;
 
@@ -181,7 +182,7 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 {
 	struct irq_domain *domain;
 
-	domain = __irq_domain_add(of_node, first_hwirq + size,
+	domain = __irq_domain_add(of_node_to_fwnode(of_node), first_hwirq + size,
 				  first_hwirq + size, 0, ops, host_data);
 	if (domain)
 		irq_domain_associate_many(domain, first_irq, first_hwirq, size);
-- 
2.1.4
