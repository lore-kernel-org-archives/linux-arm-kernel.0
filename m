From: dkos@cadence.com (Damian Kos)
Date: Tue, 3 Jul 2018 11:02:22 +0100
Subject: [PATCH 11/12] drm/rockchip: added implementation for a few FW
 commands.
In-Reply-To: <1530612152-27555-1-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
Message-ID: <1530612152-27555-12-git-send-email-dkos@cadence.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added support for a register read, register write and register field write
commands.
Added support for adjust link training command.
Updated cdn_dp_get_event function, so it reads all SW event registers.
Added definitions mostly for Framer and Streamer.

Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/rockchip/cdn-dp-reg.c |  167 ++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/rockchip/cdn-dp-reg.h |  143 +++++++++++++++++++++++++++-
 2 files changed, 305 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
index eb3042c..b061cfc 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
@@ -410,7 +410,10 @@ int cdn_dp_event_config(struct cdn_dp_device *dp)
 
 u32 cdn_dp_get_event(struct cdn_dp_device *dp)
 {
-	return readl(dp->regs + SW_EVENTS0);
+	return readl(dp->regs + SW_EVENTS0)
+		| (readl(dp->regs + SW_EVENTS1) << 8)
+		| (readl(dp->regs + SW_EVENTS2) << 16)
+		| (readl(dp->regs + SW_EVENTS3) << 24);
 }
 
 int cdn_dp_get_hpd_status(struct cdn_dp_device *dp)
@@ -981,3 +984,165 @@ int cdn_dp_audio_config(struct cdn_dp_device *dp, struct audio_info *audio)
 		DRM_DEV_ERROR(dp->dev, "audio config failed: %d\n", ret);
 	return ret;
 }
+
+int cdn_dp_register_read(struct cdn_dp_device *dp, u32 addr, u32 *value)
+{
+	u8 msg[4], resp[8];
+	int ret;
+
+	if (addr == 0) {
+		ret = -EINVAL;
+		goto err_register_read;
+	}
+
+	msg[0] = (u8)(addr >> 24);
+	msg[1] = (u8)(addr >> 16);
+	msg[2] = (u8)(addr >> 8);
+	msg[3] = (u8)addr;
+
+	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_GENERAL,
+				  GENERAL_REGISTER_READ,
+				  sizeof(msg), msg);
+	if (ret)
+		goto err_register_read;
+
+	ret = cdn_dp_mailbox_validate_receive(dp, MB_MODULE_ID_GENERAL,
+					      GENERAL_REGISTER_READ,
+					      sizeof(resp));
+	if (ret)
+		goto err_register_read;
+
+	ret = cdn_dp_mailbox_read_receive(dp, resp, sizeof(resp));
+	if (ret)
+		goto err_register_read;
+
+	/* Returned address value should be the same as requested */
+	if (memcmp(msg, resp, sizeof(msg))) {
+		ret = -EINVAL;
+		goto err_register_read;
+	}
+
+	*value = (resp[4] << 24) | (resp[5] << 16) | (resp[6] << 8) | resp[7];
+
+err_register_read:
+	if (ret) {
+		DRM_DEV_ERROR(dp->dev, "Failed to read register.\n");
+		*value = 0;
+	}
+
+	return ret;
+}
+
+int cdn_dp_register_write(struct cdn_dp_device *dp, u32 addr, u32 value)
+{
+	u8 msg[8];
+	int ret;
+
+	if (addr == 0)
+		return -EINVAL;
+
+	msg[0] = (u8)(addr >> 24);
+	msg[1] = (u8)(addr >> 16);
+	msg[2] = (u8)(addr >> 8);
+	msg[3] = (u8)addr;
+	msg[4] = (u8)(value >> 24);
+	msg[5] = (u8)(value >> 16);
+	msg[6] = (u8)(value >> 8);
+	msg[7] = (u8)value;
+
+	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_GENERAL,
+				  GENERAL_REGISTER_WRITE,
+				  sizeof(msg), msg);
+	if (ret)
+		DRM_DEV_ERROR(dp->dev, "Failed to write register.\n");
+
+	return ret;
+}
+
+int cdn_dp_register_write_field(struct cdn_dp_device *dp, u32 addr,
+		u8 index, u8 nbits, u32 value)
+{
+	u8 msg[10];
+	int ret;
+
+	if (addr == 0)
+		return -EINVAL;
+
+	msg[0] = (u8)(addr >> 24);
+	msg[1] = (u8)(addr >> 16);
+	msg[2] = (u8)(addr >> 8);
+	msg[3] = (u8)addr;
+	msg[4] = index;
+	msg[5] = nbits;
+	msg[6] = (u8)(value >> 24);
+	msg[7] = (u8)(value >> 16);
+	msg[8] = (u8)(value >> 8);
+	msg[9] = (u8)value;
+
+	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_GENERAL,
+				  GENERAL_REGISTER_WRITE_FIELD,
+				  sizeof(msg), msg);
+	if (ret)
+		DRM_DEV_ERROR(dp->dev, "Failed to write register field.\n");
+
+	return ret;
+}
+/* rep should be a pointer already allocated with .regs of size 6 */
+int cdn_dp_adjust_lt(struct cdn_dp_device *dp, u8 nlanes,
+		     u16 udelay, u8 *lanes_data,
+		     u8 *dpcd)
+{
+	u8 payload[10];
+	u8 hdr[5]; /* For DPCD read response header */
+	u32 addr;
+	u8 const nregs = 6; /* Registers 0x202-0x207 */
+	int ret;
+
+	if (nlanes != 4 && nlanes != 2 && nlanes != 1) {
+		DRM_DEV_ERROR(dp->dev, "invalid number of lanes: %d\n", nlanes);
+		ret = -EINVAL;
+		goto err_adjust_lt;
+	}
+
+	payload[0] = nlanes;
+	payload[1] = (u8)(udelay >> 8);
+	payload[2] = (u8)udelay;
+
+	payload[3] = lanes_data[0];
+	if (nlanes > 1)
+		payload[4] = lanes_data[1];
+	if (nlanes > 2) {
+		payload[5] = lanes_data[2];
+		payload[6] = lanes_data[3];
+	}
+
+	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX,
+				  DPTX_ADJUST_LT,
+				  sizeof(payload), payload);
+	if (ret)
+		goto err_adjust_lt;
+
+	/* Yes, read the DPCD read command response */
+	ret = cdn_dp_mailbox_validate_receive(dp, MB_MODULE_ID_DP_TX,
+					      DPTX_READ_DPCD,
+					      sizeof(hdr) + nregs);
+	if (ret)
+		goto err_adjust_lt;
+
+	ret = cdn_dp_mailbox_read_receive(dp, hdr, sizeof(hdr));
+	if (ret)
+		goto err_adjust_lt;
+
+	addr = (hdr[2] << 24) | (hdr[3] << 8) | hdr[4];
+	if (addr != DP_LANE0_1_STATUS)
+		goto err_adjust_lt;
+
+	ret = cdn_dp_mailbox_read_receive(dp, dpcd, nregs);
+
+err_adjust_lt:
+	if (ret)
+		DRM_DEV_ERROR(dp->dev, "Failed to adjust Link Training.\n");
+
+	return ret;
+}
+
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.h b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
index c4bbb4a..b5472ad 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
@@ -156,6 +156,14 @@
 #define DP_FRONT_BACK_PORCH		0x2278
 #define DP_BYTE_COUNT			0x227c
 
+/* dptx framer global config fields */
+#define DP_FRAMER_NUM_LANES(x)		(x - 1)
+#define DP_FRAMER_EN			BIT(3)
+#define DP_FRAMER_RATE_GOVERNOR_EN	BIT(4)
+#define DP_FRAMER_NO_VIDEO_MODE		BIT(5)
+#define DP_FRAMER_DISABLE_PHY_RST	BIT(6)
+#define DP_FRAMER_WR_FAILING_EDGE_VSYNC	BIT(7)
+
 /* dptx stream addr */
 #define MSA_HORIZONTAL_0		0x2280
 #define MSA_HORIZONTAL_1		0x2284
@@ -323,10 +331,13 @@
 #define MB_MODULE_ID_GENERAL		0x0a
 
 /* general opcode */
-#define GENERAL_MAIN_CONTROL            0x01
-#define GENERAL_TEST_ECHO               0x02
-#define GENERAL_BUS_SETTINGS            0x03
-#define GENERAL_TEST_ACCESS             0x04
+#define GENERAL_MAIN_CONTROL		0x01
+#define GENERAL_TEST_ECHO		0x02
+#define GENERAL_BUS_SETTINGS		0x03
+#define GENERAL_TEST_ACCESS		0x04
+#define GENERAL_REGISTER_WRITE		0x05
+#define GENERAL_REGISTER_WRITE_FIELD	0x06
+#define GENERAL_REGISTER_READ		0x07
 
 #define DPTX_SET_POWER_MNG			0x00
 #define DPTX_SET_HOST_CAPABILITIES		0x01
@@ -346,6 +357,7 @@
 #define DPTX_SET_LINK_BREAK_POINT		0x0f
 #define DPTX_FORCE_LANES			0x10
 #define DPTX_HPD_STATE				0x11
+#define DPTX_ADJUST_LT				0x12
 
 #define FW_STANDBY				0
 #define FW_ACTIVE				1
@@ -424,6 +436,122 @@
 /* Reference cycles when using lane clock as reference */
 #define LANE_REF_CYC				0x8000
 
+#define CDN_DPTX_FRAMER				0x02200
+#define CDN_DP_FRAMER_GLOBAL_CONFIG		(CDN_DPTX_FRAMER + 0x00)
+#define CDN_DP_NUM_LANES(x)			(x - 1)
+#define CDN_DP_FRAMER_EN			BIT(3)
+#define CDN_DP_RATE_GOVERNOR_EN			BIT(4)
+#define CDN_DP_NO_VIDEO_MODE			BIT(5)
+#define CDN_DP_DISABLE_PHY_RST			BIT(6)
+#define CDN_DP_WR_FAILING_EDGE_VSYNC		BIT(7)
+
+#define CDN_DP_SW_RESET				(CDN_DPTX_FRAMER + 0x04)
+#define CDN_DP_FRAMER_TU			(CDN_DPTX_FRAMER + 0x08)
+#define CDN_DP_FRAMER_TU_SIZE(x)		(((x) & GENMASK(6, 0)) << 8)
+#define CDN_DP_FRAMER_TU_VS(x)			((x) & GENMASK(5, 0))
+#define CDN_DP_FRAMER_TU_CNT_RST_EN		BIT(15)
+
+#define CDN_DPTX_STREAM				0x03000
+#define CDN_DP_MSA_HORIZONTAL_0			(CDN_DPTX_STREAM + 0x00)
+#define CDN_DP_MSAH0_H_TOTAL(x)			(x)
+#define CDN_DP_MSAH0_HSYNC_START(x)		((x) << 16)
+
+#define CDN_DP_MSA_HORIZONTAL_1			(CDN_DPTX_STREAM + 0x04)
+#define CDN_DP_MSAH1_HSYNC_WIDTH(x)		(x)
+#define CDN_DP_MSAH1_HSYNC_POL_LOW		BIT(15)
+#define CDN_DP_MSAH1_HDISP_WIDTH(x)		((x) << 16)
+
+#define CDN_DP_MSA_VERTICAL_0			(CDN_DPTX_STREAM + 0x08)
+#define CDN_DP_MSAV0_V_TOTAL(x)			(x)
+#define CDN_DP_MSAV0_VSYNC_START(x)		((x) << 16)
+
+#define CDN_DP_MSA_VERTICAL_1			(CDN_DPTX_STREAM + 0x0c)
+#define CDN_DP_MSAV1_VSYNC_WIDTH(x)		(x)
+#define CDN_DP_MSAV1_VSYNC_POL_LOW		BIT(15)
+#define CDN_DP_MSAV1_VDISP_WIDTH(x)		((x) << 16)
+
+#define CDN_DP_MSA_MISC				(CDN_DPTX_STREAM + 0x10)
+#define CDN_DP_STREAM_CONFIG			(CDN_DPTX_STREAM + 0x14)
+#define CDN_DP_RATE_GOVERNOR_STATUS		(CDN_DPTX_STREAM + 0x2c)
+#define CDN_DP_RG_TU_VS_DIFF(x)			((x) << 8)
+
+#define CDN_DP_HORIZONTAL			(CDN_DPTX_STREAM + 0x30)
+#define CDN_DP_H_HSYNC_WIDTH(x)			(x)
+#define CDN_DP_H_H_TOTAL(x)			((x) << 16)
+
+#define CDN_DP_VERTICAL_0			(CDN_DPTX_STREAM + 0x34)
+#define CDN_DP_V0_VHEIGHT(x)			(x)
+#define CDN_DP_V0_VSTART(x)			((x) << 16)
+
+#define CDN_DP_VERTICAL_1			(CDN_DPTX_STREAM + 0x38)
+#define CDN_DP_V1_VTOTAL(x)			(x)
+#define CDN_DP_V1_VTOTAL_EVEN			BIT(16)
+
+#define CDN_DP_FRAMER_PXL_REPR			(CDN_DPTX_STREAM + 0x4c)
+#define CDN_DP_FRAMER_6_BPC			BIT(0)
+#define CDN_DP_FRAMER_8_BPC			BIT(1)
+#define CDN_DP_FRAMER_10_BPC			BIT(2)
+#define CDN_DP_FRAMER_12_BPC			BIT(3)
+#define CDN_DP_FRAMER_16_BPC			BIT(4)
+#define CDN_DP_FRAMER_PXL_FORMAT		0x8
+#define CDN_DP_FRAMER_RGB			BIT(0)
+#define CDN_DP_FRAMER_YCBCR444			BIT(1)
+#define CDN_DP_FRAMER_YCBCR422			BIT(2)
+#define CDN_DP_FRAMER_YCBCR420			BIT(3)
+#define CDN_DP_FRAMER_Y_ONLY			BIT(4)
+
+#define CDN_DP_FRAMER_SP			(CDN_DPTX_STREAM + 0x10)
+#define CDN_DP_FRAMER_VSYNC_POL_LOW		BIT(0)
+#define CDN_DP_FRAMER_HSYNC_POL_LOW		BIT(1)
+#define CDN_DP_FRAMER_INTERLACE			BIT(2)
+
+#define CDN_DP_LINE_THRESH			(CDN_DPTX_STREAM + 0x64)
+#define CDN_DP_VB_ID				(CDN_DPTX_STREAM + 0x68)
+#define CDN_DP_VB_ID_INTERLACED			BIT(2)
+
+#define CDN_DP_FRONT_BACK_PORCH			(CDN_DPTX_STREAM + 0x78)
+#define CDN_DP_BACK_PORCH(x)			(x)
+#define CDN_DP_FRONT_PORCH(x)			((x) << 16)
+
+#define CDN_DP_BYTE_COUNT			(CDN_DPTX_STREAM + 0x7c)
+
+#define CDN_DPTX_GLOBAL				0x02300
+#define CDN_DP_LANE_EN				(CDN_DPTX_GLOBAL + 0x00)
+#define CDN_DP_LANE_EN_LANES(x)			GENMASK(x - 1, 0)
+#define CDN_DP_ENHNCD				(CDN_DPTX_GLOBAL + 0x04)
+
+#define CDN_SOURCE_VIDEO_INTERFACE		0x00b00
+#define CDN_BND_HSYNC2VSYNC			(CDN_SOURCE_VIDEO_INTERFACE + 0x00)
+#define CDN_IP_DTCT_WIN				GENMASK(11, 0)
+#define CDN_IP_DET_INTERLACE_FORMAT		BIT(12)
+#define CDN_IP_BYPASS_V_INTERFACE		BIT(13)
+
+#define CDN_HSYNC2VSYNC_POL_CTRL		(CDN_SOURCE_VIDEO_INTERFACE + 0x10)
+#define CDN_H2V_HSYNC_POL_ACTIVE_LOW		BIT(1)
+#define CDN_H2V_VSYNC_POL_ACTIVE_LOW		BIT(2)
+
+#define CDN_DPTX_PHY_CONFIG			0x02000
+#define CDN_PHY_TRAINING_EN			BIT(0)
+#define CDN_PHY_TRAINING_TYPE(x)		(((x) & GENMASK(3, 0)) << 1)
+#define CDN_PHY_SCRAMBLER_BYPASS		BIT(5)
+#define CDN_PHY_ENCODER_BYPASS			BIT(6)
+#define CDN_PHY_SKEW_BYPASS			BIT(7)
+#define CDN_PHY_TRAINING_AUTO			BIT(8)
+#define CDN_PHY_LANE0_SKEW(x)			(((x) & GENMASK(2, 0)) << 9)
+#define CDN_PHY_LANE1_SKEW(x)			(((x) & GENMASK(2, 0)) << 12)
+#define CDN_PHY_LANE2_SKEW(x)			(((x) & GENMASK(2, 0)) << 15)
+#define CDN_PHY_LANE3_SKEW(x)			(((x) & GENMASK(2, 0)) << 18)
+#define CDN_PHY_COMMON_CONFIG			(CDN_PHY_LANE1_SKEW(1) | CDN_PHY_LANE2_SKEW(2) | CDN_PHY_LANE3_SKEW(3))
+#define CDN_PHY_10BIT_EN			BIT(21)
+
+#define CDN_PRE_EMPHASIS(x)			((x) & GENMASK(1, 0))
+#define CDN_FORCE_PRE_EMPHASIS			BIT(2)
+
+#define CDN_VOLT_SWING(x)			((x) & GENMASK(1, 0))
+#define CDN_FORCE_VOLT_SWING			BIT(2)
+
+#define CDN_DP_TRAINING_PATTERN_4		0x7
+
 enum voltage_swing_level {
 	VOLTAGE_LEVEL_0,
 	VOLTAGE_LEVEL_1,
@@ -479,4 +607,11 @@ int cdn_dp_get_edid_block(void *dp, u8 *edid,
 int cdn_dp_audio_stop(struct cdn_dp_device *dp, struct audio_info *audio);
 int cdn_dp_audio_mute(struct cdn_dp_device *dp, bool enable);
 int cdn_dp_audio_config(struct cdn_dp_device *dp, struct audio_info *audio);
+int cdn_dp_register_read(struct cdn_dp_device *dp, u32 addr, u32 *value);
+int cdn_dp_register_write(struct cdn_dp_device *dp, u32 addr, u32 value);
+int cdn_dp_register_write_field(struct cdn_dp_device *dp, u32 addr,
+				u8 index, u8 nbits, u32 value);
+int cdn_dp_adjust_lt(struct cdn_dp_device *dp, u8 nlanes,
+		     u16 udelay, u8 *lanes_data,
+		     u8 *dpcd);
 #endif /* _CDN_DP_REG_H */
-- 
1.7.1
