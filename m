From: lori.hikichi@broadcom.com (Lori Hikichi)
Date: Mon, 14 Aug 2017 15:06:49 -0700
Subject: [PATCH 1/9] ASoC: cygnus: Add support for 384kHz frame rates
In-Reply-To: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
References: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
Message-ID: <1502748417-26417-2-git-send-email-lori.hikichi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow the audio ports to operate at 384kHz.

Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
---
 sound/soc/bcm/cygnus-ssp.c | 235 +++++++++++----------------------------------
 1 file changed, 55 insertions(+), 180 deletions(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index e710bb0..1a57a4e 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -27,12 +27,6 @@
 
 #define DEFAULT_VCO    1354750204
 
-#define CYGNUS_TDM_RATE \
-		(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 | \
-		SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_22050 | \
-		SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
-		SNDRV_PCM_RATE_48000)
-
 #define CAPTURE_FCI_ID_BASE 0x180
 #define CYGNUS_SSP_TRISTATE_MASK 0x001fff
 #define CYGNUS_PLLCLKSEL_MASK 0xf
@@ -234,152 +228,20 @@ struct pll_macro_entry {
 	{98304000, 2},
 };
 
+#define CYGNUS_RATE_MIN     8000
+#define CYGNUS_RATE_MAX   384000
+
 /* List of valid frame sizes for tdm mode */
 static const int ssp_valid_tdm_framesize[] = {32, 64, 128, 256, 512};
 
-/*
- * Use this relationship to derive the sampling rate (lrclk)
- * lrclk = (mclk) / ((2*mclk_to_sclk_ratio) * (32 * SCLK))).
- *
- * Use mclk and pll_ch from the table above
- *
- * Valid SCLK = 0/1/2/4/8/12
- *
- * mclk_to_sclk_ratio = number of MCLK per SCLK. Division is twice the
- * value programmed in this field.
- * Valid mclk_to_sclk_ratio = 1 through to 15
- *
- * eg: To set lrclk = 48khz, set mclk = 12288000, mclk_to_sclk_ratio = 2,
- * SCLK = 64
- */
-struct _ssp_clk_coeff {
-	u32 mclk;
-	u32 sclk_rate;
-	u32 rate;
-	u32 mclk_rate;
+static const unsigned int cygnus_rates[] = {
+	 8000, 11025,  16000,  22050,  32000,  44100, 48000,
+	88200, 96000, 176400, 192000, 352800, 384000
 };
 
-static const struct _ssp_clk_coeff ssp_clk_coeff[] = {
-	{ 4096000,  32,  16000, 4},
-	{ 4096000,  32,  32000, 2},
-	{ 4096000,  64,   8000, 4},
-	{ 4096000,  64,  16000, 2},
-	{ 4096000,  64,  32000, 1},
-	{ 4096000, 128,   8000, 2},
-	{ 4096000, 128,  16000, 1},
-	{ 4096000, 256,   8000, 1},
-
-	{ 6144000,  32,  16000, 6},
-	{ 6144000,  32,  32000, 3},
-	{ 6144000,  32,  48000, 2},
-	{ 6144000,  32,  96000, 1},
-	{ 6144000,  64,   8000, 6},
-	{ 6144000,  64,  16000, 3},
-	{ 6144000,  64,  48000, 1},
-	{ 6144000, 128,   8000, 3},
-
-	{ 8192000,  32,  32000, 4},
-	{ 8192000,  64,  16000, 4},
-	{ 8192000,  64,  32000, 2},
-	{ 8192000, 128,   8000, 4},
-	{ 8192000, 128,  16000, 2},
-	{ 8192000, 128,  32000, 1},
-	{ 8192000, 256,   8000, 2},
-	{ 8192000, 256,  16000, 1},
-	{ 8192000, 512,   8000, 1},
-
-	{12288000,  32,  32000, 6},
-	{12288000,  32,  48000, 4},
-	{12288000,  32,  96000, 2},
-	{12288000,  32, 192000, 1},
-	{12288000,  64,  16000, 6},
-	{12288000,  64,  32000, 3},
-	{12288000,  64,  48000, 2},
-	{12288000,  64,  96000, 1},
-	{12288000, 128,   8000, 6},
-	{12288000, 128,  16000, 3},
-	{12288000, 128,  48000, 1},
-	{12288000, 256,   8000, 3},
-
-	{16384000,  64,  32000, 4},
-	{16384000, 128,  16000, 4},
-	{16384000, 128,  32000, 2},
-	{16384000, 256,   8000, 4},
-	{16384000, 256,  16000, 2},
-	{16384000, 256,  32000, 1},
-	{16384000, 512,   8000, 2},
-	{16384000, 512,  16000, 1},
-
-	{24576000,  32,  96000, 4},
-	{24576000,  32, 192000, 2},
-	{24576000,  64,  32000, 6},
-	{24576000,  64,  48000, 4},
-	{24576000,  64,  96000, 2},
-	{24576000,  64, 192000, 1},
-	{24576000, 128,  16000, 6},
-	{24576000, 128,  32000, 3},
-	{24576000, 128,  48000, 2},
-	{24576000, 256,   8000, 6},
-	{24576000, 256,  16000, 3},
-	{24576000, 256,  48000, 1},
-	{24576000, 512,   8000, 3},
-
-	{49152000,  32, 192000, 4},
-	{49152000,  64,  96000, 4},
-	{49152000,  64, 192000, 2},
-	{49152000, 128,  32000, 6},
-	{49152000, 128,  48000, 4},
-	{49152000, 128,  96000, 2},
-	{49152000, 128, 192000, 1},
-	{49152000, 256,  16000, 6},
-	{49152000, 256,  32000, 3},
-	{49152000, 256,  48000, 2},
-	{49152000, 256,  96000, 1},
-	{49152000, 512,   8000, 6},
-	{49152000, 512,  16000, 3},
-	{49152000, 512,  48000, 1},
-
-	{ 5644800,  32,  22050, 4},
-	{ 5644800,  32,  44100, 2},
-	{ 5644800,  32,  88200, 1},
-	{ 5644800,  64,  11025, 4},
-	{ 5644800,  64,  22050, 2},
-	{ 5644800,  64,  44100, 1},
-
-	{11289600,  32,  44100, 4},
-	{11289600,  32,  88200, 2},
-	{11289600,  32, 176400, 1},
-	{11289600,  64,  22050, 4},
-	{11289600,  64,  44100, 2},
-	{11289600,  64,  88200, 1},
-	{11289600, 128,  11025, 4},
-	{11289600, 128,  22050, 2},
-	{11289600, 128,  44100, 1},
-
-	{22579200,  32,  88200, 4},
-	{22579200,  32, 176400, 2},
-	{22579200,  64,  44100, 4},
-	{22579200,  64,  88200, 2},
-	{22579200,  64, 176400, 1},
-	{22579200, 128,  22050, 4},
-	{22579200, 128,  44100, 2},
-	{22579200, 128,  88200, 1},
-	{22579200, 256,  11025, 4},
-	{22579200, 256,  22050, 2},
-	{22579200, 256,  44100, 1},
-
-	{45158400,  32, 176400, 4},
-	{45158400,  64,  88200, 4},
-	{45158400,  64, 176400, 2},
-	{45158400, 128,  44100, 4},
-	{45158400, 128,  88200, 2},
-	{45158400, 128, 176400, 1},
-	{45158400, 256,  22050, 4},
-	{45158400, 256,  44100, 2},
-	{45158400, 256,  88200, 1},
-	{45158400, 512,  11025, 4},
-	{45158400, 512,  22050, 2},
-	{45158400, 512,  44100, 1},
+static const struct snd_pcm_hw_constraint_list cygnus_rate_constraint = {
+	.count = ARRAY_SIZE(cygnus_rates),
+	.list = cygnus_rates,
 };
 
 static struct cygnus_aio_port *cygnus_dai_get_portinfo(struct snd_soc_dai *dai)
@@ -679,40 +541,55 @@ static int pll_configure_mclk(struct cygnus_audio *cygaud, u32 mclk,
 	return p_entry->pll_ch_num;
 }
 
-static int cygnus_ssp_set_clocks(struct cygnus_aio_port *aio,
-			struct cygnus_audio *cygaud)
+static int cygnus_ssp_set_clocks(struct cygnus_aio_port *aio)
 {
-	u32 value, i = 0;
+	u32 value;
 	u32 mask = 0xf;
 	u32 sclk;
-	bool found = false;
-	const struct _ssp_clk_coeff *p_entry = NULL;
+	u32 mclk_rate;
+	unsigned int bit_rate;
+	unsigned int ratio;
 
-	for (i = 0; i < ARRAY_SIZE(ssp_clk_coeff); i++) {
-		p_entry = &ssp_clk_coeff[i];
-		if ((p_entry->rate == aio->lrclk) &&
-		    (p_entry->sclk_rate == aio->bit_per_frame) &&
-		    (p_entry->mclk == aio->mclk)) {
-			found = true;
-			break;
-		}
-	}
-	if (!found) {
+	bit_rate = aio->bit_per_frame * aio->lrclk;
+
+	/*
+	 * Check if the bit clock can be generated from the given MCLK.
+	 * MCLK must be a perfect multiple of bit clock and must be one of the
+	 * following values... (2,4,6,8,10,12,14)
+	 */
+	if ((aio->mclk % bit_rate) != 0)
+		return -EINVAL;
+
+	ratio = aio->mclk / bit_rate;
+	switch (ratio) {
+	case 2:
+	case 4:
+	case 6:
+	case 8:
+	case 10:
+	case 12:
+	case 14:
+		mclk_rate = ratio / 2;
+		break;
+
+	default:
 		dev_err(aio->cygaud->dev,
-			"No valid match found in ssp_clk_coeff array\n");
+			"Invalid combination of MCLK and BCLK\n");
 		dev_err(aio->cygaud->dev, "lrclk = %u, bits/frame = %u, mclk = %u\n",
 			aio->lrclk, aio->bit_per_frame, aio->mclk);
 		return -EINVAL;
 	}
 
-	sclk = aio->bit_per_frame;
-	if (sclk == 512)
-		sclk = 0;
-	/* sclks_per_1fs_div = sclk cycles/32 */
-	sclk /= 32;
 	/* Set sclk rate */
 	switch (aio->port_type) {
 	case PORT_TDM:
+		sclk = aio->bit_per_frame;
+		if (sclk == 512)
+			sclk = 0;
+
+		/* sclks_per_1fs_div = sclk cycles/32 */
+		sclk /= 32;
+
 		/* Set number of bitclks per frame */
 		value = readl(aio->cygaud->audio + aio->regs.i2s_cfg);
 		value &= ~(mask << I2S_OUT_CFGX_SCLKS_PER_1FS_DIV32);
@@ -731,7 +608,7 @@ static int cygnus_ssp_set_clocks(struct cygnus_aio_port *aio,
 	/* Set MCLK_RATE ssp port (spdif and ssp are the same) */
 	value = readl(aio->cygaud->audio + aio->regs.i2s_mclk_cfg);
 	value &= ~(0xf << I2S_OUT_MCLKRATE_SHIFT);
-	value |= (p_entry->mclk_rate << I2S_OUT_MCLKRATE_SHIFT);
+	value |= (mclk_rate << I2S_OUT_MCLKRATE_SHIFT);
 	writel(value, aio->cygaud->audio + aio->regs.i2s_mclk_cfg);
 
 	dev_dbg(aio->cygaud->dev, "mclk cfg reg = 0x%x\n", value);
@@ -745,7 +622,6 @@ static int cygnus_ssp_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
 	struct cygnus_aio_port *aio = cygnus_dai_get_portinfo(dai);
-	struct cygnus_audio *cygaud = snd_soc_dai_get_drvdata(dai);
 	int rate, bitres;
 	u32 value;
 	u32 mask = 0x1f;
@@ -841,7 +717,7 @@ static int cygnus_ssp_hw_params(struct snd_pcm_substream *substream,
 	aio->lrclk = rate;
 
 	if (!aio->is_slave)
-		ret = cygnus_ssp_set_clocks(aio, cygaud);
+		ret = cygnus_ssp_set_clocks(aio);
 
 	return ret;
 }
@@ -888,6 +764,11 @@ static int cygnus_ssp_startup(struct snd_pcm_substream *substream,
 	else
 		aio->clk_trace.cap_en = true;
 
+	substream->runtime->hw.rate_min = CYGNUS_RATE_MIN;
+	substream->runtime->hw.rate_max = CYGNUS_RATE_MAX;
+
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE, &cygnus_rate_constraint);
 	return 0;
 }
 
@@ -1261,9 +1142,7 @@ static int cygnus_ssp_resume(struct snd_soc_dai *cpu_dai)
 	.playback = { \
 		.channels_min = 1, \
 		.channels_max = 16, \
-		.rates = CYGNUS_TDM_RATE | SNDRV_PCM_RATE_88200 | \
-			SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 | \
-			SNDRV_PCM_RATE_192000, \
+		.rates = SNDRV_PCM_RATE_KNOT, \
 		.formats = SNDRV_PCM_FMTBIT_S8 | \
 				SNDRV_PCM_FMTBIT_S16_LE | \
 				SNDRV_PCM_FMTBIT_S32_LE, \
@@ -1271,9 +1150,7 @@ static int cygnus_ssp_resume(struct snd_soc_dai *cpu_dai)
 	.capture = { \
 		.channels_min = 2, \
 		.channels_max = 16, \
-		.rates = CYGNUS_TDM_RATE | SNDRV_PCM_RATE_88200 | \
-			SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 | \
-			SNDRV_PCM_RATE_192000, \
+		.rates = SNDRV_PCM_RATE_KNOT, \
 		.formats =  SNDRV_PCM_FMTBIT_S16_LE | \
 					SNDRV_PCM_FMTBIT_S32_LE, \
 	}, \
@@ -1293,9 +1170,7 @@ static int cygnus_ssp_resume(struct snd_soc_dai *cpu_dai)
 	.playback = {
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = CYGNUS_TDM_RATE | SNDRV_PCM_RATE_88200 |
-			SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |
-			SNDRV_PCM_RATE_192000,
+		.rates = SNDRV_PCM_RATE_KNOT,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE |
 			SNDRV_PCM_FMTBIT_S32_LE,
 	},
-- 
1.9.1
