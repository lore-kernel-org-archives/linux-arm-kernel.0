From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 27 Mar 2015 11:13:45 +0000
Subject: [PATCH 1/3] drm: bridge/dw_hdmi: combine
 hdmi_set_clock_regenerator_n() and hdmi_regenerate_cts()
In-Reply-To: <20150327111320.GA4019@n2100.arm.linux.org.uk>
References: <20150327111320.GA4019@n2100.arm.linux.org.uk>
Message-ID: <E1YbSCv-0007yz-Qj@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Combine these two functions into a single implementation.  These two
functions are called consecutively anyway.  Idea from a patch by
Yakir Yang.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index cd6a70647e32..78363552d80e 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -177,19 +177,16 @@ static void hdmi_mask_writeb(struct dw_hdmi *hdmi, u8 data, unsigned int reg,
 	hdmi_modb(hdmi, data << shift, mask, reg);
 }
 
-static void hdmi_set_clock_regenerator_n(struct dw_hdmi *hdmi,
-					 unsigned int value)
+static void hdmi_set_cts_n(struct dw_hdmi *hdmi, unsigned int cts,
+			   unsigned int n)
 {
-	hdmi_writeb(hdmi, value & 0xff, HDMI_AUD_N1);
-	hdmi_writeb(hdmi, (value >> 8) & 0xff, HDMI_AUD_N2);
-	hdmi_writeb(hdmi, (value >> 16) & 0x0f, HDMI_AUD_N3);
+	hdmi_writeb(hdmi, n & 0xff, HDMI_AUD_N1);
+	hdmi_writeb(hdmi, (n >> 8) & 0xff, HDMI_AUD_N2);
+	hdmi_writeb(hdmi, (n >> 16) & 0x0f, HDMI_AUD_N3);
 
 	/* nshift factor = 0 */
 	hdmi_modb(hdmi, 0, HDMI_AUD_CTS3_N_SHIFT_MASK, HDMI_AUD_CTS3);
-}
 
-static void hdmi_regenerate_cts(struct dw_hdmi *hdmi, unsigned int cts)
-{
 	/* Must be set/cleared first */
 	hdmi_modb(hdmi, 0, HDMI_AUD_CTS3_CTS_MANUAL, HDMI_AUD_CTS3);
 
@@ -355,8 +352,7 @@ static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
 		__func__, hdmi->sample_rate, hdmi->ratio,
 		pixel_clk, clk_n, clk_cts);
 
-	hdmi_set_clock_regenerator_n(hdmi, clk_n);
-	hdmi_regenerate_cts(hdmi, clk_cts);
+	hdmi_set_cts_n(hdmi, clk_cts, clk_n);
 }
 
 static void hdmi_init_clk_regenerator(struct dw_hdmi *hdmi)
-- 
1.8.3.1
