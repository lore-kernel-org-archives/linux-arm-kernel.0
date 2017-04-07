From: romain.perier@collabora.com (Romain Perier)
Date: Fri,  7 Apr 2017 16:19:04 +0200
Subject: [PATCH 1/2] drm: dw-hdmi: add specific I2S and AHB functions for
 stream handling
In-Reply-To: <20170407141905.14147-1-romain.perier@collabora.com>
References: <20170407141905.14147-1-romain.perier@collabora.com>
Message-ID: <20170407141905.14147-2-romain.perier@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, CTS+N is forced to zero as a workaround of the IP block for
i.MX platforms. This is requested in the datasheet of the corresponding
IP for AHB mode only. However, we have seen that it introduces glitches
or delays when playing a sound on HDMI for I2S mode. This proves that we
cannot keep the current functions for handling audio stream as-is if
these contain workaround that are specific to a mode.

This commit introduces two callbacks, one for each variant.
dw_hdmi_setup defines the right function depending on the detected
variant. Then, the exported functions dw_hdmi_audio_enable and
dw_hdmi_audio_disable calls the corresponding callbacks

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 drivers/gpu/drm/bridge/dw-hdmi.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw-hdmi.c b/drivers/gpu/drm/bridge/dw-hdmi.c
index 542d198..d34e0a5 100644
--- a/drivers/gpu/drm/bridge/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/dw-hdmi.c
@@ -166,6 +166,8 @@ struct dw_hdmi {
 
 	void (*write)(struct dw_hdmi *hdmi, u8 val, int offset);
 	u8 (*read)(struct dw_hdmi *hdmi, int offset);
+	void (*enable_audio)(struct dw_hdmi *hdmi);
+	void (*disable_audio)(struct dw_hdmi *hdmi);
 };
 
 #define HDMI_IH_PHY_STAT0_RX_SENSE \
@@ -557,13 +559,34 @@ void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate)
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_set_sample_rate);
 
+void dw_hdmi_ahb_audio_enable(struct dw_hdmi *hdmi)
+{
+	hdmi_set_cts_n(hdmi, hdmi->audio_cts, hdmi->audio_n);
+}
+
+void dw_hdmi_ahb_audio_disable(struct dw_hdmi *hdmi)
+{
+	hdmi_set_cts_n(hdmi, hdmi->audio_cts, 0);
+}
+
+void dw_hdmi_i2s_audio_enable(struct dw_hdmi *hdmi)
+{
+	hdmi_set_cts_n(hdmi, hdmi->audio_cts, hdmi->audio_n);
+}
+
+
+void dw_hdmi_i2s_audio_disable(struct dw_hdmi *hdmi)
+{
+
+}
+
 void dw_hdmi_audio_enable(struct dw_hdmi *hdmi)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&hdmi->audio_lock, flags);
 	hdmi->audio_enable = true;
-	hdmi_set_cts_n(hdmi, hdmi->audio_cts, hdmi->audio_n);
+	hdmi->enable_audio(hdmi);
 	spin_unlock_irqrestore(&hdmi->audio_lock, flags);
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_audio_enable);
@@ -574,7 +597,7 @@ void dw_hdmi_audio_disable(struct dw_hdmi *hdmi)
 
 	spin_lock_irqsave(&hdmi->audio_lock, flags);
 	hdmi->audio_enable = false;
-	hdmi_set_cts_n(hdmi, hdmi->audio_cts, 0);
+	hdmi->disable_audio(hdmi);
 	spin_unlock_irqrestore(&hdmi->audio_lock, flags);
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_audio_disable);
@@ -2114,6 +2137,8 @@ __dw_hdmi_probe(struct platform_device *pdev,
 		audio.irq = irq;
 		audio.hdmi = hdmi;
 		audio.eld = hdmi->connector.eld;
+		hdmi->enable_audio = dw_hdmi_ahb_audio_enable;
+		hdmi->disable_audio = dw_hdmi_ahb_audio_disable;
 
 		pdevinfo.name = "dw-hdmi-ahb-audio";
 		pdevinfo.data = &audio;
@@ -2126,6 +2151,8 @@ __dw_hdmi_probe(struct platform_device *pdev,
 		audio.hdmi	= hdmi;
 		audio.write	= hdmi_writeb;
 		audio.read	= hdmi_readb;
+		hdmi->enable_audio = dw_hdmi_i2s_audio_enable;
+		hdmi->disable_audio = dw_hdmi_i2s_audio_disable;
 
 		pdevinfo.name = "dw-hdmi-i2s-audio";
 		pdevinfo.data = &audio;
-- 
2.9.3
