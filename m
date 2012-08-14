From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 14 Aug 2012 15:49:15 +0200
Subject: [PATCH 01/23] of: add dma-mask binding
In-Reply-To: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
References: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1344952177-18385-2-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

This will allow each device to specify its dma-mask for this we use the
coherent_dma_mask as pointer. By default the dma-mask will be set to
DMA_BIT_MASK(32).
The microblaze architecture hook is drop

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 drivers/of/platform.c |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index e44f8c2..11c765c 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -121,6 +121,21 @@ void of_device_make_bus_id(struct device *dev)
 	dev_set_name(dev, "%s.%d", node->name, magic - 1);
 }
 
+static void of_get_dma_mask(struct device *dev, struct device_node *np)
+{
+	const __be32 *prop;
+	int len;
+
+	prop = of_get_property(np, "dma-mask", &len);
+
+	dev->dma_mask = &dev->coherent_dma_mask;
+
+	if (!prop)
+		dev->coherent_dma_mask = DMA_BIT_MASK(32);
+	else
+		dev->coherent_dma_mask = of_read_number(prop, len / 4);
+}
+
 /**
  * of_device_alloc - Allocate and initialize an of_device
  * @np: device node to assign to device
@@ -161,10 +176,8 @@ struct platform_device *of_device_alloc(struct device_node *np,
 		WARN_ON(of_irq_to_resource_table(np, res, num_irq) != num_irq);
 	}
 
+	of_get_dma_mask(&dev->dev, np);
 	dev->dev.of_node = of_node_get(np);
-#if defined(CONFIG_MICROBLAZE)
-	dev->dev.dma_mask = &dev->archdata.dma_mask;
-#endif
 	dev->dev.parent = parent;
 
 	if (bus_id)
@@ -201,10 +214,6 @@ struct platform_device *of_platform_device_create_pdata(
 	if (!dev)
 		return NULL;
 
-#if defined(CONFIG_MICROBLAZE)
-	dev->archdata.dma_mask = 0xffffffffUL;
-#endif
-	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
 
-- 
1.7.2.5
