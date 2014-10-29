From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Wed, 29 Oct 2014 18:00:19 +0800
Subject: [PATCH v5 1/6] irqdomain: do irq_find_mapping and set_type for
 hierarchy irqdomain
In-Reply-To: <1414576824-16143-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1414576824-16143-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1414576824-16143-2-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is possible to call irq_create_of_mapping to create/translate the
same IRQ from DT for multiple times. Perform irq_find_mapping check
and set_type for hierarchy irqdomain in irq_create_of_mapping() to
avoid duplicate these functionality in all outer most irqdomain.

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 kernel/irq/irqdomain.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 7cc9cbb..c292603 100644
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
@@ -492,10 +487,24 @@ unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
 			return 0;
 	}
 
-	/* Create mapping */
-	virq = irq_create_mapping(domain, hwirq);
-	if (!virq)
-		return virq;
+	if (irq_domain_is_hierarchy(domain)) {
+		/*
+		 * If we've already configured this interrupt,
+		 * don't do it again, or hell will break loose.
+		 */
+		virq = irq_find_mapping(domain, hwirq);
+		if (virq)
+			return virq;
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
