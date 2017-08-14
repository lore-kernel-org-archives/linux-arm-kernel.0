From: lori.hikichi@broadcom.com (Lori Hikichi)
Date: Mon, 14 Aug 2017 15:06:57 -0700
Subject: [PATCH 9/9] ASoC: cygnus: Tidy up of structure access
In-Reply-To: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
References: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
Message-ID: <1502748417-26417-10-git-send-email-lori.hikichi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds copies of the frequently accessed io handles to each ports
data structure, making it more convenient to access.  Also, a small
cleanup to the type names used in cygnus_pcm.  None of this should
result in a functional change to the driver.

Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
---
 sound/soc/bcm/cygnus-pcm.c |  50 ++++----
 sound/soc/bcm/cygnus-ssp.c | 298 +++++++++++++++++++++------------------------
 sound/soc/bcm/cygnus-ssp.h |  22 ++--
 3 files changed, 178 insertions(+), 192 deletions(-)

diff --git a/sound/soc/bcm/cygnus-pcm.c b/sound/soc/bcm/cygnus-pcm.c
index d616e096..d82bf55 100644
--- a/sound/soc/bcm/cygnus-pcm.c
+++ b/sound/soc/bcm/cygnus-pcm.c
@@ -329,24 +329,24 @@ static void enable_intr(struct snd_pcm_substream *substream)
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		/* Clear interrupt status before enabling them */
-		writel(clear_mask, aio->cygaud->audio + ESR0_STATUS_CLR_OFFSET);
-		writel(clear_mask, aio->cygaud->audio + ESR1_STATUS_CLR_OFFSET);
-		writel(clear_mask, aio->cygaud->audio + ESR3_STATUS_CLR_OFFSET);
+		writel(clear_mask, aio->audio + ESR0_STATUS_CLR_OFFSET);
+		writel(clear_mask, aio->audio + ESR1_STATUS_CLR_OFFSET);
+		writel(clear_mask, aio->audio + ESR3_STATUS_CLR_OFFSET);
 		/* Unmask the interrupts of the given port*/
-		writel(clear_mask, aio->cygaud->audio + ESR0_MASK_CLR_OFFSET);
-		writel(clear_mask, aio->cygaud->audio + ESR1_MASK_CLR_OFFSET);
-		writel(clear_mask, aio->cygaud->audio + ESR3_MASK_CLR_OFFSET);
+		writel(clear_mask, aio->audio + ESR0_MASK_CLR_OFFSET);
+		writel(clear_mask, aio->audio + ESR1_MASK_CLR_OFFSET);
+		writel(clear_mask, aio->audio + ESR3_MASK_CLR_OFFSET);
 
 		writel(ANY_PLAYBACK_IRQ,
-			aio->cygaud->audio + INTH_R5F_MASK_CLEAR_OFFSET);
+			aio->audio + INTH_R5F_MASK_CLEAR_OFFSET);
 	} else {
-		writel(clear_mask, aio->cygaud->audio + ESR2_STATUS_CLR_OFFSET);
-		writel(clear_mask, aio->cygaud->audio + ESR4_STATUS_CLR_OFFSET);
-		writel(clear_mask, aio->cygaud->audio + ESR2_MASK_CLR_OFFSET);
-		writel(clear_mask, aio->cygaud->audio + ESR4_MASK_CLR_OFFSET);
+		writel(clear_mask, aio->audio + ESR2_STATUS_CLR_OFFSET);
+		writel(clear_mask, aio->audio + ESR4_STATUS_CLR_OFFSET);
+		writel(clear_mask, aio->audio + ESR2_MASK_CLR_OFFSET);
+		writel(clear_mask, aio->audio + ESR4_MASK_CLR_OFFSET);
 
 		writel(ANY_CAPTURE_IRQ,
-			aio->cygaud->audio + INTH_R5F_MASK_CLEAR_OFFSET);
+			aio->audio + INTH_R5F_MASK_CLEAR_OFFSET);
 	}
 
 }
@@ -366,12 +366,12 @@ static void disable_intr(struct snd_pcm_substream *substream)
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		/* Mask the interrupts of the given port*/
-		writel(set_mask, aio->cygaud->audio + ESR0_MASK_SET_OFFSET);
-		writel(set_mask, aio->cygaud->audio + ESR1_MASK_SET_OFFSET);
-		writel(set_mask, aio->cygaud->audio + ESR3_MASK_SET_OFFSET);
+		writel(set_mask, aio->audio + ESR0_MASK_SET_OFFSET);
+		writel(set_mask, aio->audio + ESR1_MASK_SET_OFFSET);
+		writel(set_mask, aio->audio + ESR3_MASK_SET_OFFSET);
 	} else {
-		writel(set_mask, aio->cygaud->audio + ESR2_MASK_SET_OFFSET);
-		writel(set_mask, aio->cygaud->audio + ESR4_MASK_SET_OFFSET);
+		writel(set_mask, aio->audio + ESR2_MASK_SET_OFFSET);
+		writel(set_mask, aio->audio + ESR4_MASK_SET_OFFSET);
 	}
 
 }
@@ -415,13 +415,13 @@ static void cygnus_pcm_period_elapsed(struct snd_pcm_substream *substream)
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		/* Set the ring buffer to full */
-		regval = readl(aio->cygaud->audio + p_rbuf->rdaddr);
+		regval = readl(aio->audio + p_rbuf->rdaddr);
 		regval = regval ^ BIT(31);
-		writel(regval, aio->cygaud->audio + p_rbuf->wraddr);
+		writel(regval, aio->audio + p_rbuf->wraddr);
 	} else {
 		/* Set the ring buffer to empty */
-		regval = readl(aio->cygaud->audio + p_rbuf->wraddr);
-		writel(regval, aio->cygaud->audio + p_rbuf->rdaddr);
+		regval = readl(aio->audio + p_rbuf->wraddr);
+		writel(regval, aio->audio + p_rbuf->rdaddr);
 	}
 }
 
@@ -690,7 +690,7 @@ static int cygnus_pcm_prepare(struct snd_pcm_substream *substream)
 
 	is_play = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ? 1 : 0;
 
-	ringbuf_set_initial(aio->cygaud->audio, p_rbuf, is_play, start,
+	ringbuf_set_initial(aio->audio, p_rbuf, is_play, start,
 				periodsize, bufsize);
 
 	return ret;
@@ -710,11 +710,11 @@ static snd_pcm_uframes_t cygnus_pcm_pointer(struct snd_pcm_substream *substream)
 	 */
 	p_rbuf = get_ringbuf(substream);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		cur = readl(aio->cygaud->audio + p_rbuf->rdaddr);
+		cur = readl(aio->audio + p_rbuf->rdaddr);
 	else
-		cur = readl(aio->cygaud->audio + p_rbuf->wraddr);
+		cur = readl(aio->audio + p_rbuf->wraddr);
 
-	base = readl(aio->cygaud->audio + p_rbuf->baseaddr);
+	base = readl(aio->audio + p_rbuf->baseaddr);
 
 	/*
 	 * Mask off the MSB of the rdaddr,wraddr and baseaddr
diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index 97bf67a..7535613 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -226,78 +226,76 @@ static int audio_ssp_init_portregs(struct cygnus_aio_port *aio)
 	int status = 0;
 
 	/* Set Group ID */
-	writel(0, aio->cygaud->audio + BF_SRC_GRP0_OFFSET);
-	writel(1, aio->cygaud->audio + BF_SRC_GRP1_OFFSET);
-	writel(2, aio->cygaud->audio + BF_SRC_GRP2_OFFSET);
-	writel(3, aio->cygaud->audio + BF_SRC_GRP3_OFFSET);
+	writel(0, aio->audio + BF_SRC_GRP0_OFFSET);
+	writel(1, aio->audio + BF_SRC_GRP1_OFFSET);
+	writel(2, aio->audio + BF_SRC_GRP2_OFFSET);
+	writel(3, aio->audio + BF_SRC_GRP3_OFFSET);
 
 	switch (aio->port_type) {
 	case PORT_TDM:
-		value = readl(aio->cygaud->audio + aio->regs.i2s_stream_cfg);
+		value = readl(aio->audio + aio->regs.i2s_stream_cfg);
 		value &= ~I2S_STREAM_CFG_MASK;
 
 		/* Configure the AUD_FMM_IOP_OUT_I2S_x_STREAM_CFG reg */
 		value |= aio->portnum << I2S_OUT_STREAM_CFG_GROUP_ID;
 		value |= aio->portnum; /* FCI ID is the port num */
 		value |= CH_GRP_STEREO << I2S_OUT_STREAM_CFG_CHANNEL_GROUPING;
-		writel(value, aio->cygaud->audio + aio->regs.i2s_stream_cfg);
+		writel(value, aio->audio + aio->regs.i2s_stream_cfg);
 
 		/* Configure the AUD_FMM_BF_CTRL_SOURCECH_CFGX reg */
-		value = readl(aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
+		value = readl(aio->audio + aio->regs.bf_sourcech_cfg);
 		value &= ~BIT(BF_SRC_CFGX_NOT_PAUSE_WHEN_EMPTY);
 		value &= ~BIT(BF_SRC_CFGX_SAMPLE_REPEAT_ENABLE);
 		value |= BIT(BF_SRC_CFGX_SFIFO_SZ_DOUBLE);
 		value |= BIT(BF_SRC_CFGX_PROCESS_SEQ_ID_VALID);
-		writel(value, aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
+		writel(value, aio->audio + aio->regs.bf_sourcech_cfg);
 
 		/* Configure the AUD_FMM_IOP_IN_I2S_x_CAP_STREAM_CFG_0 reg */
-		value = readl(aio->cygaud->i2s_in +
-			aio->regs.i2s_cap_stream_cfg);
+		value = readl(aio->i2s_in + aio->regs.i2s_cap_stream_cfg);
 		value &= ~I2S_CAP_STREAM_CFG_MASK;
 		value |= aio->portnum << I2S_IN_STREAM_CFG_0_GROUP_ID;
-		writel(value, aio->cygaud->i2s_in +
-			aio->regs.i2s_cap_stream_cfg);
+		writel(value, aio->i2s_in + aio->regs.i2s_cap_stream_cfg);
 
 		/* Configure the AUD_FMM_BF_CTRL_DESTCH_CFGX_REG_BASE reg */
 		fci_id = CAPTURE_FCI_ID_BASE + aio->portnum;
 
-		value = readl(aio->cygaud->audio + aio->regs.bf_destch_cfg);
+		value = readl(aio->audio + aio->regs.bf_destch_cfg);
 		value |= BIT(BF_DST_CFGX_DFIFO_SZ_DOUBLE);
 		value &= ~BIT(BF_DST_CFGX_NOT_PAUSE_WHEN_FULL);
 		value |= (fci_id << BF_DST_CFGX_FCI_ID);
 		value |= BIT(BF_DST_CFGX_PROC_SEQ_ID_VALID);
-		writel(value, aio->cygaud->audio + aio->regs.bf_destch_cfg);
+		writel(value, aio->audio + aio->regs.bf_destch_cfg);
 
 		/* Enable the transmit pin for this port */
-		value = readl(aio->cygaud->audio + AUD_MISC_SEROUT_OE_REG_BASE);
+		value = readl(aio->audio + AUD_MISC_SEROUT_OE_REG_BASE);
 		value &= ~BIT((aio->portnum * 4) + AUD_MISC_SEROUT_SDAT_OE);
-		writel(value, aio->cygaud->audio + AUD_MISC_SEROUT_OE_REG_BASE);
+		writel(value, aio->audio + AUD_MISC_SEROUT_OE_REG_BASE);
 		break;
 	case PORT_SPDIF:
-		value = readl(aio->cygaud->audio + SPDIF_CTRL_OFFSET);
+		value = readl(aio->audio + SPDIF_CTRL_OFFSET);
 		value |= BIT(SPDIF_0_OUT_DITHER_ENA);
-		writel(value, aio->cygaud->audio + SPDIF_CTRL_OFFSET);
+		writel(value, aio->audio + SPDIF_CTRL_OFFSET);
 
 		/* Enable and set the FCI ID for the SPDIF channel */
-		value = readl(aio->cygaud->audio + SPDIF_STREAM_CFG_OFFSET);
+		value = readl(aio->audio + SPDIF_STREAM_CFG_OFFSET);
 		value &= ~SPDIF_STREAM_CFG_MASK;
 		value |= aio->portnum; /* FCI ID is the port num */
 		value |= BIT(SPDIF_0_OUT_STREAM_ENA);
-		writel(value, aio->cygaud->audio + SPDIF_STREAM_CFG_OFFSET);
+		writel(value, aio->audio + SPDIF_STREAM_CFG_OFFSET);
 
-		value = readl(aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
+		value = readl(aio->audio + aio->regs.bf_sourcech_cfg);
 		value &= ~BIT(BF_SRC_CFGX_NOT_PAUSE_WHEN_EMPTY);
 		value |= BIT(BF_SRC_CFGX_SFIFO_SZ_DOUBLE);
 		value |= BIT(BF_SRC_CFGX_PROCESS_SEQ_ID_VALID);
-		writel(value, aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
+		writel(value, aio->audio + aio->regs.bf_sourcech_cfg);
 
 		/* Enable the spdif output pin */
-		value = readl(aio->cygaud->audio + AUD_MISC_SEROUT_OE_REG_BASE);
+		value = readl(aio->audio + AUD_MISC_SEROUT_OE_REG_BASE);
 		value &= ~BIT(AUD_MISC_SEROUT_SPDIF_OE);
-		writel(value, aio->cygaud->audio + AUD_MISC_SEROUT_OE_REG_BASE);
+		writel(value, aio->audio + AUD_MISC_SEROUT_OE_REG_BASE);
 		break;
 	default:
-		dev_err(aio->cygaud->dev, "Port not supported\n");
+		dev_err(aio->dev, "Port not supported\n");
 		status = -EINVAL;
 	}
 
@@ -308,24 +306,24 @@ static void audio_ssp_in_enable(struct cygnus_aio_port *aio)
 {
 	u32 value;
 
-	value = readl(aio->cygaud->audio + aio->regs.bf_destch_cfg);
+	value = readl(aio->audio + aio->regs.bf_destch_cfg);
 	value |= BIT(BF_DST_CFGX_CAP_ENA);
-	writel(value, aio->cygaud->audio + aio->regs.bf_destch_cfg);
+	writel(value, aio->audio + aio->regs.bf_destch_cfg);
 
 	/*
 	 * DATA_ENABLE need to be set even if doing capture.
 	 * Subsequent Tx will fail if this is not done.
 	 */
 	if (!aio->streams_on) {
-		value = readl(aio->cygaud->audio + aio->regs.i2s_cfg);
+		value = readl(aio->audio + aio->regs.i2s_cfg);
 		value |= BIT(I2S_OUT_CFGX_CLK_ENA);
 		value |= BIT(I2S_OUT_CFGX_DATA_ENABLE);
-		writel(value, aio->cygaud->audio + aio->regs.i2s_cfg);
+		writel(value, aio->audio + aio->regs.i2s_cfg);
 	}
 
-	value = readl(aio->cygaud->i2s_in + aio->regs.i2s_cap_stream_cfg);
+	value = readl(aio->i2s_in + aio->regs.i2s_cap_stream_cfg);
 	value |= BIT(I2S_IN_STREAM_CFG_CAP_ENA);
-	writel(value, aio->cygaud->i2s_in + aio->regs.i2s_cap_stream_cfg);
+	writel(value, aio->i2s_in + aio->regs.i2s_cap_stream_cfg);
 
 	/* Enable input portion of block */
 	udelay(10);
@@ -334,12 +332,11 @@ static void audio_ssp_in_enable(struct cygnus_aio_port *aio)
 	 * The input port may or may not be held in reset. Always clear
 	 * the reset. This will be benign if the port is not in reset.
 	 */
-	value = readl(aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
+	value = readl(aio->i2s_in + IOP_SW_INIT_LOGIC);
 	value &= ~BIT(IOP_LOGIC_RESET_IN_OFFSET(aio->portnum));
-	writel(value, aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
+	writel(value, aio->i2s_in + IOP_SW_INIT_LOGIC);
 
-	writel(BF_DESTCH_CTRLX_CAP_RUN,
-		aio->cygaud->audio + aio->regs.bf_destch_ctrl);
+	writel(BF_DESTCH_CTRLX_CAP_RUN, aio->audio + aio->regs.bf_destch_ctrl);
 
 	aio->streams_on |= CAPTURE_STREAM_MASK;
 }
@@ -348,17 +345,17 @@ static void audio_ssp_in_disable(struct cygnus_aio_port *aio)
 {
 	u32 value;
 
-	value = readl(aio->cygaud->audio + aio->regs.bf_destch_cfg);
+	value = readl(aio->audio + aio->regs.bf_destch_cfg);
 	value &= ~BIT(BF_DST_CFGX_CAP_ENA);
-	writel(value, aio->cygaud->audio + aio->regs.bf_destch_cfg);
+	writel(value, aio->audio + aio->regs.bf_destch_cfg);
 
-	value = readl(aio->cygaud->i2s_in + aio->regs.i2s_cap_stream_cfg);
+	value = readl(aio->i2s_in + aio->regs.i2s_cap_stream_cfg);
 	value &= ~BIT(I2S_IN_STREAM_CFG_CAP_ENA);
-	writel(value, aio->cygaud->i2s_in + aio->regs.i2s_cap_stream_cfg);
+	writel(value, aio->i2s_in + aio->regs.i2s_cap_stream_cfg);
 
 	aio->streams_on &= ~CAPTURE_STREAM_MASK;
 
-	writel(0x0, aio->cygaud->audio + aio->regs.bf_destch_ctrl);
+	writel(0x0, aio->audio + aio->regs.bf_destch_ctrl);
 
 	/*
 	 * Put input portion of port in reset.
@@ -375,9 +372,9 @@ static void audio_ssp_in_disable(struct cygnus_aio_port *aio)
 	 *
 	 */
 	if (aio->mode == CYGNUS_SSPMODE_TDM) {
-		value = readl(aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
+		value = readl(aio->i2s_in + IOP_SW_INIT_LOGIC);
 		value |= BIT(IOP_LOGIC_RESET_IN_OFFSET(aio->portnum));
-		writel(value, aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
+		writel(value, aio->i2s_in + IOP_SW_INIT_LOGIC);
 	}
 
 	/* If both playback and capture are off */
@@ -387,10 +384,10 @@ static void audio_ssp_in_disable(struct cygnus_aio_port *aio)
 		 * Need 1 bit clock tick for INIT_LOGIC to activate
 		 */
 		udelay(10);
-		value = readl(aio->cygaud->audio + aio->regs.i2s_cfg);
+		value = readl(aio->audio + aio->regs.i2s_cfg);
 		value &= ~BIT(I2S_OUT_CFGX_CLK_ENA);
 		value &= ~BIT(I2S_OUT_CFGX_DATA_ENABLE);
-		writel(value, aio->cygaud->audio + aio->regs.i2s_cfg);
+		writel(value, aio->audio + aio->regs.i2s_cfg);
 	}
 }
 
@@ -401,52 +398,51 @@ static int audio_ssp_out_enable(struct cygnus_aio_port *aio)
 
 	switch (aio->port_type) {
 	case PORT_TDM:
-		value = readl(aio->cygaud->audio + aio->regs.i2s_stream_cfg);
+		value = readl(aio->audio + aio->regs.i2s_stream_cfg);
 		value &= ~(I2S_OUT_STREAM_CFG_FCI_ID_MASK);
 		value |= aio->portnum;
-		writel(value, aio->cygaud->audio + aio->regs.i2s_stream_cfg);
+		writel(value, aio->audio + aio->regs.i2s_stream_cfg);
 
-		value = readl(aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
+		value = readl(aio->audio + aio->regs.bf_sourcech_cfg);
 		value |= BIT(BF_SRC_CFGX_SFIFO_ENA);
-		writel(value, aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
+		writel(value, aio->audio + aio->regs.bf_sourcech_cfg);
 
 		writel(BIT(BF_SOURCECH_CTRL_PLAY_RUN),
-			aio->cygaud->audio + aio->regs.bf_sourcech_ctrl);
+			aio->audio + aio->regs.bf_sourcech_ctrl);
 
-		value = readl(aio->cygaud->audio + aio->regs.i2s_stream_cfg);
+		value = readl(aio->audio + aio->regs.i2s_stream_cfg);
 		value |= BIT(I2S_OUT_STREAM_ENA);
-		writel(value, aio->cygaud->audio + aio->regs.i2s_stream_cfg);
+		writel(value, aio->audio + aio->regs.i2s_stream_cfg);
 
-		value = readl(aio->cygaud->audio + aio->regs.i2s_cfg);
+		value = readl(aio->audio + aio->regs.i2s_cfg);
 		value |= BIT(I2S_OUT_CFGX_CLK_ENA);
 		value |= BIT(I2S_OUT_CFGX_DATA_ENABLE);
-		writel(value, aio->cygaud->audio + aio->regs.i2s_cfg);
+		writel(value, aio->audio + aio->regs.i2s_cfg);
 
 		/*
 		 * The output port may or may not be in reset. Always clear
 		 * the reset. This will be benign if the port is not in reset.
 		 */
-		value = readl(aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
+		value = readl(aio->i2s_in + IOP_SW_INIT_LOGIC);
 		value &= ~BIT(aio->portnum);
-		writel(value, aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
+		writel(value, aio->i2s_in + IOP_SW_INIT_LOGIC);
 
 		aio->streams_on |= PLAYBACK_STREAM_MASK;
 		break;
 	case PORT_SPDIF:
-		value = readl(aio->cygaud->audio + SPDIF_FORMAT_CFG_OFFSET);
+		value = readl(aio->audio + SPDIF_FORMAT_CFG_OFFSET);
 		value |= 0x3;
-		writel(value, aio->cygaud->audio + SPDIF_FORMAT_CFG_OFFSET);
+		writel(value, aio->audio + SPDIF_FORMAT_CFG_OFFSET);
 
 		writel(BIT(BF_SOURCECH_CTRL_PLAY_RUN),
-			aio->cygaud->audio + aio->regs.bf_sourcech_ctrl);
+			aio->audio + aio->regs.bf_sourcech_ctrl);
 
-		value = readl(aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
+		value = readl(aio->audio + aio->regs.bf_sourcech_cfg);
 		value |= BIT(BF_SRC_CFGX_SFIFO_ENA);
-		writel(value, aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
+		writel(value, aio->audio + aio->regs.bf_sourcech_cfg);
 		break;
 	default:
-		dev_err(aio->cygaud->dev,
-			"Port not supported %d\n", aio->portnum);
+		dev_err(aio->dev, "Port not supported %d\n", aio->portnum);
 		status = -EINVAL;
 	}
 
@@ -463,9 +459,9 @@ static int audio_ssp_out_disable(struct cygnus_aio_port *aio)
 		aio->streams_on &= ~PLAYBACK_STREAM_MASK;
 
 		/* Set the FCI ID to INVALID */
-		value = readl(aio->cygaud->audio + aio->regs.i2s_stream_cfg);
+		value = readl(aio->audio + aio->regs.i2s_stream_cfg);
 		value |= 0x3ff;
-		writel(value, aio->cygaud->audio + aio->regs.i2s_stream_cfg);
+		writel(value, aio->audio + aio->regs.i2s_stream_cfg);
 
 		/*
 		 * We want to wait enough time for 2 LRCLK.
@@ -475,20 +471,20 @@ static int audio_ssp_out_disable(struct cygnus_aio_port *aio)
 		udelay(300);
 
 		/* set group_sync_dis = 1 */
-		value = readl(aio->cygaud->audio + BF_SRC_GRP_SYNC_DIS_OFFSET);
+		value = readl(aio->audio + BF_SRC_GRP_SYNC_DIS_OFFSET);
 		value |= BIT(aio->portnum);
-		writel(value, aio->cygaud->audio + BF_SRC_GRP_SYNC_DIS_OFFSET);
+		writel(value, aio->audio + BF_SRC_GRP_SYNC_DIS_OFFSET);
 
-		writel(0, aio->cygaud->audio + aio->regs.bf_sourcech_ctrl);
+		writel(0, aio->audio + aio->regs.bf_sourcech_ctrl);
 
-		value = readl(aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
+		value = readl(aio->audio + aio->regs.bf_sourcech_cfg);
 		value &= ~BIT(BF_SRC_CFGX_SFIFO_ENA);
-		writel(value, aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
+		writel(value, aio->audio + aio->regs.bf_sourcech_cfg);
 
 		/* set group_sync_dis = 0 */
-		value = readl(aio->cygaud->audio + BF_SRC_GRP_SYNC_DIS_OFFSET);
+		value = readl(aio->audio + BF_SRC_GRP_SYNC_DIS_OFFSET);
 		value &= ~BIT(aio->portnum);
-		writel(value, aio->cygaud->audio + BF_SRC_GRP_SYNC_DIS_OFFSET);
+		writel(value, aio->audio + BF_SRC_GRP_SYNC_DIS_OFFSET);
 
 		/*
 		 * We want to wait enough time for 1 LRCLK.
@@ -498,33 +494,32 @@ static int audio_ssp_out_disable(struct cygnus_aio_port *aio)
 		udelay(175);
 
 		if (aio->is_slave && (aio->mode == CYGNUS_SSPMODE_TDM)) {
-			value = readl(aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
+			value = readl(aio->i2s_in + IOP_SW_INIT_LOGIC);
 			value |= BIT(aio->portnum);
-			writel(value, aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
+			writel(value, aio->i2s_in + IOP_SW_INIT_LOGIC);
 		}
 
 		/* If both playback and capture are off */
 		if (aio->streams_on == 0) {
-			value = readl(aio->cygaud->audio + aio->regs.i2s_cfg);
+			value = readl(aio->audio + aio->regs.i2s_cfg);
 			value &= ~BIT(I2S_OUT_CFGX_DATA_ENABLE);
 			value &= ~BIT(I2S_OUT_CFGX_CLK_ENA);
-			writel(value, aio->cygaud->audio + aio->regs.i2s_cfg);
+			writel(value, aio->audio + aio->regs.i2s_cfg);
 		}
 
 		break;
 	case PORT_SPDIF:
-		value = readl(aio->cygaud->audio + SPDIF_FORMAT_CFG_OFFSET);
+		value = readl(aio->audio + SPDIF_FORMAT_CFG_OFFSET);
 		value &= ~0x3;
-		writel(value, aio->cygaud->audio + SPDIF_FORMAT_CFG_OFFSET);
-		writel(0, aio->cygaud->audio + aio->regs.bf_sourcech_ctrl);
+		writel(value, aio->audio + SPDIF_FORMAT_CFG_OFFSET);
+		writel(0, aio->audio + aio->regs.bf_sourcech_ctrl);
 
-		value = readl(aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
+		value = readl(aio->audio + aio->regs.bf_sourcech_cfg);
 		value &= ~BIT(BF_SRC_CFGX_SFIFO_ENA);
-		writel(value, aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
+		writel(value, aio->audio + aio->regs.bf_sourcech_cfg);
 		break;
 	default:
-		dev_err(aio->cygaud->dev,
-			"Port not supported %d\n", aio->portnum);
+		dev_err(aio->dev, "Port not supported %d\n", aio->portnum);
 		status = -EINVAL;
 	}
 
@@ -565,9 +560,8 @@ static int cygnus_ssp_set_clocks(struct cygnus_aio_port *aio)
 		break;
 
 	default:
-		dev_err(aio->cygaud->dev,
-			"Invalid combination of MCLK and BCLK\n");
-		dev_err(aio->cygaud->dev, "lrclk = %u, bits/frame = %u, mclk = %u\n",
+		dev_err(aio->dev, "Invalid combination of MCLK and BCLK\n");
+		dev_err(aio->dev, "lrclk = %u, bits/frame = %u, mclk = %u\n",
 			aio->lrclk, bits_per_frame, aio->mclk);
 		return -EINVAL;
 	}
@@ -583,28 +577,27 @@ static int cygnus_ssp_set_clocks(struct cygnus_aio_port *aio)
 		sclk /= 32;
 
 		/* Set number of bitclks per frame */
-		value = readl(aio->cygaud->audio + aio->regs.i2s_cfg);
+		value = readl(aio->audio + aio->regs.i2s_cfg);
 		value &= ~(mask << I2S_OUT_CFGX_SCLKS_PER_1FS_DIV32);
 		value |= sclk << I2S_OUT_CFGX_SCLKS_PER_1FS_DIV32;
-		writel(value, aio->cygaud->audio + aio->regs.i2s_cfg);
-		dev_dbg(aio->cygaud->dev,
-			"SCLKS_PER_1FS_DIV32 = 0x%x\n", value);
+		writel(value, aio->audio + aio->regs.i2s_cfg);
+		dev_dbg(aio->dev, "SCLKS_PER_1FS_DIV32 = 0x%x\n", value);
 		break;
 	case PORT_SPDIF:
 		break;
 	default:
-		dev_err(aio->cygaud->dev, "Unknown port type\n");
+		dev_err(aio->dev, "Unknown port type\n");
 		return -EINVAL;
 	}
 
 	/* Set MCLK_RATE ssp port (spdif and ssp are the same) */
-	value = readl(aio->cygaud->audio + aio->regs.i2s_mclk_cfg);
+	value = readl(aio->audio + aio->regs.i2s_mclk_cfg);
 	value &= ~(0xf << I2S_OUT_MCLKRATE_SHIFT);
 	value |= (mclk_rate << I2S_OUT_MCLKRATE_SHIFT);
-	writel(value, aio->cygaud->audio + aio->regs.i2s_mclk_cfg);
+	writel(value, aio->audio + aio->regs.i2s_mclk_cfg);
 
-	dev_dbg(aio->cygaud->dev, "mclk cfg reg = 0x%x\n", value);
-	dev_dbg(aio->cygaud->dev, "bits per frame = %u, mclk = %u Hz, lrclk = %u Hz\n",
+	dev_dbg(aio->dev, "mclk cfg reg = 0x%x\n", value);
+	dev_dbg(aio->dev, "bits per frame = %u, mclk = %u Hz, lrclk = %u Hz\n",
 			bits_per_frame, aio->mclk, aio->lrclk);
 	return 0;
 }
@@ -619,11 +612,10 @@ static int cygnus_ssp_hw_params(struct snd_pcm_substream *substream,
 	u32 mask;
 	int ret = 0;
 
-	dev_dbg(aio->cygaud->dev, "%s port = %d\n", __func__, aio->portnum);
-	dev_dbg(aio->cygaud->dev, "params_channels %d\n",
-			params_channels(params));
-	dev_dbg(aio->cygaud->dev, "rate %d\n", params_rate(params));
-	dev_dbg(aio->cygaud->dev, "format %d\n", params_format(params));
+	dev_dbg(aio->dev, "%s port = %d\n", __func__, aio->portnum);
+	dev_dbg(aio->dev, "params_channels %d\n", params_channels(params));
+	dev_dbg(aio->dev, "rate %d\n", params_rate(params));
+	dev_dbg(aio->dev, "format %d\n", params_format(params));
 
 	rate = params_rate(params);
 
@@ -631,14 +623,14 @@ static int cygnus_ssp_hw_params(struct snd_pcm_substream *substream,
 	case CYGNUS_SSPMODE_TDM:
 		/* It's expected that set_dai_tdm_slot has been called */
 		if ((rate == 192000) && (params_channels(params) > 4)) {
-			dev_err(aio->cygaud->dev, "Cannot run %d channels at %dHz\n",
+			dev_err(aio->dev, "Cannot run %d channels at %dHz\n",
 				params_channels(params), rate);
 			return -EINVAL;
 		}
 		break;
 	case CYGNUS_SSPMODE_I2S:
 		if (params_channels(params) != 2) {
-			dev_err(aio->cygaud->dev, "i2s mode must use 2 channels\n");
+			dev_err(aio->dev, "i2s mode must use 2 channels\n");
 			return -EINVAL;
 		}
 
@@ -648,16 +640,15 @@ static int cygnus_ssp_hw_params(struct snd_pcm_substream *substream,
 
 		break;
 	default:
-		dev_err(aio->cygaud->dev,
-			"%s port running in unknown mode\n", __func__);
+		dev_err(aio->dev, "%s unknown mode\n", __func__);
 		return -EINVAL;
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		value = readl(aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
+		value = readl(aio->audio + aio->regs.bf_sourcech_cfg);
 		value &= ~BIT(BF_SRC_CFGX_BUFFER_PAIR_ENABLE);
 		value &= ~BIT(BF_SRC_CFGX_SAMPLE_CH_MODE);
-		writel(value, aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
+		writel(value, aio->audio + aio->regs.bf_sourcech_cfg);
 
 		switch (params_format(params)) {
 		case SNDRV_PCM_FORMAT_S16_LE:
@@ -675,38 +666,34 @@ static int cygnus_ssp_hw_params(struct snd_pcm_substream *substream,
 		}
 
 		mask = BF_SRC_CFGX_BITRES_MASK;
-		value = readl(aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
+		value = readl(aio->audio + aio->regs.bf_sourcech_cfg);
 		value &= ~(mask << BF_SRC_CFGX_BIT_RES);
 		value |= (bitres << BF_SRC_CFGX_BIT_RES);
-		writel(value, aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
+		writel(value, aio->audio + aio->regs.bf_sourcech_cfg);
 
 		/* Only needed for LSB mode, ignored for MSB */
 		mask = I2S_OUT_CFGX_BIT_PER_SAMPLE_MASK;
-		value = readl(aio->cygaud->audio + aio->regs.i2s_cfg);
+		value = readl(aio->audio + aio->regs.i2s_cfg);
 		value &= ~(mask << I2S_OUT_CFGX_BITS_PER_SAMPLE);
 		value |= (bits_per_sample << I2S_OUT_CFGX_BITS_PER_SAMPLE);
-		writel(value, aio->cygaud->audio + aio->regs.i2s_cfg);
+		writel(value, aio->audio + aio->regs.i2s_cfg);
 	} else {
 
 		switch (params_format(params)) {
 		case SNDRV_PCM_FORMAT_S16_LE:
 			bits_per_sample = 16;
 
-			value = readl(aio->cygaud->audio +
-					aio->regs.bf_destch_cfg);
+			value = readl(aio->audio + aio->regs.bf_destch_cfg);
 			value |= BIT(BF_DST_CFGX_CAP_MODE);
-			writel(value, aio->cygaud->audio +
-					aio->regs.bf_destch_cfg);
+			writel(value, aio->audio + aio->regs.bf_destch_cfg);
 			break;
 
 		case SNDRV_PCM_FORMAT_S32_LE:
 			bits_per_sample = 24; /* Only 24 valid bits */
 
-			value = readl(aio->cygaud->audio +
-					aio->regs.bf_destch_cfg);
+			value = readl(aio->audio + aio->regs.bf_destch_cfg);
 			value &= ~BIT(BF_DST_CFGX_CAP_MODE);
-			writel(value, aio->cygaud->audio +
-					aio->regs.bf_destch_cfg);
+			writel(value, aio->audio + aio->regs.bf_destch_cfg);
 			break;
 
 		default:
@@ -715,10 +702,10 @@ static int cygnus_ssp_hw_params(struct snd_pcm_substream *substream,
 
 		/* Used for both LSB and MSB modes */
 		mask = I2S_IN_CFGX_BIT_PER_SAMPLE_MASK;
-		value = readl(aio->cygaud->i2s_in + aio->regs.i2s_cap_cfg);
+		value = readl(aio->i2s_in + aio->regs.i2s_cap_cfg);
 		value &= ~(mask << I2S_IN_CFGX_BITS_PER_SAMPLE);
 		value |= (bits_per_sample << I2S_IN_CFGX_BITS_PER_SAMPLE);
-		writel(value, aio->cygaud->i2s_in + aio->regs.i2s_cap_cfg);
+		writel(value, aio->i2s_in + aio->regs.i2s_cap_cfg);
 	}
 
 	/* Put output port into reset prior to configuring.
@@ -741,13 +728,13 @@ static int cygnus_ssp_hw_params(struct snd_pcm_substream *substream,
 			 * in the same state for our first transfer as it is
 			 * every transfer.
 			 */
-			value = readl(aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
+			value = readl(aio->i2s_in + IOP_SW_INIT_LOGIC);
 			value |= BIT(aio->portnum);
-			writel(value, aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
+			writel(value, aio->i2s_in + IOP_SW_INIT_LOGIC);
 
-			value = readl(aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
+			value = readl(aio->i2s_in + IOP_SW_INIT_LOGIC);
 			value |= BIT(IOP_LOGIC_RESET_IN_OFFSET(aio->portnum));
-			writel(value, aio->cygaud->i2s_in + IOP_SW_INIT_LOGIC);
+			writel(value, aio->i2s_in + IOP_SW_INIT_LOGIC);
 		}
 
 		if (aio->port_type != PORT_SPDIF)
@@ -790,52 +777,49 @@ static int cygnus_ssp_set_sysclk(struct snd_soc_dai *dai,
 	long rate;
 	struct cygnus_aio_port *aio = cygnus_dai_get_portinfo(dai);
 
-	dev_dbg(aio->cygaud->dev,
-		"%s Enter port = %d\n", __func__, aio->portnum);
+	dev_dbg(aio->dev, "%s Enter port = %d\n", __func__, aio->portnum);
 
 	/*
 	 * This should not happen, but the machine file may inadvertently
 	 * call set_sysclk without configuring a clock via the devicetree.
 	 */
 	if (!aio->clk_info.audio_clk) {
-		dev_err(aio->cygaud->dev,
-			"%s Error. No clock assigned.\n", __func__);
+		dev_err(aio->dev, "%s Error. No clock assigned.\n", __func__);
 		return -ENODEV;
 	}
 
 	rate = clk_round_rate(aio->clk_info.audio_clk, freq);
 	if (rate < 0) {
-		dev_err(aio->cygaud->dev, "%s Error with with clock %ld.\n",
+		dev_err(aio->dev, "%s Error with with clock %ld.\n",
 			__func__, rate);
 		return rate;
 	}
 
 	if (!mclk_in_range(freq, rate)) {
-		dev_err(aio->cygaud->dev, "%s Can not set rate to %u  actual %ld.\n",
+		dev_err(aio->dev, "%s Can not set rate to %u  actual %ld.\n",
 			__func__, freq, rate);
 		return -EINVAL;
 	}
 
 	ret = clk_set_rate(aio->clk_info.audio_clk, freq);
 	if (ret) {
-		dev_err(aio->cygaud->dev,
-			"%s Set MCLK rate fail %d\n", __func__, ret);
+		dev_err(aio->dev, "%s Set MCLK rate fail %d\n", __func__, ret);
 		return ret;
 	}
 
 	aio->mclk = freq;
 	sel = aio->clk_info.clk_mux;
 
-	dev_dbg(aio->cygaud->dev, "%s Setting MCLKSEL to %d\n", __func__, sel);
-	value = readl(aio->cygaud->audio + aio->regs.i2s_mclk_cfg);
+	dev_dbg(aio->dev, "%s Setting MCLKSEL to %d\n", __func__, sel);
+	value = readl(aio->audio + aio->regs.i2s_mclk_cfg);
 	value &= ~(0xf << I2S_OUT_PLLCLKSEL_SHIFT);
 	value |= (sel << I2S_OUT_PLLCLKSEL_SHIFT);
-	writel(value, aio->cygaud->audio + aio->regs.i2s_mclk_cfg);
+	writel(value, aio->audio + aio->regs.i2s_mclk_cfg);
 
 	/* Clear bit for active */
-	value = readl(aio->cygaud->audio + AUD_MISC_SEROUT_OE_REG_BASE);
+	value = readl(aio->audio + AUD_MISC_SEROUT_OE_REG_BASE);
 	value &= ~BIT(AUD_MISC_SEROUT_MCLK_OE + (aio->portnum * 4));
-	writel(value, aio->cygaud->audio + AUD_MISC_SEROUT_OE_REG_BASE);
+	writel(value, aio->audio + AUD_MISC_SEROUT_OE_REG_BASE);
 
 	return 0;
 }
@@ -883,7 +867,7 @@ static int cygnus_ssp_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 	u32 val;
 	u32 mask;
 
-	dev_dbg(aio->cygaud->dev, "%s Enter  fmt: %x\n", __func__, fmt);
+	dev_dbg(aio->dev, "%s Enter  fmt: %x\n", __func__, fmt);
 
 	if (aio->port_type == PORT_SPDIF)
 		return -EINVAL;
@@ -912,7 +896,7 @@ static int cygnus_ssp_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 			aio->fs_delay = 1;
 		else {
 			if (aio->is_slave) {
-				dev_err(aio->cygaud->dev,
+				dev_err(aio->dev,
 				"%s DSP_B mode not supported while slave.\n",
 					__func__);
 				return -EINVAL;
@@ -929,7 +913,7 @@ static int cygnus_ssp_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 	/* We must be i2s master to invert any clock */
 	if ((fmt & SND_SOC_DAIFMT_INV_MASK) != SND_SOC_DAIFMT_NB_NF) {
 		if (aio->is_slave || (aio->mode == CYGNUS_SSPMODE_TDM)) {
-			dev_err(aio->cygaud->dev,
+			dev_err(aio->dev,
 			"%s Can only invert clocks in i2s master mode\n",
 				__func__);
 			return -EINVAL;
@@ -957,7 +941,7 @@ static int cygnus_ssp_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	val = readl(aio->cygaud->audio + AUD_MISC_SEROUT_OE_REG_BASE);
+	val = readl(aio->audio + AUD_MISC_SEROUT_OE_REG_BASE);
 
 	/*
 	 * Configure the word clk and bit clk as output or tristate
@@ -972,8 +956,8 @@ static int cygnus_ssp_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 	else
 		val &= ~mask;  /* Clear bit for drive */
 
-	dev_dbg(aio->cygaud->dev, "%s  Set OE bits 0x%x\n", __func__, val);
-	writel(val, aio->cygaud->audio + AUD_MISC_SEROUT_OE_REG_BASE);
+	dev_dbg(aio->dev, "%s  Set OE bits 0x%x\n", __func__, val);
+	writel(val, aio->audio + AUD_MISC_SEROUT_OE_REG_BASE);
 
 	return 0;
 }
@@ -983,7 +967,7 @@ static int cygnus_ssp_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct cygnus_aio_port *aio = cygnus_dai_get_portinfo(dai);
 
-	dev_dbg(aio->cygaud->dev,
+	dev_dbg(aio->dev,
 		"%s cmd %d at port = %d\n", __func__, cmd, aio->portnum);
 
 	switch (cmd) {
@@ -1023,8 +1007,7 @@ static int cygnus_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
 	unsigned int i;
 
 	if (tx_mask != rx_mask) {
-		dev_err(aio->cygaud->dev,
-			"%s tx_mask must equal rx_mask\n", __func__);
+		dev_err(aio->dev, "%s tx_mask must equal rx_mask\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1050,8 +1033,7 @@ static int cygnus_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
 	}
 
 	if (!found) {
-		dev_err(aio->cygaud->dev,
-			"%s In TDM mode, frame bits INVALID (%d)\n",
+		dev_err(aio->dev, "%s In TDM mode, frame bits INVALID (%d)\n",
 			__func__, bits_per_frame);
 		return -EINVAL;
 	}
@@ -1060,7 +1042,7 @@ static int cygnus_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
 	aio->slot_width = slot_width;
 	aio->slots_per_frame = slots;
 
-	dev_dbg(aio->cygaud->dev, "%s active_slots %u, bits per frame %d\n",
+	dev_dbg(aio->dev, "%s active_slots %u, bits per frame %d\n",
 			__func__, aio->active_slots, bits_per_frame);
 	return 0;
 }
@@ -1074,7 +1056,7 @@ static int cygnus_ssp_set_pll(struct snd_soc_dai *cpu_dai, int pll_id,
 	int ret = 0;
 
 	if (!aio->clk_info.audio_clk) {
-		dev_err(aio->cygaud->dev,
+		dev_err(aio->dev,
 			"%s: port %d does not have an assigned clock.\n",
 			__func__, aio->portnum);
 		return -ENODEV;
@@ -1082,7 +1064,7 @@ static int cygnus_ssp_set_pll(struct snd_soc_dai *cpu_dai, int pll_id,
 
 	clk_pll = clk_get_parent(aio->clk_info.audio_clk);
 	if (IS_ERR(clk_pll)) {
-		dev_err(aio->cygaud->dev,
+		dev_err(aio->dev,
 			"%s: could not get audiopll clock.\n", __func__);
 		return -ENODEV;
 	}
@@ -1185,7 +1167,7 @@ static void update_ssp_cfg(struct cygnus_aio_port *aio)
 	 * bit set in the Tx formatter (which would be the Tx Formatters
 	 * internal clock or signal from external pin).
 	 */
-	ssp_curcfg = readl(aio->cygaud->i2s_in + aio->regs.i2s_cap_cfg);
+	ssp_curcfg = readl(aio->i2s_in + aio->regs.i2s_cap_cfg);
 	ssp_incfg = (ssp_curcfg & I2S_IN_CFG_REG_UPDATE_MASK) | ssp_newcfg;
 	ssp_incfg |= BIT(I2S_OUT_CFGX_SLAVE_MODE);
 
@@ -1194,13 +1176,13 @@ static void update_ssp_cfg(struct cygnus_aio_port *aio)
 	ssp_incfg &= ~BIT(I2S_OUT_CFGX_BITS_PER_SLOT);
 	ssp_incfg |= (bits_per_slot_in << I2S_OUT_CFGX_BITS_PER_SLOT);
 
-	writel(ssp_incfg, aio->cygaud->i2s_in + aio->regs.i2s_cap_cfg);
+	writel(ssp_incfg, aio->i2s_in + aio->regs.i2s_cap_cfg);
 
 	/*
 	 * SSP out cfg.
 	 * Retain bits we do not want to update, then OR in new bits
 	 */
-	ssp_curcfg = readl(aio->cygaud->audio + aio->regs.i2s_cfg);
+	ssp_curcfg = readl(aio->audio + aio->regs.i2s_cfg);
 	ssp_outcfg = (ssp_curcfg & I2S_OUT_CFG_REG_UPDATE_MASK) | ssp_newcfg;
 
 	ssp_outcfg &= ~(0xf << I2S_OUT_CFGX_VALID_SLOT);
@@ -1208,7 +1190,7 @@ static void update_ssp_cfg(struct cygnus_aio_port *aio)
 	ssp_outcfg &= ~BIT(I2S_OUT_CFGX_BITS_PER_SLOT);
 	ssp_outcfg |= (bits_per_slot_out << I2S_OUT_CFGX_BITS_PER_SLOT);
 
-	writel(ssp_outcfg, aio->cygaud->audio + aio->regs.i2s_cfg);
+	writel(ssp_outcfg, aio->audio + aio->regs.i2s_cfg);
 }
 
 
@@ -1320,7 +1302,9 @@ static int parse_ssp_child_node(struct platform_device *pdev,
 	}
 
 	aio = &cygaud->portinfo[portnum];
-	aio->cygaud = cygaud;
+
+	aio->audio = cygaud->audio;
+	aio->i2s_in = cygaud->i2s_in;
 	aio->portnum = portnum;
 	aio->port_type = port_type;
 	aio->fsync_width = -1;
@@ -1349,8 +1333,7 @@ static int parse_ssp_child_node(struct platform_device *pdev,
 
 	dev_dbg(&pdev->dev, "%s portnum = %d\n", __func__, aio->portnum);
 	aio->streams_on = 0;
-	aio->cygaud->dev = &pdev->dev;
-
+	aio->dev = &pdev->dev;
 
 	aio->clk_info.audio_clk = NULL;
 
@@ -1421,7 +1404,6 @@ static int cygnus_ssp_probe(struct platform_device *pdev)
 	}
 
 	active_port_count = 0;
-
 	for_each_available_child_of_node(pdev->dev.of_node, child_node) {
 		err = parse_ssp_child_node(pdev, child_node, cygaud,
 					&cygnus_ssp_dai[active_port_count]);
diff --git a/sound/soc/bcm/cygnus-ssp.h b/sound/soc/bcm/cygnus-ssp.h
index 648321d..ac346b8 100644
--- a/sound/soc/bcm/cygnus-ssp.h
+++ b/sound/soc/bcm/cygnus-ssp.h
@@ -32,13 +32,13 @@
 #define PROP_LEN_MAX 40
 
 struct ringbuf_regs {
-	unsigned rdaddr;
-	unsigned wraddr;
-	unsigned baseaddr;
-	unsigned endaddr;
-	unsigned fmark;   /* freemark for play, fullmark for caputure */
-	unsigned period_bytes;
-	unsigned buf_size;
+	unsigned int rdaddr;
+	unsigned int wraddr;
+	unsigned int baseaddr;
+	unsigned int endaddr;
+	unsigned int fmark;   /* freemark for play, fullmark for caputure */
+	u32 period_bytes;
+	u32 buf_size;
 };
 
 #define RINGBUF_REG_PLAYBACK(num) ((struct ringbuf_regs) { \
@@ -85,6 +85,8 @@ struct cygnus_audio_clkinfo {
 };
 
 struct cygnus_aio_port {
+	struct device *dev;
+
 	int portnum;
 	int mode;
 	bool is_slave;
@@ -104,7 +106,9 @@ struct cygnus_aio_port {
 	unsigned int slots_per_frame;
 	unsigned int active_slots;
 
-	struct cygnus_audio *cygaud;
+	void __iomem *audio;
+	void __iomem *i2s_in;
+
 	struct cygnus_ssp_regs regs;
 
 	struct ringbuf_regs play_rb_regs;
@@ -122,8 +126,8 @@ struct cygnus_audio {
 
 	int irq_num;
 	void __iomem *audio;
-	struct device *dev;
 	void __iomem *i2s_in;
+	struct device *dev;
 };
 
 extern int cygnus_ssp_set_custom_fsync_width(struct snd_soc_dai *cpu_dai,
-- 
1.9.1
