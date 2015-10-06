From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  6 Oct 2015 18:36:28 +0100
Subject: [PATCH 15/16] irqdomain: Introduce irq_domain_create_hierarchy
In-Reply-To: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com>
References: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1444152989-31726-16-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we're about to start converting the various MSI layers to
use fwnode_handle instead of device_node, add irq_domain_create_hierarchy
as a directly equivalent of irq_domain_add_hierarchy (which still
exists as a compatibility interface).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irqdomain.h | 17 +++++++++++++++--
 kernel/irq/irqdomain.c    | 10 +++++-----
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 949caa7..2b3340ae 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -340,10 +340,23 @@ extern void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
 				void *chip_data, irq_flow_handler_t handler,
 				void *handler_data, const char *handler_name);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
-extern struct irq_domain *irq_domain_add_hierarchy(struct irq_domain *parent,
+extern struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
 			unsigned int flags, unsigned int size,
-			struct device_node *node,
+			struct fwnode_handle *fwnode,
 			const struct irq_domain_ops *ops, void *host_data);
+
+static inline struct irq_domain *irq_domain_add_hierarchy(struct irq_domain *parent,
+					    unsigned int flags,
+					    unsigned int size,
+					    struct device_node *node,
+					    const struct irq_domain_ops *ops,
+					    void *host_data)
+{
+	return irq_domain_create_hierarchy(parent, flags, size,
+					   of_node_to_fwnode(node),
+					   ops, host_data);
+}
+
 extern int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 				   unsigned int nr_irqs, int node, void *arg,
 				   bool realloc);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 6fbecae..a53b60f 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -858,7 +858,7 @@ static int irq_domain_alloc_descs(int virq, unsigned int cnt,
  * @parent:	Parent irq domain to associate with the new domain
  * @flags:	Irq domain flags associated to the domain
  * @size:	Size of the domain. See below
- * @node:	Optional device-tree node of the interrupt controller
+ * @fwnode:	Optional fwnode of the interrupt controller
  * @ops:	Pointer to the interrupt domain callbacks
  * @host_data:	Controller private data pointer
  *
@@ -868,19 +868,19 @@ static int irq_domain_alloc_descs(int virq, unsigned int cnt,
  * domain flags are set.
  * Returns pointer to IRQ domain, or NULL on failure.
  */
-struct irq_domain *irq_domain_add_hierarchy(struct irq_domain *parent,
+struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
 					    unsigned int flags,
 					    unsigned int size,
-					    struct device_node *node,
+					    struct fwnode_handle *fwnode,
 					    const struct irq_domain_ops *ops,
 					    void *host_data)
 {
 	struct irq_domain *domain;
 
 	if (size)
-		domain = irq_domain_add_linear(node, size, ops, host_data);
+		domain = irq_domain_create_linear(fwnode, size, ops, host_data);
 	else
-		domain = irq_domain_add_tree(node, ops, host_data);
+		domain = irq_domain_create_tree(fwnode, ops, host_data);
 	if (domain) {
 		domain->parent = parent;
 		domain->flags |= flags;
-- 
2.1.4
