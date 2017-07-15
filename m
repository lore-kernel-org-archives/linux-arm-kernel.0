From: zyw@rock-chips.com (Chris Zhong)
Date: Sat, 15 Jul 2017 19:00:18 +0800
Subject: [PATCH] drm/rockchip: cdn-dp: send audio infoframe to sink
Message-ID: <1500116418-4178-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some DP/HDMI sink need to receive the audio infoframe to play sound,
especially some multi-channel AV receiver, they need the
channel_allocation from infoframe to config the speakers. Send the
audio infoframe via SDP will make them work properly.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 drivers/gpu/drm/rockchip/cdn-dp-core.c | 20 ++++++++++++++++++++
 drivers/gpu/drm/rockchip/cdn-dp-reg.c  | 19 +++++++++++++++++++
 drivers/gpu/drm/rockchip/cdn-dp-reg.h  |  6 ++++++
 3 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 9b0b058..e59ca47 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -802,6 +802,7 @@ static int cdn_dp_audio_hw_params(struct device *dev,  void *data,
 		.sample_rate = params->sample_rate,
 		.channels = params->channels,
 	};
+	u8 buffer[14];
 	int ret;
 
 	mutex_lock(&dp->lock);
@@ -823,6 +824,25 @@ static int cdn_dp_audio_hw_params(struct device *dev,  void *data,
 		goto out;
 	}
 
+	memset(buffer, 0, sizeof(buffer));
+
+	ret = hdmi_audio_infoframe_pack(&params->cea, buffer, sizeof(buffer));
+	if (ret < 0) {
+		DRM_DEV_ERROR(dev, "Failed to pack audio infoframe: %d\n", ret);
+		goto out;
+	}
+
+	/*
+	 * Change the infoframe header to SDP header per DP 1.3 spec, Table
+	 * 2-98.
+	 */
+	buffer[0] = 0;
+	buffer[1] = HDMI_INFOFRAME_TYPE_AUDIO;
+	buffer[2] = 0x1b;
+	buffer[3] = 0x48;
+
+	cdn_dp_sdp_write(dp, 0, buffer, sizeof(buffer));
+
 	ret = cdn_dp_audio_config(dp, &audio);
 	if (!ret)
 		dp->audio_info = audio;
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
index b14d211..8907db0 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
@@ -951,6 +951,25 @@ static void cdn_dp_audio_config_spdif(struct cdn_dp_device *dp)
 	clk_set_rate(dp->spdif_clk, CDN_DP_SPDIF_CLK);
 }
 
+void cdn_dp_sdp_write(struct cdn_dp_device *dp, int entry_id, u8 *buf, u32 len)
+{
+	int idx;
+	u32 *packet = (u32 *)buf;
+	u32 length = len / 4;
+	u8 type = buf[1];
+
+	for (idx = 0; idx < length; idx++)
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
 int cdn_dp_audio_config(struct cdn_dp_device *dp, struct audio_info *audio)
 {
 	int ret;
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
-- 
2.6.3
