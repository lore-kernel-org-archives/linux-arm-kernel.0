From: stefan@agner.ch (Stefan Agner)
Date: Wed, 12 Sep 2018 11:32:18 -0700
Subject: [PATCH v2 4/8] drm/bridge: allow to specify data-enable polarity
In-Reply-To: <20180912183222.25414-1-stefan@agner.ch>
References: <20180912183222.25414-1-stefan@agner.ch>
Message-ID: <20180912183222.25414-5-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support boards with a passive RGB to VGA bridge which require a low
active data-enable polarity.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/bridge/dumb-vga-dac.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge/dumb-vga-dac.c
index b2309ad228cf..de001e322ba8 100644
--- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
+++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
@@ -179,6 +179,7 @@ static struct i2c_adapter *dumb_vga_retrieve_ddc(struct device *dev)
 static int dumb_vga_probe(struct platform_device *pdev)
 {
 	struct dumb_vga *vga;
+	u32 de;
 
 	vga = devm_kzalloc(&pdev->dev, sizeof(*vga), GFP_KERNEL);
 	if (!vga)
@@ -194,6 +195,23 @@ static int dumb_vga_probe(struct platform_device *pdev)
 		dev_dbg(&pdev->dev, "No vdd regulator found: %d\n", ret);
 	}
 
+	vga->bridge.funcs = &dumb_vga_bridge_funcs;
+	vga->bridge.of_node = pdev->dev.of_node;
+	vga->bridge.timings = of_device_get_match_data(&pdev->dev);
+
+	if (!vga->bridge.timings &&
+	    !of_property_read_u32(pdev->dev.of_node, "de-active", &de)) {
+		struct drm_bridge_timings *timings;
+
+		timings = devm_kzalloc(&pdev->dev, sizeof(*timings), GFP_KERNEL);
+		if (!timings)
+			return -ENOMEM;
+
+		timings->input_bus_flags = de ? DRM_BUS_FLAG_DE_HIGH :
+						DRM_BUS_FLAG_DE_LOW;
+		vga->bridge.timings = timings;
+	}
+
 	vga->ddc = dumb_vga_retrieve_ddc(&pdev->dev);
 	if (IS_ERR(vga->ddc)) {
 		if (PTR_ERR(vga->ddc) == -ENODEV) {
@@ -205,10 +223,6 @@ static int dumb_vga_probe(struct platform_device *pdev)
 		}
 	}
 
-	vga->bridge.funcs = &dumb_vga_bridge_funcs;
-	vga->bridge.of_node = pdev->dev.of_node;
-	vga->bridge.timings = of_device_get_match_data(&pdev->dev);
-
 	drm_bridge_add(&vga->bridge);
 
 	return 0;
-- 
2.18.0
