From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:46:26 +0100
Subject: [PATCH 160/222] dw-hdmi-audio: parse ELD from HDMI driver
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeaI-0007Ny-Se@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Parse the ELD (EDID like data) stored from the HDMI driver to restrict
the sample rates and channels which are available to ALSA.  This causes
the ALSA device to reflect the capabilities of the overall audio path,
not just what is supported at the HDMI source interface level.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/dw-hdmi-audio.c | 51 +++++++++++++++++++++++++++++++++
 drivers/staging/imx-drm/dw-hdmi-audio.h |  1 +
 drivers/staging/imx-drm/imx-hdmi.c      |  3 ++
 3 files changed, 55 insertions(+)

diff --git a/drivers/staging/imx-drm/dw-hdmi-audio.c b/drivers/staging/imx-drm/dw-hdmi-audio.c
index 9c27df0112d2..b2595b0a82ce 100644
--- a/drivers/staging/imx-drm/dw-hdmi-audio.c
+++ b/drivers/staging/imx-drm/dw-hdmi-audio.c
@@ -300,6 +300,56 @@ static struct snd_pcm_hardware dw_hdmi_hw = {
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
+static void dw_hdmi_parse_eld(struct snd_dw_hdmi *dw,
+	struct snd_pcm_runtime *runtime)
+{
+	u8 *sad, *eld = dw->data.eld;
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
@@ -330,6 +380,7 @@ static int dw_hdmi_open(struct snd_pcm_substream *substream)
 		       base + HDMI_IH_MUTE_AHBDMAAUD_STAT0);
 
 	runtime->hw = dw_hdmi_hw;
+	dw_hdmi_parse_eld(dw, runtime);
 	snd_pcm_limit_hw_rates(runtime);
 
 	return 0;
diff --git a/drivers/staging/imx-drm/dw-hdmi-audio.h b/drivers/staging/imx-drm/dw-hdmi-audio.h
index f01979d49efd..2d91d709381d 100644
--- a/drivers/staging/imx-drm/dw-hdmi-audio.h
+++ b/drivers/staging/imx-drm/dw-hdmi-audio.h
@@ -8,6 +8,7 @@ struct dw_hdmi_audio_data {
 	void __iomem *base;
 	int irq;
 	struct imx_hdmi *hdmi;
+	u8 *eld;
 	void (*set_sample_rate)(struct imx_hdmi *, unsigned);
 };
 
diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index af4cba51e255..ac72649448a8 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -1410,6 +1410,8 @@ static int imx_hdmi_connector_get_modes(struct drm_connector *connector)
 
 		drm_mode_connector_update_edid_property(connector, edid);
 		ret = drm_add_edid_modes(connector, edid);
+		/* Store the ELD */
+		drm_edid_to_eld(connector, edid);
 		kfree(edid);
 	} else {
 		dev_dbg(hdmi->dev, "failed to get edid\n");
@@ -1726,6 +1728,7 @@ static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
 	audio.base = hdmi->regs;
 	audio.irq = irq;
 	audio.hdmi = hdmi;
+	audio.eld = hdmi->connector.eld;
 	audio.set_sample_rate = imx_hdmi_set_sample_rate;
 
 	pdevinfo.name = "dw-hdmi-audio";
-- 
1.8.3.1
