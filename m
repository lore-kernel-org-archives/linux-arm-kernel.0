From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 08 Aug 2015 17:10:37 +0100
Subject: [PATCH 7/9] drm: bridge/dw_hdmi: remove ratio support from ACR code
In-Reply-To: <20150808160936.GN7557@n2100.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZO6hh-0003Nc-A7@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We never set the ratio for CTS/N calculation for the audio clock
regenerator (ACR) to anything but 100, so this adds pointless
complexity.  Should we support pixel repetition, we should update the
CTS/N calculation code to use those parameters or the actual TMDS clock
rate instead of a ratio.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi.c | 44 ++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 5576cd7d7abb..60487bff48e3 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -140,7 +140,6 @@ struct dw_hdmi {
 	unsigned int audio_cts;
 	unsigned int audio_n;
 	bool audio_enable;
-	int ratio;
 
 	void (*write)(struct dw_hdmi *hdmi, u8 val, int offset);
 	u8 (*read)(struct dw_hdmi *hdmi, int offset);
@@ -217,8 +216,7 @@ static void hdmi_set_cts_n(struct dw_hdmi *hdmi, unsigned int cts,
 	hdmi_writeb(hdmi, n & 0xff, HDMI_AUD_N1);
 }
 
-static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk,
-				   unsigned int ratio)
+static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk)
 {
 	unsigned int n = (128 * freq) / 1000;
 	unsigned int mult = 1;
@@ -231,9 +229,9 @@ static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk,
 	switch (freq) {
 	case 32000:
 		if (pixel_clk == 25175000)
-			n = (ratio == 150) ? 9152 : 4576;
+			n = 4576;
 		else if (pixel_clk == 27027000)
-			n = (ratio == 150) ? 8192 : 4096;
+			n = 4096;
 		else if (pixel_clk == 74176000 || pixel_clk == 148352000)
 			n = 11648;
 		else
@@ -247,7 +245,7 @@ static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk,
 		else if (pixel_clk == 74176000)
 			n = 17836;
 		else if (pixel_clk == 148352000)
-			n = (ratio == 150) ? 17836 : 8918;
+			n = 8918;
 		else
 			n = 6272;
 		n *= mult;
@@ -255,13 +253,13 @@ static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk,
 
 	case 48000:
 		if (pixel_clk == 25175000)
-			n = (ratio == 150) ? 9152 : 6864;
+			n = 6864;
 		else if (pixel_clk == 27027000)
-			n = (ratio == 150) ? 8192 : 6144;
+			n = 6144;
 		else if (pixel_clk == 74176000)
 			n = 11648;
 		else if (pixel_clk == 148352000)
-			n = (ratio == 150) ? 11648 : 5824;
+			n = 5824;
 		else
 			n = 6144;
 		n *= mult;
@@ -274,13 +272,11 @@ static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk,
 	return n;
 }
 
-static unsigned int hdmi_compute_cts(unsigned int freq, unsigned long pixel_clk,
-				     unsigned int ratio)
+static unsigned int hdmi_compute_cts(unsigned int freq, unsigned long pixel_clk)
 {
 	unsigned int cts = 0;
 
-	pr_debug("%s: freq: %d pixel_clk: %ld ratio: %d\n", __func__, freq,
-		 pixel_clk, ratio);
+	pr_debug("%s: freq: %d pixel_clk: %ld\n", __func__, freq, pixel_clk);
 
 	switch (freq) {
 	case 32000:
@@ -341,26 +337,24 @@ static unsigned int hdmi_compute_cts(unsigned int freq, unsigned long pixel_clk,
 	default:
 		break;
 	}
-	if (ratio == 100)
-		return cts;
-	return (cts * ratio) / 100;
+	return cts;
 }
 
 static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
-	unsigned long pixel_clk, unsigned int sample_rate, unsigned int ratio)
+	unsigned long pixel_clk, unsigned int sample_rate)
 {
 	unsigned int n, cts;
 
-	n = hdmi_compute_n(sample_rate, pixel_clk, ratio);
-	cts = hdmi_compute_cts(sample_rate, pixel_clk, ratio);
+	n = hdmi_compute_n(sample_rate, pixel_clk);
+	cts = hdmi_compute_cts(sample_rate, pixel_clk);
 	if (!cts) {
 		dev_err(hdmi->dev,
 			"%s: pixel clock/sample rate not supported: %luMHz / %ukHz\n",
 			__func__, pixel_clk, sample_rate);
 	}
 
-	dev_dbg(hdmi->dev, "%s: samplerate=%ukHz ratio=%d pixelclk=%luMHz N=%d cts=%d\n",
-		__func__, sample_rate, ratio, pixel_clk, n, cts);
+	dev_dbg(hdmi->dev, "%s: samplerate=%ukHz pixelclk=%luMHz N=%d cts=%d\n",
+		__func__, sample_rate, pixel_clk, n, cts);
 
 	spin_lock_irq(&hdmi->audio_lock);
 	hdmi->audio_n = n;
@@ -372,8 +366,7 @@ static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
 static void hdmi_init_clk_regenerator(struct dw_hdmi *hdmi)
 {
 	mutex_lock(&hdmi->audio_mutex);
-	hdmi_set_clk_regenerator(hdmi, 74250000, hdmi->sample_rate,
-				 hdmi->ratio);
+	hdmi_set_clk_regenerator(hdmi, 74250000, hdmi->sample_rate);
 	mutex_unlock(&hdmi->audio_mutex);
 }
 
@@ -381,7 +374,7 @@ static void hdmi_clk_regenerator_update_pixel_clock(struct dw_hdmi *hdmi)
 {
 	mutex_lock(&hdmi->audio_mutex);
 	hdmi_set_clk_regenerator(hdmi, hdmi->hdmi_data.video_mode.mpixelclock,
-				 hdmi->sample_rate, hdmi->ratio);
+				 hdmi->sample_rate);
 	mutex_unlock(&hdmi->audio_mutex);
 }
 
@@ -390,7 +383,7 @@ void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate)
 	mutex_lock(&hdmi->audio_mutex);
 	hdmi->sample_rate = rate;
 	hdmi_set_clk_regenerator(hdmi, hdmi->hdmi_data.video_mode.mpixelclock,
-				 hdmi->sample_rate, hdmi->ratio);
+				 hdmi->sample_rate);
 	mutex_unlock(&hdmi->audio_mutex);
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_set_sample_rate);
@@ -1746,7 +1739,6 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
 	hdmi->dev = dev;
 	hdmi->dev_type = plat_data->dev_type;
 	hdmi->sample_rate = 48000;
-	hdmi->ratio = 100;
 	hdmi->encoder = encoder;
 	hdmi->disabled = true;
 	hdmi->rxsense = true;
-- 
2.1.0
