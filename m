From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:29:35 +0000
Subject: [PATCH RFC 45/46] imx-drm: dw-hdmi-audio: parse ELD from HDMI driver
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1Vyppf-0007GW-RY@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Parse the ELD (EDID like data) stored from the HDMI driver to restrict
the sample rates and channels which are available to ALSA.  This causes
the ALSA device to reflect the capabilities of the overall audio path,
not just what is supported at the HDMI source interface level.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/dw-hdmi-audio.c |   50 +++++++++++++++++++++++++++++++
 drivers/staging/imx-drm/imx-hdmi.c      |    8 +++++
 drivers/staging/imx-drm/imx-hdmi.h      |    1 +
 3 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/imx-drm/dw-hdmi-audio.c b/drivers/staging/imx-drm/dw-hdmi-audio.c
index 946055d2a975..8f70e6565d22 100644
--- a/drivers/staging/imx-drm/dw-hdmi-audio.c
+++ b/drivers/staging/imx-drm/dw-hdmi-audio.c
@@ -274,6 +274,55 @@ static struct snd_pcm_hardware dw_hdmi_hw = {
 	.fifo_size = 0,
 };
 
+static unsigned rates_mask[] = {
+	SNDRV_PCM_RATE_32000,
+	SNDRV_PCM_RATE_44100,
+	SNDRV_PCM_RATE_48000,
+	SNDRV_PCM_RATE_88200,
+	SNDRV_PCM_RATE_96000,
+	SNDRV_PCM_RATE_176400,
+	SNDRV_PCM_RATE_192000,
+};
+
+static void dw_hdmi_parse_eld(struct snd_dw_hdmi *dw, struct snd_pcm_runtime *runtime)
+{
+	uint8_t *sad, *eld = imx_hdmi_get_eld(dw->hdmi);
+	unsigned eld_ver,  mnl, sad_count, rates, rate_mask, i;
+	unsigned max_channels;
+
+	eld_ver = eld[0] >> 3;
+	if (eld_ver != 2 && eld_ver != 31)
+		return;
+
+	mnl = eld[4] & 0x1f;
+	if (mnl > 16)
+		return;
+
+	sad_count = eld[5] >> 4;
+	sad = eld + 20 + mnl;
+
+	/* Start from the basic audio settings */
+	max_channels = 2;
+	rates = 7;
+	while (sad_count > 0) {
+		switch (sad[0] & 0x78) {
+		case 0x08: /* PCM */
+			max_channels = max(max_channels, (sad[0] & 7) + 1u);
+			rates |= sad[1];
+			break;
+		}
+		sad += 3;
+		sad_count -= 1;
+	}
+
+	for (rate_mask = i = 0; i < ARRAY_SIZE(rates_mask); i++)
+		if (rates & 1 << i)
+			rate_mask |= rates_mask[i];
+
+	runtime->hw.rates &= rate_mask;
+	runtime->hw.channels_max = min(runtime->hw.channels_max, max_channels);
+}
+
 static int dw_hdmi_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -302,6 +351,7 @@ static int dw_hdmi_open(struct snd_pcm_substream *substream)
 		       dw->base + HDMI_IH_MUTE_AHBDMAAUD_STAT0);
 
 	runtime->hw = dw_hdmi_hw;
+	dw_hdmi_parse_eld(dw, runtime);
 	snd_pcm_limit_hw_rates(runtime);
 
 	return 0;
diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index eb196c0862c8..949dd7c25166 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -375,6 +375,12 @@ void imx_hdmi_set_sample_rate(struct imx_hdmi *hdmi, unsigned int rate)
 }
 EXPORT_SYMBOL(imx_hdmi_set_sample_rate);
 
+uint8_t *imx_hdmi_get_eld(struct imx_hdmi *hdmi)
+{
+	return hdmi->connector.eld;
+}
+EXPORT_SYMBOL(imx_hdmi_get_eld);
+
 /*
  * this submodule is responsible for the video data synchronization.
  * for example, for RGB 4:4:4 input, the data map is defined as
@@ -1406,6 +1412,8 @@ static int imx_hdmi_connector_get_modes(struct drm_connector *connector)
 
 		drm_mode_connector_update_edid_property(connector, edid);
 		ret = drm_add_edid_modes(connector, edid);
+		/* Store the ELD */
+		drm_edid_to_eld(connector, edid);
 		kfree(edid);
 	} else {
 		dev_dbg(hdmi->dev, "failed to get edid\n");
diff --git a/drivers/staging/imx-drm/imx-hdmi.h b/drivers/staging/imx-drm/imx-hdmi.h
index 8029febdbabe..5baaa9cba943 100644
--- a/drivers/staging/imx-drm/imx-hdmi.h
+++ b/drivers/staging/imx-drm/imx-hdmi.h
@@ -1032,5 +1032,6 @@ enum {
 
 struct imx_hdmi;
 void imx_hdmi_set_sample_rate(struct imx_hdmi *hdmi, unsigned int rate);
+uint8_t *imx_hdmi_get_eld(struct imx_hdmi *hdmi);
 
 #endif /* __IMX_HDMI_H__ */
-- 
1.7.4.4
