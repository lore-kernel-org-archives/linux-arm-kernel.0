From: heiko@sntech.de (Heiko Stuebner)
Date: Mon,  1 Oct 2018 14:38:40 +0200
Subject: [PATCH v6 2/7] drm/bridge/synopsys: dsi: don't call
 __dw_mipi_dsi_probe from dw_mipi_dsi_bind
In-Reply-To: <20181001123845.11818-1-heiko@sntech.de>
References: <20181001123845.11818-1-heiko@sntech.de>
Message-ID: <20181001123845.11818-3-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__dw_mipi_dsi_probe() does all the grabbing of resources and does it using
devm-helpers. So this is happening on each try of master bringup possibly
slowing down things a lot.

Drivers using the component framework may instead want to call
dw_mipi_dsi_probe separately in their probe function to setup resources
early. That way the dsi bus also gets created earlier and also not
recreated on each bind-try, so that attached panels can load their modules
and be probed way before the bridge-attach in the bind call.

So drop the call to __dw_mipi_dsi_probe and modify the function to take
a struct dw_mipi_dsi instead of the platform-device.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 15 +++------------
 include/drm/bridge/dw_mipi_dsi.h              |  5 +----
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index 07cde255cab2..bb4aeca5c0f9 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -966,31 +966,22 @@ EXPORT_SYMBOL_GPL(dw_mipi_dsi_remove);
 /*
  * Bind/unbind API, used from platforms based on the component framework.
  */
-struct dw_mipi_dsi *
-dw_mipi_dsi_bind(struct platform_device *pdev, struct drm_encoder *encoder,
-		 const struct dw_mipi_dsi_plat_data *plat_data)
+int dw_mipi_dsi_bind(struct dw_mipi_dsi *dsi, struct drm_encoder *encoder)
 {
-	struct dw_mipi_dsi *dsi;
 	int ret;
 
-	dsi = __dw_mipi_dsi_probe(pdev, plat_data);
-	if (IS_ERR(dsi))
-		return dsi;
-
 	ret = drm_bridge_attach(encoder, &dsi->bridge, NULL);
 	if (ret) {
-		dw_mipi_dsi_remove(dsi);
 		DRM_ERROR("Failed to initialize bridge with drm\n");
-		return ERR_PTR(ret);
+		return ret;
 	}
 
-	return dsi;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_mipi_dsi_bind);
 
 void dw_mipi_dsi_unbind(struct dw_mipi_dsi *dsi)
 {
-	__dw_mipi_dsi_remove(dsi);
 }
 EXPORT_SYMBOL_GPL(dw_mipi_dsi_unbind);
 
diff --git a/include/drm/bridge/dw_mipi_dsi.h b/include/drm/bridge/dw_mipi_dsi.h
index d9c6d549f971..6d7f8eb5d9f2 100644
--- a/include/drm/bridge/dw_mipi_dsi.h
+++ b/include/drm/bridge/dw_mipi_dsi.h
@@ -35,10 +35,7 @@ struct dw_mipi_dsi *dw_mipi_dsi_probe(struct platform_device *pdev,
 				      const struct dw_mipi_dsi_plat_data
 				      *plat_data);
 void dw_mipi_dsi_remove(struct dw_mipi_dsi *dsi);
-struct dw_mipi_dsi *dw_mipi_dsi_bind(struct platform_device *pdev,
-				     struct drm_encoder *encoder,
-				     const struct dw_mipi_dsi_plat_data
-				     *plat_data);
+int dw_mipi_dsi_bind(struct dw_mipi_dsi *dsi, struct drm_encoder *encoder);
 void dw_mipi_dsi_unbind(struct dw_mipi_dsi *dsi);
 
 #endif /* __DW_MIPI_DSI__ */
-- 
2.18.0
