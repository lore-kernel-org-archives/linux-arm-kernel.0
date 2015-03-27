From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 27 Mar 2015 11:13:50 +0000
Subject: [PATCH 2/3] drm: bridge/dw_hdmi: protect n/cts setting with a mutex
In-Reply-To: <20150327111320.GA4019@n2100.arm.linux.org.uk>
References: <20150327111320.GA4019@n2100.arm.linux.org.uk>
Message-ID: <E1YbSD0-0007z4-Uc@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HDMI n/cts settings need to be updated whenever the audio sample
rate or the video pixel clock changes.  This needs to be protected
against concurrency as there is no synchronisation between these two
operations.  Introduce a mutex (called audio_mutex) to protect against
two threads trying to update the video clock rate and pixel clock
simultaneously.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 78363552d80e..b75922d4901e 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/hdmi.h>
+#include <linux/mutex.h>
 #include <linux/of_device.h>
 
 #include <drm/drm_of.h>
@@ -126,6 +127,7 @@ struct dw_hdmi {
 	struct i2c_adapter *ddc;
 	void __iomem *regs;
 
+	struct mutex audio_mutex;
 	unsigned int sample_rate;
 	int ratio;
 
@@ -357,12 +359,16 @@ static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
 
 static void hdmi_init_clk_regenerator(struct dw_hdmi *hdmi)
 {
+	mutex_lock(&hdmi->audio_mutex);
 	hdmi_set_clk_regenerator(hdmi, 74250000);
+	mutex_unlock(&hdmi->audio_mutex);
 }
 
 static void hdmi_clk_regenerator_update_pixel_clock(struct dw_hdmi *hdmi)
 {
+	mutex_lock(&hdmi->audio_mutex);
 	hdmi_set_clk_regenerator(hdmi, hdmi->hdmi_data.video_mode.mpixelclock);
+	mutex_unlock(&hdmi->audio_mutex);
 }
 
 /*
@@ -1565,6 +1571,8 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
 	hdmi->ratio = 100;
 	hdmi->encoder = encoder;
 
+	mutex_init(&hdmi->audio_mutex);
+
 	of_property_read_u32(np, "reg-io-width", &val);
 
 	switch (val) {
-- 
1.8.3.1
