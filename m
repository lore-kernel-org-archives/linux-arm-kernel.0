From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Thu, 23 Oct 2014 23:53:10 +0800
Subject: [PATCH v4 2/7] irqdomain: Add back xlate and set_type for hierarchy
 irq domain
In-Reply-To: <1414079595-26129-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1414079595-26129-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1414079595-26129-3-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move xlate and set_type out to common code for hierarchy irq domain.
Withouth this common code, all outermost irq domain will have to duplicate
these function.

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 kernel/irq/irqdomain.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index dd8d3ab..b3288e8 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -478,11 +478,6 @@ unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
 		return 0;
 	}
 
-	if (irq_domain_is_hierarchy(domain)) {
-		virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, irq_data);
-		return virq <= 0 ? 0 : virq;
-	}
-
 	/* If domain has no translation, then we assume interrupt line */
 	if (domain->ops->xlate == NULL)
 		hwirq = irq_data->args[0];
@@ -492,10 +487,26 @@ unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
 			return 0;
 	}
 
-	/* Create mapping */
-	virq = irq_create_mapping(domain, hwirq);
-	if (!virq)
-		return virq;
+	if (irq_domain_is_hierarchy(domain)) {
+		if (domain->ops->xlate) {
+			/*
+			 * If we've already configured this interrupt,
+			 * don't do it again, or hell will break loose.
+			 */
+			virq = irq_find_mapping(domain, hwirq);
+			if (virq)
+				return virq;
+		}
+
+		virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, irq_data);
+		if (virq <= 0)
+			return 0;
+	} else {
+		/* Create mapping */
+		virq = irq_create_mapping(domain, hwirq);
+		if (!virq)
+			return virq;
+	}
 
 	/* Set type if specified and different than the current one */
 	if (type != IRQ_TYPE_NONE &&
-- 
1.8.1.1.dirty
