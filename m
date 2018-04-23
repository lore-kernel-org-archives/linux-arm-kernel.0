From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 23 Apr 2018 09:20:28 +0200
Subject: [PATCH 2/2 v4] drm/pl111: Enable device-specific assigned memory
Message-ID: <20180423072028.6739-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Versatile Express has 8 MB of dedicated video RAM (VRAM)
on the motherboard, which is what we should be using for the
PL111 if available. On this platform, the memory backplane
is constructed so that only this memory will work properly
with the CLCD on the motherboard, using any other memory
area just gives random snow on the display.

The CA9 Versatile Express also has a PL111 instance on its
core tile that can address all memory, and this does not
have the restriction.

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
Cc: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Collect Eric's review-tag.
ChangeLog v2->v3:
- Fix error path so we uref the memory properly.
- Augment the GEM buffer import to return an error pointer
  if we try to import a buffer when using device-assigned
  memory: we can only scan out the special memory and the
  GEM buffers are not copied but referenced by pointer.
ChangeLog v1->v2:
- Make sure to also call of_reserved_mem_device_release() at
  remove() and errorpath.
---
 drivers/gpu/drm/pl111/pl111_drm.h |  1 +
 drivers/gpu/drm/pl111/pl111_drv.c | 33 +++++++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_drm.h b/drivers/gpu/drm/pl111/pl111_drm.h
index 8639b2d4ddf7..ce4501d0ab48 100644
--- a/drivers/gpu/drm/pl111/pl111_drm.h
+++ b/drivers/gpu/drm/pl111/pl111_drm.h
@@ -79,6 +79,7 @@ struct pl111_drm_dev_private {
 	const struct pl111_variant_data *variant;
 	void (*variant_display_enable) (struct drm_device *drm, u32 format);
 	void (*variant_display_disable) (struct drm_device *drm);
+	bool use_device_memory;
 };
 
 int pl111_display_init(struct drm_device *dev);
diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 4621259d5387..5fcf21837746 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -60,6 +60,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
+#include <linux/of_reserved_mem.h>
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
@@ -207,6 +208,23 @@ static int pl111_modeset_init(struct drm_device *dev)
 	return ret;
 }
 
+struct drm_gem_object *pl111_gem_import_sg_table(struct drm_device *dev,
+						 struct dma_buf_attachment *attach,
+						 struct sg_table *sgt)
+{
+	struct pl111_drm_dev_private *priv = dev->dev_private;
+
+	/*
+	 * When using device-specific reserved memory we can't import
+	 * DMA buffers: those are passed by reference in any global
+	 * memory and we can only handle a specific range of memory.
+	 */
+	if (priv->use_device_memory)
+		return ERR_PTR(-EINVAL);
+
+	return drm_gem_cma_prime_import_sg_table(dev, attach, sgt);
+}
+
 DEFINE_DRM_GEM_CMA_FOPS(drm_fops);
 
 static struct drm_driver pl111_drm_driver = {
@@ -227,7 +245,7 @@ static struct drm_driver pl111_drm_driver = {
 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
 	.gem_prime_import = drm_gem_prime_import,
-	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
+	.gem_prime_import_sg_table = pl111_gem_import_sg_table,
 	.gem_prime_export = drm_gem_prime_export,
 	.gem_prime_get_sg_table	= drm_gem_cma_prime_get_sg_table,
 
@@ -257,6 +275,12 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 	drm->dev_private = priv;
 	priv->variant = variant;
 
+	ret = of_reserved_mem_device_init(dev);
+	if (!ret) {
+		dev_info(dev, "using device-specific reserved memory\n");
+		priv->use_device_memory = true;
+	}
+
 	if (of_property_read_u32(dev->of_node, "max-memory-bandwidth",
 				 &priv->memory_bw)) {
 		dev_info(dev, "no max memory bandwidth specified, assume unlimited\n");
@@ -275,7 +299,8 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 	priv->regs = devm_ioremap_resource(dev, &amba_dev->res);
 	if (IS_ERR(priv->regs)) {
 		dev_err(dev, "%s failed mmio\n", __func__);
-		return PTR_ERR(priv->regs);
+		ret = PTR_ERR(priv->regs);
+		goto dev_unref;
 	}
 
 	/* This may override some variant settings */
@@ -305,11 +330,14 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 
 dev_unref:
 	drm_dev_unref(drm);
+	of_reserved_mem_device_release(dev);
+
 	return ret;
 }
 
 static int pl111_amba_remove(struct amba_device *amba_dev)
 {
+	struct device *dev = &amba_dev->dev;
 	struct drm_device *drm = amba_get_drvdata(amba_dev);
 	struct pl111_drm_dev_private *priv = drm->dev_private;
 
@@ -319,6 +347,7 @@ static int pl111_amba_remove(struct amba_device *amba_dev)
 		drm_panel_bridge_remove(priv->bridge);
 	drm_mode_config_cleanup(drm);
 	drm_dev_unref(drm);
+	of_reserved_mem_device_release(dev);
 
 	return 0;
 }
-- 
2.14.3
