From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Mon, 17 Nov 2014 19:03:17 +0800
Subject: [Patch V3 4/9] irqdomain: Introduce helper function
 irq_domain_add_hierarchy()
In-Reply-To: <1416222202-28002-1-git-send-email-jiang.liu@linux.intel.com>
References: <1416222202-28002-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <1416222202-28002-5-git-send-email-jiang.liu@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce helper function irq_domain_add_hierarchy(), which creates
a linear irqdomain if parameter 'size' is not zero, otherwise creates
a tree irqdomain.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/irqdomain.h |    4 ++++
 kernel/irq/irqdomain.c    |   19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index ad92b0b15945..30e8c753fa98 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -248,6 +248,10 @@ int irq_domain_xlate_onetwocell(struct irq_domain *d, struct device_node *ctrlr,
 extern struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
 						unsigned int virq);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
+extern struct irq_domain *irq_domain_add_hierarchy(struct irq_domain *parent,
+			unsigned int flags, unsigned int size,
+			struct device_node *node,
+			const struct irq_domain_ops *ops, void *host_data);
 extern int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 				   unsigned int nr_irqs, int node, void *arg,
 				   bool realloc);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 03fc7d018324..73c66d6f9ffc 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -742,6 +742,25 @@ static int irq_domain_alloc_descs(int virq, unsigned int cnt,
 }
 
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
+struct irq_domain *irq_domain_add_hierarchy(struct irq_domain *parent,
+			unsigned int flags, unsigned int size,
+			struct device_node *node,
+			const struct irq_domain_ops *ops, void *host_data)
+{
+	struct irq_domain *domain;
+
+	if (size)
+		domain = irq_domain_add_linear(node, size, ops, host_data);
+	else
+		domain = irq_domain_add_tree(node, ops, host_data);
+	if (domain) {
+		domain->parent = parent;
+		domain->flags |= flags;
+	}
+
+	return domain;
+}
+
 static void irq_domain_insert_irq(int virq)
 {
 	struct irq_data *data;
-- 
1.7.10.4
