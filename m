From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 14 Sep 2016 16:01:24 +0100
Subject: [PATCH] of/platform: Initialise dev->fwnode appropriately
Message-ID: <38259ab3716da072fab37f06d034329244491c13.1473865096.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whilst we're some of the way towards a universal firmware property
interface, drivers which deal with both OF and ACPI probing end up
having to do things like this:

    dev->of_node ? &dev->of_node->fwnode : dev->fwnode

This seems unnecessary, when the OF code could instead simply fill in
the device's fwnode when binding the of_node, and let the drivers use
dev->fwnode either way. Let's give it a go and see what falls out.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/of/platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index f39ccd5aa701..f811d2796437 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -142,6 +142,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
 	}
 
 	dev->dev.of_node = of_node_get(np);
+	dev->dev.fwnode = &np->fwnode;
 	dev->dev.parent = parent ? : &platform_bus;
 
 	if (bus_id)
@@ -241,6 +242,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 
 	/* setup generic device info */
 	dev->dev.of_node = of_node_get(node);
+	dev->dev.fwnode = &node->fwnode;
 	dev->dev.parent = parent ? : &platform_bus;
 	dev->dev.platform_data = platform_data;
 	if (bus_id)
-- 
2.8.1.dirty
