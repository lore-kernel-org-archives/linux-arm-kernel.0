From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  6 Apr 2018 16:19:35 +0200
Subject: [PATCH 2/2 v2] drm/pl111: Enable device-specific assigned memory
In-Reply-To: <20180406141935.6801-1-linus.walleij@linaro.org>
References: <20180406141935.6801-1-linus.walleij@linaro.org>
Message-ID: <20180406141935.6801-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Versatile Express has 8 MB of dedicated video RAM (VRAM)
on the motherboard, which is what we should be using for the
PL111 if available. On this platform, the memory backplane
is constructed so that only this memory will work properly
with the CLCD on the motherboard, using any other memory
region just gives random snow on the display.

The CA9 Versatile Express also has a PL111 instance on its
core tile. This is OK, it has been tested with the motherboard
VRAM and that works just as fine as regular CMA memory.

The memory is assigned to the device using the memory-region
device tree property and a "shared-dma-pool" reserved
memory pool like this:

reserved-memory {
        #address-cells = <1>;
        #size-cells = <1>;
        ranges;

        vram: vram at 48000000 {
                compatible = "shared-dma-pool";
                reg = <0x48000000 0x00800000>;
                no-map;
        };
};

clcd at 1f000 {
        compatible = "arm,pl111", "arm,primecell";
	(...)
        memory-region = <&vram>;
}?;

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Mali DP Maintainers <malidp@foss.arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Make sure to also call of_reserved_mem_device_release() at
  remove() and errorpath.
---
 drivers/gpu/drm/pl111/pl111_drv.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 4621259d5387..bc57c15d9fe4 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -60,6 +60,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
+#include <linux/of_reserved_mem.h>
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
@@ -257,6 +258,10 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 	drm->dev_private = priv;
 	priv->variant = variant;
 
+	ret = of_reserved_mem_device_init(dev);
+	if (!ret)
+		dev_info(dev, "using device-specific reserved memory\n");
+
 	if (of_property_read_u32(dev->of_node, "max-memory-bandwidth",
 				 &priv->memory_bw)) {
 		dev_info(dev, "no max memory bandwidth specified, assume unlimited\n");
@@ -275,7 +280,8 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 	priv->regs = devm_ioremap_resource(dev, &amba_dev->res);
 	if (IS_ERR(priv->regs)) {
 		dev_err(dev, "%s failed mmio\n", __func__);
-		return PTR_ERR(priv->regs);
+		ret = PTR_ERR(priv->regs);
+		goto mem_rel;
 	}
 
 	/* This may override some variant settings */
@@ -305,11 +311,15 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 
 dev_unref:
 	drm_dev_unref(drm);
+mem_rel:
+	of_reserved_mem_device_release(dev);
+
 	return ret;
 }
 
 static int pl111_amba_remove(struct amba_device *amba_dev)
 {
+	struct device *dev = &amba_dev->dev;
 	struct drm_device *drm = amba_get_drvdata(amba_dev);
 	struct pl111_drm_dev_private *priv = drm->dev_private;
 
@@ -319,6 +329,7 @@ static int pl111_amba_remove(struct amba_device *amba_dev)
 		drm_panel_bridge_remove(priv->bridge);
 	drm_mode_config_cleanup(drm);
 	drm_dev_unref(drm);
+	of_reserved_mem_device_release(dev);
 
 	return 0;
 }
-- 
2.14.3
