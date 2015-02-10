From: ykk@rock-chips.com (Yakir Yang)
Date: Tue, 10 Feb 2015 22:23:41 +0800
Subject: [RFC PATCH 3/3] drm: bridge/dw_hdmi: improve hdmi single-end test
In-Reply-To: <1423577791-19238-1-git-send-email-ykk@rock-chips.com>
References: <1423577791-19238-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1423578221-19527-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because of iMX6 & Rockchip have differnet mpll config parameter,
than the cklvl & txlvl would be different, we also should seperate
this parmeter.

As for Rockchip HDMI, when pixle clock less than 148MHz, the cklvl &
txlvl should be set to 13. When pixel clock less than 74.25MHz the
cklvl & txlvl should be set to 17.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---

 drivers/gpu/drm/bridge/dw_hdmi.c            |   14 +++++++-------
 drivers/gpu/drm/imx/dw_hdmi-imx.c           |   12 ++++++------
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c |   14 +++++++-------
 include/drm/bridge/dw_hdmi.h                |    5 +++--
 4 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 8b3208c..869262d 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -764,7 +764,7 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi, unsigned char prep,
 	const struct dw_hdmi_plat_data *plat_data = hdmi->plat_data;
 	const struct dw_hdmi_mpll_config *mpll_config = plat_data->mpll_cfg;
 	const struct dw_hdmi_curr_ctrl *curr_ctrl = plat_data->cur_ctr;
-	const struct dw_hdmi_sym_term *sym_term =  plat_data->sym_term;
+	const struct dw_hdmi_phy_config *phy_config = plat_data->phy_config;
 
 	if (prep)
 		return -EINVAL;
@@ -835,18 +835,18 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi, unsigned char prep,
 	hdmi_phy_i2c_write(hdmi, 0x0000, 0x13);  /* PLLPHBYCTRL */
 	hdmi_phy_i2c_write(hdmi, 0x0006, 0x17);
 
-	for (i = 0; sym_term[i].mpixelclock != (~0UL); i++)
+	for (i = 0; phy_config[i].mpixelclock != (~0UL); i++)
 		if (hdmi->hdmi_data.video_mode.mpixelclock <=
-		    sym_term[i].mpixelclock)
+		    phy_config[i].mpixelclock)
 			break;
 
 	/* RESISTANCE TERM 133Ohm Cfg */
-	hdmi_phy_i2c_write(hdmi, sym_term[i].term, 0x19);  /* TXTERM */
+	hdmi_phy_i2c_write(hdmi, phy_config[i].term, 0x19);  /* TXTERM */
 	/* PREEMP Cgf 0.00 */
-	hdmi_phy_i2c_write(hdmi, sym_term[i].sym_ctr, 0x09);  /* CKSYMTXCTRL */
-
+	hdmi_phy_i2c_write(hdmi, phy_config[i].sym_ctr, 0x09); /* CKSYMTXCTRL */
 	/* TX/CK LVL 10 */
-	hdmi_phy_i2c_write(hdmi, 0x01ad, 0x0E);  /* VLEVCTRL */
+	hdmi_phy_i2c_write(hdmi, phy_config[i].vlev_ctr, 0x0E); /* VLEVCTRL */
+
 	/* REMOVE CLK TERM */
 	hdmi_phy_i2c_write(hdmi, 0x8000, 0x05);  /* CKCALCTRL */
 
diff --git a/drivers/gpu/drm/imx/dw_hdmi-imx.c b/drivers/gpu/drm/imx/dw_hdmi-imx.c
index 121d30c..d6095d2 100644
--- a/drivers/gpu/drm/imx/dw_hdmi-imx.c
+++ b/drivers/gpu/drm/imx/dw_hdmi-imx.c
@@ -73,10 +73,10 @@ static const struct dw_hdmi_curr_ctrl imx_cur_ctr[] = {
 	}
 };
 
-static const struct dw_hdmi_sym_term imx_sym_term[] = {
-	/*pixelclk   symbol   term*/
-	{ 148500000, 0x800d, 0x0005 },
-	{ ~0UL,      0x0000, 0x0000 }
+static const struct dw_hdmi_phy_config imx_phy_config[] = {
+	/*pixelclk   symbol   term   vlev */
+	{ 148500000, 0x800d, 0x0005, 0x01ad},
+	{ ~0UL,      0x0000, 0x0000, 0x0000}
 };
 
 static int dw_hdmi_imx_parse_dt(struct imx_hdmi *hdmi)
@@ -139,14 +139,14 @@ static struct drm_encoder_funcs dw_hdmi_imx_encoder_funcs = {
 static struct dw_hdmi_plat_data imx6q_hdmi_drv_data = {
 	.mpll_cfg = imx_mpll_cfg,
 	.cur_ctr  = imx_cur_ctr,
-	.sym_term = imx_sym_term,
+	.phy_config = imx_phy_config,
 	.dev_type = IMX6Q_HDMI,
 };
 
 static struct dw_hdmi_plat_data imx6dl_hdmi_drv_data = {
 	.mpll_cfg = imx_mpll_cfg,
 	.cur_ctr  = imx_cur_ctr,
-	.sym_term = imx_sym_term,
+	.phy_config = imx_phy_config,
 	.dev_type = IMX6DL_HDMI,
 };
 
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 51030ca..65152a9 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -139,12 +139,12 @@ static const struct dw_hdmi_curr_ctrl rockchip_cur_ctr[] = {
 	}
 };
 
-static const struct dw_hdmi_sym_term rockchip_sym_term[] = {
-	/*pixelclk   symbol   term*/
-	{ 74250000,  0x8009, 0x0004 },
-	{ 148500000, 0x803b, 0x0004 },
-	{ 297000000, 0x8039, 0x0005 },
-	{ ~0UL,	     0x0000, 0x0000 }
+static const struct dw_hdmi_phy_config rockchip_phy_config[] = {
+	/*pixelclk   symbol   term   vlev*/
+	{ 74250000,  0x8009, 0x0004, 0x0251},
+	{ 148500000, 0x803b, 0x0004, 0x01ad},
+	{ 297000000, 0x8039, 0x0005, 0x01ad},
+	{ ~0UL,	     0x0000, 0x0000, 0x0000}
 };
 
 static int rockchip_hdmi_parse_dt(struct rockchip_hdmi *hdmi)
@@ -236,7 +236,7 @@ static const struct dw_hdmi_plat_data rockchip_hdmi_drv_data = {
 	.mode_valid = dw_hdmi_rockchip_mode_valid,
 	.mpll_cfg   = rockchip_mpll_cfg,
 	.cur_ctr    = rockchip_cur_ctr,
-	.sym_term   = rockchip_sym_term,
+	.phy_config = rockchip_phy_config,
 	.dev_type   = RK3288_HDMI,
 };
 
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index b3f3b0d..1f14cc3 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -50,17 +50,18 @@ struct dw_hdmi_curr_ctrl {
 	u16 curr[DW_HDMI_RES_MAX];
 };
 
-struct dw_hdmi_sym_term {
+struct dw_hdmi_phy_config {
 	unsigned long mpixelclock;
 	u16 sym_ctr;    /*clock symbol and transmitter control*/
 	u16 term;       /*transmission termination value*/
+	u16 vlev_ctr;   /* voltage level control */
 };
 
 struct dw_hdmi_plat_data {
 	enum dw_hdmi_devtype dev_type;
 	const struct dw_hdmi_mpll_config *mpll_cfg;
 	const struct dw_hdmi_curr_ctrl *cur_ctr;
-	const struct dw_hdmi_sym_term *sym_term;
+	const struct dw_hdmi_phy_config *phy_config;
 	enum drm_mode_status (*mode_valid)(struct drm_connector *connector,
 					   struct drm_display_mode *mode);
 };
-- 
1.7.9.5
