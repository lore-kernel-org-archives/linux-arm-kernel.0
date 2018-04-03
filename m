From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue,  3 Apr 2018 15:29:18 +0200
Subject: [PATCH 5/7] drm/sun4i: Rely on dma-parent for our RAM offset
In-Reply-To: <cover.54a07919b9d7fe8d7c90e9f4929648013e641cff.1522761929.git-series.maxime.ripard@bootlin.com>
References: <cover.54a07919b9d7fe8d7c90e9f4929648013e641cff.1522761929.git-series.maxime.ripard@bootlin.com>
Message-ID: <856ea14e004a70d7d7cf9ca12485c558a966c948.1522761929.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we can express our DMA topology, rely on those property instead of
hardcoding an offset from the dma_addr_t which wasn't really great.

We still need to add some code to deal with the old DT that would lack that
property, but we move the offset to the DRM device dma_pfn_offset to be
able to rely on just the dma_addr_t associated to the GEM object.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 847eecbe4d14..04e85d3ca36e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -222,13 +222,6 @@ int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
 	paddr = drm_fb_cma_get_gem_addr(fb, state, 0);
 	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
 
-	/*
-	 * backend DMA accesses DRAM directly, bypassing the system
-	 * bus. As such, the address range is different and the buffer
-	 * address needs to be corrected.
-	 */
-	paddr -= PHYS_OFFSET;
-
 	/* Write the 32 lower bits of the address (in bits) */
 	lo_paddr = paddr << 3;
 	DRM_DEBUG_DRIVER("Setting address lower bits to 0x%x\n", lo_paddr);
@@ -361,6 +354,27 @@ static int sun4i_backend_bind(struct device *dev, struct device *master,
 		return -ENOMEM;
 	dev_set_drvdata(dev, backend);
 
+	if (of_find_property(dev->of_node, "dma-parent", NULL)) {
+		/*
+		 * This assume we have the same DMA constraints for all our the
+		 * devices in our pipeline (all the backends, but also the
+		 * frontends). This sounds bad, but it has always been the case
+		 * for us, and DRM doesn't do per-device allocation either, so
+		 * we would need to fix DRM first...
+		 */
+		ret = of_dma_configure(drm->dev, dev->of_node);
+		if (ret)
+			return ret;
+	} else {
+		/*
+		 * If we don't have the dma-parent property, most likely
+		 * because of an old DT, we need to set the DMA offset by hand
+		 * on our device since the RAM mapping is at 0 for the DMA bus,
+		 * unlike the CPU.
+		 */
+		drm->dev->dma_pfn_offset = PHYS_PFN_OFFSET;
+	}
+
 	backend->engine.node = dev->of_node;
 	backend->engine.ops = &sun4i_backend_engine_ops;
 	backend->engine.id = sun4i_backend_of_get_id(dev->of_node);
-- 
git-series 0.9.1
