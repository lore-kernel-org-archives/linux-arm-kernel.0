From: zyw@rock-chips.com (Chris Zhong)
Date: Tue, 18 Jul 2017 19:20:42 +0800
Subject: [PATCH v2 2/2] drm/rockchip: cdn-dp: send audio infoframe to sink
In-Reply-To: <1500376842-6739-1-git-send-email-zyw@rock-chips.com>
References: <1500376842-6739-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1500376842-6739-2-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some DP/HDMI sink need to receive the audio infoframe to play sound,
especially some multi-channel AV receiver, they need the
channel_allocation from infoframe to config the speakers. Send the
audio infoframe via SDP will make them work properly.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>

---

Changes in v2:
- According to the advice of Sean Paul and Doug
use hdmi_audio_infoframe_pack_payload to pack the buffer
define a SDP_HEADER_SIZE

 drivers/gpu/drm/rockchip/cdn-dp-core.c | 20 ++++++++++++++++++++
 drivers/gpu/drm/rockchip/cdn-dp-reg.c  | 27 +++++++++++++++++++++++++++
 drivers/gpu/drm/rockchip/cdn-dp-reg.h  |  6 ++++++
 include/drm/drm_dp_helper.h            |  1 +
 4 files changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 9b0b058..6a4fc66 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -802,6 +802,7 @@ static int cdn_dp_audio_hw_params(struct device *dev,  void *data,
 		.sample_rate = params->sample_rate,
 		.channels = params->channels,
 	};
+	u8 buffer[HDMI_AUDIO_INFOFRAME_SIZE + EDP_SDP_HEADER_SIZE] = { 0 };
 	int ret;
 
 	mutex_lock(&dp->lock);
@@ -823,6 +824,25 @@ static int cdn_dp_audio_hw_params(struct device *dev,  void *data,
 		goto out;
 	}
 
+	/*
+	 * Prepare the infoframe header to SDP header per DP 1.3 spec, Table
+	 * 2-98.
+	 */
+	buffer[0] = 0;
+	buffer[1] = HDMI_INFOFRAME_TYPE_AUDIO;
+	buffer[2] = 0x1b;
+	buffer[3] = 0x48;
+
+	ret = hdmi_audio_infoframe_pack_payload(&params->cea,
+						&buffer[EDP_SDP_HEADER_SIZE],
+						HDMI_AUDIO_INFOFRAME_SIZE);
+	if (ret < 0) {
+		DRM_DEV_ERROR(dev, "Failed to pack audio infoframe: %d\n", ret);
+		goto out;
+	}
+
+	cdn_dp_sdp_write(dp, 0, buffer, sizeof(buffer));
+
 	ret = cdn_dp_audio_config(dp, &audio);
 	if (!ret)
 		dp->audio_info = audio;
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
index b14d211..4a818e4 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
@@ -286,6 +286,33 @@ int cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr, u8 value)
 	return ret;
 }
 
+void cdn_dp_sdp_write(struct cdn_dp_device *dp, int entry_id, u8 *buf,
+		      u32 buf_len)
+{
+	int idx;
+	u32 *packet = (u32 *)buf;
+	u32 num_packets = buf_len / 4;
+	u8 type;
+
+	if (buf_len < EDP_SDP_HEADER_SIZE) {
+		DRM_DEV_ERROR(dp->dev, "sdp buffer length: %d\n", buf_len);
+		return;
+	}
+
+	type = buf[1];
+
+	for (idx = 0; idx < num_packets; idx++)
+		writel(cpu_to_le32(*packet++), dp->regs + SOURCE_PIF_DATA_WR);
+
+	writel(entry_id, dp->regs + SOURCE_PIF_WR_ADDR);
+
+	writel(F_HOST_WR, dp->regs + SOURCE_PIF_WR_REQ);
+
+	writel(PIF_PKT_TYPE_VALID | F_PACKET_TYPE(type) | entry_id,
+	       dp->regs + SOURCE_PIF_PKT_ALLOC_REG);
+	writel(PIF_PKT_ALLOC_WR_EN, dp->regs + SOURCE_PIF_PKT_ALLOC_WR_EN);
+}
+
 int cdn_dp_load_firmware(struct cdn_dp_device *dp, const u32 *i_mem,
 			 u32 i_size, const u32 *d_mem, u32 d_size)
 {
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.h b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
index c4bbb4a83..6ec0e81 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
@@ -424,6 +424,11 @@
 /* Reference cycles when using lane clock as reference */
 #define LANE_REF_CYC				0x8000
 
+#define F_HOST_WR		BIT(0)
+#define PIF_PKT_ALLOC_WR_EN	BIT(0)
+#define PIF_PKT_TYPE_VALID	(3 << 16)
+#define F_PACKET_TYPE(x)	(((x) & 0xff) << 8)
+
 enum voltage_swing_level {
 	VOLTAGE_LEVEL_0,
 	VOLTAGE_LEVEL_1,
@@ -478,5 +483,6 @@ int cdn_dp_set_video_status(struct cdn_dp_device *dp, int active);
 int cdn_dp_config_video(struct cdn_dp_device *dp);
 int cdn_dp_audio_stop(struct cdn_dp_device *dp, struct audio_info *audio);
 int cdn_dp_audio_mute(struct cdn_dp_device *dp, bool enable);
+void cdn_dp_sdp_write(struct cdn_dp_device *dp, int entry_id, u8 *buf, u32 len);
 int cdn_dp_audio_config(struct cdn_dp_device *dp, struct audio_info *audio);
 #endif /* _CDN_DP_REG_H */
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index b17476a..5d5dd07 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -878,6 +878,7 @@ struct edp_sdp_header {
 	u8 HB3; /* 7:5 reserved, 4:0 number of valid data bytes */
 } __packed;
 
+#define EDP_SDP_HEADER_SIZE			4
 #define EDP_SDP_HEADER_REVISION_MASK		0x1F
 #define EDP_SDP_HEADER_VALID_PAYLOAD_BYTES	0x1F
 
-- 
2.7.4
