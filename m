From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  1 Aug 2013 15:25:10 +0200
Subject: [PATCHv6 07/13] irqdomain: add function to find a MSI irq_domain
In-Reply-To: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1375363516-2620-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that an irq_domain can be associated to a msi_chip structure, a
given PCIe driver will want to find this irq_domain, based on the
Device Tree node of the interrupt controller, as pointed by the
'msi-controller' DT property.

However, since on those platforms a single piece of hardware,
represented by a single DT node can provide both a "normal" IRQ domain
and a MSI-type IRQ domain, we need separate lookup functions to
distinguish them.

This patch makes irq_find_host() find only non-MSI-type IRQ domains,
and introduces irq_find_msi_host() to find only MSI-type IRQ
domains. It does so by factorizing the irq_find_host() logic into
__irq_find_host().

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 include/linux/irqdomain.h | 21 ++++++++++++++++++++-
 kernel/irq/irqdomain.c    | 13 ++++++++++---
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index b0504ff..fc669b4 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -129,7 +129,8 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 					 irq_hw_number_t first_hwirq,
 					 const struct irq_domain_ops *ops,
 					 void *host_data);
-extern struct irq_domain *irq_find_host(struct device_node *node);
+struct irq_domain *__irq_find_host(struct device_node *node,
+				   bool findmsi);
 extern void irq_set_default_host(struct irq_domain *host);
 
 /**
@@ -196,6 +197,24 @@ static inline struct irq_domain *irq_domain_add_msi(struct device_node *of_node,
 }
 
 
+/**
+ * irq_find_host() - Locates a domain for a given device node
+ * @node: device-tree node of the interrupt controller
+ */
+static inline struct irq_domain *irq_find_host(struct device_node *node)
+{
+	return __irq_find_host(node, false);
+}
+
+/**
+ * irq_find_msi_host() - Locates a MSI domain for a given device node
+ * @node: device-tree node of the interrupt controller
+ */
+static inline struct irq_domain *irq_find_msi_host(struct device_node *node)
+{
+	return __irq_find_host(node, true);
+}
+
 extern void irq_domain_remove(struct irq_domain *host);
 
 extern int irq_domain_associate(struct irq_domain *domain, unsigned int irq,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 8d02af7..6d066e2 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -197,10 +197,14 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
 
 /**
- * irq_find_host() - Locates a domain for a given device node
+ * __irq_find_host() - Locates a domain for a given device node,
+ * taking into account whether the domain is of MSI-type or not.
  * @node: device-tree node of the interrupt controller
+ * @findmsi: true when the domain being search is of MSI-type, false
+ * otherwise.
  */
-struct irq_domain *irq_find_host(struct device_node *node)
+struct irq_domain *__irq_find_host(struct device_node *node,
+				   bool findmsi)
 {
 	struct irq_domain *h, *found = NULL;
 	int rc;
@@ -212,6 +216,9 @@ struct irq_domain *irq_find_host(struct device_node *node)
 	 */
 	mutex_lock(&irq_domain_mutex);
 	list_for_each_entry(h, &irq_domain_list, link) {
+		if ((findmsi && !h->msi_chip) ||
+		    (!findmsi && h->msi_chip))
+			continue;
 		if (h->ops->match)
 			rc = h->ops->match(h, node);
 		else
@@ -225,7 +232,7 @@ struct irq_domain *irq_find_host(struct device_node *node)
 	mutex_unlock(&irq_domain_mutex);
 	return found;
 }
-EXPORT_SYMBOL_GPL(irq_find_host);
+EXPORT_SYMBOL_GPL(__irq_find_host);
 
 /**
  * irq_set_default_host() - Set a "default" irq domain
-- 
1.8.1.2
