From: romain.perier@collabora.com (Romain Perier)
Date: Fri,  7 Apr 2017 16:19:05 +0200
Subject: [PATCH 2/2] drm: dw-hdmi: Gate audio clock from the I2S enablement
 callbacks
In-Reply-To: <20170407141905.14147-1-romain.perier@collabora.com>
References: <20170407141905.14147-1-romain.perier@collabora.com>
Message-ID: <20170407141905.14147-3-romain.perier@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the audio sampler clock is enabled from dw_hdmi_setup() at
step E. and is kept enabled for later use. This clock should be enabled
and disabled along with the actual audio stream and not always on (that
is bad for PM). Futhermore, as described by the datasheet, the I2S
variant need to gate/ungate the clock when the stream is
enabled/disabled.

This commit adds a parameter to hdmi_audio_enable_clk() that controls
when the audio sample clock must be enabled or disabled. Then, it adds
the call to this function from dw_hdmi_i2s_audio_enable() and
dw_hdmi_i2s_audio_disable().

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 drivers/gpu/drm/bridge/dw-hdmi.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw-hdmi.c b/drivers/gpu/drm/bridge/dw-hdmi.c
index d34e0a5..3bd0807 100644
--- a/drivers/gpu/drm/bridge/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/dw-hdmi.c
@@ -559,6 +559,12 @@ void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate)
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_set_sample_rate);
 
+static void hdmi_enable_audio_clk(struct dw_hdmi *hdmi, bool enable)
+{
+	hdmi_modb(hdmi, enable ? 0 : HDMI_MC_CLKDIS_AUDCLK_DISABLE,
+		  HDMI_MC_CLKDIS_AUDCLK_DISABLE, HDMI_MC_CLKDIS);
+}
+
 void dw_hdmi_ahb_audio_enable(struct dw_hdmi *hdmi)
 {
 	hdmi_set_cts_n(hdmi, hdmi->audio_cts, hdmi->audio_n);
@@ -572,12 +578,13 @@ void dw_hdmi_ahb_audio_disable(struct dw_hdmi *hdmi)
 void dw_hdmi_i2s_audio_enable(struct dw_hdmi *hdmi)
 {
 	hdmi_set_cts_n(hdmi, hdmi->audio_cts, hdmi->audio_n);
+	hdmi_enable_audio_clk(hdmi, true);
 }
 
 
 void dw_hdmi_i2s_audio_disable(struct dw_hdmi *hdmi)
 {
-
+	hdmi_enable_audio_clk(hdmi, false);
 }
 
 void dw_hdmi_audio_enable(struct dw_hdmi *hdmi)
@@ -1365,11 +1372,6 @@ static void dw_hdmi_enable_video_path(struct dw_hdmi *hdmi)
 	}
 }
 
-static void hdmi_enable_audio_clk(struct dw_hdmi *hdmi)
-{
-	hdmi_modb(hdmi, 0, HDMI_MC_CLKDIS_AUDCLK_DISABLE, HDMI_MC_CLKDIS);
-}
-
 /* Workaround to clear the overflow condition */
 static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
 {
@@ -1471,7 +1473,7 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 
 		/* HDMI Initialization Step E - Configure audio */
 		hdmi_clk_regenerator_update_pixel_clock(hdmi);
-		hdmi_enable_audio_clk(hdmi);
+		hdmi_enable_audio_clk(hdmi, true);
 	}
 
 	/* not for DVI mode */
-- 
2.9.3
