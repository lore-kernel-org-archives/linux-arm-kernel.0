From: ykk@rock-chips.com (Yakir Yang)
Date: Tue,  3 Feb 2015 10:13:49 -0500
Subject: [PATCH v3 07/15] drm: bridge/dw_hdmi: set ncts_atomic_write &
 cts_manual
In-Reply-To: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
References: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1422976429-30212-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ncts_atomic_write & cts_manual bits are present when design id
equal to 0x20. After set the ncts_atomic_write, then the new N and
CTS values are only used when aud_n1 register is updated. After set
cts_manual bit, the new CTS value can set by AudCTS registers.

- write N3 ncts_atomic_write = 1
- write CTS3 CTS_manual = 1

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v3:
- Set ncts_atomic_write & cts_manual

Changes in v2: None

 drivers/gpu/drm/bridge/dw_hdmi.c | 13 +++++++++++--
 drivers/gpu/drm/bridge/dw_hdmi.h |  6 ++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 81309df..b0b2605 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -199,8 +199,15 @@ static void hdmi_mask_writeb(struct dw_hdmi *hdmi, u8 data, unsigned int reg,
 static void hdmi_set_clock_regenerator(struct dw_hdmi *hdmi,
 				       unsigned int n, unsigned int cts)
 {
+	if (hdmi->id.design == 0x20) {
+		/* set ncts_atomic_write */
+		hdmi_writeb(hdmi, HDMI_AUD_N3_NCTS_ATOMIC_WRITE_SET,
+			    HDMI_AUD_N3);
+	}
+
 	/* Must be set/cleared first */
-	hdmi_modb(hdmi, 0, HDMI_AUD_CTS3_CTS_MANUAL, HDMI_AUD_CTS3);
+	hdmi_modb(hdmi, HDMI_AUD_CTS3_CTS_MANUAL, HDMI_AUD_CTS3_CTS_MANUAL,
+		  HDMI_AUD_CTS3);
 
 	/* nshift factor = 0 */
 	hdmi_modb(hdmi, 0, HDMI_AUD_CTS3_N_SHIFT_MASK, HDMI_AUD_CTS3);
@@ -210,7 +217,9 @@ static void hdmi_set_clock_regenerator(struct dw_hdmi *hdmi,
 	hdmi_writeb(hdmi, (cts >> 8) & 0xff, HDMI_AUD_CTS2);
 	hdmi_writeb(hdmi, cts & 0xff, HDMI_AUD_CTS1);
 
-	hdmi_writeb(hdmi, (n >> 16) & 0x0f, HDMI_AUD_N3);
+	/* set n values */
+	hdmi_modb(hdmi, (n >> 16) & HDMI_AUD_N3_AUDN19_16_MASK,
+		  HDMI_AUD_N3_AUDN19_16_MASK, HDMI_AUD_N3);
 	hdmi_writeb(hdmi, (n >> 8) & 0xff, HDMI_AUD_N2);
 	hdmi_writeb(hdmi, n & 0xff, HDMI_AUD_N1);
 }
diff --git a/drivers/gpu/drm/bridge/dw_hdmi.h b/drivers/gpu/drm/bridge/dw_hdmi.h
index e4ba634..29e4bee 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.h
+++ b/drivers/gpu/drm/bridge/dw_hdmi.h
@@ -907,6 +907,12 @@ enum {
 	HDMI_PHY_I2CM_CTLINT_ADDR_ARBITRATION_POL = 0x08,
 	HDMI_PHY_I2CM_CTLINT_ADDR_ARBITRATION_MASK = 0x04,
 
+/* AUD_N3 field values */
+	HDMI_AUD_N3_NCTS_ATOMIC_WRITE_MASK = 0x80,
+	HDMI_AUD_N3_NCTS_ATOMIC_WRITE_SET = 0x80,
+	HDMI_AUD_N3_NCTS_ATOMIC_WRITE_CLEAR = 0x00,
+	HDMI_AUD_N3_AUDN19_16_MASK = 0x0f,
+
 /* AUD_CTS3 field values */
 	HDMI_AUD_CTS3_N_SHIFT_OFFSET = 5,
 	HDMI_AUD_CTS3_N_SHIFT_MASK = 0xe0,
-- 
2.1.2
