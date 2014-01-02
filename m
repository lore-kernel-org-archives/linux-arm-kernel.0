From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:29:40 +0000
Subject: [PATCH RFC 46/46] imx-drm: pass an IPU ID to crtc and core (needs
 work)
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1Vyppk-0007Ga-Ui@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On IMX6D/Q devices, the display bridge muxes can select either display
interface on either of the IPUs.  Therefore, we need to positively know
which IPU each CRTC is.

We partially solve this by passing an IPU ID from the IPUv3 driver into
the DRM CRTC driver, which also passes it into the core code.  This
gives a method by which we can try to solve this.

However, we're still stuck with trying to guess the IPU ID in the IPU
driver as we don't have a positive way to identify this.  This needs to
be resolved.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-drm-core.c      |   14 +++++++-------
 drivers/staging/imx-drm/imx-drm.h           |    2 +-
 drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h |    1 +
 drivers/staging/imx-drm/ipu-v3/ipu-common.c |   15 +++++++++++----
 drivers/staging/imx-drm/ipuv3-crtc.c        |    7 +++----
 5 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 6b86bfeb091f..2490dc32df4a 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -42,8 +42,8 @@ struct imx_drm_crtc {
 	int					pipe;
 	struct imx_drm_crtc_helper_funcs	imx_drm_helper_funcs;
 	void					*cookie;
-	int					id;
-	int					mux_id;
+	int					di_id;
+	int					ipu_id;
 };
 
 static int legacyfb_depth = 16;
@@ -345,7 +345,7 @@ static int imx_drm_driver_load(struct drm_device *drm, unsigned long flags)
 int imx_drm_add_crtc(struct drm_device *drm, struct drm_crtc *crtc,
 		struct imx_drm_crtc **new_crtc,
 		const struct imx_drm_crtc_helper_funcs *imx_drm_helper_funcs,
-		void *cookie, int id)
+		void *cookie, int ipu_id, int di_id)
 {
 	struct imx_drm_device *imxdrm = drm->dev_private;
 	struct imx_drm_crtc *imx_drm_crtc;
@@ -368,8 +368,8 @@ int imx_drm_add_crtc(struct drm_device *drm, struct drm_crtc *crtc,
 	imx_drm_crtc->imx_drm_helper_funcs = *imx_drm_helper_funcs;
 	imx_drm_crtc->pipe = imxdrm->pipes++;
 	imx_drm_crtc->cookie = cookie;
-	imx_drm_crtc->id = id;
-	imx_drm_crtc->mux_id = imx_drm_crtc->pipe;
+	imx_drm_crtc->di_id = di_id;
+	imx_drm_crtc->ipu_id = ipu_id;
 	imx_drm_crtc->crtc = crtc;
 
 	imxdrm->crtc[imx_drm_crtc->pipe] = imx_drm_crtc;
@@ -426,7 +426,7 @@ static uint32_t imx_drm_find_crtc_mask(struct imx_drm_device *imxdrm,
 
 	for (i = 0; i < MAX_CRTC; i++) {
 		struct imx_drm_crtc *imx_drm_crtc = imxdrm->crtc[i];
-		if (imx_drm_crtc && imx_drm_crtc->id == id &&
+		if (imx_drm_crtc && imx_drm_crtc->di_id == id &&
 		    imx_drm_crtc->cookie == cookie)
 			return drm_helper_crtc_possible_mask(imx_drm_crtc->crtc);
 	}
@@ -482,7 +482,7 @@ int imx_drm_encoder_get_mux_id(struct drm_encoder *encoder)
 {
 	struct imx_drm_crtc *imx_crtc = imx_drm_find_crtc(encoder->crtc);
 
-	return imx_crtc ? imx_crtc->mux_id : -EINVAL;
+	return imx_crtc ? imx_crtc->ipu_id * 2 + imx_crtc->di_id : -EINVAL;
 }
 EXPORT_SYMBOL_GPL(imx_drm_encoder_get_mux_id);
 
diff --git a/drivers/staging/imx-drm/imx-drm.h b/drivers/staging/imx-drm/imx-drm.h
index 0a26222ec539..7d8d9634a4db 100644
--- a/drivers/staging/imx-drm/imx-drm.h
+++ b/drivers/staging/imx-drm/imx-drm.h
@@ -29,7 +29,7 @@ struct imx_drm_crtc_helper_funcs {
 int imx_drm_add_crtc(struct drm_device *drm, struct drm_crtc *crtc,
 		struct imx_drm_crtc **new_crtc,
 		const struct imx_drm_crtc_helper_funcs *imx_helper_funcs,
-		void *cookie, int id);
+		void *cookie, int ipu_id, int di_id);
 int imx_drm_remove_crtc(struct imx_drm_crtc *);
 int imx_drm_init_drm(struct platform_device *pdev,
 		int preferred_bpp);
diff --git a/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h b/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
index 4826b5c0249d..7b879ace4feb 100644
--- a/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
+++ b/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
@@ -319,6 +319,7 @@ struct ipu_client_platformdata {
 	int dp;
 	int dmfc;
 	int dma[2];
+	int ipu;
 };
 
 #endif /* __DRM_IPU_H__ */
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-common.c b/drivers/staging/imx-drm/ipu-v3/ipu-common.c
index 97ca6924dbb3..96b1135b1181 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-common.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-common.c
@@ -1003,19 +1003,26 @@ static int ipu_add_client_devices(struct ipu_soc *ipu)
 {
 	struct device *dev = ipu->dev;
 	unsigned i;
-	int id, ret;
+	int ipu_id, id, ret;
 
 	mutex_lock(&ipu_client_id_mutex);
-	id = ipu_client_id;
-	ipu_client_id += ARRAY_SIZE(client_reg);
+	id = ipu_client_id++;
 	mutex_unlock(&ipu_client_id_mutex);
 
+	/* FIXME: this needs a better solution */
+	ipu_id = id;
+
+	id *= ARRAY_SIZE(client_reg);
+
 	for (i = 0; i < ARRAY_SIZE(client_reg); i++) {
 		const struct ipu_platform_reg *reg = &client_reg[i];
+		struct ipu_client_platformdata pdata = reg->pdata;
 		struct platform_device *pdev;
 
+		pdata.ipu = ipu_id;
+
 		pdev = platform_device_register_data(dev, reg->name,
-			id++, &reg->pdata, sizeof(reg->pdata));
+			id++, &pdata, sizeof(pdata));
 
 		if (IS_ERR(pdev))
 			goto err_register;
diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index ed2423efc1d0..b2de40b1fb2c 100644
--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -349,10 +349,9 @@ static int ipu_crtc_init(struct ipu_crtc *ipu_crtc,
 		return ret;
 	}
 
-	ret = imx_drm_add_crtc(drm, &ipu_crtc->base,
-			&ipu_crtc->imx_crtc,
-			&ipu_crtc_helper_funcs,
-			ipu_crtc->dev->parent->of_node, pdata->di);
+	ret = imx_drm_add_crtc(drm, &ipu_crtc->base, &ipu_crtc->imx_crtc,
+			&ipu_crtc_helper_funcs, ipu_crtc->dev->parent->of_node,
+			pdata->ipu, pdata->di);
 	if (ret) {
 		dev_err(ipu_crtc->dev, "adding crtc failed with %d.\n", ret);
 		goto err_put_resources;
-- 
1.7.4.4
