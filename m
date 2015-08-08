From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 08 Aug 2015 17:10:16 +0100
Subject: [PATCH 3/9] drm: bridge/dw_hdmi-ahb-audio: basic support for
 multi-channel PCM audio
In-Reply-To: <20150808160936.GN7557@n2100.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZO6hM-0003N8-NX@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic support for multi-channel PCM audio, with fixed speaker
mappings.  This has been tested with an AV receiver, and appears to
work for low sample rates up to 8 channels.

It should be noted that multi-channel mode using the IEC958 alsa-lib
conversion plugin requires correct AES channel status for the AV
receiver to recognise the stream, especially the sample rate bits.
"Not identified" does not work there.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c | 59 +++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c b/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c
index 125b81306254..3a8f32e04b63 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c
@@ -62,9 +62,14 @@ enum {
 	HDMI_AHB_DMA_CONF0_INCR4 = 0,
 	HDMI_AHB_DMA_CONF0_BURST_MODE = BIT(0),
 	HDMI_AHB_DMA_MASK_DONE = BIT(7),
+
 	HDMI_REVISION_ID = 0x0001,
 	HDMI_IH_AHBDMAAUD_STAT0 = 0x0109,
 	HDMI_IH_MUTE_AHBDMAAUD_STAT0 = 0x0189,
+	HDMI_FC_AUDICONF2 = 0x1027,
+	HDMI_FC_AUDSCONF = 0x1063,
+	HDMI_FC_AUDSCONF_LAYOUT1 = 1 << 0,
+	HDMI_FC_AUDSCONF_LAYOUT0 = 0 << 0,
 	HDMI_AHB_DMA_CONF0 = 0x3600,
 	HDMI_AHB_DMA_START = 0x3601,
 	HDMI_AHB_DMA_STOP = 0x3602,
@@ -77,6 +82,44 @@ enum {
 	HDMI_AHB_DMA_BUFFPOL = 0x361a,
 };
 
+struct dw_hdmi_channel_conf {
+	u8 conf1;
+	u8 ca;
+};
+
+/*
+ * The default mapping of ALSA channels to HDMI channels and speaker
+ * allocation bits.  Note that we can't do channel remapping here -
+ * channels must be in the same order.
+ *
+ * Mappings for alsa-lib pcm/surround*.conf files:
+ *
+ *		Front	Sur4.0	Sur4.1	Sur5.0	Sur5.1	Sur7.1
+ * Channels	2	4	6	6	6	8
+ *
+ * Our mapping from ALSA channel to CEA686D speaker name and HDMI channel:
+ *
+ *				Number of ALSA channels
+ * ALSA Channel	2	3	4	5	6	7	8
+ * 0		FL:0	=	=	=	=	=	=
+ * 1		FR:1	=	=	=	=	=	=
+ * 2			FC:3	RL:4	LFE:2	=	=	=
+ * 3				RR:5	RL:4	FC:3	=	=
+ * 4					RR:5	RL:4	=	=
+ * 5						RR:5	=	=
+ * 6							RC:6	=
+ * 7							RLC/FRC	RLC/FRC
+ */
+static struct dw_hdmi_channel_conf default_hdmi_channel_config[7] = {
+	{ 0x03, 0x00 },	/* FL,FR */
+	{ 0x0b, 0x02 },	/* FL,FR,FC */
+	{ 0x33, 0x08 },	/* FL,FR,RL,RR */
+	{ 0x37, 0x09 },	/* FL,FR,LFE,RL,RR */
+	{ 0x3f, 0x0b },	/* FL,FR,LFE,FC,RL,RR */
+	{ 0x7f, 0x0f },	/* FL,FR,LFE,FC,RL,RR,RC */
+	{ 0xff, 0x13 },	/* FL,FR,LFE,FC,RL,RR,[FR]RC,[FR]LC */
+};
+
 struct snd_dw_hdmi {
 	struct snd_card *card;
 	struct snd_pcm *pcm;
@@ -352,7 +395,7 @@ static int dw_hdmi_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_dw_hdmi *dw = substream->private_data;
-	u8 threshold, conf0, conf1;
+	u8 threshold, conf0, conf1, layout, ca;
 
 	/* Setup as per 3.0.5 FSL 4.1.0 BSP */
 	switch (dw->revision) {
@@ -380,11 +423,23 @@ static int dw_hdmi_prepare(struct snd_pcm_substream *substream)
 	runtime->hw.fifo_size = threshold * 32;
 
 	conf0 |= HDMI_AHB_DMA_CONF0_EN_HLOCK;
-	conf1 = (1 << runtime->channels) - 1;
+	conf1 = default_hdmi_channel_config[runtime->channels - 2].conf1;
+	ca = default_hdmi_channel_config[runtime->channels - 2].ca;
+
+	/*
+	 * For >2 channel PCM audio, we need to select layout 1
+	 * and set an appropriate channel map.
+	 */
+	if (runtime->channels > 2)
+		layout = HDMI_FC_AUDSCONF_LAYOUT1;
+	else
+		layout = HDMI_FC_AUDSCONF_LAYOUT0;
 
 	writeb_relaxed(threshold, dw->data.base + HDMI_AHB_DMA_THRSLD);
 	writeb_relaxed(conf0, dw->data.base + HDMI_AHB_DMA_CONF0);
 	writeb_relaxed(conf1, dw->data.base + HDMI_AHB_DMA_CONF1);
+	writeb_relaxed(layout, dw->data.base + HDMI_FC_AUDSCONF);
+	writeb_relaxed(ca, dw->data.base + HDMI_FC_AUDICONF2);
 
 	switch (runtime->format) {
 	case SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE:
-- 
2.1.0
