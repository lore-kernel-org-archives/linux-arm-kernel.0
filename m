From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 14 Jan 2015 19:42:36 +0100
Subject: [PATCH V3 09/15] ASoC: samsung: i2s: Protect more registers with a
 spinlock
In-Reply-To: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
References: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1421260962-16892-10-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure the I2SMOD, I2SPSR registers, which are also exposed through
clk API are only accessed with the i2s->spinlock spinlock held.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c |   81 +++++++++++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 30 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 20cc51f..05fc2f0 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -472,17 +472,22 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 {
 	struct i2s_dai *i2s = to_info(dai);
 	struct i2s_dai *other = get_other_dai(i2s);
-	u32 mod = readl(i2s->addr + I2SMOD);
 	const struct samsung_i2s_variant_regs *i2s_regs = i2s->variant_regs;
 	unsigned int cdcon_mask = 1 << i2s_regs->cdclkcon_off;
 	unsigned int rsrc_mask = 1 << i2s_regs->rclksrc_off;
+	u32 mod, mask, val = 0;
+
+	spin_lock(i2s->lock);
+	mod = readl(i2s->addr + I2SMOD);
+	spin_unlock(i2s->lock);
 
 	switch (clk_id) {
 	case SAMSUNG_I2S_OPCLK:
-		mod &= ~MOD_OPCLK_MASK;
-		mod |= dir;
+		mask = MOD_OPCLK_MASK;
+		val = dir;
 		break;
 	case SAMSUNG_I2S_CDCLK:
+		mask = 1 << i2s_regs->cdclkcon_off;
 		/* Shouldn't matter in GATING(CLOCK_IN) mode */
 		if (dir == SND_SOC_CLOCK_IN)
 			rfs = 0;
@@ -499,15 +504,15 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 		}
 
 		if (dir == SND_SOC_CLOCK_IN)
-			mod |= 1 << i2s_regs->cdclkcon_off;
-		else
-			mod &= ~(1 << i2s_regs->cdclkcon_off);
+			val = 1 << i2s_regs->cdclkcon_off;
 
 		i2s->rfs = rfs;
 		break;
 
 	case SAMSUNG_I2S_RCLKSRC_0: /* clock corrsponding to IISMOD[10] := 0 */
 	case SAMSUNG_I2S_RCLKSRC_1: /* clock corrsponding to IISMOD[10] := 1 */
+		mask = 1 << i2s_regs->rclksrc_off;
+
 		if ((i2s->quirks & QUIRK_NO_MUXPSR)
 				|| (clk_id == SAMSUNG_I2S_RCLKSRC_0))
 			clk_id = 0;
@@ -557,18 +562,19 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 			return 0;
 		}
 
-		if (clk_id == 0)
-			mod &= ~(1 << i2s_regs->rclksrc_off);
-		else
-			mod |= 1 << i2s_regs->rclksrc_off;
-
+		if (clk_id == 1)
+			val = 1 << i2s_regs->rclksrc_off;
 		break;
 	default:
 		dev_err(&i2s->pdev->dev, "We don't serve that!\n");
 		return -EINVAL;
 	}
 
+	spin_lock(i2s->lock);
+	mod = readl(i2s->addr + I2SMOD);
+	mod = (mod & ~mask) | val;
 	writel(mod, i2s->addr + I2SMOD);
+	spin_unlock(i2s->lock);
 
 	return 0;
 }
@@ -577,9 +583,8 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 	unsigned int fmt)
 {
 	struct i2s_dai *i2s = to_info(dai);
-	u32 mod = readl(i2s->addr + I2SMOD);
 	int lrp_shift, sdf_shift, sdf_mask, lrp_rlow, mod_slave;
-	u32 tmp = 0;
+	u32 mod, tmp = 0;
 
 	lrp_shift = i2s->variant_regs->lrp_off;
 	sdf_shift = i2s->variant_regs->sdf_off;
@@ -639,12 +644,15 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
+	spin_lock(i2s->lock);
+	mod = readl(i2s->addr + I2SMOD);
 	/*
 	 * Don't change the I2S mode if any controller is active on this
 	 * channel.
 	 */
 	if (any_active(i2s) &&
 		((mod & (sdf_mask | lrp_rlow | mod_slave)) != tmp)) {
+		spin_unlock(i2s->lock);
 		dev_err(&i2s->pdev->dev,
 				"%s:%d Other DAI busy\n", __func__, __LINE__);
 		return -EAGAIN;
@@ -653,6 +661,7 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 	mod &= ~(sdf_mask | lrp_rlow | mod_slave);
 	mod |= tmp;
 	writel(mod, i2s->addr + I2SMOD);
+	spin_unlock(i2s->lock);
 
 	return 0;
 }
@@ -661,16 +670,16 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
 	struct i2s_dai *i2s = to_info(dai);
-	u32 mod = readl(i2s->addr + I2SMOD);
+	u32 mod, mask = 0, val = 0;
 
 	if (!is_secondary(i2s))
-		mod &= ~(MOD_DC2_EN | MOD_DC1_EN);
+		mask |= (MOD_DC2_EN | MOD_DC1_EN);
 
 	switch (params_channels(params)) {
 	case 6:
-		mod |= MOD_DC2_EN;
+		val |= MOD_DC2_EN;
 	case 4:
-		mod |= MOD_DC1_EN;
+		val |= MOD_DC1_EN;
 		break;
 	case 2:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -692,44 +701,49 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (is_secondary(i2s))
-		mod &= ~MOD_BLCS_MASK;
+		mask |= MOD_BLCS_MASK;
 	else
-		mod &= ~MOD_BLCP_MASK;
+		mask |= MOD_BLCP_MASK;
 
 	if (is_manager(i2s))
-		mod &= ~MOD_BLC_MASK;
+		mask |= MOD_BLC_MASK;
 
 	switch (params_width(params)) {
 	case 8:
 		if (is_secondary(i2s))
-			mod |= MOD_BLCS_8BIT;
+			val |= MOD_BLCS_8BIT;
 		else
-			mod |= MOD_BLCP_8BIT;
+			val |= MOD_BLCP_8BIT;
 		if (is_manager(i2s))
-			mod |= MOD_BLC_8BIT;
+			val |= MOD_BLC_8BIT;
 		break;
 	case 16:
 		if (is_secondary(i2s))
-			mod |= MOD_BLCS_16BIT;
+			val |= MOD_BLCS_16BIT;
 		else
-			mod |= MOD_BLCP_16BIT;
+			val |= MOD_BLCP_16BIT;
 		if (is_manager(i2s))
-			mod |= MOD_BLC_16BIT;
+			val |= MOD_BLC_16BIT;
 		break;
 	case 24:
 		if (is_secondary(i2s))
-			mod |= MOD_BLCS_24BIT;
+			val |= MOD_BLCS_24BIT;
 		else
-			mod |= MOD_BLCP_24BIT;
+			val |= MOD_BLCP_24BIT;
 		if (is_manager(i2s))
-			mod |= MOD_BLC_24BIT;
+			val |= MOD_BLC_24BIT;
 		break;
 	default:
 		dev_err(&i2s->pdev->dev, "Format(%d) not supported\n",
 				params_format(params));
 		return -EINVAL;
 	}
+
+	spin_lock(i2s->lock);
+	mod = readl(i2s->addr + I2SMOD);
+	mod = (mod & ~mask) | val;
 	writel(mod, i2s->addr + I2SMOD);
+	spin_unlock(i2s->lock);
 
 	samsung_asoc_init_dma_data(dai, &i2s->dma_playback, &i2s->dma_capture);
 
@@ -979,6 +993,7 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 {
 	struct i2s_dai *i2s = to_info(dai);
 	struct i2s_dai *other = get_other_dai(i2s);
+	unsigned long flags;
 
 	if (is_secondary(i2s)) { /* If this is probe on the secondary DAI */
 		samsung_asoc_init_dma_data(dai, &other->sec_dai->dma_playback,
@@ -999,11 +1014,14 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 	i2s->rfs = 0;
 	i2s->bfs = 0;
 	i2s->rclk_srcrate = 0;
+
+	spin_lock_irqsave(i2s->lock, flags);
 	i2s_txctrl(i2s, 0);
 	i2s_rxctrl(i2s, 0);
 	i2s_fifo(i2s, FIC_TXFLUSH);
 	i2s_fifo(other, FIC_TXFLUSH);
 	i2s_fifo(i2s, FIC_RXFLUSH);
+	spin_unlock_irqrestore(i2s->lock, flags);
 
 	/* Gate CDCLK by default */
 	if (!is_opened(other))
@@ -1018,8 +1036,11 @@ static int samsung_i2s_dai_remove(struct snd_soc_dai *dai)
 	struct i2s_dai *i2s = snd_soc_dai_get_drvdata(dai);
 
 	if (!is_secondary(i2s)) {
-		if (i2s->quirks & QUIRK_NEED_RSTCLR)
+		if (i2s->quirks & QUIRK_NEED_RSTCLR) {
+			spin_lock(i2s->lock);
 			writel(0, i2s->addr + I2SCON);
+			spin_unlock(i2s->lock);
+		}
 	}
 
 	return 0;
-- 
1.7.9.5
