From: ykk@rock-chips.com (Yakir Yang)
Date: Tue,  3 Feb 2015 10:16:03 -0500
Subject: [PATCH v3 10/15] drm: bridge/dw_hdmi: add audio sample channel status
 setting
In-Reply-To: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
References: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1422976563-30353-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When transmitting IEC60985 linear PCM audio, we configure the
Aduio Sample Channel Status information of all the channel
status bits in the IEC60958 frame.
(am from https://patchwork.kernel.org/patch/5749101/)

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v3:
- Determine whether sample channel should set by desig_id.

Changes in v2:
- Add audio sample channel status setting

 drivers/gpu/drm/bridge/dw_hdmi.c | 44 ++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/bridge/dw_hdmi.h | 20 ++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 0bee5ea..44e95f3 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -196,6 +196,47 @@ static void hdmi_mask_writeb(struct dw_hdmi *hdmi, u8 data, unsigned int reg,
 	hdmi_modb(hdmi, data << shift, mask, reg);
 }
 
+static void hdmi_set_schnl(struct dw_hdmi *hdmi)
+{
+	u8 aud_schnl_samplerate;
+
+	switch (hdmi->sample_rate) {
+	case 32000:
+		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_32K;
+		break;
+	case 44100:
+		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_44K1;
+		break;
+	case 48000:
+		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_48K;
+		break;
+	case 88200:
+		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_88K2;
+		break;
+	case 96000:
+		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_96K;
+		break;
+	case 176400:
+		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_176K4;
+		break;
+	case 192000:
+		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_192K;
+		break;
+	case 768000:
+		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_768K;
+		break;
+	default:
+		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_44K1;
+		break;
+	}
+
+	/* set channel status register */
+	hdmi_modb(hdmi, aud_schnl_samplerate,
+		  HDMI_FC_AUDSCHNLS7_SMPRATE_MASK, HDMI_FC_AUDSCHNLS7);
+	hdmi_writeb(hdmi, ((~aud_schnl_samplerate) << 4) | 0x2,
+		    HDMI_FC_AUDSCHNLS8);
+}
+
 static void hdmi_set_clock_regenerator(struct dw_hdmi *hdmi,
 				       unsigned int n, unsigned int cts)
 {
@@ -439,6 +480,9 @@ static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
 		pixel_clk, clk_n, clk_cts);
 
 	hdmi_set_clock_regenerator(hdmi, clk_n, clk_cts);
+
+	if (hdmi->id.design == 0x20)
+		hdmi_set_schnl(hdmi);
 }
 
 static void hdmi_init_clk_regenerator(struct dw_hdmi *hdmi)
diff --git a/drivers/gpu/drm/bridge/dw_hdmi.h b/drivers/gpu/drm/bridge/dw_hdmi.h
index 29e4bee..c2d210f 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.h
+++ b/drivers/gpu/drm/bridge/dw_hdmi.h
@@ -162,6 +162,17 @@
 #define HDMI_FC_SPDDEVICEINF                    0x1062
 #define HDMI_FC_AUDSCONF                        0x1063
 #define HDMI_FC_AUDSSTAT                        0x1064
+#define HDMI_FC_AUDSV                           0x1065
+#define HDMI_FC_AUDSU                           0x1066
+#define HDMI_FC_AUDSCHNLS0                      0x1067
+#define HDMI_FC_AUDSCHNLS1                      0x1068
+#define HDMI_FC_AUDSCHNLS2                      0x1069
+#define HDMI_FC_AUDSCHNLS3                      0x106a
+#define HDMI_FC_AUDSCHNLS4                      0x106b
+#define HDMI_FC_AUDSCHNLS5                      0x106c
+#define HDMI_FC_AUDSCHNLS6                      0x106d
+#define HDMI_FC_AUDSCHNLS7                      0x106e
+#define HDMI_FC_AUDSCHNLS8                      0x106f
 #define HDMI_FC_DATACH0FILL                     0x1070
 #define HDMI_FC_DATACH1FILL                     0x1071
 #define HDMI_FC_DATACH2FILL                     0x1072
@@ -754,6 +765,15 @@ enum {
 /* HDMI_FC_AUDSCHNLS7 field values */
 	HDMI_FC_AUDSCHNLS7_ACCURACY_OFFSET = 4,
 	HDMI_FC_AUDSCHNLS7_ACCURACY_MASK = 0x30,
+	HDMI_FC_AUDSCHNLS7_SMPRATE_MASK = 0x0f,
+	HDMI_FC_AUDSCHNLS7_SMPRATE_192K = 0xe,
+	HDMI_FC_AUDSCHNLS7_SMPRATE_176K4 = 0xc,
+	HDMI_FC_AUDSCHNLS7_SMPRATE_96K = 0xa,
+	HDMI_FC_AUDSCHNLS7_SMPRATE_768K = 0x9,
+	HDMI_FC_AUDSCHNLS7_SMPRATE_88K2 = 0x8,
+	HDMI_FC_AUDSCHNLS7_SMPRATE_32K = 0x3,
+	HDMI_FC_AUDSCHNLS7_SMPRATE_48K = 0x2,
+	HDMI_FC_AUDSCHNLS7_SMPRATE_44K1 = 0x0,
 
 /* HDMI_FC_AUDSCHNLS8 field values */
 	HDMI_FC_AUDSCHNLS8_ORIGSAMPFREQ_MASK = 0xf0,
-- 
2.1.2
