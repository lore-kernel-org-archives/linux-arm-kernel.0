From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sun,  7 Oct 2018 11:38:54 +0200
Subject: [PATCH v2 18/29] drm/sun4i: dw-hdmi: Add quirk for setting TMDS clock
In-Reply-To: <20181007093905.11253-1-jernej.skrabec@siol.net>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
Message-ID: <20181007093905.11253-19-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It turns out that H6 HDMI BSP kernel driver doesn't change TMDS rate at
all. At this point it is not clear whether it is just not necessary or
it would cause some kind of issues.

Add a quirk for it.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 5 ++++-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index ec122136ee9d..e9e93f174b35 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -165,7 +165,9 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 		goto err_disable_clk_tmds;
 	}
 
-	drm_encoder_helper_add(encoder, &sun8i_dw_hdmi_encoder_helper_funcs);
+	if (hdmi->quirks->set_rate)
+		drm_encoder_helper_add(encoder,
+				       &sun8i_dw_hdmi_encoder_helper_funcs);
 	drm_encoder_init(drm, encoder, &sun8i_dw_hdmi_encoder_funcs,
 			 DRM_MODE_ENCODER_TMDS, NULL);
 
@@ -235,6 +237,7 @@ static int sun8i_dw_hdmi_remove(struct platform_device *pdev)
 
 static const struct sun8i_dw_hdmi_quirks sun8i_a83t_quirks = {
 	.mode_valid = sun8i_dw_hdmi_mode_valid_a83t,
+	.set_rate = true,
 };
 
 static const struct of_device_id sun8i_dw_hdmi_dt_ids[] = {
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index a645b8bc9f58..f9eb663865a4 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -173,6 +173,7 @@ struct sun8i_hdmi_phy {
 struct sun8i_dw_hdmi_quirks {
 	enum drm_mode_status (*mode_valid)(struct drm_connector *connector,
 					   const struct drm_display_mode *mode);
+	bool set_rate;
 };
 
 struct sun8i_dw_hdmi {
-- 
2.19.0
