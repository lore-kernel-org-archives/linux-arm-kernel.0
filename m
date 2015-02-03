From: ykk@rock-chips.com (Yakir Yang)
Date: Tue,  3 Feb 2015 10:13:07 -0500
Subject: [PATCH v3 06/15] drm: bridge/dw_hdmi: adjust n/cts setting order
In-Reply-To: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
References: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1422976387-30165-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the order to:
- write CTS3 CTS_manual = 0
- write CTS3 N_shift = 0
- write CTS3 CTS value
- write CTS2 CTS value
- write CTS1 CTS value
- write N3 N value
- write N2 N value
- write N1 N value

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v3:
- Only adjust the n/cts setting order

Changes in v2: None

 drivers/gpu/drm/bridge/dw_hdmi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 262163f..81309df 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -199,20 +199,20 @@ static void hdmi_mask_writeb(struct dw_hdmi *hdmi, u8 data, unsigned int reg,
 static void hdmi_set_clock_regenerator(struct dw_hdmi *hdmi,
 				       unsigned int n, unsigned int cts)
 {
-	hdmi_writeb(hdmi, n & 0xff, HDMI_AUD_N1);
-	hdmi_writeb(hdmi, (n >> 8) & 0xff, HDMI_AUD_N2);
-	hdmi_writeb(hdmi, (n >> 16) & 0x0f, HDMI_AUD_N3);
+	/* Must be set/cleared first */
+	hdmi_modb(hdmi, 0, HDMI_AUD_CTS3_CTS_MANUAL, HDMI_AUD_CTS3);
 
 	/* nshift factor = 0 */
 	hdmi_modb(hdmi, 0, HDMI_AUD_CTS3_N_SHIFT_MASK, HDMI_AUD_CTS3);
 
-	/* Must be set/cleared first */
-	hdmi_modb(hdmi, 0, HDMI_AUD_CTS3_CTS_MANUAL, HDMI_AUD_CTS3);
-
-	hdmi_writeb(hdmi, cts & 0xff, HDMI_AUD_CTS1);
-	hdmi_writeb(hdmi, (cts >> 8) & 0xff, HDMI_AUD_CTS2);
 	hdmi_writeb(hdmi, ((cts >> 16) & HDMI_AUD_CTS3_AUDCTS19_16_MASK) |
 		    HDMI_AUD_CTS3_CTS_MANUAL, HDMI_AUD_CTS3);
+	hdmi_writeb(hdmi, (cts >> 8) & 0xff, HDMI_AUD_CTS2);
+	hdmi_writeb(hdmi, cts & 0xff, HDMI_AUD_CTS1);
+
+	hdmi_writeb(hdmi, (n >> 16) & 0x0f, HDMI_AUD_N3);
+	hdmi_writeb(hdmi, (n >> 8) & 0xff, HDMI_AUD_N2);
+	hdmi_writeb(hdmi, n & 0xff, HDMI_AUD_N1);
 }
 
 static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk,
-- 
2.1.2
