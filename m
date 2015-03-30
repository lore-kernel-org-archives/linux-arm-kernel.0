From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 30 Mar 2015 20:40:01 +0100
Subject: [PATCH RFC 01/11] drm: bridge/dw_hdmi: clean up
 hdmi_set_clk_regenerator()
In-Reply-To: <20150330193911.GM24899@n2100.arm.linux.org.uk>
References: <20150330193911.GM24899@n2100.arm.linux.org.uk>
Message-ID: <E1YcfXV-0002uL-9O@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clean up hdmi_set_clk_regenerator() by allowing it to take the audio
sample rate and ratio directly, rather than hiding it inside the
function.  Raise the unsupported pixel clock/sample rate message from
debug to error level as this results in audio not working correctly.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index cca1c3d165e2..49df6c8c4ea8 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -335,39 +335,37 @@ static unsigned int hdmi_compute_cts(unsigned int freq, unsigned long pixel_clk,
 }
 
 static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
-				     unsigned long pixel_clk)
+	unsigned long pixel_clk, unsigned int sample_rate, unsigned int ratio)
 {
-	unsigned int clk_n, clk_cts;
+	unsigned int n, cts;
 
-	clk_n = hdmi_compute_n(hdmi->sample_rate, pixel_clk,
-			       hdmi->ratio);
-	clk_cts = hdmi_compute_cts(hdmi->sample_rate, pixel_clk,
-				   hdmi->ratio);
-
-	if (!clk_cts) {
-		dev_dbg(hdmi->dev, "%s: pixel clock not supported: %lu\n",
-			__func__, pixel_clk);
-		return;
+	n = hdmi_compute_n(sample_rate, pixel_clk, ratio);
+	cts = hdmi_compute_cts(sample_rate, pixel_clk, ratio);
+	if (!cts) {
+		dev_err(hdmi->dev,
+			"%s: pixel clock/sample rate not supported: %luMHz / %ukHz\n",
+			__func__, pixel_clk, sample_rate);
 	}
 
-	dev_dbg(hdmi->dev, "%s: samplerate=%d  ratio=%d  pixelclk=%lu  N=%d cts=%d\n",
-		__func__, hdmi->sample_rate, hdmi->ratio,
-		pixel_clk, clk_n, clk_cts);
+	dev_dbg(hdmi->dev, "%s: samplerate=%ukHz ratio=%d pixelclk=%luMHz N=%d cts=%d\n",
+		__func__, sample_rate, ratio, pixel_clk, n, cts);
 
-	hdmi_set_cts_n(hdmi, clk_cts, clk_n);
+	hdmi_set_cts_n(hdmi, cts, n);
 }
 
 static void hdmi_init_clk_regenerator(struct dw_hdmi *hdmi)
 {
 	mutex_lock(&hdmi->audio_mutex);
-	hdmi_set_clk_regenerator(hdmi, 74250000);
+	hdmi_set_clk_regenerator(hdmi, 74250000, hdmi->sample_rate,
+				 hdmi->ratio);
 	mutex_unlock(&hdmi->audio_mutex);
 }
 
 static void hdmi_clk_regenerator_update_pixel_clock(struct dw_hdmi *hdmi)
 {
 	mutex_lock(&hdmi->audio_mutex);
-	hdmi_set_clk_regenerator(hdmi, hdmi->hdmi_data.video_mode.mpixelclock);
+	hdmi_set_clk_regenerator(hdmi, hdmi->hdmi_data.video_mode.mpixelclock,
+				 hdmi->sample_rate, hdmi->ratio);
 	mutex_unlock(&hdmi->audio_mutex);
 }
 
-- 
1.8.3.1
