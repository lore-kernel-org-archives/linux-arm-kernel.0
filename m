From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed,  7 Mar 2012 12:26:15 +0100
Subject: [PATCH 1/1] of: add dma-mask binding
Message-ID: <1331119575-6638-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow each device to specify its dma-mask
The microblaze architecture hook is keep temporary if no dma-mask is specified
int the DT

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 drivers/of/platform.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index cae9477..bb22194 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -121,6 +121,26 @@ void of_device_make_bus_id(struct device *dev)
 	dev_set_name(dev, "%s.%d", node->name, magic - 1);
 }
 
+static u64* of_get_dma_mask(struct device_node *np)
+{
+	const __be32 *prop;
+	int len;
+	u64 *dma_mask;
+
+	prop = of_get_property(np, "dma-mask", &len);
+
+	if (!prop)
+		return NULL;
+
+	dma_mask = kzalloc(sizeof(u64), GFP_KERNEL);
+	if (!dma_mask)
+		return NULL;
+
+	*dma_mask = of_read_number(prop, len / 4);
+
+	return dma_mask;
+}
+
 /**
  * of_device_alloc - Allocate and initialize an of_device
  * @np: device node to assign to device
@@ -161,10 +181,14 @@ struct platform_device *of_device_alloc(struct device_node *np,
 		WARN_ON(of_irq_to_resource_table(np, res, num_irq) != num_irq);
 	}
 
+	dev->dev.dma_mask = of_get_dma_mask(np);
 	dev->dev.of_node = of_node_get(np);
+
 #if defined(CONFIG_MICROBLAZE)
-	dev->dev.dma_mask = &dev->archdata.dma_mask;
+	if (!dev->dev.dma_mask)
+		dev->dev.dma_mask = &dev->archdata.dma_mask;
 #endif
+
 	dev->dev.parent = parent;
 
 	if (bus_id)
-- 
1.7.7
