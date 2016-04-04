From: tn@semihalf.com (Tomasz Nowicki)
Date: Mon,  4 Apr 2016 10:52:50 +0200
Subject: [PATCH V4 2/7] irqchip, GICv3,
 ITS: Cleanup for ITS domain initialization.
In-Reply-To: <1459759975-24097-1-git-send-email-tn@semihalf.com>
References: <1459759975-24097-1-git-send-email-tn@semihalf.com>
Message-ID: <1459759975-24097-3-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no point to initialize ITS without having msi-controller
property in corresponding DT node. However, its_probe is checking
msi-controller presence at the end, so we can save our time and do that
check prior to its_probe call. Also, for the code clarity purpose,
we put domain initialization to separate function.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 57 ++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 3926179..065eac5 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1429,13 +1429,37 @@ static void its_enable_quirks(struct its_node *its)
 	gic_enable_quirks(iidr, its_quirks, its);
 }
 
+static int its_init_domain(struct device_node *node, struct its_node *its,
+			   struct irq_domain *parent)
+{
+	struct irq_domain *inner_domain;
+	struct msi_domain_info *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	inner_domain = irq_domain_add_tree(node, &its_domain_ops, its);
+	if (!inner_domain) {
+		kfree(info);
+		return -ENOMEM;
+	}
+
+	inner_domain->parent = parent;
+	inner_domain->bus_token = DOMAIN_BUS_NEXUS;
+	info->ops = &its_msi_domain_ops;
+	info->data = its;
+	inner_domain->host_data = info;
+
+	return 0;
+}
+
 static int __init its_probe(struct device_node *node,
 			    struct irq_domain *parent)
 {
 	struct resource res;
 	struct its_node *its;
 	void __iomem *its_base;
-	struct irq_domain *inner_domain;
 	u32 val;
 	u64 baser, tmp;
 	int err;
@@ -1526,28 +1550,9 @@ static int __init its_probe(struct device_node *node,
 	writeq_relaxed(0, its->base + GITS_CWRITER);
 	writel_relaxed(GITS_CTLR_ENABLE, its->base + GITS_CTLR);
 
-	if (of_property_read_bool(node, "msi-controller")) {
-		struct msi_domain_info *info;
-
-		info = kzalloc(sizeof(*info), GFP_KERNEL);
-		if (!info) {
-			err = -ENOMEM;
-			goto out_free_tables;
-		}
-
-		inner_domain = irq_domain_add_tree(node, &its_domain_ops, its);
-		if (!inner_domain) {
-			err = -ENOMEM;
-			kfree(info);
-			goto out_free_tables;
-		}
-
-		inner_domain->parent = parent;
-		inner_domain->bus_token = DOMAIN_BUS_NEXUS;
-		info->ops = &its_msi_domain_ops;
-		info->data = its;
-		inner_domain->host_data = info;
-	}
+	err = its_init_domain(node, its, parent);
+	if (err)
+		goto out_free_tables;
 
 	spin_lock(&its_lock);
 	list_add(&its->entry, &its_nodes);
@@ -1598,6 +1603,12 @@ int __init its_init(struct device_node *node, struct rdists *rdists,
 
 	for (np = of_find_matching_node(node, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
+		if (!of_property_read_bool(np, "msi-controller")) {
+			pr_warn("%s: no msi-controller property, ITS ignored\n",
+				np->full_name);
+			continue;
+		}
+
 		its_probe(np, parent_domain);
 	}
 
-- 
1.9.1
