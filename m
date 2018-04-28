From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Sat, 28 Apr 2018 22:51:39 +0200
Subject: [PATCH 2/5] ASoC: cirrus: i2s: Fix {TX|RX}LinCtrlData setup
In-Reply-To: <20180428205142.31921-1-alexander.sverdlin@gmail.com>
References: <20180428205142.31921-1-alexander.sverdlin@gmail.com>
Message-ID: <20180428205142.31921-3-alexander.sverdlin@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to "EP93xx User?s Guide", I2STXLinCtrlData and I2SRXLinCtrlData
registers actually have different format. The only currently used bit
(Left_Right_Justify) has different position. Fix this and simplify the
whole setup taking into account the fact that both registers have zero
default value.

The practical effect of the above is repaired SND_SOC_DAIFMT_RIGHT_J
support (currently unused).

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 sound/soc/cirrus/ep93xx-i2s.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index 38c240c97041..0dc3852c4621 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -51,7 +51,9 @@
 #define EP93XX_I2S_WRDLEN_24		(1 << 0)
 #define EP93XX_I2S_WRDLEN_32		(2 << 0)
 
-#define EP93XX_I2S_LINCTRLDATA_R_JUST	(1 << 2) /* Right justify */
+#define EP93XX_I2S_RXLINCTRLDATA_R_JUST	BIT(1) /* Right justify */
+
+#define EP93XX_I2S_TXLINCTRLDATA_R_JUST	BIT(2) /* Right justify */
 
 #define EP93XX_I2S_CLKCFG_LRS		(1 << 0) /* lrclk polarity */
 #define EP93XX_I2S_CLKCFG_CKP		(1 << 1) /* Bit clock polarity */
@@ -170,25 +172,25 @@ static int ep93xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 				  unsigned int fmt)
 {
 	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(cpu_dai);
-	unsigned int clk_cfg, lin_ctrl;
+	unsigned int clk_cfg;
+	unsigned int txlin_ctrl = 0;
+	unsigned int rxlin_ctrl = 0;
 
 	clk_cfg  = ep93xx_i2s_read_reg(info, EP93XX_I2S_RXCLKCFG);
-	lin_ctrl = ep93xx_i2s_read_reg(info, EP93XX_I2S_RXLINCTRLDATA);
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		clk_cfg |= EP93XX_I2S_CLKCFG_REL;
-		lin_ctrl &= ~EP93XX_I2S_LINCTRLDATA_R_JUST;
 		break;
 
 	case SND_SOC_DAIFMT_LEFT_J:
 		clk_cfg &= ~EP93XX_I2S_CLKCFG_REL;
-		lin_ctrl &= ~EP93XX_I2S_LINCTRLDATA_R_JUST;
 		break;
 
 	case SND_SOC_DAIFMT_RIGHT_J:
 		clk_cfg &= ~EP93XX_I2S_CLKCFG_REL;
-		lin_ctrl |= EP93XX_I2S_LINCTRLDATA_R_JUST;
+		rxlin_ctrl |= EP93XX_I2S_RXLINCTRLDATA_R_JUST;
+		txlin_ctrl |= EP93XX_I2S_TXLINCTRLDATA_R_JUST;
 		break;
 
 	default:
@@ -237,8 +239,8 @@ static int ep93xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	/* Write new register values */
 	ep93xx_i2s_write_reg(info, EP93XX_I2S_RXCLKCFG, clk_cfg);
 	ep93xx_i2s_write_reg(info, EP93XX_I2S_TXCLKCFG, clk_cfg);
-	ep93xx_i2s_write_reg(info, EP93XX_I2S_RXLINCTRLDATA, lin_ctrl);
-	ep93xx_i2s_write_reg(info, EP93XX_I2S_TXLINCTRLDATA, lin_ctrl);
+	ep93xx_i2s_write_reg(info, EP93XX_I2S_RXLINCTRLDATA, rxlin_ctrl);
+	ep93xx_i2s_write_reg(info, EP93XX_I2S_TXLINCTRLDATA, txlin_ctrl);
 	return 0;
 }
 
-- 
2.16.2
