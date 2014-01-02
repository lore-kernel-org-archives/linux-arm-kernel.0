From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:27:28 +0000
Subject: [PATCH RFC 20/46] imx-drm: imx-hdmi: fix CTS/N setup at init time
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1Vypnc-0007Eq-0J@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many of the variables for the audio clock regenerator (CTS/N) were not
initialised in any way.  The pixel rate which was being used also
wasn't being adjusted at all when the display mode is modified.

Get rid of the seaprate 'pixel_clk_rate', and use the stored pixel
clock rate instead.  Pass this desired pixel clock rate into
hdmi_set_clk_regenerator().  Collapse down hdmi_init_clk_regenerator()
since it is a copy of hdmi_set_clk_regenerator(), and pass a default
pixel clock rate.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-hdmi.c |   48 +++++++----------------------------
 1 files changed, 10 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index 075dd1f0c8a7..2eb51e7ea9bb 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -138,7 +138,6 @@ struct imx_hdmi {
 	struct i2c_adapter *ddc;
 	void __iomem *regs;
 
-	unsigned long pixel_clk_rate;
 	unsigned int sample_rate;
 	int ratio;
 };
@@ -332,34 +331,25 @@ static unsigned int hdmi_compute_cts(unsigned int freq, unsigned long pixel_clk,
 		return (cts * ratio) / 100;
 }
 
-static void hdmi_get_pixel_clk(struct imx_hdmi *hdmi)
-{
-	unsigned long rate;
-
-	rate = 65000000; /* FIXME */
-
-	if (rate)
-		hdmi->pixel_clk_rate = rate;
-}
-
-static void hdmi_set_clk_regenerator(struct imx_hdmi *hdmi)
+static void hdmi_set_clk_regenerator(struct imx_hdmi *hdmi,
+	unsigned long pixel_clk)
 {
 	unsigned int clk_n, clk_cts;
 
-	clk_n = hdmi_compute_n(hdmi->sample_rate, hdmi->pixel_clk_rate,
+	clk_n = hdmi_compute_n(hdmi->sample_rate, pixel_clk,
 			       hdmi->ratio);
-	clk_cts = hdmi_compute_cts(hdmi->sample_rate, hdmi->pixel_clk_rate,
+	clk_cts = hdmi_compute_cts(hdmi->sample_rate, pixel_clk,
 				   hdmi->ratio);
 
 	if (!clk_cts) {
 		dev_dbg(hdmi->dev, "%s: pixel clock not supported: %lu\n",
-			 __func__, hdmi->pixel_clk_rate);
+			 __func__, pixel_clk);
 		return;
 	}
 
 	dev_dbg(hdmi->dev, "%s: samplerate=%d  ratio=%d  pixelclk=%lu  N=%d cts=%d\n",
 		__func__, hdmi->sample_rate, hdmi->ratio,
-		hdmi->pixel_clk_rate, clk_n, clk_cts);
+		pixel_clk, clk_n, clk_cts);
 
 	hdmi_set_clock_regenerator_n(hdmi, clk_n);
 	hdmi_regenerate_cts(hdmi, clk_cts);
@@ -367,32 +357,12 @@ static void hdmi_set_clk_regenerator(struct imx_hdmi *hdmi)
 
 static void hdmi_init_clk_regenerator(struct imx_hdmi *hdmi)
 {
-	unsigned int clk_n, clk_cts;
-
-	clk_n = hdmi_compute_n(hdmi->sample_rate, hdmi->pixel_clk_rate,
-			       hdmi->ratio);
-	clk_cts = hdmi_compute_cts(hdmi->sample_rate, hdmi->pixel_clk_rate,
-				   hdmi->ratio);
-
-	if (!clk_cts) {
-		dev_dbg(hdmi->dev, "%s: pixel clock not supported: %lu\n",
-			 __func__, hdmi->pixel_clk_rate);
-		return;
-	}
-
-	dev_dbg(hdmi->dev, "%s: samplerate=%d  ratio=%d  pixelclk=%lu  N=%d cts=%d\n",
-		__func__, hdmi->sample_rate, hdmi->ratio,
-		hdmi->pixel_clk_rate, clk_n, clk_cts);
-
-	hdmi_set_clock_regenerator_n(hdmi, clk_n);
-	hdmi_regenerate_cts(hdmi, clk_cts);
+	hdmi_set_clk_regenerator(hdmi, 74250000);
 }
 
 static void hdmi_clk_regenerator_update_pixel_clock(struct imx_hdmi *hdmi)
 {
-	/* Get pixel clock from ipu */
-	hdmi_get_pixel_clk(hdmi);
-	hdmi_set_clk_regenerator(hdmi);
+	hdmi_set_clk_regenerator(hdmi, hdmi->hdmi_data.video_mode.mpixelclock);
 }
 
 /*
@@ -1640,6 +1610,8 @@ static int imx_hdmi_platform_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hdmi->dev = &pdev->dev;
+	hdmi->sample_rate = 48000;
+	hdmi->ratio = 100;
 
 	if (of_id) {
 		const struct platform_device_id *device_id = of_id->data;
-- 
1.7.4.4
