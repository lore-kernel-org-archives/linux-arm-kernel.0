From: ykk@rock-chips.com (Yakir Yang)
Date: Sun, 22 Nov 2015 21:42:59 +0800
Subject: [RFC PATCH v1 2/2] drm: bridgw/dw_hdmi: add basic hdmi hdcp driver
In-Reply-To: <1448199077-10221-1-git-send-email-ykk@rock-chips.com>
References: <1448199077-10221-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1448199779-5118-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Userspace could set the drm property "Content Protection"
to "Desired", and then driver would start to authenticate.
If the authentication successed, then the "Content Protection
KSV" would be write with the right HDCP KSV KEY, and enable
the HDCP encryption.

Besides driver export an interface for specific platform
driver that used for passing the encrypted HDCP key.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 drivers/gpu/drm/bridge/dw_hdmi.c | 355 ++++++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/bridge/dw_hdmi.h |  20 +++
 include/drm/bridge/dw_hdmi.h     |  17 ++
 3 files changed, 373 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 2c4dfc8..593a5b9 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -53,6 +53,13 @@ enum hdmi_datamap {
 	YCbCr422_12B = 0x12,
 };
 
+enum dw_hdmi_hdcp_state {
+	DW_HDMI_HDCP_STATE_DISABLED,
+	DW_HDMI_HDCP_STATE_AUTH_START,
+	DW_HDMI_HDCP_STATE_AUTH_DONE,
+	DW_HDMI_HDCP_STATE_ENCRY_EN,
+};
+
 static const u16 csc_coeff_default[3][4] = {
 	{ 0x2000, 0x0000, 0x0000, 0x0000 },
 	{ 0x0000, 0x2000, 0x0000, 0x0000 },
@@ -97,7 +104,6 @@ struct hdmi_data_info {
 	unsigned int enc_color_depth;
 	unsigned int colorimetry;
 	unsigned int pix_repet_factor;
-	unsigned int hdcp_enable;
 	struct hdmi_vmode video_mode;
 };
 
@@ -154,6 +160,14 @@ struct dw_hdmi {
 	unsigned int audio_n;
 	bool audio_enable;
 
+	/* this mutex is used for sync hdcp key content */
+	struct mutex hdcp_key_mutex;
+	struct dw_hdmi_hdcp_key_1x hdcp_key;
+	bool is_hdcp_key_present;
+
+	struct mutex hdcp_state_mutex;
+	enum dw_hdmi_hdcp_state hdcp_state;
+
 	void (*write)(struct dw_hdmi *hdmi, u8 val, int offset);
 	u8 (*read)(struct dw_hdmi *hdmi, int offset);
 };
@@ -1087,23 +1101,195 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi)
 	return 0;
 }
 
-static void hdmi_tx_hdcp_config(struct dw_hdmi *hdmi)
+static int hdmi_hdcp_wait_rmsts_ok(struct dw_hdmi *hdmi)
 {
-	u8 de;
+	unsigned long timeout;
 
-	if (hdmi->hdmi_data.video_mode.mdataenablepolarity)
-		de = HDMI_A_VIDPOLCFG_DATAENPOL_ACTIVE_HIGH;
-	else
-		de = HDMI_A_VIDPOLCFG_DATAENPOL_ACTIVE_LOW;
+	timeout = jiffies + msecs_to_jiffies(100);
+	while ((hdmi_readb(hdmi, HDMI_HDCPREG_RMSTS) & DPK_WR_OK_STS) == 0) {
+		if (time_after(jiffies, timeout))
+			return -EBUSY;
+		usleep_range(10, 15);
+	}
+
+	return 0;
+}
+
+static int _hdmi_write_hdcp_key(struct dw_hdmi *hdmi)
+{
+	struct dw_hdmi_hdcp_key_1x *key = &hdmi->hdcp_key;
+	int i, j;
+	int ret;
+
+	/* Disable decryption logic */
+	hdmi_writeb(hdmi, 0, HDMI_HDCPREG_RMCTL);
+	ret = hdmi_hdcp_wait_rmsts_ok(hdmi);
+	if (ret)
+		return ret;
+
+	/* The useful data in ksv should be 5 byte */
+	for (i = 4; i >= 0; i--)
+		hdmi_writeb(hdmi, key->ksv[i], HDMI_HDCPREG_DPK0 + i);
+
+	ret = hdmi_hdcp_wait_rmsts_ok(hdmi);
+	if (ret)
+		return ret;
+
+	/* Enable decryption logic */
+	hdmi_writeb(hdmi, 1, HDMI_HDCPREG_RMCTL);
+	hdmi_writeb(hdmi, key->seed[1], HDMI_HDCPREG_SEED1);
+	hdmi_writeb(hdmi, key->seed[0], HDMI_HDCPREG_SEED0);
+
+	/* Write encrypt device private key */
+	for (i = 0; i < DW_HDMI_HDCP_DPK_LEN - 6; i += 7) {
+		for (j = 6; j >= 0; j--)
+			hdmi_writeb(hdmi, key->device_key[i + j],
+				    HDMI_HDCPREG_DPK0 + j);
+		ret = hdmi_hdcp_wait_rmsts_ok(hdmi);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void _hdmi_close_hdcp_auth(struct dw_hdmi *hdmi)
+{
+	WARN_ON(!mutex_is_locked(&hdmi->hdcp_state_mutex));
+
+	/* Disable hdcp encryption */
+	hdmi_modb(hdmi, HDMI_A_HDCPCFG1_ENCRYPTIONDISABLE_DISABLE,
+		  HDMI_A_HDCPCFG1_ENCRYPTIONDISABLE_MASK, HDMI_A_HDCPCFG1);
 
-	/* disable rx detect */
+	/* Disable the RX detect */
 	hdmi_modb(hdmi, HDMI_A_HDCPCFG0_RXDETECT_DISABLE,
 		  HDMI_A_HDCPCFG0_RXDETECT_MASK, HDMI_A_HDCPCFG0);
 
-	hdmi_modb(hdmi, de, HDMI_A_VIDPOLCFG_DATAENPOL_MASK, HDMI_A_VIDPOLCFG);
+	hdmi->hdcp_state = DW_HDMI_HDCP_STATE_DISABLED;
+}
+
+static void _hdmi_start_hdcp_auth(struct dw_hdmi *hdmi)
+{
+	WARN_ON(!mutex_is_locked(&hdmi->hdcp_state_mutex));
+
+	/* Make sure RX detect is off before we start */
+	_hdmi_close_hdcp_auth(hdmi);
+
+	/* Enable the RX detect; expect an interrupt after this */
+	hdmi_modb(hdmi, HDMI_A_HDCPCFG0_RXDETECT_ENABLE,
+		  HDMI_A_HDCPCFG0_RXDETECT_MASK, HDMI_A_HDCPCFG0);
 
+	hdmi->hdcp_state = DW_HDMI_HDCP_STATE_AUTH_START;
+}
+
+static void _hdmi_enable_hdcp_encry(struct dw_hdmi *hdmi)
+{
+	WARN_ON(!mutex_is_locked(&hdmi->hdcp_state_mutex));
+	WARN_ON(hdmi->hdcp_state != DW_HDMI_HDCP_STATE_AUTH_DONE);
+
+	/* Enable hdcp encryption */
+	hdmi_modb(hdmi, HDMI_A_HDCPCFG1_ENCRYPTIONDISABLE_ENABLE,
+		  HDMI_A_HDCPCFG1_ENCRYPTIONDISABLE_MASK, HDMI_A_HDCPCFG1);
+
+	hdmi->hdcp_state = DW_HDMI_HDCP_STATE_ENCRY_EN;
+}
+
+static void hdmi_disable_hdcp_encry(struct dw_hdmi *hdmi)
+{
+	mutex_lock(&hdmi->hdcp_state_mutex);
+
+	/* Disable hdcp encryption */
 	hdmi_modb(hdmi, HDMI_A_HDCPCFG1_ENCRYPTIONDISABLE_DISABLE,
 		  HDMI_A_HDCPCFG1_ENCRYPTIONDISABLE_MASK, HDMI_A_HDCPCFG1);
+
+	/*
+	 * Leaving things authed, so keep track of state; note that if we turn
+	 * off auth here we blink the screen.
+	 */
+	if (hdmi->hdcp_state == DW_HDMI_HDCP_STATE_ENCRY_EN)
+		hdmi->hdcp_state = DW_HDMI_HDCP_STATE_AUTH_DONE;
+
+	mutex_unlock(&hdmi->hdcp_state_mutex);
+}
+
+static int _hdmi_set_hdcp_status_drm_property(struct dw_hdmi *hdmi, bool enable)
+{
+	struct drm_connector *connector = &hdmi->connector;
+	struct drm_mode_config *mc = &connector->dev->mode_config;
+	uint64_t ksv = 0;
+	int i;
+
+	WARN_ON(!mutex_is_locked(&mc->mutex));
+
+	for (i = 0; i > DW_HDMI_HDCP_KSV_LEN; i--)
+		ksv |= hdmi->hdcp_key.ksv[i] << 8 * i;
+
+	ksv = enable ? ksv : 0;
+
+	return drm_object_property_set_value(&connector->base,
+					     mc->content_protection_ksv_property,
+					     ksv);
+}
+
+static void hdmi_tx_hdcp_config(struct dw_hdmi *hdmi,
+				const struct drm_display_mode *mode)
+{
+	struct hdmi_vmode *vmode = &hdmi->hdmi_data.video_mode;
+	u8 vsync_pol, hsync_pol, data_pol, hdmi_dvi;
+
+	/* Reset HDCP Engine */
+	hdmi_modb(hdmi, HDMI_A_HDCPCFG1_SWRESET_ASSERT,
+		  HDMI_A_HDCPCFG1_SWRESET_MASK, HDMI_A_HDCPCFG1);
+
+	/* Configure the video polarity */
+	vsync_pol = mode->flags & DRM_MODE_FLAG_PVSYNC ?
+		    HDMI_A_VIDPOLCFG_VSYNCPOL_ACTIVE_HIGH :
+		    HDMI_A_VIDPOLCFG_VSYNCPOL_ACTIVE_LOW;
+	hsync_pol = mode->flags & DRM_MODE_FLAG_PHSYNC ?
+		    HDMI_A_VIDPOLCFG_HSYNCPOL_ACTIVE_HIGH :
+		    HDMI_A_VIDPOLCFG_HSYNCPOL_ACTIVE_LOW;
+	data_pol  = vmode->mdataenablepolarity ?
+		    HDMI_A_VIDPOLCFG_DATAENPOL_ACTIVE_HIGH :
+		    HDMI_A_VIDPOLCFG_DATAENPOL_ACTIVE_LOW;
+	hdmi_modb(hdmi, vsync_pol | hsync_pol | data_pol,
+		  HDMI_A_VIDPOLCFG_VSYNCPOL_MASK |
+		  HDMI_A_VIDPOLCFG_HSYNCPOL_MASK |
+		  HDMI_A_VIDPOLCFG_DATAENPOL_MASK,
+		  HDMI_A_VIDPOLCFG);
+
+	/* Config the display mode */
+	hdmi_dvi = hdmi->sink_is_hdmi ? HDMI_A_HDCPCFG0_HDMIDVI_HDMI :
+		   HDMI_A_HDCPCFG0_HDMIDVI_DVI;
+	hdmi_modb(hdmi, hdmi_dvi, HDMI_A_HDCPCFG0_HDMIDVI_MASK,
+		  HDMI_A_HDCPCFG0);
+
+	/* vendor suggest that a_oesswcfg should write this magic number */
+	hdmi_writeb(hdmi, 0x40, HDMI_A_OESSWCFG);
+
+	hdmi_modb(hdmi, HDMI_A_HDCPCFG0_BYPENCRYPTION_DISABLE |
+		  HDMI_A_HDCPCFG0_EN11FEATURE_DISABLE |
+		  HDMI_A_HDCPCFG0_SYNCRICHECK_ENABLE,
+		  HDMI_A_HDCPCFG0_BYPENCRYPTION_MASK |
+		  HDMI_A_HDCPCFG0_EN11FEATURE_MASK |
+		  HDMI_A_HDCPCFG0_SYNCRICHECK_MASK, HDMI_A_HDCPCFG0);
+
+	hdmi_modb(hdmi, HDMI_A_HDCPCFG1_ENCRYPTIONDISABLE_DISABLE |
+		  HDMI_A_HDCPCFG1_PH2UPSHFTENC_ENABLE,
+		  HDMI_A_HDCPCFG1_ENCRYPTIONDISABLE_MASK |
+		  HDMI_A_HDCPCFG1_PH2UPSHFTENC_MASK, HDMI_A_HDCPCFG1);
+
+	hdmi_modb(hdmi, HDMI_FC_INVIDCONF_HDCP_KEEPOUT_ACTIVE,
+		  HDMI_FC_INVIDCONF_HDCP_KEEPOUT_MASK, HDMI_FC_INVIDCONF);
+
+	/* enable hdcp clock */
+	hdmi_modb(hdmi, 0x00, HDMI_MC_CLKDIS_HDCPCLK_DISABLE, HDMI_MC_CLKDIS);
+
+	mutex_lock(&hdmi->hdcp_state_mutex);
+	if (hdmi->hdcp_state == DW_HDMI_HDCP_STATE_DISABLED)
+		_hdmi_close_hdcp_auth(hdmi);
+	else
+		_hdmi_start_hdcp_auth(hdmi);
+	mutex_unlock(&hdmi->hdcp_state_mutex);
 }
 
 static void hdmi_config_AVI(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
@@ -1218,11 +1404,7 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 	dev_dbg(hdmi->dev, "final pixclk = %d\n", vmode->mpixelclock);
 
 	/* Set up HDMI_FC_INVIDCONF */
-	inv_val = (hdmi->hdmi_data.hdcp_enable ?
-		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_ACTIVE :
-		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_INACTIVE);
-
-	inv_val |= mode->flags & DRM_MODE_FLAG_PVSYNC ?
+	inv_val = mode->flags & DRM_MODE_FLAG_PVSYNC ?
 		HDMI_FC_INVIDCONF_VSYNC_IN_POLARITY_ACTIVE_HIGH :
 		HDMI_FC_INVIDCONF_VSYNC_IN_POLARITY_ACTIVE_LOW;
 
@@ -1409,7 +1591,6 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 
 	hdmi->hdmi_data.enc_color_depth = 8;
 	hdmi->hdmi_data.pix_repet_factor = 0;
-	hdmi->hdmi_data.hdcp_enable = 0;
 	hdmi->hdmi_data.video_mode.mdataenablepolarity = true;
 
 	/* HDMI Initialization Step B.1 */
@@ -1444,7 +1625,7 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 	hdmi_video_packetize(hdmi);
 	hdmi_video_csc(hdmi);
 	hdmi_video_sample(hdmi);
-	hdmi_tx_hdcp_config(hdmi);
+	hdmi_tx_hdcp_config(hdmi, mode);
 
 	dw_hdmi_clear_overflow(hdmi);
 	if (hdmi->cable_plugin && hdmi->sink_is_hdmi)
@@ -1470,6 +1651,10 @@ static int dw_hdmi_fb_registered(struct dw_hdmi *hdmi)
 	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE,
 		    HDMI_IH_PHY_STAT0);
 
+	/* Unmask HDCP engaged interrupt */
+	hdmi_writeb(hdmi, (u8)~HDMI_A_APIINTSTAT_HDCP_ENGAGED,
+		    HDMI_A_APIINTMSK);
+
 	return 0;
 }
 
@@ -1614,6 +1799,20 @@ static void dw_hdmi_bridge_disable(struct drm_bridge *bridge)
 	dw_hdmi_update_power(hdmi);
 	dw_hdmi_update_phy_mask(hdmi);
 	mutex_unlock(&hdmi->mutex);
+
+	mutex_lock(&hdmi->hdcp_state_mutex);
+	if (hdmi->hdcp_state != DW_HDMI_HDCP_STATE_DISABLED) {
+		/*
+		 * We can ensure each time HDMI unplug/suspend, bridge
+		 * disable would be called by the drm framework with mode
+		 * config locked, so we just need to maintain the HDCP
+		 * desiredness here.
+		 */
+		if (hdmi->hdcp_state == DW_HDMI_HDCP_STATE_ENCRY_EN)
+			_hdmi_set_hdcp_status_drm_property(hdmi, false);
+		_hdmi_close_hdcp_auth(hdmi);
+	}
+	mutex_unlock(&hdmi->hdcp_state_mutex);
 }
 
 static void dw_hdmi_bridge_enable(struct drm_bridge *bridge)
@@ -1722,12 +1921,61 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
 	mutex_unlock(&hdmi->mutex);
 }
 
+static void dw_hdmi_set_content_protection(struct dw_hdmi *hdmi, uint64_t val)
+{
+	/*
+	 * For enable: we start authentication.  When that finishes we'll
+	 * get an interrupt and turn on encryption.
+	 *
+	 * For disable: we just turn off encryption.  There's no need to
+	 * undo the HDCP auth.
+	 */
+
+	switch (val) {
+	case DRM_MODE_CONTENT_PROTECTION_UNDESIRED:
+		hdmi_disable_hdcp_encry(hdmi);
+		break;
+
+	case DRM_MODE_CONTENT_PROTECTION_DESIRED:
+		/*
+		 * Start auth over even if at DW_HDMI_HDCP_STATE_AUTH_DONE
+		 * since we need the interrupt where we'll set
+		 * DRM_MODE_CONTENT_PROTECTION_ENABLED.  We don't wan to set
+		 * it here because we'd need to grab the mode_config mutex and
+		 * that could lead to deadlock.
+		 */
+		mutex_lock(&hdmi->hdcp_state_mutex);
+		_hdmi_start_hdcp_auth(hdmi);
+		mutex_unlock(&hdmi->hdcp_state_mutex);
+
+		break;
+	default:
+		WARN_ON(1);
+	}
+}
+
+static int dw_hdmi_connector_set_property(struct drm_connector *connector,
+					  struct drm_property *property,
+					  uint64_t val)
+{
+	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
+					    connector);
+
+	DRM_DEBUG_KMS("[PROPERTY:%s] = %llu\n", property->name, val);
+
+	if (strcmp(property->name, "Content Protection") == 0)
+		dw_hdmi_set_content_protection(hdmi, val);
+
+	return 0;
+}
+
 static struct drm_connector_funcs dw_hdmi_connector_funcs = {
 	.dpms = drm_helper_connector_dpms,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = dw_hdmi_connector_detect,
 	.destroy = dw_hdmi_connector_destroy,
 	.force = dw_hdmi_connector_force,
+	.set_property = dw_hdmi_connector_set_property,
 };
 
 static struct drm_connector_helper_funcs dw_hdmi_connector_helper_funcs = {
@@ -1766,16 +2014,22 @@ static irqreturn_t dw_hdmi_i2c_irq(struct dw_hdmi *hdmi)
 static irqreturn_t dw_hdmi_hardirq(int irq, void *dev_id)
 {
 	struct dw_hdmi *hdmi = dev_id;
-	u8 intr_stat;
+	u8 intr_stat, hdcp_stat;
 	irqreturn_t ret = IRQ_NONE;
 
 	if (hdmi->i2c)
 		ret = dw_hdmi_i2c_irq(hdmi);
 
+	hdcp_stat = hdmi_readb(hdmi, HDMI_A_APIINTSTAT);
+	if (hdcp_stat & HDMI_A_APIINTSTAT_HDCP_ENGAGED) {
+		hdmi_writeb(hdmi, ~0, HDMI_A_APIINTMSK);
+		ret = IRQ_WAKE_THREAD;
+	}
+
 	intr_stat = hdmi_readb(hdmi, HDMI_IH_PHY_STAT0);
 	if (intr_stat) {
 		hdmi_writeb(hdmi, ~0, HDMI_IH_MUTE_PHY_STAT0);
-		return IRQ_WAKE_THREAD;
+		ret = IRQ_WAKE_THREAD;
 	}
 
 	return ret;
@@ -1784,7 +2038,7 @@ static irqreturn_t dw_hdmi_hardirq(int irq, void *dev_id)
 static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 {
 	struct dw_hdmi *hdmi = dev_id;
-	u8 intr_stat, phy_int_pol, phy_pol_mask, phy_stat;
+	u8 intr_stat, phy_int_pol, phy_pol_mask, phy_stat, hdcp_stat;
 
 	intr_stat = hdmi_readb(hdmi, HDMI_IH_PHY_STAT0);
 	phy_int_pol = hdmi_readb(hdmi, HDMI_PHY_POL0);
@@ -1844,9 +2098,33 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 		drm_helper_hpd_irq_event(hdmi->bridge->dev);
 	}
 
+	hdcp_stat = hdmi_readb(hdmi, HDMI_A_APIINTSTAT);
+	if (hdcp_stat & HDMI_A_APIINTSTAT_HDCP_ENGAGED) {
+		hdmi_writeb(hdmi, HDMI_A_APIINTSTAT_HDCP_ENGAGED,
+			    HDMI_A_APIINTCLR);
+		hdcp_stat &= ~HDMI_A_APIINTSTAT_HDCP_ENGAGED;
+
+		/* Always grab mode config mutex before state mutex */
+		mutex_lock(&hdmi->connector.dev->mode_config.mutex);
+		mutex_lock(&hdmi->hdcp_state_mutex);
+		hdmi->hdcp_state = DW_HDMI_HDCP_STATE_AUTH_DONE;
+		_hdmi_enable_hdcp_encry(hdmi);
+		_hdmi_set_hdcp_status_drm_property(hdmi, true);
+		mutex_unlock(&hdmi->hdcp_state_mutex);
+		mutex_unlock(&hdmi->connector.dev->mode_config.mutex);
+	}
+
+	if (hdcp_stat) {
+		dev_dbg(hdmi->dev, "Unexpected HDCP irq %#x\n", hdcp_stat);
+		hdmi_writeb(hdmi, hdcp_stat, HDMI_A_APIINTCLR);
+	}
+
 	hdmi_writeb(hdmi, intr_stat, HDMI_IH_PHY_STAT0);
 	hdmi_writeb(hdmi, ~(HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE),
 		    HDMI_IH_MUTE_PHY_STAT0);
+	hdmi_writeb(hdmi, (u8)~HDMI_A_APIINTSTAT_HDCP_ENGAGED,
+		    HDMI_A_APIINTMSK);
+
 
 	return IRQ_HANDLED;
 }
@@ -1854,6 +2132,7 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 static int dw_hdmi_register(struct drm_device *drm, struct dw_hdmi *hdmi)
 {
 	struct drm_encoder *encoder = hdmi->encoder;
+	struct drm_mode_config *mode_config;
 	struct drm_bridge *bridge;
 	int ret;
 
@@ -1880,6 +2159,11 @@ static int dw_hdmi_register(struct drm_device *drm, struct dw_hdmi *hdmi)
 	drm_connector_init(drm, &hdmi->connector, &dw_hdmi_connector_funcs,
 			   DRM_MODE_CONNECTOR_HDMIA);
 
+	mode_config = &hdmi->connector.dev->mode_config;
+	drm_object_attach_property(&hdmi->connector.base,
+				   mode_config->content_protection_property,
+				   DRM_MODE_CONTENT_PROTECTION_UNDESIRED);
+
 	hdmi->connector.encoder = encoder;
 
 	drm_mode_connector_attach_encoder(&hdmi->connector, encoder);
@@ -1887,6 +2171,36 @@ static int dw_hdmi_register(struct drm_device *drm, struct dw_hdmi *hdmi)
 	return 0;
 }
 
+int dw_hdmi_config_hdcp_key(struct device *dev,
+			    const struct dw_hdmi_hdcp_key_1x *keys)
+{
+	struct dw_hdmi *hdmi = dev_get_drvdata(dev);
+	int ret;
+
+	if (!keys)
+		return -EINVAL;
+
+	mutex_lock(&hdmi->hdcp_key_mutex);
+
+	if (hdmi->is_hdcp_key_present) {
+		mutex_unlock(&hdmi->hdcp_key_mutex);
+		return -EBUSY;
+	}
+
+	hdmi->is_hdcp_key_present = true;
+	hdmi->hdcp_key = *keys;
+
+	ret = _hdmi_write_hdcp_key(hdmi);
+	mutex_unlock(&hdmi->hdcp_key_mutex);
+	if (ret) {
+		dev_err(dev, "Failed to write HDCP key to HDMI IP\n");
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_config_hdcp_key);
+
 int dw_hdmi_bind(struct device *dev, struct device *master,
 		 void *data, struct drm_encoder *encoder,
 		 struct resource *iores, int irq,
@@ -1920,6 +2234,9 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
 	mutex_init(&hdmi->audio_mutex);
 	spin_lock_init(&hdmi->audio_lock);
 
+	mutex_init(&hdmi->hdcp_key_mutex);
+	mutex_init(&hdmi->hdcp_state_mutex);
+
 	of_property_read_u32(np, "reg-io-width", &val);
 
 	switch (val) {
diff --git a/drivers/gpu/drm/bridge/dw_hdmi.h b/drivers/gpu/drm/bridge/dw_hdmi.h
index 6aadc84..6b43599 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.h
+++ b/drivers/gpu/drm/bridge/dw_hdmi.h
@@ -478,6 +478,19 @@
 #define HDMI_A_PRESETUP                         0x501A
 #define HDMI_A_SRM_BASE                         0x5020
 
+/* HDCP Registers */
+#define HDMI_HDCPREG_RMCTL                      0x780e
+#define HDMI_HDCPREG_RMSTS                      0x780f
+#define HDMI_HDCPREG_SEED0                      0x7810
+#define HDMI_HDCPREG_SEED1                      0x7811
+#define HDMI_HDCPREG_DPK0                       0x7812
+#define HDMI_HDCPREG_DPK1                       0x7813
+#define HDMI_HDCPREG_DPK2                       0x7814
+#define HDMI_HDCPREG_DPK3                       0x7815
+#define HDMI_HDCPREG_DPK4                       0x7816
+#define HDMI_HDCPREG_DPK5                       0x7817
+#define HDMI_HDCPREG_DPK6                       0x7818
+
 /* CEC Engine Registers */
 #define HDMI_CEC_CTRL                           0x7D00
 #define HDMI_CEC_STAT                           0x7D01
@@ -1024,6 +1037,13 @@ enum {
 	HDMI_A_HDCPCFG1_SWRESET_MASK = 0x1,
 	HDMI_A_HDCPCFG1_SWRESET_ASSERT = 0x0,
 
+/* HDCPREG_RMSTS field values */
+	DPK_WR_OK_STS = 0x40,
+
+/* A_APIINT_STAT field values */
+	HDMI_A_APIINTSTAT_HDCP_ENGAGED = 0x80,
+	HDMI_A_APIINTSTAT_HDCP_FAILED = 0x40,
+
 /* A_VIDPOLCFG field values */
 	HDMI_A_VIDPOLCFG_UNENCRYPTCONF_MASK = 0x60,
 	HDMI_A_VIDPOLCFG_UNENCRYPTCONF_OFFSET = 5,
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index bae79f3..355ec42 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -21,6 +21,14 @@ enum {
 	DW_HDMI_RES_MAX,
 };
 
+enum {
+	DW_HDMI_HDCP_KSV_LEN = 8,
+	DW_HDMI_HDCP_SHA_LEN = 20,
+	DW_HDMI_HDCP_DPK_LEN = 280,
+	DW_HDMI_HDCP_KEY_LEN = 308,
+	DW_HDMI_HDCP_SEED_LEN = 2,
+};
+
 enum dw_hdmi_devtype {
 	IMX6Q_HDMI,
 	IMX6DL_HDMI,
@@ -47,6 +55,13 @@ struct dw_hdmi_phy_config {
 	u16 vlev_ctr;   /* voltage level control */
 };
 
+struct dw_hdmi_hdcp_key_1x {
+	u8 ksv[DW_HDMI_HDCP_KSV_LEN];
+	u8 device_key[DW_HDMI_HDCP_DPK_LEN];
+	u8 sha1[DW_HDMI_HDCP_SHA_LEN];
+	u8 seed[DW_HDMI_HDCP_SEED_LEN];
+};
+
 struct dw_hdmi_plat_data {
 	enum dw_hdmi_devtype dev_type;
 	const struct dw_hdmi_mpll_config *mpll_cfg;
@@ -65,5 +80,7 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
 void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
 void dw_hdmi_audio_enable(struct dw_hdmi *hdmi);
 void dw_hdmi_audio_disable(struct dw_hdmi *hdmi);
+int dw_hdmi_config_hdcp_key(struct device *dev,
+			    const struct dw_hdmi_hdcp_key_1x *keys);
 
 #endif /* __IMX_HDMI_H__ */
-- 
1.9.1
