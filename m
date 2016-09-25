From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Sun, 25 Sep 2016 15:41:05 +0800
Subject: [PATCH] drm/mediatek: mark symbols static where possible
Message-ID: <1474789265-30142-1-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We get 4 warnings when building kernel with W=1:
drivers/gpu/drm/mediatek/mtk_hdmi.c:1089:6: warning: no previous prototype for 'mtk_hdmi_audio_enable' [-Wmissing-prototypes]
drivers/gpu/drm/mediatek/mtk_hdmi.c:1095:6: warning: no previous prototype for 'mtk_hdmi_audio_disable' [-Wmissing-prototypes]
drivers/gpu/drm/mediatek/mtk_hdmi.c:1101:5: warning: no previous prototype for 'mtk_hdmi_audio_set_param' [-Wmissing-prototypes]
drivers/gpu/drm/mediatek/mtk_hdmi.c:1627:5: warning: no previous prototype for 'mtk_hdmi_audio_digital_mute' [-Wmissing-prototypes]

In fact, both functions are only used in the file in which they are
declared and don't need a declaration, but can be made static.
So this patch marks both functions with 'static'.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 334562d..be4e19c 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1086,19 +1086,19 @@ static int mtk_hdmi_output_init(struct mtk_hdmi *hdmi)
 	return 0;
 }
 
-void mtk_hdmi_audio_enable(struct mtk_hdmi *hdmi)
+static void mtk_hdmi_audio_enable(struct mtk_hdmi *hdmi)
 {
 	mtk_hdmi_aud_enable_packet(hdmi, true);
 	hdmi->audio_enable = true;
 }
 
-void mtk_hdmi_audio_disable(struct mtk_hdmi *hdmi)
+static void mtk_hdmi_audio_disable(struct mtk_hdmi *hdmi)
 {
 	mtk_hdmi_aud_enable_packet(hdmi, false);
 	hdmi->audio_enable = false;
 }
 
-int mtk_hdmi_audio_set_param(struct mtk_hdmi *hdmi,
+static int mtk_hdmi_audio_set_param(struct mtk_hdmi *hdmi,
 			     struct hdmi_audio_param *param)
 {
 	if (!hdmi->audio_enable) {
@@ -1624,7 +1624,8 @@ static void mtk_hdmi_audio_shutdown(struct device *dev, void *data)
 	mtk_hdmi_audio_disable(hdmi);
 }
 
-int mtk_hdmi_audio_digital_mute(struct device *dev, void *data, bool enable)
+static int
+mtk_hdmi_audio_digital_mute(struct device *dev, void *data, bool enable)
 {
 	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
 
-- 
2.7.4
