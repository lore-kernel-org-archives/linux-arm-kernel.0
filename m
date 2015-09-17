From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 17 Sep 2015 14:57:17 +0200
Subject: [PATCH v5 23/23] of/platform: Defer probes of registered devices
In-Reply-To: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1442494637-3674-24-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of trying to match and probe platform and AMBA devices right
after each is registered, delay their probes until device_initcall_sync.

This means that devices will start probing once all built-in drivers
have registered, and after all platform and AMBA devices from the DT
have been registered already.

This allows us to prevent deferred probes by probing dependencies on
demand.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v5: None
Changes in v4:
- Also defer probes of AMBA devices registered from the DT as they can
  also request resources.

Changes in v3: None
Changes in v2: None

 drivers/of/platform.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 408d89f1d124..7b33e0369374 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -164,7 +164,8 @@ static struct platform_device *of_platform_device_create_pdata(
 					struct device_node *np,
 					const char *bus_id,
 					void *platform_data,
-					struct device *parent)
+					struct device *parent,
+					bool probe_late)
 {
 	struct platform_device *dev;
 
@@ -178,6 +179,7 @@ static struct platform_device *of_platform_device_create_pdata(
 
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
+	dev->dev.probe_late = probe_late;
 	of_dma_configure(&dev->dev, dev->dev.of_node);
 	of_msi_configure(&dev->dev, dev->dev.of_node);
 
@@ -209,7 +211,8 @@ struct platform_device *of_platform_device_create(struct device_node *np,
 					    const char *bus_id,
 					    struct device *parent)
 {
-	return of_platform_device_create_pdata(np, bus_id, NULL, parent);
+	return of_platform_device_create_pdata(np, bus_id, NULL, parent,
+					       false);
 }
 EXPORT_SYMBOL(of_platform_device_create);
 
@@ -240,6 +243,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 	dev->dev.of_node = of_node_get(node);
 	dev->dev.parent = parent ? : &platform_bus;
 	dev->dev.platform_data = platform_data;
+	dev->dev.probe_late = true;
 	if (bus_id)
 		dev_set_name(&dev->dev, "%s", bus_id);
 	else
@@ -358,7 +362,8 @@ static int of_platform_bus_create(struct device_node *bus,
 		return 0;
 	}
 
-	dev = of_platform_device_create_pdata(bus, bus_id, platform_data, parent);
+	dev = of_platform_device_create_pdata(bus, bus_id, platform_data,
+					      parent, true);
 	if (!dev || !of_match_node(matches, bus))
 		return 0;
 
-- 
2.4.3
