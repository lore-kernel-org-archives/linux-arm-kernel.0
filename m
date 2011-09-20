From: robherring2@gmail.com (Rob Herring)
Date: Tue, 20 Sep 2011 15:24:02 -0500
Subject: [PATCH 1/3] of/irq: of_irq_find_parent: check for parent equal to
	child
In-Reply-To: <1316550244-3655-1-git-send-email-robherring2@gmail.com>
References: <1316550244-3655-1-git-send-email-robherring2@gmail.com>
Message-ID: <1316550244-3655-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

An interrupt controller may often implicitly inherit itself from a parent
node when in fact the controller is the interrupt root controller. Guard
against the case of child == parent and return NULL in this case.

This can also be fixed by adding an explicit "interrupt-parent;" to a root
interrupt controller node.

Based on code from Grant Likely.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/of/irq.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 9f689f1..6a5b5e7 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -58,27 +58,27 @@ EXPORT_SYMBOL_GPL(irq_of_parse_and_map);
  */
 struct device_node *of_irq_find_parent(struct device_node *child)
 {
-	struct device_node *p;
+	struct device_node *p, *c = child;
 	const __be32 *parp;
 
-	if (!of_node_get(child))
+	if (!of_node_get(c))
 		return NULL;
 
 	do {
-		parp = of_get_property(child, "interrupt-parent", NULL);
+		parp = of_get_property(c, "interrupt-parent", NULL);
 		if (parp == NULL)
-			p = of_get_parent(child);
+			p = of_get_parent(c);
 		else {
 			if (of_irq_workarounds & OF_IMAP_NO_PHANDLE)
 				p = of_node_get(of_irq_dflt_pic);
 			else
 				p = of_find_node_by_phandle(be32_to_cpup(parp));
 		}
-		of_node_put(child);
-		child = p;
+		of_node_put(c);
+		c = p;
 	} while (p && of_get_property(p, "#interrupt-cells", NULL) == NULL);
 
-	return p;
+	return (p == child) ? NULL : p;
 }
 
 /**
-- 
1.7.5.4
