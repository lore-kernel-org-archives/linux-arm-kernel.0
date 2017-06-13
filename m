From: broonie@kernel.org (Mark Brown)
Date: Tue, 13 Jun 2017 22:07:53 +0100
Subject: Applied "ASoC: rockchip: i2s: add other configurable formats" to the
 asoc tree
In-Reply-To: <1496998369-30556-4-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <E1dKt2X-0000J2-UU@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: i2s: add other configurable formats

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ec2212c4af20d84841ae288a397d8ee9ecec72a0 Mon Sep 17 00:00:00 2001
From: zhangjun <zhangjun@rock-chips.com>
Date: Fri, 9 Jun 2017 16:52:48 +0800
Subject: [PATCH] ASoC: rockchip: i2s: add other configurable formats

simple-audio-card,bitclock-inversion = <1> : bclk falling edge taken
simple-audio-card,format = "dsp_a" : pcm no delay mode
simple-audio-card,format = "dsp_b" : pcm late 1 mode

Signed-off-by: zhangjun <zhangjun@rock-chips.com>
Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 30 ++++++++++++++++++++++++++++--
 sound/soc/rockchip/rockchip_i2s.h |  3 +++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 974915cb4c4f..66a26c56c658 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -204,7 +204,21 @@ static int rockchip_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 
 	regmap_update_bits(i2s->regmap, I2S_CKR, mask, val);
 
-	mask = I2S_TXCR_IBM_MASK;
+	mask = I2S_CKR_CKP_MASK;
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		val = I2S_CKR_CKP_NEG;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		val = I2S_CKR_CKP_POS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(i2s->regmap, I2S_CKR, mask, val);
+
+	mask = I2S_TXCR_IBM_MASK | I2S_TXCR_TFS_MASK | I2S_TXCR_PBM_MASK;
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_RIGHT_J:
 		val = I2S_TXCR_IBM_RSJM;
@@ -215,13 +229,19 @@ static int rockchip_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 	case SND_SOC_DAIFMT_I2S:
 		val = I2S_TXCR_IBM_NORMAL;
 		break;
+	case SND_SOC_DAIFMT_DSP_A: /* PCM no delay mode */
+		val = I2S_TXCR_TFS_PCM;
+		break;
+	case SND_SOC_DAIFMT_DSP_B: /* PCM delay 1 mode */
+		val = I2S_TXCR_TFS_PCM | I2S_TXCR_PBM_MODE(1);
+		break;
 	default:
 		return -EINVAL;
 	}
 
 	regmap_update_bits(i2s->regmap, I2S_TXCR, mask, val);
 
-	mask = I2S_RXCR_IBM_MASK;
+	mask = I2S_RXCR_IBM_MASK | I2S_RXCR_TFS_MASK | I2S_RXCR_PBM_MASK;
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_RIGHT_J:
 		val = I2S_RXCR_IBM_RSJM;
@@ -232,6 +252,12 @@ static int rockchip_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 	case SND_SOC_DAIFMT_I2S:
 		val = I2S_RXCR_IBM_NORMAL;
 		break;
+	case SND_SOC_DAIFMT_DSP_A: /* PCM no delay mode */
+		val = I2S_RXCR_TFS_PCM;
+		break;
+	case SND_SOC_DAIFMT_DSP_B: /* PCM delay 1 mode */
+		val = I2S_RXCR_TFS_PCM | I2S_RXCR_PBM_MODE(1);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/sound/soc/rockchip/rockchip_i2s.h b/sound/soc/rockchip/rockchip_i2s.h
index 31f11fd25393..a7b8527d8a73 100644
--- a/sound/soc/rockchip/rockchip_i2s.h
+++ b/sound/soc/rockchip/rockchip_i2s.h
@@ -41,6 +41,7 @@
 #define I2S_TXCR_TFS_SHIFT	5
 #define I2S_TXCR_TFS_I2S	(0 << I2S_TXCR_TFS_SHIFT)
 #define I2S_TXCR_TFS_PCM	(1 << I2S_TXCR_TFS_SHIFT)
+#define I2S_TXCR_TFS_MASK	(1 << I2S_TXCR_TFS_SHIFT)
 #define I2S_TXCR_VDW_SHIFT	0
 #define I2S_TXCR_VDW(x)		((x - 1) << I2S_TXCR_VDW_SHIFT)
 #define I2S_TXCR_VDW_MASK	(0x1f << I2S_TXCR_VDW_SHIFT)
@@ -70,6 +71,7 @@
 #define I2S_RXCR_TFS_SHIFT	5
 #define I2S_RXCR_TFS_I2S	(0 << I2S_RXCR_TFS_SHIFT)
 #define I2S_RXCR_TFS_PCM	(1 << I2S_RXCR_TFS_SHIFT)
+#define I2S_RXCR_TFS_MASK	(1 << I2S_RXCR_TFS_SHIFT)
 #define I2S_RXCR_VDW_SHIFT	0
 #define I2S_RXCR_VDW(x)		((x - 1) << I2S_RXCR_VDW_SHIFT)
 #define I2S_RXCR_VDW_MASK	(0x1f << I2S_RXCR_VDW_SHIFT)
@@ -91,6 +93,7 @@
 #define I2S_CKR_CKP_SHIFT	26
 #define I2S_CKR_CKP_NEG		(0 << I2S_CKR_CKP_SHIFT)
 #define I2S_CKR_CKP_POS		(1 << I2S_CKR_CKP_SHIFT)
+#define I2S_CKR_CKP_MASK	(1 << I2S_CKR_CKP_SHIFT)
 #define I2S_CKR_RLP_SHIFT	25
 #define I2S_CKR_RLP_NORMAL	(0 << I2S_CKR_RLP_SHIFT)
 #define I2S_CKR_RLP_OPPSITE	(1 << I2S_CKR_RLP_SHIFT)
-- 
2.11.0
