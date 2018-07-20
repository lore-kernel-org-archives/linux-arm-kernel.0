From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 20 Jul 2018 16:56:08 +0200
Subject: [PATCH RESEND 5/7] drm/sun4i: Rely on dma-parent for our RAM offset
In-Reply-To: <cover.d2aafc48da035aed80793da89079e5da269b45b4.1532098561.git-series.maxime.ripard@bootlin.com>
References: <cover.d2aafc48da035aed80793da89079e5da269b45b4.1532098561.git-series.maxime.ripard@bootlin.com>
Message-ID: <4e8314d579b8e78b8d40f03ff99cdfa22c43d462.1532098561.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we can express our DMA topology, rely on those property instead of
hardcoding an offset from the dma_addr_t which wasn't really great.

We still need to add some code to deal with the old DT that would lack that
property, but we move the offset to the DRM device dma_pfn_offset to be
able to rely on just the dma_addr_t associated to the GEM object.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index de0a76dfa1a2..277f23a3115f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -377,13 +377,6 @@ int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
 	paddr = drm_fb_cma_get_gem_addr(fb, state, 0);
 	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
 
-	/*
-	 * backend DMA accesses DRAM directly, bypassing the system
-	 * bus. As such, the address range is different and the buffer
-	 * address needs to be corrected.
-	 */
-	paddr -= PHYS_OFFSET;
-
 	if (sun4i_backend_format_is_yuv(fb->format->format))
 		return sun4i_backend_update_yuv_buffer(backend, fb, paddr);
 
@@ -772,6 +765,27 @@ static int sun4i_backend_bind(struct device *dev, struct device *master,
 	dev_set_drvdata(dev, backend);
 	spin_lock_init(&backend->frontend_lock);
 
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
