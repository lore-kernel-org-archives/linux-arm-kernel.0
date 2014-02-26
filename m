From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 26 Feb 2014 17:02:04 +0100
Subject: [PATCH 01/15] ASoC: fsl-ssi: Use regmap
In-Reply-To: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
References: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1393430538-32333-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces the ssi specific functions write_ssi, read_ssi and
write_ssi_mask by standard regmap function calls.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/Kconfig   |   1 +
 sound/soc/fsl/fsl_ssi.c | 267 +++++++++++++++++++++++++++---------------------
 sound/soc/fsl/fsl_ssi.h |  50 +++++----
 3 files changed, 176 insertions(+), 142 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 07f8f14..fbaea8a 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -3,6 +3,7 @@ config SND_SOC_FSL_SAI
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 
 config SND_SOC_FSL_SSI
+	select REGMAP_MMIO
 	tristate
 
 config SND_SOC_FSL_SPDIF
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 5428a1f..a77daa5 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -54,25 +54,6 @@
 #include "fsl_ssi.h"
 #include "imx-pcm.h"
 
-#ifdef PPC
-#define read_ssi(addr)			 in_be32(addr)
-#define write_ssi(val, addr)		 out_be32(addr, val)
-#define write_ssi_mask(addr, clear, set) clrsetbits_be32(addr, clear, set)
-#else
-#define read_ssi(addr)			 readl(addr)
-#define write_ssi(val, addr)		 writel(val, addr)
-/*
- * FIXME: Proper locking should be added at write_ssi_mask caller level
- * to ensure this register read/modify/write sequence is race free.
- */
-static inline void write_ssi_mask(u32 __iomem *addr, u32 clear, u32 set)
-{
-	u32 val = readl(addr);
-	val = (val & ~clear) | set;
-	writel(val, addr);
-}
-#endif
-
 /**
  * FSLSSI_I2S_RATES: sample rates supported by the I2S
  *
@@ -134,6 +115,15 @@ struct fsl_ssi_rxtx_reg_val {
 	struct fsl_ssi_reg_val rx;
 	struct fsl_ssi_reg_val tx;
 };
+static const struct regmap_config fsl_ssi_regconfig = {
+	.max_register = CCSR_SSI_SACCDIS,
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+#ifdef PPC
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+#endif
+};
 
 /**
  * fsl_ssi_private: per-SSI private data
@@ -149,7 +139,7 @@ struct fsl_ssi_rxtx_reg_val {
  * @name: name for this device
  */
 struct fsl_ssi_private {
-	struct ccsr_ssi __iomem *ssi;
+	struct regmap *regs;
 	dma_addr_t ssi_phys;
 	unsigned int irq;
 	unsigned int fifo_depth;
@@ -230,7 +220,7 @@ MODULE_DEVICE_TABLE(of, fsl_ssi_ids);
 static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 {
 	struct fsl_ssi_private *ssi_private = dev_id;
-	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	struct regmap *regs = ssi_private->regs;
 	irqreturn_t ret = IRQ_NONE;
 	__be32 sisr;
 	__be32 sisr2;
@@ -258,7 +248,8 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 	   were interrupted for.  We mask it with the Interrupt Enable register
 	   so that we only check for events that we're interested in.
 	 */
-	sisr = read_ssi(&ssi->sisr) & FSLSSI_SISR_MASK;
+	regmap_read(regs, CCSR_SSI_SISR, &sisr);
+	sisr &= FSLSSI_SISR_MASK;
 
 	if (sisr & CCSR_SSI_SISR_RFRC) {
 		ssi_private->stats.rfrc++;
@@ -368,7 +359,7 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 	sisr2 = sisr & sisr_write_mask;
 	/* Clear the bits that we set */
 	if (sisr2)
-		write_ssi(sisr2, &ssi->sisr);
+		regmap_write(regs, CCSR_SSI_SISR, sisr2);
 
 	return ret;
 }
@@ -475,17 +466,26 @@ static void fsl_ssi_debugfs_remove(struct fsl_ssi_private *ssi_private)
 static void fsl_ssi_rxtx_config(struct fsl_ssi_private *ssi_private,
 		bool enable)
 {
-	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	struct regmap *regs = ssi_private->regs;
 	struct fsl_ssi_rxtx_reg_val *vals = &ssi_private->rxtx_reg_val;
 
 	if (enable) {
-		write_ssi_mask(&ssi->sier, 0, vals->rx.sier | vals->tx.sier);
-		write_ssi_mask(&ssi->srcr, 0, vals->rx.srcr | vals->tx.srcr);
-		write_ssi_mask(&ssi->stcr, 0, vals->rx.stcr | vals->tx.stcr);
+		regmap_update_bits(regs, CCSR_SSI_SIER,
+				vals->rx.sier | vals->tx.sier,
+				vals->rx.sier | vals->tx.sier);
+		regmap_update_bits(regs, CCSR_SSI_SRCR,
+				vals->rx.srcr | vals->tx.srcr,
+				vals->rx.srcr | vals->tx.srcr);
+		regmap_update_bits(regs, CCSR_SSI_STCR,
+				vals->rx.stcr | vals->tx.stcr,
+				vals->rx.stcr | vals->tx.stcr);
 	} else {
-		write_ssi_mask(&ssi->srcr, vals->rx.srcr | vals->tx.srcr, 0);
-		write_ssi_mask(&ssi->stcr, vals->rx.stcr | vals->tx.stcr, 0);
-		write_ssi_mask(&ssi->sier, vals->rx.sier | vals->tx.sier, 0);
+		regmap_update_bits(regs, CCSR_SSI_SRCR,
+				vals->rx.srcr | vals->tx.srcr, 0);
+		regmap_update_bits(regs, CCSR_SSI_STCR,
+				vals->rx.stcr | vals->tx.stcr, 0);
+		regmap_update_bits(regs, CCSR_SSI_SIER,
+				vals->rx.sier | vals->tx.sier, 0);
 	}
 }
 
@@ -496,11 +496,14 @@ static void fsl_ssi_rxtx_config(struct fsl_ssi_private *ssi_private,
 static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 		struct fsl_ssi_reg_val *vals)
 {
-	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	struct regmap *regs = ssi_private->regs;
 	struct fsl_ssi_reg_val *avals;
-	u32 scr_val = read_ssi(&ssi->scr);
-	int nr_active_streams = !!(scr_val & CCSR_SSI_SCR_TE) +
-				!!(scr_val & CCSR_SSI_SCR_RE);
+	u32 scr_val;
+	int nr_active_streams;
+
+	regmap_read(regs, CCSR_SSI_SCR, &scr_val);
+	nr_active_streams = !!(scr_val & CCSR_SSI_SCR_TE) +
+			!!(scr_val & CCSR_SSI_SCR_RE);
 
 	/* Find the other direction values rx or tx which we do not want to
 	 * modify */
@@ -512,7 +515,7 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 	/* If vals should be disabled, start with disabling the unit */
 	if (!enable) {
 		u32 scr = vals->scr & (vals->scr ^ avals->scr);
-		write_ssi_mask(&ssi->scr, scr, 0);
+		regmap_update_bits(regs, CCSR_SSI_SCR, scr, 0);
 	}
 
 	/*
@@ -533,9 +536,9 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 	 * (online configuration)
 	 */
 	if (enable) {
-		write_ssi_mask(&ssi->sier, 0, vals->sier);
-		write_ssi_mask(&ssi->srcr, 0, vals->srcr);
-		write_ssi_mask(&ssi->stcr, 0, vals->stcr);
+		regmap_update_bits(regs, CCSR_SSI_SIER, vals->sier, vals->sier);
+		regmap_update_bits(regs, CCSR_SSI_SRCR, vals->srcr, vals->srcr);
+		regmap_update_bits(regs, CCSR_SSI_STCR, vals->stcr, vals->stcr);
 	} else {
 		u32 sier;
 		u32 srcr;
@@ -555,15 +558,15 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 		srcr = vals->srcr & (vals->srcr ^ avals->srcr);
 		stcr = vals->stcr & (vals->stcr ^ avals->stcr);
 
-		write_ssi_mask(&ssi->srcr, srcr, 0);
-		write_ssi_mask(&ssi->stcr, stcr, 0);
-		write_ssi_mask(&ssi->sier, sier, 0);
+		regmap_update_bits(regs, CCSR_SSI_SRCR, srcr, 0);
+		regmap_update_bits(regs, CCSR_SSI_STCR, stcr, 0);
+		regmap_update_bits(regs, CCSR_SSI_SIER, sier, 0);
 	}
 
 config_done:
 	/* Enabling of subunits is done after configuration */
 	if (enable)
-		write_ssi_mask(&ssi->scr, 0, vals->scr);
+		regmap_update_bits(regs, CCSR_SSI_SCR, vals->scr, vals->scr);
 }
 
 
@@ -614,37 +617,38 @@ static void fsl_ssi_setup_reg_vals(struct fsl_ssi_private *ssi_private)
 
 static void fsl_ssi_setup_ac97(struct fsl_ssi_private *ssi_private)
 {
-	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	struct regmap *regs = ssi_private->regs;
 
 	/*
 	 * Setup the clock control register
 	 */
-	write_ssi(CCSR_SSI_SxCCR_WL(17) | CCSR_SSI_SxCCR_DC(13),
-			&ssi->stccr);
-	write_ssi(CCSR_SSI_SxCCR_WL(17) | CCSR_SSI_SxCCR_DC(13),
-			&ssi->srccr);
+	regmap_write(regs, CCSR_SSI_STCCR,
+			CCSR_SSI_SxCCR_WL(17) | CCSR_SSI_SxCCR_DC(13));
+	regmap_write(regs, CCSR_SSI_SRCCR,
+			CCSR_SSI_SxCCR_WL(17) | CCSR_SSI_SxCCR_DC(13));
 
 	/*
 	 * Enable AC97 mode and startup the SSI
 	 */
-	write_ssi(CCSR_SSI_SACNT_AC97EN | CCSR_SSI_SACNT_FV,
-			&ssi->sacnt);
-	write_ssi(0xff, &ssi->saccdis);
-	write_ssi(0x300, &ssi->saccen);
+	regmap_write(regs, CCSR_SSI_SACNT,
+			CCSR_SSI_SACNT_AC97EN | CCSR_SSI_SACNT_FV);
+	regmap_write(regs, CCSR_SSI_SACCDIS, 0xff);
+	regmap_write(regs, CCSR_SSI_SACCEN, 0x300);
 
 	/*
 	 * Enable SSI, Transmit and Receive. AC97 has to communicate with the
 	 * codec before a stream is started.
 	 */
-	write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_SSIEN |
-			CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE);
+	regmap_update_bits(regs, CCSR_SSI_SCR,
+			CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE,
+			CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE);
 
-	write_ssi(CCSR_SSI_SOR_WAIT(3), &ssi->sor);
+	regmap_write(regs, CCSR_SSI_SOR, CCSR_SSI_SOR_WAIT(3));
 }
 
 static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
 {
-	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	struct regmap *regs = ssi_private->regs;
 	u8 wm;
 	int synchronous = ssi_private->cpu_dai_drv.symmetric_rates;
 
@@ -659,7 +663,7 @@ static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
 	 * Section 16.5 of the MPC8610 reference manual says that the SSI needs
 	 * to be disabled before updating the registers we set here.
 	 */
-	write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_SSIEN, 0);
+	regmap_update_bits(regs, CCSR_SSI_SCR, CCSR_SSI_SCR_SSIEN, 0);
 
 	/*
 	 * Program the SSI into I2S Slave Non-Network Synchronous mode. Also
@@ -667,17 +671,19 @@ static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
 	 *
 	 * FIXME: Little-endian samples require a different shift dir
 	 */
-	write_ssi_mask(&ssi->scr,
-		CCSR_SSI_SCR_I2S_MODE_MASK | CCSR_SSI_SCR_SYN,
-		CCSR_SSI_SCR_TFR_CLK_DIS |
-		ssi_private->i2s_mode |
-		(synchronous ? CCSR_SSI_SCR_SYN : 0));
+	regmap_update_bits(regs, CCSR_SSI_SCR,
+			CCSR_SSI_SCR_I2S_MODE_MASK | CCSR_SSI_SCR_SYN |
+			CCSR_SSI_SCR_TFR_CLK_DIS,
+			CCSR_SSI_SCR_TFR_CLK_DIS | ssi_private->i2s_mode |
+			(synchronous ? CCSR_SSI_SCR_SYN : 0));
 
-	write_ssi(CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TFSI |
-			CCSR_SSI_STCR_TEFS | CCSR_SSI_STCR_TSCKP, &ssi->stcr);
+	regmap_write(regs, CCSR_SSI_STCR, CCSR_SSI_STCR_TXBIT0 |
+			CCSR_SSI_STCR_TFSI | CCSR_SSI_STCR_TEFS |
+			CCSR_SSI_STCR_TSCKP);
 
-	write_ssi(CCSR_SSI_SRCR_RXBIT0 | CCSR_SSI_SRCR_RFSI |
-			CCSR_SSI_SRCR_REFS | CCSR_SSI_SRCR_RSCKP, &ssi->srcr);
+	regmap_write(regs, CCSR_SSI_SRCR, CCSR_SSI_SRCR_RXBIT0 |
+			CCSR_SSI_SRCR_RFSI | CCSR_SSI_SRCR_REFS |
+			CCSR_SSI_SRCR_RSCKP);
 
 	/*
 	 * The DC and PM bits are only used if the SSI is the clock master.
@@ -699,9 +705,9 @@ static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
 	else
 		wm = ssi_private->fifo_depth;
 
-	write_ssi(CCSR_SSI_SFCSR_TFWM0(wm) | CCSR_SSI_SFCSR_RFWM0(wm) |
-		CCSR_SSI_SFCSR_TFWM1(wm) | CCSR_SSI_SFCSR_RFWM1(wm),
-		&ssi->sfcsr);
+	regmap_write(regs, CCSR_SSI_SFCSR, CCSR_SSI_SFCSR_TFWM0(wm) |
+			CCSR_SSI_SFCSR_RFWM0(wm) | CCSR_SSI_SFCSR_TFWM1(wm) |
+			CCSR_SSI_SFCSR_RFWM1(wm));
 
 	/*
 	 * For ac97 interrupts are enabled with the startup of the substream
@@ -716,16 +722,19 @@ static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
 	 * cases like I2S mode to call the extra set_tdm_slot() any more.
 	 */
 	if (!ssi_private->imx_ac97) {
-		write_ssi_mask(&ssi->stccr, CCSR_SSI_SxCCR_DC_MASK,
+		regmap_update_bits(regs, CCSR_SSI_STCCR, CCSR_SSI_SxCCR_DC_MASK,
 				CCSR_SSI_SxCCR_DC(2));
-		write_ssi_mask(&ssi->srccr, CCSR_SSI_SxCCR_DC_MASK,
+		regmap_update_bits(regs, CCSR_SSI_SRCCR, CCSR_SSI_SxCCR_DC_MASK,
 				CCSR_SSI_SxCCR_DC(2));
 	}
 
 	if (ssi_private->use_dual_fifo) {
-		write_ssi_mask(&ssi->srcr, 0, CCSR_SSI_SRCR_RFEN1);
-		write_ssi_mask(&ssi->stcr, 0, CCSR_SSI_STCR_TFEN1);
-		write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_TCH_EN);
+		regmap_update_bits(regs, CCSR_SSI_SRCR, CCSR_SSI_SRCR_RFEN1,
+				CCSR_SSI_SRCR_RFEN1);
+		regmap_update_bits(regs, CCSR_SSI_STCR, CCSR_SSI_STCR_TFEN1,
+				CCSR_SSI_STCR_TFEN1);
+		regmap_update_bits(regs, CCSR_SSI_SCR, CCSR_SSI_SCR_TCH_EN,
+				CCSR_SSI_SCR_TCH_EN);
 	}
 
 	return 0;
@@ -788,12 +797,16 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *hw_params, struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
-	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	struct regmap *regs = ssi_private->regs;
 	unsigned int channels = params_channels(hw_params);
 	unsigned int sample_size =
 		snd_pcm_format_width(params_format(hw_params));
 	u32 wl = CCSR_SSI_SxCCR_WL(sample_size);
-	int enabled = read_ssi(&ssi->scr) & CCSR_SSI_SCR_SSIEN;
+	u32 scr_val;
+	int enabled;
+
+	regmap_read(regs, CCSR_SSI_SCR, &scr_val);
+	enabled = scr_val & CCSR_SSI_SCR_SSIEN;
 
 	/*
 	 * If we're in synchronous mode, and the SSI is already enabled,
@@ -815,12 +828,14 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	/* In synchronous mode, the SSI uses STCCR for capture */
 	if ((substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ||
 	    ssi_private->cpu_dai_drv.symmetric_rates)
-		write_ssi_mask(&ssi->stccr, CCSR_SSI_SxCCR_WL_MASK, wl);
+		regmap_update_bits(regs, CCSR_SSI_STCCR, CCSR_SSI_SxCCR_WL_MASK,
+				wl);
 	else
-		write_ssi_mask(&ssi->srccr, CCSR_SSI_SxCCR_WL_MASK, wl);
+		regmap_update_bits(regs, CCSR_SSI_SRCCR, CCSR_SSI_SxCCR_WL_MASK,
+				wl);
 
 	if (!ssi_private->imx_ac97)
-		write_ssi_mask(&ssi->scr,
+		regmap_update_bits(regs, CCSR_SSI_SCR,
 				CCSR_SSI_SCR_NET | CCSR_SSI_SCR_I2S_MODE_MASK,
 				channels == 1 ? 0 : ssi_private->i2s_mode);
 
@@ -833,17 +848,20 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 {
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
-	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	struct regmap *regs = ssi_private->regs;
 	u32 strcr = 0, stcr, srcr, scr, mask;
 
-	scr = read_ssi(&ssi->scr) & ~(CCSR_SSI_SCR_SYN | CCSR_SSI_SCR_I2S_MODE_MASK);
+	regmap_read(regs, CCSR_SSI_SCR, &scr);
+	scr &= ~(CCSR_SSI_SCR_SYN | CCSR_SSI_SCR_I2S_MODE_MASK);
 	scr |= CCSR_SSI_SCR_NET;
 
 	mask = CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TFDIR | CCSR_SSI_STCR_TXDIR |
 		CCSR_SSI_STCR_TSCKP | CCSR_SSI_STCR_TFSI | CCSR_SSI_STCR_TFSL |
 		CCSR_SSI_STCR_TEFS;
-	stcr = read_ssi(&ssi->stcr) & ~mask;
-	srcr = read_ssi(&ssi->srcr) & ~mask;
+	regmap_read(regs, CCSR_SSI_STCR, &stcr);
+	regmap_read(regs, CCSR_SSI_SRCR, &srcr);
+	stcr &= ~mask;
+	srcr &= ~mask;
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
@@ -925,9 +943,9 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		scr |= CCSR_SSI_SCR_SYN;
 	}
 
-	write_ssi(stcr, &ssi->stcr);
-	write_ssi(srcr, &ssi->srcr);
-	write_ssi(scr, &ssi->scr);
+	regmap_write(regs, CCSR_SSI_STCR, stcr);
+	regmap_write(regs, CCSR_SSI_SRCR, srcr);
+	regmap_write(regs, CCSR_SSI_SCR, scr);
 
 	return 0;
 }
@@ -945,7 +963,7 @@ static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 				  int clk_id, unsigned int freq, int dir)
 {
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
-	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	struct regmap *regs = ssi_private->regs;
 	int synchronous = ssi_private->cpu_dai_drv.symmetric_rates, ret;
 	u32 pm = 999, div2, psr, stccr, mask, afreq, factor, i;
 	unsigned long flags, clkrate, baudrate, tmprate;
@@ -1007,9 +1025,9 @@ static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	mask = CCSR_SSI_SxCCR_PM_MASK | CCSR_SSI_SxCCR_DIV2 | CCSR_SSI_SxCCR_PSR;
 
 	if (dir == SND_SOC_CLOCK_OUT || synchronous)
-		write_ssi_mask(&ssi->stccr, mask, stccr);
+		regmap_update_bits(regs, CCSR_SSI_STCCR, mask, stccr);
 	else
-		write_ssi_mask(&ssi->srccr, mask, stccr);
+		regmap_update_bits(regs, CCSR_SSI_SRCCR, mask, stccr);
 
 	spin_lock_irqsave(&ssi_private->baudclk_lock, flags);
 	if (!ssi_private->baudclk_locked) {
@@ -1035,31 +1053,34 @@ static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 				u32 rx_mask, int slots, int slot_width)
 {
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
-	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	struct regmap *regs = ssi_private->regs;
 	u32 val;
 
 	/* The slot number should be >= 2 if using Network mode or I2S mode */
-	val = read_ssi(&ssi->scr) & (CCSR_SSI_SCR_I2S_MODE_MASK | CCSR_SSI_SCR_NET);
+	regmap_read(regs, CCSR_SSI_SCR, &val);
+	val &= CCSR_SSI_SCR_I2S_MODE_MASK | CCSR_SSI_SCR_NET;
 	if (val && slots < 2) {
 		dev_err(cpu_dai->dev, "slot number should be >= 2 in I2S or NET\n");
 		return -EINVAL;
 	}
 
-	write_ssi_mask(&ssi->stccr, CCSR_SSI_SxCCR_DC_MASK,
+	regmap_update_bits(regs, CCSR_SSI_STCCR, CCSR_SSI_SxCCR_DC_MASK,
 			CCSR_SSI_SxCCR_DC(slots));
-	write_ssi_mask(&ssi->srccr, CCSR_SSI_SxCCR_DC_MASK,
+	regmap_update_bits(regs, CCSR_SSI_SRCCR, CCSR_SSI_SxCCR_DC_MASK,
 			CCSR_SSI_SxCCR_DC(slots));
 
 	/* The register SxMSKs needs SSI to provide essential clock due to
 	 * hardware design. So we here temporarily enable SSI to set them.
 	 */
-	val = read_ssi(&ssi->scr) & CCSR_SSI_SCR_SSIEN;
-	write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_SSIEN);
+	regmap_read(regs, CCSR_SSI_SCR, &val);
+	val &= CCSR_SSI_SCR_SSIEN;
+	regmap_update_bits(regs, CCSR_SSI_SCR, CCSR_SSI_SCR_SSIEN,
+			CCSR_SSI_SCR_SSIEN);
 
-	write_ssi(tx_mask, &ssi->stmsk);
-	write_ssi(rx_mask, &ssi->srmsk);
+	regmap_write(regs, CCSR_SSI_STMSK, tx_mask);
+	regmap_write(regs, CCSR_SSI_SRMSK, rx_mask);
 
-	write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_SSIEN, val);
+	regmap_update_bits(regs, CCSR_SSI_SCR, CCSR_SSI_SCR_SSIEN, val);
 
 	return 0;
 }
@@ -1078,8 +1099,9 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(rtd->cpu_dai);
-	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	struct regmap *regs = ssi_private->regs;
 	unsigned long flags;
+	u32 val;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -1097,8 +1119,9 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 		else
 			fsl_ssi_rx_config(ssi_private, false);
 
-		if (!ssi_private->imx_ac97 && (read_ssi(&ssi->scr) &
-					(CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE)) == 0) {
+		regmap_read(regs, CCSR_SSI_SCR, &val);
+		val &= CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE;
+		if (!ssi_private->imx_ac97 && !val) {
 			spin_lock_irqsave(&ssi_private->baudclk_lock, flags);
 			ssi_private->baudclk_locked = false;
 			spin_unlock_irqrestore(&ssi_private->baudclk_lock, flags);
@@ -1111,9 +1134,9 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	if (ssi_private->imx_ac97) {
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			write_ssi(CCSR_SSI_SOR_TX_CLR, &ssi->sor);
+			regmap_write(regs, CCSR_SSI_SOR, CCSR_SSI_SOR_TX_CLR);
 		else
-			write_ssi(CCSR_SSI_SOR_RX_CLR, &ssi->sor);
+			regmap_write(regs, CCSR_SSI_SOR, CCSR_SSI_SOR_RX_CLR);
 	}
 
 	return 0;
@@ -1192,7 +1215,7 @@ static void fsl_ssi_ac97_init(void)
 static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 		unsigned short val)
 {
-	struct ccsr_ssi *ssi = fsl_ac97_data->ssi;
+	struct regmap *regs = fsl_ac97_data->regs;
 	unsigned int lreg;
 	unsigned int lval;
 
@@ -1201,12 +1224,12 @@ static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 
 
 	lreg = reg <<  12;
-	write_ssi(lreg, &ssi->sacadd);
+	regmap_write(regs, CCSR_SSI_SACADD, lreg);
 
 	lval = val << 4;
-	write_ssi(lval , &ssi->sacdat);
+	regmap_write(regs, CCSR_SSI_SACDAT, lval);
 
-	write_ssi_mask(&ssi->sacnt, CCSR_SSI_SACNT_RDWR_MASK,
+	regmap_update_bits(regs, CCSR_SSI_SACNT, CCSR_SSI_SACNT_RDWR_MASK,
 			CCSR_SSI_SACNT_WR);
 	udelay(100);
 }
@@ -1214,19 +1237,21 @@ static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
 		unsigned short reg)
 {
-	struct ccsr_ssi *ssi = fsl_ac97_data->ssi;
+	struct regmap *regs = fsl_ac97_data->regs;
 
 	unsigned short val = -1;
+	u32 reg_val;
 	unsigned int lreg;
 
 	lreg = (reg & 0x7f) <<  12;
-	write_ssi(lreg, &ssi->sacadd);
-	write_ssi_mask(&ssi->sacnt, CCSR_SSI_SACNT_RDWR_MASK,
+	regmap_write(regs, CCSR_SSI_SACADD, lreg);
+	regmap_update_bits(regs, CCSR_SSI_SACNT, CCSR_SSI_SACNT_RDWR_MASK,
 			CCSR_SSI_SACNT_RD);
 
 	udelay(100);
 
-	val = (read_ssi(&ssi->sacdat) >> 4) & 0xffff;
+	regmap_read(regs, CCSR_SSI_SACDAT, &reg_val);
+	val = (reg_val >> 4) & 0xffff;
 
 	return val;
 }
@@ -1262,6 +1287,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	const char *p, *sprop;
 	const uint32_t *iprop;
 	struct resource res;
+	void __iomem *iomem;
 	char name[64];
 	bool shared;
 	bool ac97 = false;
@@ -1322,12 +1348,20 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "could not determine device resources\n");
 		return ret;
 	}
-	ssi_private->ssi = of_iomap(np, 0);
-	if (!ssi_private->ssi) {
+	ssi_private->ssi_phys = res.start;
+
+	iomem = devm_ioremap(&pdev->dev, res.start, resource_size(&res));
+	if (!iomem) {
 		dev_err(&pdev->dev, "could not map device resources\n");
 		return -ENOMEM;
 	}
-	ssi_private->ssi_phys = res.start;
+
+	ssi_private->regs = devm_regmap_init_mmio(&pdev->dev, iomem,
+			&fsl_ssi_regconfig);
+	if (IS_ERR(ssi_private->regs)) {
+		dev_err(&pdev->dev, "Failed to init register map\n");
+		return PTR_ERR(ssi_private->regs);
+	}
 
 	ssi_private->irq = irq_of_parse_and_map(np, 0);
 	if (!ssi_private->irq) {
@@ -1416,9 +1450,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		ssi_private->dma_params_rx.maxburst =
 			ssi_private->fifo_depth - 2;
 		ssi_private->dma_params_tx.addr =
-			ssi_private->ssi_phys + offsetof(struct ccsr_ssi, stx0);
+			ssi_private->ssi_phys + CCSR_SSI_STX0;
 		ssi_private->dma_params_rx.addr =
-			ssi_private->ssi_phys + offsetof(struct ccsr_ssi, srx0);
+			ssi_private->ssi_phys + CCSR_SSI_SRX0;
 		ssi_private->dma_params_tx.filter_data =
 			&ssi_private->filter_data_tx;
 		ssi_private->dma_params_rx.filter_data =
@@ -1488,6 +1522,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	if (ret)
 		goto error_dbgfs;
 
+
 	if (ssi_private->ssi_on_imx) {
 		if (!ssi_private->use_dma) {
 
@@ -1499,7 +1534,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 			 */
 
 			ssi_private->fiq_params.irq = ssi_private->irq;
-			ssi_private->fiq_params.base = ssi_private->ssi;
+			ssi_private->fiq_params.base = iomem;
 			ssi_private->fiq_params.dma_params_rx =
 				&ssi_private->dma_params_rx;
 			ssi_private->fiq_params.dma_params_tx =
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index e6b6324..85f85dc 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -12,32 +12,30 @@
 #ifndef _MPC8610_I2S_H
 #define _MPC8610_I2S_H
 
-/* SSI Register Map */
-struct ccsr_ssi {
-	__be32 stx0;	/* 0x.0000 - SSI Transmit Data Register 0 */
-	__be32 stx1;	/* 0x.0004 - SSI Transmit Data Register 1 */
-	__be32 srx0;	/* 0x.0008 - SSI Receive Data Register 0 */
-	__be32 srx1;	/* 0x.000C - SSI Receive Data Register 1 */
-	__be32 scr;	/* 0x.0010 - SSI Control Register */
-	__be32 sisr;	/* 0x.0014 - SSI Interrupt Status Register Mixed */
-	__be32 sier;	/* 0x.0018 - SSI Interrupt Enable Register */
-	__be32 stcr;	/* 0x.001C - SSI Transmit Configuration Register */
-	__be32 srcr;	/* 0x.0020 - SSI Receive Configuration Register */
-	__be32 stccr;	/* 0x.0024 - SSI Transmit Clock Control Register */
-	__be32 srccr;	/* 0x.0028 - SSI Receive Clock Control Register */
-	__be32 sfcsr;	/* 0x.002C - SSI FIFO Control/Status Register */
-	__be32 str;	/* 0x.0030 - SSI Test Register */
-	__be32 sor;	/* 0x.0034 - SSI Option Register */
-	__be32 sacnt;	/* 0x.0038 - SSI AC97 Control Register */
-	__be32 sacadd;	/* 0x.003C - SSI AC97 Command Address Register */
-	__be32 sacdat;	/* 0x.0040 - SSI AC97 Command Data Register */
-	__be32 satag;	/* 0x.0044 - SSI AC97 Tag Register */
-	__be32 stmsk;	/* 0x.0048 - SSI Transmit Time Slot Mask Register */
-	__be32 srmsk;	/* 0x.004C - SSI Receive Time Slot Mask Register */
-	__be32 saccst;	/* 0x.0050 - SSI AC97 Channel Status Register */
-	__be32 saccen;	/* 0x.0054 - SSI AC97 Channel Enable Register */
-	__be32 saccdis; /* 0x.0058 - SSI AC97 Channel Disable Register */
-};
+/* SSI registers */
+#define CCSR_SSI_STX0			0x00
+#define CCSR_SSI_STX1			0x04
+#define CCSR_SSI_SRX0			0x08
+#define CCSR_SSI_SRX1			0x0c
+#define CCSR_SSI_SCR			0x10
+#define CCSR_SSI_SISR			0x14
+#define CCSR_SSI_SIER			0x18
+#define CCSR_SSI_STCR			0x1c
+#define CCSR_SSI_SRCR			0x20
+#define CCSR_SSI_STCCR			0x24
+#define CCSR_SSI_SRCCR			0x28
+#define CCSR_SSI_SFCSR			0x2c
+#define CCSR_SSI_STR			0x30
+#define CCSR_SSI_SOR			0x34
+#define CCSR_SSI_SACNT			0x38
+#define CCSR_SSI_SACADD			0x3c
+#define CCSR_SSI_SACDAT			0x40
+#define CCSR_SSI_SATAG			0x44
+#define CCSR_SSI_STMSK			0x48
+#define CCSR_SSI_SRMSK			0x4c
+#define CCSR_SSI_SACCST			0x50
+#define CCSR_SSI_SACCEN			0x54
+#define CCSR_SSI_SACCDIS		0x58
 
 #define CCSR_SSI_SCR_RFR_CLK_DIS	0x00000800
 #define CCSR_SSI_SCR_TFR_CLK_DIS	0x00000400
-- 
1.8.5.3
