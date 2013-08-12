From: padma.v@samsung.com (Padmavathi Venna)
Date: Mon, 12 Aug 2013 15:19:52 +0530
Subject: [PATCH V4 2/4] ASoC: Samsung: I2S: Modify the I2S driver to support
 I2S on Exynos5420
In-Reply-To: <1376300994-1679-1-git-send-email-padma.v@samsung.com>
References: <1376300994-1679-1-git-send-email-padma.v@samsung.com>
Message-ID: <1376300994-1679-3-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos5420 added support for I2S TDM mode. For this, there are some
register changes in the I2S controller. This patch adds the relevant
register changes to support I2S in normal mode. This patch adds a
quirk for TDM mode and if TDM mode is present all the relevent changes
will be applied.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 .../devicetree/bindings/sound/samsung-i2s.txt      |    4 +
 include/linux/platform_data/asoc-s3c.h             |    1 +
 sound/soc/samsung/i2s-regs.h                       |   15 ++++
 sound/soc/samsung/i2s.c                            |   81 ++++++++++++++++++--
 4 files changed, 93 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.txt b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
index 25a0024..7386d44 100644
--- a/Documentation/devicetree/bindings/sound/samsung-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
@@ -6,6 +6,10 @@ Required SoC Specific Properties:
    - samsung,s3c6410-i2s: for 8/16/24bit stereo I2S.
    - samsung,s5pv210-i2s: for 8/16/24bit multichannel(5.1) I2S with
      secondary fifo, s/w reset control and internal mux for root clk src.
+   - samsung,exynos5420-i2s: for 8/16/24bit multichannel(7.1) I2S with
+     secondary fifo, s/w reset control, internal mux for root clk src and
+     TDM support. TDM (Time division multiplexing) is to allow transfer of
+     multiple channel audio data on single data line.
 
 - reg: physical base address of the controller and length of memory mapped
   region.
diff --git a/include/linux/platform_data/asoc-s3c.h b/include/linux/platform_data/asoc-s3c.h
index 8827259..9efc04d 100644
--- a/include/linux/platform_data/asoc-s3c.h
+++ b/include/linux/platform_data/asoc-s3c.h
@@ -36,6 +36,7 @@ struct samsung_i2s {
  */
 #define QUIRK_NO_MUXPSR		(1 << 2)
 #define QUIRK_NEED_RSTCLR	(1 << 3)
+#define QUIRK_SUPPORTS_TDM	(1 << 4)
 	/* Quirks of the I2S controller */
 	u32 quirks;
 	dma_addr_t idma_addr;
diff --git a/sound/soc/samsung/i2s-regs.h b/sound/soc/samsung/i2s-regs.h
index 30513b7..821a502 100644
--- a/sound/soc/samsung/i2s-regs.h
+++ b/sound/soc/samsung/i2s-regs.h
@@ -31,6 +31,10 @@
 #define I2SLVL1ADDR	0x34
 #define I2SLVL2ADDR	0x38
 #define I2SLVL3ADDR	0x3c
+#define I2SSTR1		0x40
+#define I2SVER		0x44
+#define I2SFIC2		0x48
+#define I2STDM		0x4c
 
 #define CON_RSTCLR		(1 << 31)
 #define CON_FRXOFSTATUS		(1 << 26)
@@ -117,6 +121,17 @@
 #define MOD_BCLK_MASK		3
 #define MOD_8BIT		(1 << 0)
 
+#define EXYNOS5420_MOD_LRP_SHIFT	15
+#define EXYNOS5420_MOD_SDF_SHIFT	6
+#define EXYNOS5420_MOD_RCLK_SHIFT	4
+#define EXYNOS5420_MOD_BCLK_SHIFT	0
+#define EXYNOS5420_MOD_BCLK_64FS	4
+#define EXYNOS5420_MOD_BCLK_96FS	5
+#define EXYNOS5420_MOD_BCLK_128FS	6
+#define EXYNOS5420_MOD_BCLK_192FS	7
+#define EXYNOS5420_MOD_BCLK_256FS	8
+#define EXYNOS5420_MOD_BCLK_MASK	0xf
+
 #define MOD_CDCLKCON		(1 << 12)
 
 #define PSR_PSREN		(1 << 15)
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 1671d9b..ce487c2 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -199,7 +199,12 @@ static inline bool is_manager(struct i2s_dai *i2s)
 /* Read RCLK of I2S (in multiples of LRCLK) */
 static inline unsigned get_rfs(struct i2s_dai *i2s)
 {
-	u32 rfs = (readl(i2s->addr + I2SMOD) >> MOD_RCLK_SHIFT);
+	u32 rfs;
+
+	if (i2s->quirks & QUIRK_SUPPORTS_TDM)
+		rfs = readl(i2s->addr + I2SMOD) >> EXYNOS5420_MOD_RCLK_SHIFT;
+	else
+		rfs = (readl(i2s->addr + I2SMOD) >> MOD_RCLK_SHIFT);
 	rfs &= MOD_RCLK_MASK;
 
 	switch (rfs) {
@@ -214,8 +219,12 @@ static inline unsigned get_rfs(struct i2s_dai *i2s)
 static inline void set_rfs(struct i2s_dai *i2s, unsigned rfs)
 {
 	u32 mod = readl(i2s->addr + I2SMOD);
-	int rfs_shift =  MOD_RCLK_SHIFT;
+	int rfs_shift;
 
+	if (i2s->quirks & QUIRK_SUPPORTS_TDM)
+		rfs_shift = EXYNOS5420_MOD_RCLK_SHIFT;
+	else
+		rfs_shift = MOD_RCLK_SHIFT;
 	mod &= ~(MOD_RCLK_MASK << rfs_shift);
 
 	switch (rfs) {
@@ -239,10 +248,22 @@ static inline void set_rfs(struct i2s_dai *i2s, unsigned rfs)
 /* Read Bit-Clock of I2S (in multiples of LRCLK) */
 static inline unsigned get_bfs(struct i2s_dai *i2s)
 {
-	u32 bfs =  readl(i2s->addr + I2SMOD) >> MOD_BCLK_SHIFT;
-	bfs &= MOD_BCLK_MASK;
+	u32 bfs;
+
+	if (i2s->quirks & QUIRK_SUPPORTS_TDM) {
+		bfs = readl(i2s->addr + I2SMOD) >> EXYNOS5420_MOD_BCLK_SHIFT;
+		bfs &= EXYNOS5420_MOD_BCLK_MASK;
+	} else {
+		bfs =  readl(i2s->addr + I2SMOD) >> MOD_BCLK_SHIFT;
+		bfs &= MOD_BCLK_MASK;
+	}
 
 	switch (bfs) {
+	case 8: return 256;
+	case 7: return 192;
+	case 6: return 128;
+	case 5: return 96;
+	case 4: return 64;
 	case 3: return 24;
 	case 2: return 16;
 	case 1:	return 48;
@@ -254,9 +275,22 @@ static inline unsigned get_bfs(struct i2s_dai *i2s)
 static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
 {
 	u32 mod = readl(i2s->addr + I2SMOD);
-	int bfs_shift = MOD_BCLK_SHIFT;
+	int bfs_shift;
+	int tdm = i2s->quirks & QUIRK_SUPPORTS_TDM;
 
-	mod &= ~(MOD_BCLK_MASK << bfs_shift);
+	if (i2s->quirks & QUIRK_SUPPORTS_TDM) {
+		bfs_shift = EXYNOS5420_MOD_BCLK_SHIFT;
+		mod &= ~(EXYNOS5420_MOD_BCLK_MASK << bfs_shift);
+	} else {
+		bfs_shift = MOD_BCLK_SHIFT;
+		mod &= ~(MOD_BCLK_MASK << bfs_shift);
+	}
+
+	/* Non-TDM I2S controllers do not support BCLK > 48 * FS */
+	if (!tdm && bfs > 48) {
+		dev_err(&i2s->pdev->dev, "Unsupported BCLK divider\n");
+		return;
+	}
 
 	switch (bfs) {
 	case 48:
@@ -271,6 +305,21 @@ static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
 	case 16:
 		mod |= (MOD_BCLK_16FS << bfs_shift);
 		break;
+	case 64:
+		mod |= (EXYNOS5420_MOD_BCLK_64FS << bfs_shift);
+		break;
+	case 96:
+		mod |= (EXYNOS5420_MOD_BCLK_96FS << bfs_shift);
+		break;
+	case 128:
+		mod |= (EXYNOS5420_MOD_BCLK_128FS << bfs_shift);
+		break;
+	case 192:
+		mod |= (EXYNOS5420_MOD_BCLK_192FS << bfs_shift);
+		break;
+	case 256:
+		mod |= (EXYNOS5420_MOD_BCLK_256FS << bfs_shift);
+		break;
 	default:
 		dev_err(&i2s->pdev->dev, "Wrong BCLK Divider!\n");
 		return;
@@ -496,10 +545,17 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 {
 	struct i2s_dai *i2s = to_info(dai);
 	u32 mod = readl(i2s->addr + I2SMOD);
-	int lrp_shift = MOD_LRP_SHIFT, sdf_shift = MOD_SDF_SHIFT;
-	int sdf_mask, lrp_rlow;
+	int lrp_shift, sdf_shift, sdf_mask, lrp_rlow;
 	u32 tmp = 0;
 
+	if (i2s->quirks & QUIRK_SUPPORTS_TDM) {
+		lrp_shift = EXYNOS5420_MOD_LRP_SHIFT;
+		sdf_shift = EXYNOS5420_MOD_SDF_SHIFT;
+	} else {
+		lrp_shift = MOD_LRP_SHIFT;
+		sdf_shift = MOD_SDF_SHIFT;
+	}
+
 	sdf_mask = MOD_SDF_MASK << sdf_shift;
 	lrp_rlow = MOD_LR_RLOW << lrp_shift;
 
@@ -1253,6 +1309,12 @@ static const struct samsung_i2s_dai_data i2sv5_dai_type = {
 	.quirks = QUIRK_PRI_6CHAN | QUIRK_SEC_DAI | QUIRK_NEED_RSTCLR,
 };
 
+static const struct samsung_i2s_dai_data i2sv6_dai_type = {
+	.dai_type = TYPE_PRI,
+	.quirks = QUIRK_PRI_6CHAN | QUIRK_SEC_DAI | QUIRK_NEED_RSTCLR |
+			QUIRK_SUPPORTS_TDM,
+};
+
 static const struct samsung_i2s_dai_data samsung_dai_type_pri = {
 	.dai_type = TYPE_PRI,
 };
@@ -1281,6 +1343,9 @@ static const struct of_device_id exynos_i2s_match[] = {
 	}, {
 		.compatible = "samsung,s5pv210-i2s",
 		.data = &i2sv5_dai_type,
+	}, {
+		.compatible = "samsung,exynos5420-i2s",
+		.data = &i2sv6_dai_type,
 	},
 	{},
 };
-- 
1.7.4.4
