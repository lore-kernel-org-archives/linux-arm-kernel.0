From: peda@axentia.se (Peter Rosin)
Date: Sat, 25 Aug 2018 10:56:19 +0200
Subject: [PATCH v9 3/4] drm/atmel-hlcdc: always iterate over the first 4
 output endpoints
In-Reply-To: <20180825085620.10566-1-peda@axentia.se>
References: <20180825085620.10566-1-peda@axentia.se>
Message-ID: <20180825085620.10566-4-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables more flexible devicetrees. You can e.g. have two output
nodes where one is not enabled, without the ordering affecting things.

Prior to this patch the active nodes had to have endpoint id zero and
upwards consecutively.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
index 8db51fb131db..c05c2b744981 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -78,12 +78,23 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
 int atmel_hlcdc_create_outputs(struct drm_device *dev)
 {
 	int endpoint, ret = 0;
+	int attached = 0;
 
-	for (endpoint = 0; !ret; endpoint++)
+	/*
+	 * Always scan the first few endpoints even if we get -ENODEV,
+	 * but keep going after that as long as we keep getting hits.
+	 */
+	for (endpoint = 0; !ret || endpoint < 4; endpoint++) {
 		ret = atmel_hlcdc_attach_endpoint(dev, endpoint);
+		if (ret == -ENODEV)
+			continue;
+		if (ret)
+			break;
+		attached++;
+	}
 
 	/* At least one device was successfully attached.*/
-	if (ret == -ENODEV && endpoint)
+	if (ret == -ENODEV && attached)
 		return 0;
 
 	return ret;
-- 
2.11.0
