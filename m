From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  1 Dec 2017 07:05:43 +0100
Subject: [PATCH v2 20/27] drm/sun4i: Add scaler configuration to DE2 mixers
In-Reply-To: <20171201060550.10392-1-jernej.skrabec@siol.net>
References: <20171201060550.10392-1-jernej.skrabec@siol.net>
Message-ID: <20171201060550.10392-21-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No all SoCs support scaling on all channels. For example, V3s support
scaling only on VI channels. Because of that, add additional
configuration bitmask which tells which channel support scaler.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c |  1 +
 drivers/gpu/drm/sun4i/sun8i_mixer.h | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 888620b1d3f1..e3296a060352 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -336,6 +336,7 @@ static int sun8i_mixer_remove(struct platform_device *pdev)
 static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 	.vi_num = 2,
 	.ui_num = 1,
+	.scaler_mask = 0x3,
 };
 
 static const struct of_device_id sun8i_mixer_of_table[] = {
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index bad0969ac105..a6270b307ae5 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -94,9 +94,19 @@ struct de2_fmt_info {
 	u32 de2_fmt;
 };
 
+/**
+ * struct sun8i_mixer_cfg - mixer HW configuration
+ * @vi_num: number of VI channels
+ * @ui_num: number of UI channels
+ * @scaler_mask: bitmask which tells which channel supports scaling
+ *	First, scaler supports for VI channels is defined and after that, scaler
+ *	support for UI channels. For example, if mixer has 2 VI channels without
+ *	scaler and 2 UI channels with scaler, bitmask would be 0xC.
+ */
 struct sun8i_mixer_cfg {
 	int		vi_num;
 	int		ui_num;
+	int		scaler_mask;
 };
 
 struct sun8i_mixer {
-- 
2.15.1
