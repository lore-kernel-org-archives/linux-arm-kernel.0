From: lori.hikichi@broadcom.com (Lori Hikichi)
Date: Mon, 14 Aug 2017 15:06:54 -0700
Subject: [PATCH 6/9] ASoc: cygnus: Fix problems with multichannel transfers
In-Reply-To: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
References: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
Message-ID: <1502748417-26417-7-git-send-email-lori.hikichi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Problems were found with multi-channel (4+) TDM transfers. The alignment
of the channels within the frame could shift when starting a new transfer.
In order to implement a fix the register programming sequence needed to
be revised.

Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
---
 sound/soc/bcm/cygnus-ssp.c | 539 ++++++++++++++++++++++++++++++++-------------
 sound/soc/bcm/cygnus-ssp.h |  14 +-
 2 files changed, 394 insertions(+), 159 deletions(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index 5b6e345..5292c04 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -121,6 +121,7 @@
 #define I2S_OUT_STREAM_ENA  31
 #define I2S_OUT_STREAM_CFG_GROUP_ID  20
 #define I2S_OUT_STREAM_CFG_CHANNEL_GROUPING  24
+#define I2S_OUT_STREAM_CFG_FCI_ID_MASK  0x3ff
 
 /* AUD_FMM_IOP_IN_I2S_x_CAP */
 #define I2S_IN_STREAM_CFG_CAP_ENA   31
@@ -129,7 +130,11 @@
 /* AUD_FMM_IOP_OUT_I2S_x_I2S_CFG_REG */
 #define I2S_OUT_CFGX_CLK_ENA         0
 #define I2S_OUT_CFGX_DATA_ENABLE     1
+#define I2S_OUT_CFGX_LRCK_POLARITY   4
+#define I2S_OUT_CFGX_SCLK_POLARITY   5
 #define I2S_OUT_CFGX_DATA_ALIGNMENT  6
+#define I2S_OUT_CFGX_BITS_PER_SAMPLE 8
+#define I2S_OUT_CFGX_BIT_PER_SAMPLE_MASK 0x1f
 #define I2S_OUT_CFGX_BITS_PER_SLOT  13
 #define I2S_OUT_CFGX_VALID_SLOT     14
 #define I2S_OUT_CFGX_FSYNC_WIDTH    18
@@ -137,14 +142,27 @@
 #define I2S_OUT_CFGX_SLAVE_MODE     30
 #define I2S_OUT_CFGX_TDM_MODE       31
 
+#define I2S_IN_CFGX_DATA_ALIGNMENT   6
+#define I2S_IN_CFGX_BITS_PER_SAMPLE  8
+#define I2S_IN_CFGX_BIT_PER_SAMPLE_MASK 0x1f
+#define I2S_IN_CFGX_BITS_PER_SLOT   13
+#define I2S_IN_CFGX_VALID_SLOT      14
+#define I2S_IN_CFGX_SLAVE_MODE      30
+#define I2S_IN_CFGX_TDM_MODE        31
+
 /* AUD_FMM_BF_CTRL_SOURCECH_CFGx_REG */
 #define BF_SRC_CFGX_SFIFO_ENA              0
 #define BF_SRC_CFGX_BUFFER_PAIR_ENABLE     1
 #define BF_SRC_CFGX_SAMPLE_CH_MODE         2
 #define BF_SRC_CFGX_SFIFO_SZ_DOUBLE        5
 #define BF_SRC_CFGX_NOT_PAUSE_WHEN_EMPTY  10
+#define BF_SRC_CFGX_SAMPLE_REPEAT_ENABLE  11
 #define BF_SRC_CFGX_BIT_RES               20
 #define BF_SRC_CFGX_PROCESS_SEQ_ID_VALID  31
+#define BF_SRC_CFGX_BITRES_MASK           0x1f
+
+/* AUD_FMM_BF_CTRL_SOURCECH_CTRLx_REG */
+#define BF_SOURCECH_CTRL_PLAY_RUN   0
 
 /* AUD_FMM_BF_CTRL_DESTCH_CFGx_REG */
 #define BF_DST_CFGX_CAP_ENA              0
@@ -154,11 +172,16 @@
 #define BF_DST_CFGX_FCI_ID              12
 #define BF_DST_CFGX_CAP_MODE            24
 #define BF_DST_CFGX_PROC_SEQ_ID_VALID   31
+#define BF_DST_CFGX_BITRES_MASK         0x1f
+
+/* AUD_FMM_BF_CTRL_DESTCH_CTRLX */
+#define BF_DESTCH_CTRLX_CAP_RUN  0x1
 
 /* AUD_FMM_IOP_OUT_SPDIF_xxx */
 #define SPDIF_0_OUT_DITHER_ENA     3
 #define SPDIF_0_OUT_STREAM_ENA    31
 
+#define IOP_LOGIC_RESET_IN_OFFSET(x) ((x) + 7) /* Capture ports offset by 7 */
 
 #define INIT_SSP_REGS(num) (struct cygnus_ssp_regs){ \
 		.i2s_stream_cfg = OUT_I2S_ ##num## _STREAM_CFG_OFFSET, \
@@ -169,8 +192,7 @@
 		.bf_destch_ctrl = BF_DST_CTRL ##num## _OFFSET, \
 		.bf_destch_cfg = BF_DST_CFG ##num## _OFFSET, \
 		.bf_sourcech_ctrl = BF_SRC_CTRL ##num## _OFFSET, \
-		.bf_sourcech_cfg = BF_SRC_CFG ##num## _OFFSET, \
-		.bf_sourcech_grp = BF_SRC_GRP ##num## _OFFSET \
+		.bf_sourcech_cfg = BF_SRC_CFG ##num## _OFFSET \
 }
 
 #define CYGNUS_RATE_MIN     8000
@@ -189,6 +211,8 @@
 	.list = cygnus_rates,
 };
 
+static void update_ssp_cfg(struct cygnus_aio_port *aio);
+
 static struct cygnus_aio_port *cygnus_dai_get_portinfo(struct snd_soc_dai *dai)
 {
 	struct cygnus_audio *cygaud = snd_soc_dai_get_drvdata(dai);
@@ -201,15 +225,17 @@ static int audio_ssp_init_portregs(struct cygnus_aio_port *aio)
 	u32 value, fci_id;
 	int status = 0;
 
+	/* Set Group ID */
+	writel(0, aio->cygaud->audio + BF_SRC_GRP0_OFFSET);
+	writel(1, aio->cygaud->audio + BF_SRC_GRP1_OFFSET);
+	writel(2, aio->cygaud->audio + BF_SRC_GRP2_OFFSET);
+	writel(3, aio->cygaud->audio + BF_SRC_GRP3_OFFSET);
+
 	switch (aio->port_type) {
 	case PORT_TDM:
 		value = readl(aio->cygaud->audio + aio->regs.i2s_stream_cfg);
 		value &= ~I2S_STREAM_CFG_MASK;
 
-		/* Set Group ID */
-		writel(aio->portnum,
-			aio->cygaud->audio + aio->regs.bf_sourcech_grp);
-
 		/* Configure the AUD_FMM_IOP_OUT_I2S_x_STREAM_CFG reg */
 		value |= aio->portnum << I2S_OUT_STREAM_CFG_GROUP_ID;
 		value |= aio->portnum; /* FCI ID is the port num */
@@ -219,6 +245,7 @@ static int audio_ssp_init_portregs(struct cygnus_aio_port *aio)
 		/* Configure the AUD_FMM_BF_CTRL_SOURCECH_CFGX reg */
 		value = readl(aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
 		value &= ~BIT(BF_SRC_CFGX_NOT_PAUSE_WHEN_EMPTY);
+		value &= ~BIT(BF_SRC_CFGX_SAMPLE_REPEAT_ENABLE);
 		value |= BIT(BF_SRC_CFGX_SFIFO_SZ_DOUBLE);
 		value |= BIT(BF_SRC_CFGX_PROCESS_SEQ_ID_VALID);
 		writel(value, aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
@@ -247,8 +274,6 @@ static int audio_ssp_init_portregs(struct cygnus_aio_port *aio)
 		writel(value, aio->cygaud->audio + AUD_MISC_SEROUT_OE_REG_BASE);
 		break;
 	case PORT_SPDIF:
-		writel(aio->portnum, aio->cygaud->audio + BF_SRC_GRP3_OFFSET);
-
 		value = readl(aio->cygaud->audio + SPDIF_CTRL_OFFSET);
 		value |= BIT(SPDIF_0_OUT_DITHER_ENA);
 		writel(value, aio->cygaud->audio + SPDIF_CTRL_OFFSET);
@@ -287,17 +312,35 @@ static void audio_ssp_in_enable(struct cygnus_aio_port *aio)
 	value |= BIT(BF_DST_CFGX_CAP_ENA);
 	writel(value, aio->cygaud->audio + aio->regs.bf_destch_cfg);
 
-	writel(0x1, aio->cygaud->audio + aio->regs.bf_destch_ctrl);
-
-	value = readl(aio->cygaud->audio + aio->regs.i2s_cfg);
-	value |= BIT(I2S_OUT_CFGX_CLK_ENA);
-	value |= BIT(I2S_OUT_CFGX_DATA_ENABLE);
-	writel(value, aio->cygaud->audio + aio->regs.i2s_cfg);
+	/*
+	 * DATA_ENABLE need to be set even if doing capture.
+	 * Subsequent Tx will fail if this is not done.
+	 */
+	if (!aio->streams_on) {
+		value = readl(aio->cygaud->audio + aio->regs.i2s_cfg);
+		value |= BIT(I2S_OUT_CFGX_CLK_ENA);
+		value |= BIT(I2S_OUT_CFGX_DATA_ENABLE);
+		writel(value, aio->cygaud->audio + aio->regs.i2s_cfg);
+	}
 
 	value = readl(aio->cygaud->i2s_in + aio->regs.i2s_cap_stream_cfg);
 	value |= BIT(I2S_IN_STREAM_CFG_CAP_ENA);
 	writel(value, aio->cygaud->i2s_in + aio->regs.i2s_cap_stream_cfg);
 
+	/* Enable input portion of block */
+	udelay(10);
+
+	/*
+	 * The input port may or may not be held in reset. Always clear
+	 * the reset. This will be benign if the port is not in reset.
+	 */
+	value = readl(aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
+	value &= ~BIT(IOP_LOGIC_RESET_IN_OFFSET(aio->portnum));
+	writel(value, aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
+
+	writel(BF_DESTCH_CTRLX_CAP_RUN,
+		aio->cygaud->audio + aio->regs.bf_destch_ctrl);
+
 	aio->streams_on |= CAPTURE_STREAM_MASK;
 }
 
@@ -305,25 +348,50 @@ static void audio_ssp_in_disable(struct cygnus_aio_port *aio)
 {
 	u32 value;
 
+	value = readl(aio->cygaud->audio + aio->regs.bf_destch_cfg);
+	value &= ~BIT(BF_DST_CFGX_CAP_ENA);
+	writel(value, aio->cygaud->audio + aio->regs.bf_destch_cfg);
+
 	value = readl(aio->cygaud->i2s_in + aio->regs.i2s_cap_stream_cfg);
 	value &= ~BIT(I2S_IN_STREAM_CFG_CAP_ENA);
 	writel(value, aio->cygaud->i2s_in + aio->regs.i2s_cap_stream_cfg);
 
 	aio->streams_on &= ~CAPTURE_STREAM_MASK;
 
+	writel(0x0, aio->cygaud->audio + aio->regs.bf_destch_ctrl);
+
+	/*
+	 * Put input portion of port in reset.
+	 * Clears residual data (32 bits) from internal formatter buffer
+	 * BIT_CLOCK must be present for this to take effect.  For Cygnus
+	 * in slave mode this means we must master after Cygnus port
+	 */
+	/*
+	 * TDM Slave Rx needs to toggle this reset.
+	 * See comment in cygnus_ssp_hw_params() about JIRA-1312.
+	 * TDM Master Rx also needs this fix
+	 *   32 bit transfers of fully populated TDM frames will have every
+	 *   transfer after the first with misaligned channels.
+	 *
+	 */
+	if (aio->mode == CYGNUS_SSPMODE_TDM) {
+		value = readl(aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
+		value |= BIT(IOP_LOGIC_RESET_IN_OFFSET(aio->portnum));
+		writel(value, aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
+	}
+
 	/* If both playback and capture are off */
 	if (!aio->streams_on) {
+		/*
+		 * Add small delay before turning off clock
+		 * Need 1 bit clock tick for INIT_LOGIC to activate
+		 */
+		udelay(10);
 		value = readl(aio->cygaud->audio + aio->regs.i2s_cfg);
 		value &= ~BIT(I2S_OUT_CFGX_CLK_ENA);
 		value &= ~BIT(I2S_OUT_CFGX_DATA_ENABLE);
 		writel(value, aio->cygaud->audio + aio->regs.i2s_cfg);
 	}
-
-	writel(0x0, aio->cygaud->audio + aio->regs.bf_destch_ctrl);
-
-	value = readl(aio->cygaud->audio + aio->regs.bf_destch_cfg);
-	value &= ~BIT(BF_DST_CFGX_CAP_ENA);
-	writel(value, aio->cygaud->audio + aio->regs.bf_destch_cfg);
 }
 
 static int audio_ssp_out_enable(struct cygnus_aio_port *aio)
@@ -334,19 +402,33 @@ static int audio_ssp_out_enable(struct cygnus_aio_port *aio)
 	switch (aio->port_type) {
 	case PORT_TDM:
 		value = readl(aio->cygaud->audio + aio->regs.i2s_stream_cfg);
-		value |= BIT(I2S_OUT_STREAM_ENA);
+		value &= ~(I2S_OUT_STREAM_CFG_FCI_ID_MASK);
+		value |= aio->portnum;
 		writel(value, aio->cygaud->audio + aio->regs.i2s_stream_cfg);
 
-		writel(1, aio->cygaud->audio + aio->regs.bf_sourcech_ctrl);
+		value = readl(aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
+		value |= BIT(BF_SRC_CFGX_SFIFO_ENA);
+		writel(value, aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
+
+		writel(BIT(BF_SOURCECH_CTRL_PLAY_RUN),
+			aio->cygaud->audio + aio->regs.bf_sourcech_ctrl);
+
+		value = readl(aio->cygaud->audio + aio->regs.i2s_stream_cfg);
+		value |= BIT(I2S_OUT_STREAM_ENA);
+		writel(value, aio->cygaud->audio + aio->regs.i2s_stream_cfg);
 
 		value = readl(aio->cygaud->audio + aio->regs.i2s_cfg);
 		value |= BIT(I2S_OUT_CFGX_CLK_ENA);
 		value |= BIT(I2S_OUT_CFGX_DATA_ENABLE);
 		writel(value, aio->cygaud->audio + aio->regs.i2s_cfg);
 
-		value = readl(aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
-		value |= BIT(BF_SRC_CFGX_SFIFO_ENA);
-		writel(value, aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
+		/*
+		 * The output port may or may not be in reset. Always clear
+		 * the reset. This will be benign if the port is not in reset.
+		 */
+		value = readl(aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
+		value &= ~BIT(aio->portnum);
+		writel(value, aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
 
 		aio->streams_on |= PLAYBACK_STREAM_MASK;
 		break;
@@ -355,7 +437,8 @@ static int audio_ssp_out_enable(struct cygnus_aio_port *aio)
 		value |= 0x3;
 		writel(value, aio->cygaud->audio + SPDIF_FORMAT_CFG_OFFSET);
 
-		writel(1, aio->cygaud->audio + aio->regs.bf_sourcech_ctrl);
+		writel(BIT(BF_SOURCECH_CTRL_PLAY_RUN),
+			aio->cygaud->audio + aio->regs.bf_sourcech_ctrl);
 
 		value = readl(aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
 		value |= BIT(BF_SRC_CFGX_SFIFO_ENA);
@@ -379,13 +462,17 @@ static int audio_ssp_out_disable(struct cygnus_aio_port *aio)
 	case PORT_TDM:
 		aio->streams_on &= ~PLAYBACK_STREAM_MASK;
 
-		/* If both playback and capture are off */
-		if (!aio->streams_on) {
-			value = readl(aio->cygaud->audio + aio->regs.i2s_cfg);
-			value &= ~BIT(I2S_OUT_CFGX_CLK_ENA);
-			value &= ~BIT(I2S_OUT_CFGX_DATA_ENABLE);
-			writel(value, aio->cygaud->audio + aio->regs.i2s_cfg);
-		}
+		/* Set the FCI ID to INVALID */
+		value = readl(aio->cygaud->audio + aio->regs.i2s_stream_cfg);
+		value |= 0x3ff;
+		writel(value, aio->cygaud->audio + aio->regs.i2s_stream_cfg);
+
+		/*
+		 * We want to wait enough time for 2 LRCLK.
+		 * At 8 kHz framerate, this would be 250 us.
+		 * Set delay to 300 us to be safe.
+		 */
+		udelay(300);
 
 		/* set group_sync_dis = 1 */
 		value = readl(aio->cygaud->audio + BF_SRC_GRP_SYNC_DIS_OFFSET);
@@ -403,16 +490,27 @@ static int audio_ssp_out_disable(struct cygnus_aio_port *aio)
 		value &= ~BIT(aio->portnum);
 		writel(value, aio->cygaud->audio + BF_SRC_GRP_SYNC_DIS_OFFSET);
 
-		value = readl(aio->cygaud->audio + aio->regs.i2s_stream_cfg);
-		value &= ~BIT(I2S_OUT_STREAM_ENA);
-		writel(value, aio->cygaud->audio + aio->regs.i2s_stream_cfg);
+		/*
+		 * We want to wait enough time for 1 LRCLK.
+		 * At 8 kHz framerate, this would be 125 us.
+		 * Set delay to 175 us to be safe.
+		 */
+		udelay(175);
+
+		if (aio->is_slave && (aio->mode == CYGNUS_SSPMODE_TDM)) {
+			value = readl(aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
+			value |= BIT(aio->portnum);
+			writel(value, aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
+		}
+
+		/* If both playback and capture are off */
+		if (aio->streams_on == 0) {
+			value = readl(aio->cygaud->audio + aio->regs.i2s_cfg);
+			value &= ~BIT(I2S_OUT_CFGX_DATA_ENABLE);
+			value &= ~BIT(I2S_OUT_CFGX_CLK_ENA);
+			writel(value, aio->cygaud->audio + aio->regs.i2s_cfg);
+		}
 
-		/* IOP SW INIT on OUT_I2S_x */
-		value = readl(aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
-		value |= BIT(aio->portnum);
-		writel(value, aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
-		value &= ~BIT(aio->portnum);
-		writel(value, aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
 		break;
 	case PORT_SPDIF:
 		value = readl(aio->cygaud->audio + SPDIF_FORMAT_CFG_OFFSET);
@@ -439,10 +537,12 @@ static int cygnus_ssp_set_clocks(struct cygnus_aio_port *aio)
 	u32 mask = 0xf;
 	u32 sclk;
 	u32 mclk_rate;
+	unsigned int bits_per_frame;
 	unsigned int bit_rate;
 	unsigned int ratio;
 
-	bit_rate = aio->bit_per_frame * aio->lrclk;
+	bits_per_frame = aio->slots_per_frame * aio->slot_width;
+	bit_rate = bits_per_frame * aio->lrclk;
 
 	/*
 	 * Check if the bit clock can be generated from the given MCLK.
@@ -468,14 +568,14 @@ static int cygnus_ssp_set_clocks(struct cygnus_aio_port *aio)
 		dev_err(aio->cygaud->dev,
 			"Invalid combination of MCLK and BCLK\n");
 		dev_err(aio->cygaud->dev, "lrclk = %u, bits/frame = %u, mclk = %u\n",
-			aio->lrclk, aio->bit_per_frame, aio->mclk);
+			aio->lrclk, bits_per_frame, aio->mclk);
 		return -EINVAL;
 	}
 
 	/* Set sclk rate */
 	switch (aio->port_type) {
 	case PORT_TDM:
-		sclk = aio->bit_per_frame;
+		sclk = bits_per_frame;
 		if (sclk == 512)
 			sclk = 0;
 
@@ -505,7 +605,7 @@ static int cygnus_ssp_set_clocks(struct cygnus_aio_port *aio)
 
 	dev_dbg(aio->cygaud->dev, "mclk cfg reg = 0x%x\n", value);
 	dev_dbg(aio->cygaud->dev, "bits per frame = %u, mclk = %u Hz, lrclk = %u Hz\n",
-			aio->bit_per_frame, aio->mclk, aio->lrclk);
+			bits_per_frame, aio->mclk, aio->lrclk);
 	return 0;
 }
 
@@ -514,9 +614,9 @@ static int cygnus_ssp_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
 	struct cygnus_aio_port *aio = cygnus_dai_get_portinfo(dai);
-	int rate, bitres;
+	int rate, bitres, bits_per_sample;
 	u32 value;
-	u32 mask = 0x1f;
+	u32 mask;
 	int ret = 0;
 
 	dev_dbg(aio->cygaud->dev, "%s port = %d\n", __func__, aio->portnum);
@@ -529,6 +629,7 @@ static int cygnus_ssp_hw_params(struct snd_pcm_substream *substream,
 
 	switch (aio->mode) {
 	case CYGNUS_SSPMODE_TDM:
+		/* It's expected that set_dai_tdm_slot has been called */
 		if ((rate == 192000) && (params_channels(params) > 4)) {
 			dev_err(aio->cygaud->dev, "Cannot run %d channels at %dHz\n",
 				params_channels(params), rate);
@@ -536,7 +637,15 @@ static int cygnus_ssp_hw_params(struct snd_pcm_substream *substream,
 		}
 		break;
 	case CYGNUS_SSPMODE_I2S:
-		aio->bit_per_frame = 64; /* I2S must be 64 bit per frame */
+		if (params_channels(params) != 2) {
+			dev_err(aio->cygaud->dev, "i2s mode must use 2 channels\n");
+			return -EINVAL;
+		}
+
+		aio->active_slots = 2;
+		aio->slots_per_frame = 2;
+		aio->slot_width = 32; /* Use 64Fs */
+
 		break;
 	default:
 		dev_err(aio->cygaud->dev,
@@ -553,26 +662,36 @@ static int cygnus_ssp_hw_params(struct snd_pcm_substream *substream,
 		switch (params_format(params)) {
 		case SNDRV_PCM_FORMAT_S16_LE:
 			bitres = 16;
+			bits_per_sample = 16;
 			break;
 
 		case SNDRV_PCM_FORMAT_S32_LE:
-			/* 32 bit mode is coded as 0 */
-			bitres = 0;
+			bitres = 0; /* 32 bit mode is coded as 0 */
+			bits_per_sample = 24; /* Only 24 valid bits */
 			break;
 
 		default:
 			return -EINVAL;
 		}
 
+		mask = BF_SRC_CFGX_BITRES_MASK;
 		value = readl(aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
 		value &= ~(mask << BF_SRC_CFGX_BIT_RES);
 		value |= (bitres << BF_SRC_CFGX_BIT_RES);
 		writel(value, aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
 
+		/* Only needed for LSB mode, ignored for MSB */
+		mask = I2S_OUT_CFGX_BIT_PER_SAMPLE_MASK;
+		value = readl(aio->cygaud->audio + aio->regs.i2s_cfg);
+		value &= ~(mask << I2S_OUT_CFGX_BITS_PER_SAMPLE);
+		value |= (bits_per_sample << I2S_OUT_CFGX_BITS_PER_SAMPLE);
+		writel(value, aio->cygaud->audio + aio->regs.i2s_cfg);
 	} else {
 
 		switch (params_format(params)) {
 		case SNDRV_PCM_FORMAT_S16_LE:
+			bits_per_sample = 16;
+
 			value = readl(aio->cygaud->audio +
 					aio->regs.bf_destch_cfg);
 			value |= BIT(BF_DST_CFGX_CAP_MODE);
@@ -581,6 +700,8 @@ static int cygnus_ssp_hw_params(struct snd_pcm_substream *substream,
 			break;
 
 		case SNDRV_PCM_FORMAT_S32_LE:
+			bits_per_sample = 24; /* Only 24 valid bits */
+
 			value = readl(aio->cygaud->audio +
 					aio->regs.bf_destch_cfg);
 			value &= ~BIT(BF_DST_CFGX_CAP_MODE);
@@ -591,12 +712,52 @@ static int cygnus_ssp_hw_params(struct snd_pcm_substream *substream,
 		default:
 			return -EINVAL;
 		}
+
+		/* Used for both LSB and MSB modes */
+		mask = I2S_IN_CFGX_BIT_PER_SAMPLE_MASK;
+		value = readl(aio->cygaud->i2s_in + aio->regs.i2s_cap_cfg);
+		value &= ~(mask << I2S_IN_CFGX_BITS_PER_SAMPLE);
+		value |= (bits_per_sample << I2S_IN_CFGX_BITS_PER_SAMPLE);
+		writel(value, aio->cygaud->i2s_in + aio->regs.i2s_cap_cfg);
 	}
 
-	aio->lrclk = rate;
+	/* Put output port into reset prior to configuring.
+	 * This action is a workaround for couple situations:
+	 *   1) JIRA-1312: 16-bit TDM Slave Tx problem
+	 *      If the port is configured as 16-bit slave and
+	 *      both CLK_ENA and DATA_ENABLE bits are off then the port will
+	 *      fail to Tx.  Therefore, we hold port in reset until the
+	 *      we are ready to enable
+	 *   2) The TDM Slave Tx stream will be misaligned on the first
+	 *      transfer after boot/reset (both 16 and 32 bit modes).
+	 *      Applying reset will workaround this problem.
+	 */
+	if (aio->streams_on == 0) {
+		if (aio->is_slave && (aio->mode == CYGNUS_SSPMODE_TDM)) {
+			/*
+			 * Need to do this LOGIC reset after boot/reset
+			 * because it puts the logic in a slightly different
+			 * than hard reset. In this way the chip logic will be
+			 * in the same state for our first transfer as it is
+			 * every transfer.
+			 */
+			value = readl(aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
+			value |= BIT(aio->portnum);
+			writel(value, aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
+
+			value = readl(aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
+			value |= BIT(IOP_LOGIC_RESET_IN_OFFSET(aio->portnum));
+			writel(value, aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
+		}
+
+		if (aio->port_type != PORT_SPDIF)
+			update_ssp_cfg(aio);
 
-	if (!aio->is_slave)
-		ret = cygnus_ssp_set_clocks(aio);
+		aio->lrclk = rate;
+
+		if (!aio->is_slave)
+			ret = cygnus_ssp_set_clocks(aio);
+	}
 
 	return ret;
 }
@@ -703,28 +864,6 @@ static void cygnus_ssp_shutdown(struct snd_pcm_substream *substream,
 	clk_disable_unprepare(aio->clk_info.audio_clk);
 }
 
-/*
- * Bit    Update  Notes
- * 31     Yes     TDM Mode        (1 = TDM, 0 = i2s)
- * 30     Yes     Slave Mode	  (1 = Slave, 0 = Master)
- * 29:26  No      Sclks per frame
- * 25:18  Yes     FS Width
- * 17:14  No      Valid Slots
- * 13     No      Bits		  (1 = 16 bits, 0 = 32 bits)
- * 12:08  No     Bits per samp
- * 07     Yes     Justifcation    (1 = LSB, 0 = MSB)
- * 06     Yes     Alignment       (1 = Delay 1 clk, 0 = no delay
- * 05     Yes     SCLK polarity   (1 = Rising, 0 = Falling)
- * 04     Yes     LRCLK Polarity  (1 = High for left, 0 = Low for left)
- * 03:02  Yes     Reserved - write as zero
- * 01     No      Data Enable
- * 00     No      CLK Enable
- */
-#define I2S_OUT_CFG_REG_UPDATE_MASK   0x3C03FF03
-
-/* Input cfg is same as output, but the FS width is not a valid field */
-#define I2S_IN_CFG_REG_UPDATE_MASK  (I2S_OUT_CFG_REG_UPDATE_MASK | 0x03FC0000)
-
 int cygnus_ssp_set_custom_fsync_width(struct snd_soc_dai *cpu_dai, int len)
 {
 	struct cygnus_aio_port *aio = cygnus_dai_get_portinfo(cpu_dai);
@@ -740,10 +879,6 @@ int cygnus_ssp_set_custom_fsync_width(struct snd_soc_dai *cpu_dai, int len)
 static int cygnus_ssp_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 {
 	struct cygnus_aio_port *aio = cygnus_dai_get_portinfo(cpu_dai);
-	u32 ssp_curcfg;
-	u32 ssp_newcfg;
-	u32 ssp_outcfg;
-	u32 ssp_incfg;
 	u32 val;
 	u32 mask;
 
@@ -752,15 +887,11 @@ static int cygnus_ssp_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 	if (aio->port_type == PORT_SPDIF)
 		return -EINVAL;
 
-	ssp_newcfg = 0;
-
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
-		ssp_newcfg |= BIT(I2S_OUT_CFGX_SLAVE_MODE);
 		aio->is_slave = 1;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
-		ssp_newcfg &= ~BIT(I2S_OUT_CFGX_SLAVE_MODE);
 		aio->is_slave = 0;
 		break;
 	default:
@@ -769,25 +900,24 @@ static int cygnus_ssp_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-		ssp_newcfg |= BIT(I2S_OUT_CFGX_DATA_ALIGNMENT);
-		ssp_newcfg |= BIT(I2S_OUT_CFGX_FSYNC_WIDTH);
+		aio->fs_delay = 1;
 		aio->mode = CYGNUS_SSPMODE_I2S;
 		break;
 
 	case SND_SOC_DAIFMT_DSP_A:
 	case SND_SOC_DAIFMT_DSP_B:
-		ssp_newcfg |= BIT(I2S_OUT_CFGX_TDM_MODE);
-
 		/* DSP_A = data after FS, DSP_B = data during FS */
 		if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_DSP_A)
-			ssp_newcfg |= BIT(I2S_OUT_CFGX_DATA_ALIGNMENT);
-
-		if ((aio->fsync_width > 0) && (aio->fsync_width < 256))
-			ssp_newcfg |=
-				(aio->fsync_width << I2S_OUT_CFGX_FSYNC_WIDTH);
-		else
-			ssp_newcfg |= BIT(I2S_OUT_CFGX_FSYNC_WIDTH);
-
+			aio->fs_delay = 1;
+		else {
+			if (aio->is_slave) {
+				dev_err(aio->cygaud->dev,
+				"%s DSP_B mode not supported while slave.\n",
+					__func__);
+				return -EINVAL;
+			}
+			aio->fs_delay = 0;
+		}
 		aio->mode = CYGNUS_SSPMODE_TDM;
 		break;
 
@@ -795,21 +925,36 @@ static int cygnus_ssp_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	/*
-	 * SSP out cfg.
-	 * Retain bits we do not want to update, then OR in new bits
-	 */
-	ssp_curcfg = readl(aio->cygaud->audio + aio->regs.i2s_cfg);
-	ssp_outcfg = (ssp_curcfg & I2S_OUT_CFG_REG_UPDATE_MASK) | ssp_newcfg;
-	writel(ssp_outcfg, aio->cygaud->audio + aio->regs.i2s_cfg);
+	/* We must be i2s master to invert any clock */
+	if ((fmt & SND_SOC_DAIFMT_INV_MASK) != SND_SOC_DAIFMT_NB_NF) {
+		if (aio->is_slave || (aio->mode == CYGNUS_SSPMODE_TDM)) {
+			dev_err(aio->cygaud->dev,
+			"%s Can only invert clocks in i2s master mode\n",
+				__func__);
+			return -EINVAL;
+		}
+	}
 
-	/*
-	 * SSP in cfg.
-	 * Retain bits we do not want to update, then OR in new bits
-	 */
-	ssp_curcfg = readl(aio->cygaud->i2s_in + aio->regs.i2s_cap_cfg);
-	ssp_incfg = (ssp_curcfg & I2S_IN_CFG_REG_UPDATE_MASK) | ssp_newcfg;
-	writel(ssp_incfg, aio->cygaud->i2s_in + aio->regs.i2s_cap_cfg);
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_NF:
+		aio->invert_bclk = true;
+		aio->invert_fs = false;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		aio->invert_bclk = false;
+		aio->invert_fs = true;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		aio->invert_bclk = true;
+		aio->invert_fs = true;
+		break;
+	case SND_SOC_DAIFMT_NB_NF:
+		aio->invert_bclk = false;
+		aio->invert_fs = false;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	val = readl(aio->cygaud->audio + AUD_MISC_SEROUT_OE_REG_BASE);
 
@@ -871,12 +1016,10 @@ static int cygnus_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
 	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
 {
 	struct cygnus_aio_port *aio = cygnus_dai_get_portinfo(cpu_dai);
-	u32 value;
-	int bits_per_slot = 0;     /* default to 32-bits per slot */
-	int frame_bits;
 	unsigned int active_slots;
+	unsigned int bits_per_frame;
 	bool found = false;
-	int i;
+	unsigned int i;
 
 	if (tx_mask != rx_mask) {
 		dev_err(aio->cygaud->dev,
@@ -886,35 +1029,20 @@ static int cygnus_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
 
 	active_slots = hweight32(tx_mask);
 
-	if ((active_slots < 0) || (active_slots > 16))
+	if ((active_slots == 0) || (active_slots > 16))
 		return -EINVAL;
 
 	/* Slot value must be even */
 	if (active_slots % 2)
 		return -EINVAL;
 
-	/* We encode 16 slots as 0 in the reg */
-	if (active_slots == 16)
-		active_slots = 0;
-
-	/* Slot Width is either 16 or 32 */
-	switch (slot_width) {
-	case 16:
-		bits_per_slot = 1;
-		break;
-	case 32:
-		bits_per_slot = 0;
-		break;
-	default:
-		bits_per_slot = 0;
-		dev_warn(aio->cygaud->dev,
-			"%s Defaulting Slot Width to 32\n", __func__);
-	}
+	if ((slot_width != 16) && (slot_width != 32))
+		return -EINVAL;
 
-	frame_bits = slots * slot_width;
+	bits_per_frame = slots * slot_width;
 
 	for (i = 0; i < ARRAY_SIZE(ssp_valid_tdm_framesize); i++) {
-		if (ssp_valid_tdm_framesize[i] == frame_bits) {
+		if (ssp_valid_tdm_framesize[i] == bits_per_frame) {
 			found = true;
 			break;
 		}
@@ -923,31 +1051,16 @@ static int cygnus_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
 	if (!found) {
 		dev_err(aio->cygaud->dev,
 			"%s In TDM mode, frame bits INVALID (%d)\n",
-			__func__, frame_bits);
+			__func__, bits_per_frame);
 		return -EINVAL;
 	}
 
-	aio->bit_per_frame = frame_bits;
+	aio->active_slots = active_slots;
+	aio->slot_width = slot_width;
+	aio->slots_per_frame = slots;
 
 	dev_dbg(aio->cygaud->dev, "%s active_slots %u, bits per frame %d\n",
-			__func__, active_slots, frame_bits);
-
-	/* Set capture side of ssp port */
-	value = readl(aio->cygaud->i2s_in + aio->regs.i2s_cap_cfg);
-	value &= ~(0xf << I2S_OUT_CFGX_VALID_SLOT);
-	value |= (active_slots << I2S_OUT_CFGX_VALID_SLOT);
-	value &= ~BIT(I2S_OUT_CFGX_BITS_PER_SLOT);
-	value |= (bits_per_slot << I2S_OUT_CFGX_BITS_PER_SLOT);
-	writel(value, aio->cygaud->i2s_in + aio->regs.i2s_cap_cfg);
-
-	/* Set playback side of ssp port */
-	value = readl(aio->cygaud->audio + aio->regs.i2s_cfg);
-	value &= ~(0xf << I2S_OUT_CFGX_VALID_SLOT);
-	value |= (active_slots << I2S_OUT_CFGX_VALID_SLOT);
-	value &= ~BIT(I2S_OUT_CFGX_BITS_PER_SLOT);
-	value |= (bits_per_slot << I2S_OUT_CFGX_BITS_PER_SLOT);
-	writel(value, aio->cygaud->audio + aio->regs.i2s_cfg);
-
+			__func__, aio->active_slots, bits_per_frame);
 	return 0;
 }
 
@@ -978,6 +1091,124 @@ static int cygnus_ssp_set_pll(struct snd_soc_dai *cpu_dai, int pll_id,
 	return ret;
 }
 
+/*
+ * Bit    Update  Notes
+ * 31     Yes     TDM Mode        (1 = TDM, 0 = i2s)
+ * 30     Yes     Slave Mode      (1 = Slave, 0 = Master)
+ * 29:26  No      Sclks per frame
+ * 25:18  Yes     FS Width
+ * 17:14  No      Valid Slots
+ * 13     No      Bits            (1 = 16 bits, 0 = 32 bits)
+ * 12:08  No      Bits per samp
+ * 07     Yes     Justifcation    (1 = LSB, 0 = MSB)
+ * 06     Yes     Alignment       (1 = Delay 1 clk, 0 = no delay
+ * 05     Yes     SCLK polarity   (1 = Rising, 0 = Falling)
+ * 04     Yes     LRCLK Polarity  (1 = High for left, 0 = Low for left)
+ * 03:02  Yes     Reserved - write as zero
+ * 01     No      Data Enable
+ * 00     No      CLK Enable
+ */
+#define I2S_OUT_CFG_REG_UPDATE_MASK   0x3c03ff03  /* set bit = do not modify */
+
+/* Input cfg is same as output, but the FS width is not a valid field */
+#define I2S_IN_CFG_REG_UPDATE_MASK  (I2S_OUT_CFG_REG_UPDATE_MASK | 0x03fc0000)
+
+static void update_ssp_cfg(struct cygnus_aio_port *aio)
+{
+	u32 valid_slots;       /* reg val to program */
+	int bits_per_slot_cmn;
+	int bits_per_slot_in;
+	int bits_per_slot_out;
+
+	u32 ssp_newcfg;
+	u32 ssp_curcfg;
+	u32 ssp_outcfg;
+	u32 ssp_incfg;
+	u32 fsync_width;
+
+	if (aio->port_type == PORT_SPDIF)
+		return;
+
+	/* We encode 16 slots as 0 in the reg */
+	valid_slots = aio->active_slots;
+	if (aio->active_slots == 16)
+		valid_slots = 0;
+
+	/* Slot Width is either 16 or 32 */
+	bits_per_slot_cmn = 0;     /* Default to 32 bits */
+	if (aio->slot_width <= 16)
+		bits_per_slot_cmn = 1;
+
+	bits_per_slot_in = bits_per_slot_cmn;
+	bits_per_slot_out = bits_per_slot_cmn;
+
+	ssp_newcfg = 0;
+
+	if (aio->mode == CYGNUS_SSPMODE_TDM) {
+		ssp_newcfg |= BIT(I2S_OUT_CFGX_TDM_MODE);
+		if (aio->fsync_width == -1)
+			fsync_width = 1;
+		else
+			fsync_width = aio->fsync_width;
+
+		ssp_newcfg |= (fsync_width << I2S_OUT_CFGX_FSYNC_WIDTH);
+	}
+
+	if (aio->is_slave)
+		ssp_newcfg |= BIT(I2S_OUT_CFGX_SLAVE_MODE);
+	else
+		ssp_newcfg &= ~BIT(I2S_OUT_CFGX_SLAVE_MODE);
+
+	if (aio->mode == CYGNUS_SSPMODE_I2S) {
+		ssp_newcfg |= BIT(I2S_OUT_CFGX_DATA_ALIGNMENT);
+		ssp_newcfg |= BIT(I2S_OUT_CFGX_FSYNC_WIDTH);
+	} else {
+		if (aio->fs_delay == 0)
+			ssp_newcfg &= ~BIT(I2S_OUT_CFGX_DATA_ALIGNMENT);
+		else
+			ssp_newcfg |= BIT(I2S_OUT_CFGX_DATA_ALIGNMENT);
+	}
+
+	if (aio->invert_bclk)
+		ssp_newcfg |= BIT(I2S_OUT_CFGX_SCLK_POLARITY);
+
+	if (aio->invert_fs)
+		ssp_newcfg |= BIT(I2S_OUT_CFGX_LRCK_POLARITY);
+
+	/*
+	 * SSP in cfg.
+	 * Retain bits we do not want to update, then OR in new bits
+	 * Always set slave mode for Rx formatter.
+	 * The Rx formatter's Slave Mode bit controls if it uses its own
+	 * internal clock or the clock signal that comes from the Slave Mode
+	 * bit set in the Tx formatter (which would be the Tx Formatters
+	 * internal clock or signal from external pin).
+	 */
+	ssp_curcfg = readl(aio->cygaud->i2s_in + aio->regs.i2s_cap_cfg);
+	ssp_incfg = (ssp_curcfg & I2S_IN_CFG_REG_UPDATE_MASK) | ssp_newcfg;
+	ssp_incfg |= BIT(I2S_OUT_CFGX_SLAVE_MODE);
+
+	ssp_incfg &= ~(0xf << I2S_OUT_CFGX_VALID_SLOT);
+	ssp_incfg |= (valid_slots << I2S_OUT_CFGX_VALID_SLOT);
+	ssp_incfg &= ~BIT(I2S_OUT_CFGX_BITS_PER_SLOT);
+	ssp_incfg |= (bits_per_slot_in << I2S_OUT_CFGX_BITS_PER_SLOT);
+
+	writel(ssp_incfg, aio->cygaud->i2s_in + aio->regs.i2s_cap_cfg);
+
+	/*
+	 * SSP out cfg.
+	 * Retain bits we do not want to update, then OR in new bits
+	 */
+	ssp_curcfg = readl(aio->cygaud->audio + aio->regs.i2s_cfg);
+	ssp_outcfg = (ssp_curcfg & I2S_OUT_CFG_REG_UPDATE_MASK) | ssp_newcfg;
+
+	ssp_outcfg &= ~(0xf << I2S_OUT_CFGX_VALID_SLOT);
+	ssp_outcfg |= (valid_slots << I2S_OUT_CFGX_VALID_SLOT);
+	ssp_outcfg &= ~BIT(I2S_OUT_CFGX_BITS_PER_SLOT);
+	ssp_outcfg |= (bits_per_slot_out << I2S_OUT_CFGX_BITS_PER_SLOT);
+
+	writel(ssp_outcfg, aio->cygaud->audio + aio->regs.i2s_cfg);
+}
 
 
 static const struct snd_soc_dai_ops cygnus_ssp_dai_ops = {
diff --git a/sound/soc/bcm/cygnus-ssp.h b/sound/soc/bcm/cygnus-ssp.h
index ad15a00..648321d 100644
--- a/sound/soc/bcm/cygnus-ssp.h
+++ b/sound/soc/bcm/cygnus-ssp.h
@@ -77,7 +77,6 @@ struct cygnus_ssp_regs {
 	u32 bf_destch_cfg;
 	u32 bf_sourcech_ctrl;
 	u32 bf_sourcech_cfg;
-	u32 bf_sourcech_grp;
 };
 
 struct cygnus_audio_clkinfo {
@@ -90,14 +89,21 @@ struct cygnus_aio_port {
 	int mode;
 	bool is_slave;
 	int streams_on;   /* will be 0 if both capture and play are off */
-	int fsync_width;
 	int port_type;
 
+	unsigned int fsync_width;
+	unsigned int fs_delay;
+	bool invert_bclk;
+	bool invert_fs;
+
 	u32 mclk;
 	u32 lrclk;
-	u32 bit_per_frame;
 	u32 pll_clk_num;
 
+	unsigned int slot_width;
+	unsigned int slots_per_frame;
+	unsigned int active_slots;
+
 	struct cygnus_audio *cygaud;
 	struct cygnus_ssp_regs regs;
 
@@ -120,8 +126,6 @@ struct cygnus_audio {
 	void __iomem *i2s_in;
 };
 
-extern int cygnus_ssp_get_mode(struct snd_soc_dai *cpu_dai);
-extern int cygnus_ssp_add_pll_tweak_controls(struct snd_soc_pcm_runtime *rtd);
 extern int cygnus_ssp_set_custom_fsync_width(struct snd_soc_dai *cpu_dai,
 						int len);
 extern int cygnus_soc_platform_register(struct device *dev,
-- 
1.9.1
