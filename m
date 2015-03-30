From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 30 Mar 2015 20:40:21 +0100
Subject: [PATCH RFC 05/11] drm: bridge/dw_hdmi: introduce interface to setting
 sample rate
In-Reply-To: <20150330193911.GM24899@n2100.arm.linux.org.uk>
References: <20150330193911.GM24899@n2100.arm.linux.org.uk>
Message-ID: <E1YcfXp-0002ux-PC@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce dw_hdmi_set_sample_rate(), which allows us to configure the
audio sample rate, setting the CTS/N values appropriately.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi.c | 10 ++++++++++
 include/drm/bridge/dw_hdmi.h     |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 06b5583140a8..245d17e58dec 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -366,6 +366,16 @@ static void hdmi_clk_regenerator_update_pixel_clock(struct dw_hdmi *hdmi)
 	mutex_unlock(&hdmi->audio_mutex);
 }
 
+void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate)
+{
+	mutex_lock(&hdmi->audio_mutex);
+	hdmi->sample_rate = rate;
+	hdmi_set_clk_regenerator(hdmi, hdmi->hdmi_data.video_mode.mpixelclock,
+				 hdmi->sample_rate, hdmi->ratio);
+	mutex_unlock(&hdmi->audio_mutex);
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_set_sample_rate);
+
 /*
  * this submodule is responsible for the video data synchronization.
  * for example, for RGB 4:4:4 input, the data map is defined as
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index 5a4f49005169..424b51f6a215 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -12,6 +12,8 @@
 
 #include <drm/drmP.h>
 
+struct dw_hdmi;
+
 enum {
 	DW_HDMI_RES_8,
 	DW_HDMI_RES_10,
@@ -58,4 +60,7 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
 		 void *data, struct drm_encoder *encoder,
 		 struct resource *iores, int irq,
 		 const struct dw_hdmi_plat_data *plat_data);
+
+void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
+
 #endif /* __IMX_HDMI_H__ */
-- 
1.8.3.1
