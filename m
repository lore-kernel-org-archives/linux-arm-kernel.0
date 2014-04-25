From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:44:44 +0100
Subject: [PATCH 156/222] imx-drm: ipu-dc: disable DC module when not in use
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeYe-0007Ng-BW@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-arm-kernel at lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h |  2 ++
 drivers/staging/imx-drm/ipu-v3/ipu-dc.c     | 14 ++++++++++++--
 drivers/staging/imx-drm/ipuv3-crtc.c        |  8 ++++++--
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h b/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
index 8678ad18a3ef..c2c6fab05eaa 100644
--- a/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
+++ b/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
@@ -115,8 +115,10 @@ struct ipu_dc *ipu_dc_get(struct ipu_soc *ipu, int channel);
 void ipu_dc_put(struct ipu_dc *dc);
 int ipu_dc_init_sync(struct ipu_dc *dc, struct ipu_di *di, bool interlaced,
 		u32 pixel_fmt, u32 width);
+void ipu_dc_enable(struct ipu_soc *ipu);
 void ipu_dc_enable_channel(struct ipu_dc *dc);
 void ipu_dc_disable_channel(struct ipu_dc *dc);
+void ipu_dc_disable(struct ipu_soc *ipu);
 
 /*
  * IPU Display Interface (di) functions
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
index 7f5734aef9f7..97cf6fad2427 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
@@ -227,12 +227,16 @@ int ipu_dc_init_sync(struct ipu_dc *dc, struct ipu_di *di, bool interlaced,
 	writel(0x0, dc->base + DC_WR_CH_ADDR);
 	writel(width, priv->dc_reg + DC_DISP_CONF2(dc->di));
 
-	ipu_module_enable(priv->ipu, IPU_CONF_DC_EN);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ipu_dc_init_sync);
 
+void ipu_dc_enable(struct ipu_soc *ipu)
+{
+	ipu_module_enable(ipu, IPU_CONF_DC_EN);
+}
+EXPORT_SYMBOL_GPL(ipu_dc_enable);
+
 void ipu_dc_enable_channel(struct ipu_dc *dc)
 {
 	int di;
@@ -289,6 +293,12 @@ void ipu_dc_disable_channel(struct ipu_dc *dc)
 }
 EXPORT_SYMBOL_GPL(ipu_dc_disable_channel);
 
+void ipu_dc_disable(struct ipu_soc *ipu)
+{
+	ipu_module_disable(ipu, IPU_CONF_DC_EN);
+}
+EXPORT_SYMBOL_GPL(ipu_dc_disable);
+
 static void ipu_dc_map_config(struct ipu_dc_priv *priv, enum ipu_dc_map map,
 		int byte_num, int offset, int mask)
 {
diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index ab667a191a36..47bec5e17358 100644
--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -60,10 +60,12 @@ struct ipu_crtc {
 
 static void ipu_fb_enable(struct ipu_crtc *ipu_crtc)
 {
+	struct ipu_soc *ipu = dev_get_drvdata(ipu_crtc->dev->parent);
+
 	if (ipu_crtc->enabled)
 		return;
 
-	/* TODO: Enable DC module here, right now it is never disabled */
+	ipu_dc_enable(ipu);
 	ipu_plane_enable(ipu_crtc->plane[0]);
 	/* Start DC channel and DI after IDMAC */
 	ipu_dc_enable_channel(ipu_crtc->dc);
@@ -74,6 +76,8 @@ static void ipu_fb_enable(struct ipu_crtc *ipu_crtc)
 
 static void ipu_fb_disable(struct ipu_crtc *ipu_crtc)
 {
+	struct ipu_soc *ipu = dev_get_drvdata(ipu_crtc->dev->parent);
+
 	if (!ipu_crtc->enabled)
 		return;
 
@@ -81,7 +85,7 @@ static void ipu_fb_disable(struct ipu_crtc *ipu_crtc)
 	ipu_dc_disable_channel(ipu_crtc->dc);
 	ipu_di_disable(ipu_crtc->di);
 	ipu_plane_disable(ipu_crtc->plane[0]);
-	/* TODO: Disable DC module here */
+	ipu_dc_disable(ipu);
 
 	ipu_crtc->enabled = 0;
 }
-- 
1.8.3.1
