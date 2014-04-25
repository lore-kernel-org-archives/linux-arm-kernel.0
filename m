From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:44:29 +0100
Subject: [PATCH 153/222] imx-drm: ipu-dp: split disabling the DP foreground
 channel from disabling the DP module
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeYP-0007NU-0l@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-arm-kernel at lists.infradead.org

The former has to be done before disabling the DMFC, the latter has to be
done afterwards. Otherwise the DMFC FIFOs never get cleared properly.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h |  2 +
 drivers/staging/imx-drm/ipu-v3/ipu-dp.c     | 68 +++++++++++++++++++----------
 drivers/staging/imx-drm/ipuv3-plane.c       |  4 ++
 3 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h b/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
index 2966e425990e..8678ad18a3ef 100644
--- a/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
+++ b/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
@@ -153,8 +153,10 @@ void ipu_dmfc_put(struct dmfc_channel *dmfc);
 
 struct ipu_dp *ipu_dp_get(struct ipu_soc *ipu, unsigned int flow);
 void ipu_dp_put(struct ipu_dp *);
+int ipu_dp_enable(struct ipu_soc *ipu);
 int ipu_dp_enable_channel(struct ipu_dp *dp);
 void ipu_dp_disable_channel(struct ipu_dp *dp);
+void ipu_dp_disable(struct ipu_soc *ipu);
 int ipu_dp_setup_channel(struct ipu_dp *dp,
 		enum ipu_color_space in, enum ipu_color_space out);
 int ipu_dp_set_window_pos(struct ipu_dp *, u16 x_pos, u16 y_pos);
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dp.c b/drivers/staging/imx-drm/ipu-v3/ipu-dp.c
index 58f87c8d7c07..6980fa125517 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-dp.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-dp.c
@@ -215,10 +215,9 @@ int ipu_dp_setup_channel(struct ipu_dp *dp,
 }
 EXPORT_SYMBOL_GPL(ipu_dp_setup_channel);
 
-int ipu_dp_enable_channel(struct ipu_dp *dp)
+int ipu_dp_enable(struct ipu_soc *ipu)
 {
-	struct ipu_flow *flow = to_flow(dp);
-	struct ipu_dp_priv *priv = flow->priv;
+	struct ipu_dp_priv *priv = ipu->dp_priv;
 
 	mutex_lock(&priv->mutex);
 
@@ -227,15 +226,28 @@ int ipu_dp_enable_channel(struct ipu_dp *dp)
 
 	priv->use_count++;
 
-	if (dp->foreground) {
-		u32 reg;
+	mutex_unlock(&priv->mutex);
 
-		reg = readl(flow->base + DP_COM_CONF);
-		reg |= DP_COM_CONF_FG_EN;
-		writel(reg, flow->base + DP_COM_CONF);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_dp_enable);
 
-		ipu_srm_dp_sync_update(priv->ipu);
-	}
+int ipu_dp_enable_channel(struct ipu_dp *dp)
+{
+	struct ipu_flow *flow = to_flow(dp);
+	struct ipu_dp_priv *priv = flow->priv;
+	u32 reg;
+
+	if (!dp->foreground)
+		return 0;
+
+	mutex_lock(&priv->mutex);
+
+	reg = readl(flow->base + DP_COM_CONF);
+	reg |= DP_COM_CONF_FG_EN;
+	writel(reg, flow->base + DP_COM_CONF);
+
+	ipu_srm_dp_sync_update(priv->ipu);
 
 	mutex_unlock(&priv->mutex);
 
@@ -247,25 +259,35 @@ void ipu_dp_disable_channel(struct ipu_dp *dp)
 {
 	struct ipu_flow *flow = to_flow(dp);
 	struct ipu_dp_priv *priv = flow->priv;
+	u32 reg, csc;
+
+	if (!dp->foreground)
+		return;
 
 	mutex_lock(&priv->mutex);
 
-	priv->use_count--;
+	reg = readl(flow->base + DP_COM_CONF);
+	csc = reg & DP_COM_CONF_CSC_DEF_MASK;
+	if (csc == DP_COM_CONF_CSC_DEF_FG)
+		reg &= ~DP_COM_CONF_CSC_DEF_MASK;
 
-	if (dp->foreground) {
-		u32 reg, csc;
+	reg &= ~DP_COM_CONF_FG_EN;
+	writel(reg, flow->base + DP_COM_CONF);
 
-		reg = readl(flow->base + DP_COM_CONF);
-		csc = reg & DP_COM_CONF_CSC_DEF_MASK;
-		if (csc == DP_COM_CONF_CSC_DEF_FG)
-			reg &= ~DP_COM_CONF_CSC_DEF_MASK;
+	writel(0, flow->base + DP_FG_POS);
+	ipu_srm_dp_sync_update(priv->ipu);
 
-		reg &= ~DP_COM_CONF_FG_EN;
-		writel(reg, flow->base + DP_COM_CONF);
+	mutex_unlock(&priv->mutex);
+}
+EXPORT_SYMBOL_GPL(ipu_dp_disable_channel);
 
-		writel(0, flow->base + DP_FG_POS);
-		ipu_srm_dp_sync_update(priv->ipu);
-	}
+void ipu_dp_disable(struct ipu_soc *ipu)
+{
+	struct ipu_dp_priv *priv = ipu->dp_priv;
+
+	mutex_lock(&priv->mutex);
+
+	priv->use_count--;
 
 	if (!priv->use_count)
 		ipu_module_disable(priv->ipu, IPU_CONF_DP_EN);
@@ -275,7 +297,7 @@ void ipu_dp_disable_channel(struct ipu_dp *dp)
 
 	mutex_unlock(&priv->mutex);
 }
-EXPORT_SYMBOL_GPL(ipu_dp_disable_channel);
+EXPORT_SYMBOL_GPL(ipu_dp_disable);
 
 struct ipu_dp *ipu_dp_get(struct ipu_soc *ipu, unsigned int flow)
 {
diff --git a/drivers/staging/imx-drm/ipuv3-plane.c b/drivers/staging/imx-drm/ipuv3-plane.c
index 27a8d735dae0..5697e59ddf1d 100644
--- a/drivers/staging/imx-drm/ipuv3-plane.c
+++ b/drivers/staging/imx-drm/ipuv3-plane.c
@@ -239,6 +239,8 @@ int ipu_plane_get_resources(struct ipu_plane *ipu_plane)
 
 void ipu_plane_enable(struct ipu_plane *ipu_plane)
 {
+	if (ipu_plane->dp)
+		ipu_dp_enable(ipu_plane->ipu);
 	ipu_dmfc_enable_channel(ipu_plane->dmfc);
 	ipu_idmac_enable_channel(ipu_plane->ipu_ch);
 	if (ipu_plane->dp)
@@ -257,6 +259,8 @@ void ipu_plane_disable(struct ipu_plane *ipu_plane)
 		ipu_dp_disable_channel(ipu_plane->dp);
 	ipu_idmac_disable_channel(ipu_plane->ipu_ch);
 	ipu_dmfc_disable_channel(ipu_plane->dmfc);
+	if (ipu_plane->dp)
+		ipu_dp_disable(ipu_plane->ipu);
 }
 
 static void ipu_plane_dpms(struct ipu_plane *ipu_plane, int mode)
-- 
1.8.3.1
