From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 04 Aug 2013 20:34:04 +0100
Subject: [PATCH RFC 13/13] ASoC: kirkwood: add IEC958 channel status support
In-Reply-To: <20130804192136.GK23006@n2100.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
Message-ID: <E1V6444-0004m8-Od@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for userspace setting the IEC958 channel status data
for the SPDIF interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-i2s.c |   93 +++++++++++++++++++++++++++++++++++++
 sound/soc/kirkwood/kirkwood.h     |   33 +++++++++++++
 2 files changed, 126 insertions(+), 0 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 236b0b2..c6599eb 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -18,6 +18,7 @@
 #include <linux/mbus.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
+#include <sound/asoundef.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -29,11 +30,94 @@
 #define KIRKWOOD_I2S_RATES \
 	(SNDRV_PCM_RATE_44100 | \
 	 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000)
+
 #define KIRKWOOD_I2S_FORMATS \
 	(SNDRV_PCM_FMTBIT_S16_LE | \
 	 SNDRV_PCM_FMTBIT_S24_LE | \
 	 SNDRV_PCM_FMTBIT_S32_LE)
 
+static int kirkwood_iec958_info(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
+	uinfo->count = 1;
+
+	return 0;
+}
+
+static int kirkwood_iec958_mask_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	memset(ucontrol->value.iec958.status, 0,
+	       sizeof(ucontrol->value.iec958.status));
+	memset(ucontrol->value.iec958.status, 0xff, 4);
+	return 0;
+}
+
+static int kirkwood_iec958_dflt_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dai *cpu_dai = snd_kcontrol_chip(kcontrol);
+	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(cpu_dai);
+	u32 reg;
+
+	reg = readl_relaxed(priv->io + KIRKWOOD_SPDIF_STATUS0_L);
+	ucontrol->value.iec958.status[3] = reg >> 24;
+	ucontrol->value.iec958.status[2] = reg >> 16;
+	ucontrol->value.iec958.status[1] = reg >>  8;
+	ucontrol->value.iec958.status[0] = reg;
+
+	return 0;
+}
+
+static int kirkwood_iec958_dflt_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dai *cpu_dai = snd_kcontrol_chip(kcontrol);
+	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(cpu_dai);
+	u32 val, nval;
+
+	val  = readl_relaxed(priv->io + KIRKWOOD_SPDIF_PLAYCTL);
+	nval = val & ~(KIRKWOOD_SPDIF_NON_PCM | KIRKWOOD_SPDIF_REG_VALIDITY);
+	if (ucontrol->value.iec958.status[0] & IEC958_AES0_NONAUDIO)
+		nval |= KIRKWOOD_SPDIF_NON_PCM | KIRKWOOD_SPDIF_REG_VALIDITY;
+	writel_relaxed(nval, priv->io + KIRKWOOD_SPDIF_PLAYCTL);
+
+	val = readl_relaxed(priv->io + KIRKWOOD_SPDIF_STATUS0_L);
+	nval = ucontrol->value.iec958.status[3] << 24 |
+	       ucontrol->value.iec958.status[2] << 16 |
+	       ucontrol->value.iec958.status[1] << 8 |
+	       ucontrol->value.iec958.status[0];
+	writel_relaxed(nval, priv->io + KIRKWOOD_SPDIF_STATUS0_L);
+	writel_relaxed(nval, priv->io + KIRKWOOD_SPDIF_STATUS0_R);
+
+	return nval != val;
+}
+
+static const struct snd_kcontrol_new kirkwood_i2s_iec958_controls[] = {
+	{
+		.iface	= SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name	= SNDRV_CTL_NAME_IEC958("", PLAYBACK, CON_MASK),
+		.access	= SNDRV_CTL_ELEM_ACCESS_READ,
+		.info	= kirkwood_iec958_info,
+		.get	= kirkwood_iec958_mask_get,
+	}, {
+		.iface	= SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name	= SNDRV_CTL_NAME_IEC958("", PLAYBACK, PRO_MASK),
+		.access	= SNDRV_CTL_ELEM_ACCESS_READ,
+		.info	= kirkwood_iec958_info,
+		.get	= kirkwood_iec958_mask_get,
+	}, {
+		.iface	= SNDRV_CTL_ELEM_IFACE_PCM,
+		.name	= SNDRV_CTL_NAME_IEC958("", PLAYBACK, DEFAULT),
+		.access	= SNDRV_CTL_ELEM_ACCESS_READWRITE |
+			  SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info	= kirkwood_iec958_info,
+		.get	= kirkwood_iec958_dflt_get,
+		.put	= kirkwood_iec958_dflt_put,
+	},
+};
+
 static int kirkwood_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 		unsigned int fmt)
 {
@@ -408,6 +492,15 @@ static int kirkwood_i2s_probe(struct snd_soc_dai *dai)
 	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
 	unsigned long value;
 	unsigned int reg_data;
+	int ret;
+
+	ret = snd_soc_add_dai_controls(dai, kirkwood_i2s_iec958_controls,
+				ARRAY_SIZE(kirkwood_i2s_iec958_controls));
+	if (ret) {
+		dev_err(dai->dev,
+			"unable to add soc card controls: %d\n", ret);
+		return ret;
+	}
 
 	/* It appears that these can't be attached to the CPU DAI */
 	snd_soc_dapm_new_controls(&dai->platform->dapm,
diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index 3b70876..17b48a6 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -105,6 +105,39 @@
 #define KIRKWOOD_PLAY_BYTE_INT_COUNT		0x1314
 #define KIRKWOOD_BYTE_INT_COUNT_MASK		0xffffff
 
+#define KIRKWOOD_SPDIF_PLAYCTL			0x2204
+#define KIRKWOOD_SPDIF_NON_PCM			(1<<17)
+#define KIRKWOOD_SPDIF_REG_VALIDITY		(1<<16)
+#define KIRKWOOD_SPDIF_FORCE_PARERR		(1<<4)
+#define KIRKWOOD_SPDIF_MEM_USER_EN		(1<<2)
+#define KIRKWOOD_SPDIF_MEM_VALIDITY_EN		(1<<1)
+#define KIRKWOOD_SPDIF_BLOCK_START_MODE		(1<<0)
+
+#define KIRKWOOD_SPDIF_STATUS0_L		0x2280
+#define KIRKWOOD_SPDIF_STATUS1_L		0x2284
+#define KIRKWOOD_SPDIF_STATUS2_L		0x2288
+#define KIRKWOOD_SPDIF_STATUS3_L		0x228c
+#define KIRKWOOD_SPDIF_STATUS4_L		0x2290
+#define KIRKWOOD_SPDIF_STATUS5_L		0x2294
+#define KIRKWOOD_SPDIF_STATUS0_R		0x22a0
+#define KIRKWOOD_SPDIF_STATUS1_R		0x22a4
+#define KIRKWOOD_SPDIF_STATUS2_R		0x22a8
+#define KIRKWOOD_SPDIF_STATUS3_R		0x22ac
+#define KIRKWOOD_SPDIF_STATUS4_R		0x22b0
+#define KIRKWOOD_SPDIF_STATUS5_R		0x22b4
+#define KIRKWOOD_SPDIF_USER0_L			0x22c0
+#define KIRKWOOD_SPDIF_USER1_L			0x22c4
+#define KIRKWOOD_SPDIF_USER2_L			0x22c8
+#define KIRKWOOD_SPDIF_USER3_L			0x22cc
+#define KIRKWOOD_SPDIF_USER4_L			0x22d0
+#define KIRKWOOD_SPDIF_USER5_L			0x22d4
+#define KIRKWOOD_SPDIF_USER0_R			0x22e0
+#define KIRKWOOD_SPDIF_USER1_R			0x22e4
+#define KIRKWOOD_SPDIF_USER2_R			0x22e8
+#define KIRKWOOD_SPDIF_USER3_R			0x22ec
+#define KIRKWOOD_SPDIF_USER4_R			0x22f0
+#define KIRKWOOD_SPDIF_USER5_R			0x22f4
+
 #define KIRKWOOD_I2S_PLAYCTL			0x2508
 #define KIRKWOOD_I2S_RECCTL			0x2408
 #define KIRKWOOD_I2S_CTL_JUST_MASK		(0xf<<26)
-- 
1.7.4.4
