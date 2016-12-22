From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 22 Dec 2016 21:11:59 +0800
Subject: [PATCH] drm: zte: support hdmi audio through spdif
Message-ID: <1482412319-6304-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It enables HDMI audio support through SPDIF interface based on generic
hdmi-audio-codec driver.  The HDMI hardware supports more audio
interfaces than SPDIF, like I2S, which may be added later.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/gpu/drm/zte/Kconfig        |   1 +
 drivers/gpu/drm/zte/zx_hdmi.c      | 169 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/zte/zx_hdmi_regs.h |  14 +++
 drivers/gpu/drm/zte/zx_vou.c       |   9 ++
 drivers/gpu/drm/zte/zx_vou.h       |  10 +++
 drivers/gpu/drm/zte/zx_vou_regs.h  |   2 +
 6 files changed, 205 insertions(+)

diff --git a/drivers/gpu/drm/zte/Kconfig b/drivers/gpu/drm/zte/Kconfig
index 4065b2840f1c..ed6de4b10c74 100644
--- a/drivers/gpu/drm/zte/Kconfig
+++ b/drivers/gpu/drm/zte/Kconfig
@@ -4,5 +4,6 @@ config DRM_ZTE
 	select DRM_KMS_CMA_HELPER
 	select DRM_KMS_FB_HELPER
 	select DRM_KMS_HELPER
+	select SND_SOC_HDMI_CODEC if SND_SOC
 	help
 	  Choose this option to enable DRM on ZTE ZX SoCs.
diff --git a/drivers/gpu/drm/zte/zx_hdmi.c b/drivers/gpu/drm/zte/zx_hdmi.c
index 6bf6c364811e..e0b1bbfcc685 100644
--- a/drivers/gpu/drm/zte/zx_hdmi.c
+++ b/drivers/gpu/drm/zte/zx_hdmi.c
@@ -25,6 +25,8 @@
 #include <drm/drm_of.h>
 #include <drm/drmP.h>
 
+#include <sound/hdmi-codec.h>
+
 #include "zx_hdmi_regs.h"
 #include "zx_vou.h"
 
@@ -49,6 +51,7 @@ struct zx_hdmi {
 	bool sink_is_hdmi;
 	bool sink_has_audio;
 	const struct vou_inf *inf;
+	struct platform_device *audio_pdev;
 };
 
 #define to_zx_hdmi(x) container_of(x, struct zx_hdmi, x)
@@ -366,6 +369,163 @@ static irqreturn_t zx_hdmi_irq_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
+static int zx_hdmi_audio_startup(struct device *dev, void *data)
+{
+	struct zx_hdmi *hdmi = dev_get_drvdata(dev);
+	struct drm_encoder *encoder = &hdmi->encoder;
+
+	vou_inf_hdmi_audio_sel(encoder->crtc, VOU_HDMI_AUD_SPDIF);
+
+	return 0;
+}
+
+static void zx_hdmi_audio_shutdown(struct device *dev, void *data)
+{
+	struct zx_hdmi *hdmi = dev_get_drvdata(dev);
+
+	/* Disable audio input */
+	hdmi_writeb_mask(hdmi, AUD_EN, AUD_IN_EN, 0);
+}
+
+static int zx_hdmi_audio_get_n(unsigned int fs)
+{
+	unsigned int n;
+
+	switch (fs) {
+	case 32000:
+		n = 4096;
+		break;
+	case 44100:
+		n = 6272;
+		break;
+	case 48000:
+		n = 6144;
+		break;
+	case 88200:
+		n = 6272 * 2;
+		break;
+	case 96000:
+		n = 6144 * 2;
+		break;
+	case 176400:
+		n = 6272 * 4;
+		break;
+	case 192000:
+		n = 6144 * 4;
+		break;
+	default:
+		n = fs * 128 / 1000;
+	}
+
+	return n;
+}
+
+static int zx_hdmi_audio_hw_params(struct device *dev,
+				   void *data,
+				   struct hdmi_codec_daifmt *daifmt,
+				   struct hdmi_codec_params *params)
+{
+	struct zx_hdmi *hdmi = dev_get_drvdata(dev);
+	struct hdmi_audio_infoframe *cea = &params->cea;
+	union hdmi_infoframe frame;
+	int n;
+
+	/* We only support spdif for now */
+	if (daifmt->fmt != HDMI_SPDIF) {
+		DRM_DEV_ERROR(hdmi->dev, "invalid daifmt %d\n", daifmt->fmt);
+		return -EINVAL;
+	}
+
+	switch (params->sample_width) {
+	case 16:
+		hdmi_writeb_mask(hdmi, TPI_AUD_CONFIG, SPDIF_SAMPLE_SIZE_MASK,
+				 SPDIF_SAMPLE_SIZE_16BIT);
+		break;
+	case 20:
+		hdmi_writeb_mask(hdmi, TPI_AUD_CONFIG, SPDIF_SAMPLE_SIZE_MASK,
+				 SPDIF_SAMPLE_SIZE_20BIT);
+		break;
+	case 24:
+		hdmi_writeb_mask(hdmi, TPI_AUD_CONFIG, SPDIF_SAMPLE_SIZE_MASK,
+				 SPDIF_SAMPLE_SIZE_24BIT);
+		break;
+	default:
+		DRM_DEV_ERROR(hdmi->dev, "invalid sample width %d\n",
+			      params->sample_width);
+		return -EINVAL;
+	}
+
+	/* CTS is calculated by hardware, and we only need to take care of N */
+	n = zx_hdmi_audio_get_n(params->sample_rate);
+	hdmi_writeb(hdmi, N_SVAL1, n & 0xff);
+	hdmi_writeb(hdmi, N_SVAL2, (n >> 8) && 0xff);
+	hdmi_writeb(hdmi, N_SVAL3, (n >> 16) & 0xf);
+
+	/* Enable spdif mode */
+	hdmi_writeb_mask(hdmi, AUD_MODE, SPDIF_EN, SPDIF_EN);
+
+	/* Enable audio input */
+	hdmi_writeb_mask(hdmi, AUD_EN, AUD_IN_EN, AUD_IN_EN);
+
+	memcpy(&frame.audio, cea, sizeof(*cea));
+
+	return zx_hdmi_infoframe_trans(hdmi, &frame, FSEL_AUDIO);
+}
+
+static int zx_hdmi_audio_digital_mute(struct device *dev, void *data,
+				      bool enable)
+{
+	struct zx_hdmi *hdmi = dev_get_drvdata(dev);
+
+	if (enable)
+		hdmi_writeb_mask(hdmi, TPI_AUD_CONFIG, TPI_AUD_MUTE,
+				 TPI_AUD_MUTE);
+	else
+		hdmi_writeb_mask(hdmi, TPI_AUD_CONFIG, TPI_AUD_MUTE, 0);
+
+	return 0;
+}
+
+static int zx_hdmi_audio_get_eld(struct device *dev, void *data,
+				 uint8_t *buf, size_t len)
+{
+	struct zx_hdmi *hdmi = dev_get_drvdata(dev);
+	struct drm_connector *connector = &hdmi->connector;
+
+	memcpy(buf, connector->eld, min(sizeof(connector->eld), len));
+
+	return 0;
+}
+
+static const struct hdmi_codec_ops zx_hdmi_codec_ops = {
+	.audio_startup = zx_hdmi_audio_startup,
+	.hw_params = zx_hdmi_audio_hw_params,
+	.audio_shutdown = zx_hdmi_audio_shutdown,
+	.digital_mute = zx_hdmi_audio_digital_mute,
+	.get_eld = zx_hdmi_audio_get_eld,
+};
+
+static struct hdmi_codec_pdata zx_hdmi_codec_pdata = {
+	.ops = &zx_hdmi_codec_ops,
+	.spdif = 1,
+};
+
+static int zx_hdmi_audio_register(struct zx_hdmi *hdmi)
+{
+	struct platform_device *pdev;
+
+	pdev = platform_device_register_data(hdmi->dev, HDMI_CODEC_DRV_NAME,
+					     PLATFORM_DEVID_AUTO,
+					     &zx_hdmi_codec_pdata,
+					     sizeof(zx_hdmi_codec_pdata));
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	hdmi->audio_pdev = pdev;
+
+	return 0;
+}
+
 static int zx_hdmi_i2c_read(struct zx_hdmi *hdmi, struct i2c_msg *msg)
 {
 	int len = msg->len;
@@ -566,6 +726,12 @@ static int zx_hdmi_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 	}
 
+	ret = zx_hdmi_audio_register(hdmi);
+	if (ret) {
+		DRM_DEV_ERROR(dev, "failed to register audio: %d\n", ret);
+		return ret;
+	}
+
 	ret = zx_hdmi_register(drm, hdmi);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "failed to register hdmi: %d\n", ret);
@@ -590,6 +756,9 @@ static void zx_hdmi_unbind(struct device *dev, struct device *master,
 
 	hdmi->connector.funcs->destroy(&hdmi->connector);
 	hdmi->encoder.funcs->destroy(&hdmi->encoder);
+
+	if (hdmi->audio_pdev)
+		platform_device_unregister(hdmi->audio_pdev);
 }
 
 static const struct component_ops zx_hdmi_component_ops = {
diff --git a/drivers/gpu/drm/zte/zx_hdmi_regs.h b/drivers/gpu/drm/zte/zx_hdmi_regs.h
index de911f66b658..c6d5d8211725 100644
--- a/drivers/gpu/drm/zte/zx_hdmi_regs.h
+++ b/drivers/gpu/drm/zte/zx_hdmi_regs.h
@@ -52,5 +52,19 @@
 #define TPI_INFO_TRANS_RPT		BIT(6)
 #define TPI_DDC_MASTER_EN		0x06f8
 #define HW_DDC_MASTER			BIT(7)
+#define N_SVAL1				0xa03
+#define N_SVAL2				0xa04
+#define N_SVAL3				0xa05
+#define AUD_EN				0xa13
+#define AUD_IN_EN			BIT(0)
+#define AUD_MODE			0xa14
+#define SPDIF_EN			BIT(1)
+#define TPI_AUD_CONFIG			0xa62
+#define SPDIF_SAMPLE_SIZE_SHIFT		6
+#define SPDIF_SAMPLE_SIZE_MASK		(0x3 << SPDIF_SAMPLE_SIZE_SHIFT)
+#define SPDIF_SAMPLE_SIZE_16BIT		(0x1 << SPDIF_SAMPLE_SIZE_SHIFT)
+#define SPDIF_SAMPLE_SIZE_20BIT		(0x2 << SPDIF_SAMPLE_SIZE_SHIFT)
+#define SPDIF_SAMPLE_SIZE_24BIT		(0x3 << SPDIF_SAMPLE_SIZE_SHIFT)
+#define TPI_AUD_MUTE			BIT(4)
 
 #endif /* __ZX_HDMI_REGS_H__ */
diff --git a/drivers/gpu/drm/zte/zx_vou.c b/drivers/gpu/drm/zte/zx_vou.c
index 8ca9c4bdeeaf..b39fbb71960a 100644
--- a/drivers/gpu/drm/zte/zx_vou.c
+++ b/drivers/gpu/drm/zte/zx_vou.c
@@ -148,6 +148,15 @@ static inline struct zx_vou_hw *crtc_to_vou(struct drm_crtc *crtc)
 	return zcrtc->vou;
 }
 
+void vou_inf_hdmi_audio_sel(struct drm_crtc *crtc,
+			    enum vou_inf_hdmi_audio aud)
+{
+	struct zx_crtc *zcrtc = to_zx_crtc(crtc);
+	struct zx_vou_hw *vou = zcrtc->vou;
+
+	zx_writel_mask(vou->vouctl + VOU_INF_HDMI_CTRL, VOU_HDMI_AUD_MASK, aud);
+}
+
 void vou_inf_enable(const struct vou_inf *inf, struct drm_crtc *crtc)
 {
 	struct zx_crtc *zcrtc = to_zx_crtc(crtc);
diff --git a/drivers/gpu/drm/zte/zx_vou.h b/drivers/gpu/drm/zte/zx_vou.h
index 1559c1f79db7..97b8f97ee3a7 100644
--- a/drivers/gpu/drm/zte/zx_vou.h
+++ b/drivers/gpu/drm/zte/zx_vou.h
@@ -30,6 +30,14 @@ enum vou_inf_data_sel {
 	VOU_RGB_666	= 3,
 };
 
+enum vou_inf_hdmi_audio {
+	VOU_HDMI_AUD_SPDIF	= BIT(0),
+	VOU_HDMI_AUD_I2S	= BIT(1),
+	VOU_HDMI_AUD_DSD	= BIT(2),
+	VOU_HDMI_AUD_HBR	= BIT(3),
+	VOU_HDMI_AUD_PARALLEL	= BIT(4),
+};
+
 struct vou_inf {
 	enum vou_inf_id id;
 	enum vou_inf_data_sel data_sel;
@@ -37,6 +45,8 @@ struct vou_inf {
 	u32 clocks_sel_bits;
 };
 
+void vou_inf_hdmi_audio_sel(struct drm_crtc *crtc,
+			    enum vou_inf_hdmi_audio aud);
 void vou_inf_enable(const struct vou_inf *inf, struct drm_crtc *crtc);
 void vou_inf_disable(const struct vou_inf *inf, struct drm_crtc *crtc);
 
diff --git a/drivers/gpu/drm/zte/zx_vou_regs.h b/drivers/gpu/drm/zte/zx_vou_regs.h
index 193c1ce01fe7..48fb90bd4594 100644
--- a/drivers/gpu/drm/zte/zx_vou_regs.h
+++ b/drivers/gpu/drm/zte/zx_vou_regs.h
@@ -168,6 +168,8 @@
 #define VOU_CLK_GL0_SEL			BIT(4)
 #define VOU_CLK_REQEN			0x20
 #define VOU_CLK_EN			0x24
+#define VOU_INF_HDMI_CTRL		0x30
+#define VOU_HDMI_AUD_MASK		0x1f
 
 /* OTFPPU_CTRL registers */
 #define OTFPPU_RSZ_DATA_SOURCE		0x04
-- 
1.9.1
