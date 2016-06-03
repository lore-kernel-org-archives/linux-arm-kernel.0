From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri,  3 Jun 2016 09:26:35 +0200
Subject: [PATCH] drm: atmel-hlcdc: Fix OF graph parsing
Message-ID: <1464938795-1838-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

atmel_hlcdc_create_outputs() iterates over OF graph nodes and releases
the node (using of_node_put()) after each iteration, which is wrong
since for_each_endpoint_of_node() is already taking care of that.

Move the of_node_put() call in the error path.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Fixes: 17a8e03e7e97 ("drm: atmel-hlcdc: rework the output code to support drm bridges")
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
index 39802c0..3d34fc4 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -266,9 +266,10 @@ int atmel_hlcdc_create_outputs(struct drm_device *dev)
 		if (!ret)
 			ret = atmel_hlcdc_check_endpoint(dev, &ep);
 
-		of_node_put(ep_np);
-		if (ret)
+		if (ret) {
+			of_node_put(ep_np);
 			return ret;
+		}
 	}
 
 	for_each_endpoint_of_node(dev->dev->of_node, ep_np) {
@@ -276,9 +277,10 @@ int atmel_hlcdc_create_outputs(struct drm_device *dev)
 		if (!ret)
 			ret = atmel_hlcdc_attach_endpoint(dev, &ep);
 
-		of_node_put(ep_np);
-		if (ret)
+		if (ret) {
+			of_node_put(ep_np);
 			return ret;
+		}
 	}
 
 	return 0;
-- 
2.7.4
