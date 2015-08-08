From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 08 Aug 2015 17:10:42 +0100
Subject: [PATCH 8/9] drm: bridge/dw_hdmi: replace CTS calculation for the ACR
In-Reply-To: <20150808160936.GN7557@n2100.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZO6hm-0003Ni-E0@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Given the TDMS clock, audio sample rate, and the N parameter, we can
calculate the CTS value for the audio clock regenerator (ACR) using the
following calculation given in the HDMI specification:

	CTS = ftdms * N / (128 * fs)

The specification says that the CTS value is an average value, which is
true if the source hardware measures it.  Where source hardware needs it
to be programmed, it is particularly difficult to alternate it between
two values correctly to ensure that we achieve a correct "average"
fractional value at the sink.

Also, there's the problem that our "ftdms" is not a fully accurate
value; it is rounded to a kHz value.  This introduces an unnecessary
(and harmless) fractional value into the above equation for combinations
like 148.5MHz/1.001 for 44100Hz - we still calculate the correct CTS
value.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi.c | 92 +++++++---------------------------------
 1 file changed, 16 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 60487bff48e3..a4f9aecf1862 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -272,89 +272,29 @@ static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk)
 	return n;
 }
 
-static unsigned int hdmi_compute_cts(unsigned int freq, unsigned long pixel_clk)
-{
-	unsigned int cts = 0;
-
-	pr_debug("%s: freq: %d pixel_clk: %ld\n", __func__, freq, pixel_clk);
-
-	switch (freq) {
-	case 32000:
-		if (pixel_clk == 297000000) {
-			cts = 222750;
-			break;
-		}
-	case 48000:
-	case 96000:
-	case 192000:
-		switch (pixel_clk) {
-		case 25200000:
-		case 27000000:
-		case 54000000:
-		case 74250000:
-		case 148500000:
-			cts = pixel_clk / 1000;
-			break;
-		case 297000000:
-			cts = 247500;
-			break;
-		/*
-		 * All other TMDS clocks are not supported by
-		 * DWC_hdmi_tx. The TMDS clocks divided or
-		 * multiplied by 1,001 coefficients are not
-		 * supported.
-		 */
-		default:
-			break;
-		}
-		break;
-	case 44100:
-	case 88200:
-	case 176400:
-		switch (pixel_clk) {
-		case 25200000:
-			cts = 28000;
-			break;
-		case 27000000:
-			cts = 30000;
-			break;
-		case 54000000:
-			cts = 60000;
-			break;
-		case 74250000:
-			cts = 82500;
-			break;
-		case 148500000:
-			cts = 165000;
-			break;
-		case 297000000:
-			cts = 247500;
-			break;
-		default:
-			break;
-		}
-		break;
-	default:
-		break;
-	}
-	return cts;
-}
-
 static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
 	unsigned long pixel_clk, unsigned int sample_rate)
 {
+	unsigned long ftdms = pixel_clk;
 	unsigned int n, cts;
+	u64 tmp;
 
 	n = hdmi_compute_n(sample_rate, pixel_clk);
-	cts = hdmi_compute_cts(sample_rate, pixel_clk);
-	if (!cts) {
-		dev_err(hdmi->dev,
-			"%s: pixel clock/sample rate not supported: %luMHz / %ukHz\n",
-			__func__, pixel_clk, sample_rate);
-	}
 
-	dev_dbg(hdmi->dev, "%s: samplerate=%ukHz pixelclk=%luMHz N=%d cts=%d\n",
-		__func__, sample_rate, pixel_clk, n, cts);
+	/*
+	 * Compute the CTS value from the N value.  Note that CTS and N
+	 * can be up to 20 bits in total, so we need 64-bit math.  Also
+	 * note that our TDMS clock is not fully accurate; it is accurate
+	 * to kHz.  This can introduce an unnecessary remainder in the
+	 * calculation below, so we don't try to warn about that.
+	 */
+	tmp = (u64)ftdms * n;
+	do_div(tmp, 128 * sample_rate);
+	cts = tmp;
+
+	dev_dbg(hdmi->dev, "%s: fs=%uHz ftdms=%lu.%03luMHz N=%d cts=%d\n",
+		__func__, sample_rate, ftdms / 1000000, (ftdms / 1000) % 1000,
+		n, cts);
 
 	spin_lock_irq(&hdmi->audio_lock);
 	hdmi->audio_n = n;
-- 
2.1.0
