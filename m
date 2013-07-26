From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 26 Jul 2013 19:06:48 +0530
Subject: [PATCH V2 4/8] ASoC: Samsung: I2S: Modify driver to give more
 flexibility
In-Reply-To: <1374845812-7803-1-git-send-email-padma.v@samsung.com>
References: <1374845812-7803-1-git-send-email-padma.v@samsung.com>
Message-ID: <1374845812-7803-5-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies the i2s driver to give flexibility towards register
handling. This is a pre requirement for enabling i2s support on Exynos5420.
This patch modifies only the required registers as a pre-requirement to
support on Exynos5420.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 sound/soc/samsung/i2s-regs.h |   36 ++++++++++++++-----------
 sound/soc/samsung/i2s.c      |   58 +++++++++++++++++++++++++----------------
 2 files changed, 55 insertions(+), 39 deletions(-)

diff --git a/sound/soc/samsung/i2s-regs.h b/sound/soc/samsung/i2s-regs.h
index c0e6d9a..30513b7 100644
--- a/sound/soc/samsung/i2s-regs.h
+++ b/sound/soc/samsung/i2s-regs.h
@@ -95,22 +95,26 @@
 #define MOD_RXONLY		(1 << 8)
 #define MOD_TXRX		(2 << 8)
 #define MOD_MASK		(3 << 8)
-#define MOD_LR_LLOW		(0 << 7)
-#define MOD_LR_RLOW		(1 << 7)
-#define MOD_SDF_IIS		(0 << 5)
-#define MOD_SDF_MSB		(1 << 5)
-#define MOD_SDF_LSB		(2 << 5)
-#define MOD_SDF_MASK		(3 << 5)
-#define MOD_RCLK_256FS		(0 << 3)
-#define MOD_RCLK_512FS		(1 << 3)
-#define MOD_RCLK_384FS		(2 << 3)
-#define MOD_RCLK_768FS		(3 << 3)
-#define MOD_RCLK_MASK		(3 << 3)
-#define MOD_BCLK_32FS		(0 << 1)
-#define MOD_BCLK_48FS		(1 << 1)
-#define MOD_BCLK_16FS		(2 << 1)
-#define MOD_BCLK_24FS		(3 << 1)
-#define MOD_BCLK_MASK		(3 << 1)
+#define MOD_LRP_SHIFT		7
+#define MOD_LR_LLOW		0
+#define MOD_LR_RLOW		1
+#define MOD_SDF_SHIFT		5
+#define MOD_SDF_IIS		0
+#define MOD_SDF_MSB		1
+#define MOD_SDF_LSB		2
+#define MOD_SDF_MASK		3
+#define MOD_RCLK_SHIFT		3
+#define MOD_RCLK_256FS		0
+#define MOD_RCLK_512FS		1
+#define MOD_RCLK_384FS		2
+#define MOD_RCLK_768FS		3
+#define MOD_RCLK_MASK		3
+#define MOD_BCLK_SHIFT		1
+#define MOD_BCLK_32FS		0
+#define MOD_BCLK_48FS		1
+#define MOD_BCLK_16FS		2
+#define MOD_BCLK_24FS		3
+#define MOD_BCLK_MASK		3
 #define MOD_8BIT		(1 << 0)
 
 #define MOD_CDCLKCON		(1 << 12)
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index f661a98..0b36b0a 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -199,7 +199,8 @@ static inline bool is_manager(struct i2s_dai *i2s)
 /* Read RCLK of I2S (in multiples of LRCLK) */
 static inline unsigned get_rfs(struct i2s_dai *i2s)
 {
-	u32 rfs = (readl(i2s->addr + I2SMOD) >> 3) & 0x3;
+	u32 rfs = (readl(i2s->addr + I2SMOD) >> MOD_RCLK_SHIFT);
+	rfs &= MOD_RCLK_MASK;
 
 	switch (rfs) {
 	case 3:	return 768;
@@ -213,21 +214,22 @@ static inline unsigned get_rfs(struct i2s_dai *i2s)
 static inline void set_rfs(struct i2s_dai *i2s, unsigned rfs)
 {
 	u32 mod = readl(i2s->addr + I2SMOD);
+	int rfs_shift =  MOD_RCLK_SHIFT;
 
-	mod &= ~MOD_RCLK_MASK;
+	mod &= ~(MOD_RCLK_MASK << rfs_shift);
 
 	switch (rfs) {
 	case 768:
-		mod |= MOD_RCLK_768FS;
+		mod |= (MOD_RCLK_768FS << rfs_shift);
 		break;
 	case 512:
-		mod |= MOD_RCLK_512FS;
+		mod |= (MOD_RCLK_512FS << rfs_shift);
 		break;
 	case 384:
-		mod |= MOD_RCLK_384FS;
+		mod |= (MOD_RCLK_384FS << rfs_shift);
 		break;
 	default:
-		mod |= MOD_RCLK_256FS;
+		mod |= (MOD_RCLK_256FS << rfs_shift);
 		break;
 	}
 
@@ -237,7 +239,8 @@ static inline void set_rfs(struct i2s_dai *i2s, unsigned rfs)
 /* Read Bit-Clock of I2S (in multiples of LRCLK) */
 static inline unsigned get_bfs(struct i2s_dai *i2s)
 {
-	u32 bfs = (readl(i2s->addr + I2SMOD) >> 1) & 0x3;
+	u32 bfs =  readl(i2s->addr + I2SMOD) >> MOD_BCLK_SHIFT;
+	bfs &= MOD_BCLK_MASK;
 
 	switch (bfs) {
 	case 3: return 24;
@@ -251,21 +254,22 @@ static inline unsigned get_bfs(struct i2s_dai *i2s)
 static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
 {
 	u32 mod = readl(i2s->addr + I2SMOD);
+	int bfs_shift = MOD_BCLK_SHIFT;
 
-	mod &= ~MOD_BCLK_MASK;
+	mod &= ~(MOD_BCLK_MASK << bfs_shift);
 
 	switch (bfs) {
 	case 48:
-		mod |= MOD_BCLK_48FS;
+		mod |= (MOD_BCLK_48FS << bfs_shift);
 		break;
 	case 32:
-		mod |= MOD_BCLK_32FS;
+		mod |= (MOD_BCLK_32FS << bfs_shift);
 		break;
 	case 24:
-		mod |= MOD_BCLK_24FS;
+		mod |= (MOD_BCLK_24FS << bfs_shift);
 		break;
 	case 16:
-		mod |= MOD_BCLK_16FS;
+		mod |= (MOD_BCLK_16FS << bfs_shift);
 		break;
 	default:
 		dev_err(&i2s->pdev->dev, "Wrong BCLK Divider!\n");
@@ -492,20 +496,25 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 {
 	struct i2s_dai *i2s = to_info(dai);
 	u32 mod = readl(i2s->addr + I2SMOD);
+	int lrp_shift = MOD_LRP_SHIFT, sdf_shift = MOD_SDF_SHIFT;
+	int sdf_mask, lrp_rlow;
 	u32 tmp = 0;
 
+	sdf_mask = MOD_SDF_MASK << sdf_shift;
+	lrp_rlow = MOD_LR_RLOW << lrp_shift;
+
 	/* Format is priority */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_RIGHT_J:
-		tmp |= MOD_LR_RLOW;
-		tmp |= MOD_SDF_MSB;
+		tmp |= lrp_rlow;
+		tmp |= (MOD_SDF_MSB << sdf_shift);
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
-		tmp |= MOD_LR_RLOW;
-		tmp |= MOD_SDF_LSB;
+		tmp |= lrp_rlow;
+		tmp |= (MOD_SDF_LSB << sdf_shift);
 		break;
 	case SND_SOC_DAIFMT_I2S:
-		tmp |= MOD_SDF_IIS;
+		tmp |= (MOD_SDF_IIS << sdf_shift);
 		break;
 	default:
 		dev_err(&i2s->pdev->dev, "Format not supported\n");
@@ -520,10 +529,10 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 	case SND_SOC_DAIFMT_NB_NF:
 		break;
 	case SND_SOC_DAIFMT_NB_IF:
-		if (tmp & MOD_LR_RLOW)
-			tmp &= ~MOD_LR_RLOW;
+		if (tmp & lrp_rlow)
+			tmp &= ~lrp_rlow;
 		else
-			tmp |= MOD_LR_RLOW;
+			tmp |= lrp_rlow;
 		break;
 	default:
 		dev_err(&i2s->pdev->dev, "Polarity not supported\n");
@@ -545,15 +554,18 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
+	/*
+	 * Don't change the I2S mode if any controller is active on this
+	 * channel.
+	 */
 	if (any_active(i2s) &&
-			((mod & (MOD_SDF_MASK | MOD_LR_RLOW
-				| MOD_SLAVE)) != tmp)) {
+		((mod & (sdf_mask | lrp_rlow | MOD_SLAVE)) != tmp)) {
 		dev_err(&i2s->pdev->dev,
 				"%s:%d Other DAI busy\n", __func__, __LINE__);
 		return -EAGAIN;
 	}
 
-	mod &= ~(MOD_SDF_MASK | MOD_LR_RLOW | MOD_SLAVE);
+	mod &= ~(sdf_mask | lrp_rlow | MOD_SLAVE);
 	mod |= tmp;
 	writel(mod, i2s->addr + I2SMOD);
 
-- 
1.7.4.4
