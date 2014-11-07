From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 07 Nov 2014 12:24:40 +0530
Subject: [PATCH 2/2] ASoC: samsung: add support for exynos7 I2S controller
In-Reply-To: <1415343280-18916-1-git-send-email-padma.v@samsung.com>
References: <1415343280-18916-1-git-send-email-padma.v@samsung.com>
Message-ID: <1415343280-18916-3-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos7 I2S controller has no internal dma, supports more
no. of root clock sampling frequencies and has more no.of Rx
fifos to support 7.1CH recording in TDM mode. Due to more no.
of root clock frequency values some of the bit offsets got
shifted up by one. Also I2S1 on previous Samsung platforms
uses v3 dai type but on Exynos7 it is upgraded to v5 with
slightly modified register offsets for supporting more no.of
RFS values. Due to the above changes, the driver has to be
modified to handle all versions of I2S controller. For this
I introduced a new structure to hold modified bit offsets and
masks which is passed as dai data.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 .../devicetree/bindings/sound/samsung-i2s.txt      |   15 +-
 sound/soc/samsung/Kconfig                          |    2 +-
 sound/soc/samsung/i2s-regs.h                       |   10 +-
 sound/soc/samsung/i2s.c                            |  218 ++++++++++++++------
 4 files changed, 174 insertions(+), 71 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.txt b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
index 7386d44..d188296 100644
--- a/Documentation/devicetree/bindings/sound/samsung-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
@@ -6,10 +6,17 @@ Required SoC Specific Properties:
    - samsung,s3c6410-i2s: for 8/16/24bit stereo I2S.
    - samsung,s5pv210-i2s: for 8/16/24bit multichannel(5.1) I2S with
      secondary fifo, s/w reset control and internal mux for root clk src.
-   - samsung,exynos5420-i2s: for 8/16/24bit multichannel(7.1) I2S with
-     secondary fifo, s/w reset control, internal mux for root clk src and
-     TDM support. TDM (Time division multiplexing) is to allow transfer of
-     multiple channel audio data on single data line.
+   - samsung,exynos5420-i2s: for 8/16/24bit multichannel(5.1) I2S for
+     playback, sterio channel capture, secondary fifo using internal
+     or external dma, s/w reset control, internal mux for root clk src
+     and 7.1 channel TDM support for playback. TDM (Time division multiplexing)
+     is to allow transfer of multiple channel audio data on single data line.
+   - samsung,exynos7-i2s: with all the available features of exynos5 i2s,
+     exynos7 I2S has 7.1 channel TDM support for capture, secondary fifo
+     with only external dma and more no.of root clk sampling frequencies.
+   - samsung,exynos7-i2s1: I2S1 on previous samsung platforms supports
+     stereo channels. exynos7 i2s1 upgraded to 5.1 multichannel with
+     slightly modified bit offsets.
 
 - reg: physical base address of the controller and length of memory mapped
   region.
diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 55a3869..e0e737f 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -1,6 +1,6 @@
 config SND_SOC_SAMSUNG
 	tristate "ASoC support for Samsung"
-	depends on PLAT_SAMSUNG
+	depends on (PLAT_SAMSUNG || ARCH_EXYNOS)
 	depends on S3C64XX_PL080 || !ARCH_S3C64XX
 	depends on S3C24XX_DMAC || !ARCH_S3C24XX
 	select SND_SOC_GENERIC_DMAENGINE_PCM
diff --git a/sound/soc/samsung/i2s-regs.h b/sound/soc/samsung/i2s-regs.h
index 821a502..9170c31 100644
--- a/sound/soc/samsung/i2s-regs.h
+++ b/sound/soc/samsung/i2s-regs.h
@@ -33,8 +33,9 @@
 #define I2SLVL3ADDR	0x3c
 #define I2SSTR1		0x40
 #define I2SVER		0x44
-#define I2SFIC2		0x48
+#define I2SFIC1		0x48
 #define I2STDM		0x4c
+#define I2SFSTA		0x50
 
 #define CON_RSTCLR		(1 << 31)
 #define CON_FRXOFSTATUS		(1 << 26)
@@ -93,8 +94,6 @@
 #define MOD_BLC_24BIT		(2 << 13)
 #define MOD_BLC_MASK		(3 << 13)
 
-#define MOD_IMS_SYSMUX		(1 << 10)
-#define MOD_SLAVE		(1 << 11)
 #define MOD_TXONLY		(0 << 8)
 #define MOD_RXONLY		(1 << 8)
 #define MOD_TXRX		(2 << 8)
@@ -132,7 +131,10 @@
 #define EXYNOS5420_MOD_BCLK_256FS	8
 #define EXYNOS5420_MOD_BCLK_MASK	0xf
 
-#define MOD_CDCLKCON		(1 << 12)
+#define EXYNOS7_MOD_RCLK_64FS	4
+#define EXYNOS7_MOD_RCLK_128FS	5
+#define EXYNOS7_MOD_RCLK_96FS	6
+#define EXYNOS7_MOD_RCLK_192FS	7
 
 #define PSR_PSREN		(1 << 15)
 
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 38b9a52..947352d 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -36,9 +36,24 @@ enum samsung_dai_type {
 	TYPE_SEC,
 };
 
+struct samsung_i2s_variant_regs {
+	unsigned int	bfs_off;
+	unsigned int	rfs_off;
+	unsigned int	sdf_off;
+	unsigned int	txr_off;
+	unsigned int	rclksrc_off;
+	unsigned int	mss_off;
+	unsigned int	cdclkcon_off;
+	unsigned int	lrp_off;
+	unsigned int	bfs_mask;
+	unsigned int	rfs_mask;
+	unsigned int	ftx0cnt_off;
+};
+
 struct samsung_i2s_dai_data {
 	int dai_type;
 	u32 quirks;
+	const struct samsung_i2s_variant_regs *i2s_variant_regs;
 };
 
 struct i2s_dai {
@@ -81,6 +96,7 @@ struct i2s_dai {
 	u32	suspend_i2scon;
 	u32	suspend_i2spsr;
 	unsigned long gpios[7];	/* i2s gpio line numbers */
+	const struct samsung_i2s_variant_regs *variant_regs;
 };
 
 /* Lock for cross i/f checks */
@@ -95,7 +111,8 @@ static inline bool is_secondary(struct i2s_dai *i2s)
 /* If operating in SoC-Slave mode */
 static inline bool is_slave(struct i2s_dai *i2s)
 {
-	return (readl(i2s->addr + I2SMOD) & MOD_SLAVE) ? true : false;
+	u32 mod = readl(i2s->addr + I2SMOD);
+	return (mod & (1 << i2s->variant_regs->mss_off)) ? true : false;
 }
 
 /* If this interface of the controller is transmitting data */
@@ -200,14 +217,14 @@ static inline bool is_manager(struct i2s_dai *i2s)
 static inline unsigned get_rfs(struct i2s_dai *i2s)
 {
 	u32 rfs;
-
-	if (i2s->quirks & QUIRK_SUPPORTS_TDM)
-		rfs = readl(i2s->addr + I2SMOD) >> EXYNOS5420_MOD_RCLK_SHIFT;
-	else
-		rfs = (readl(i2s->addr + I2SMOD) >> MOD_RCLK_SHIFT);
-	rfs &= MOD_RCLK_MASK;
+	rfs = readl(i2s->addr + I2SMOD) >> i2s->variant_regs->rfs_off;
+	rfs &= i2s->variant_regs->rfs_mask;
 
 	switch (rfs) {
+	case 7: return 192;
+	case 6: return 96;
+	case 5: return 128;
+	case 4: return 64;
 	case 3:	return 768;
 	case 2: return 384;
 	case 1:	return 512;
@@ -219,15 +236,23 @@ static inline unsigned get_rfs(struct i2s_dai *i2s)
 static inline void set_rfs(struct i2s_dai *i2s, unsigned rfs)
 {
 	u32 mod = readl(i2s->addr + I2SMOD);
-	int rfs_shift;
+	int rfs_shift = i2s->variant_regs->rfs_off;
 
-	if (i2s->quirks & QUIRK_SUPPORTS_TDM)
-		rfs_shift = EXYNOS5420_MOD_RCLK_SHIFT;
-	else
-		rfs_shift = MOD_RCLK_SHIFT;
-	mod &= ~(MOD_RCLK_MASK << rfs_shift);
+	mod &= ~(i2s->variant_regs->rfs_mask << rfs_shift);
 
 	switch (rfs) {
+	case 192:
+		mod |= (EXYNOS7_MOD_RCLK_192FS << rfs_shift);
+		break;
+	case 96:
+		mod |= (EXYNOS7_MOD_RCLK_96FS << rfs_shift);
+		break;
+	case 128:
+		mod |= (EXYNOS7_MOD_RCLK_128FS << rfs_shift);
+		break;
+	case 64:
+		mod |= (EXYNOS7_MOD_RCLK_64FS << rfs_shift);
+		break;
 	case 768:
 		mod |= (MOD_RCLK_768FS << rfs_shift);
 		break;
@@ -249,14 +274,8 @@ static inline void set_rfs(struct i2s_dai *i2s, unsigned rfs)
 static inline unsigned get_bfs(struct i2s_dai *i2s)
 {
 	u32 bfs;
-
-	if (i2s->quirks & QUIRK_SUPPORTS_TDM) {
-		bfs = readl(i2s->addr + I2SMOD) >> EXYNOS5420_MOD_BCLK_SHIFT;
-		bfs &= EXYNOS5420_MOD_BCLK_MASK;
-	} else {
-		bfs =  readl(i2s->addr + I2SMOD) >> MOD_BCLK_SHIFT;
-		bfs &= MOD_BCLK_MASK;
-	}
+	bfs = readl(i2s->addr + I2SMOD) >> i2s->variant_regs->bfs_off;
+	bfs &= i2s->variant_regs->bfs_mask;
 
 	switch (bfs) {
 	case 8: return 256;
@@ -275,16 +294,8 @@ static inline unsigned get_bfs(struct i2s_dai *i2s)
 static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
 {
 	u32 mod = readl(i2s->addr + I2SMOD);
-	int bfs_shift;
 	int tdm = i2s->quirks & QUIRK_SUPPORTS_TDM;
-
-	if (i2s->quirks & QUIRK_SUPPORTS_TDM) {
-		bfs_shift = EXYNOS5420_MOD_BCLK_SHIFT;
-		mod &= ~(EXYNOS5420_MOD_BCLK_MASK << bfs_shift);
-	} else {
-		bfs_shift = MOD_BCLK_SHIFT;
-		mod &= ~(MOD_BCLK_MASK << bfs_shift);
-	}
+	int bfs_shift = i2s->variant_regs->bfs_off;
 
 	/* Non-TDM I2S controllers do not support BCLK > 48 * FS */
 	if (!tdm && bfs > 48) {
@@ -292,6 +303,8 @@ static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
 		return;
 	}
 
+	mod &= ~(i2s->variant_regs->bfs_mask << bfs_shift);
+
 	switch (bfs) {
 	case 48:
 		mod |= (MOD_BCLK_48FS << bfs_shift);
@@ -346,8 +359,9 @@ static inline int get_blc(struct i2s_dai *i2s)
 static void i2s_txctrl(struct i2s_dai *i2s, int on)
 {
 	void __iomem *addr = i2s->addr;
+	int txr_off = i2s->variant_regs->txr_off;
 	u32 con = readl(addr + I2SCON);
-	u32 mod = readl(addr + I2SMOD) & ~MOD_MASK;
+	u32 mod = readl(addr + I2SMOD) & ~(3 << txr_off);
 
 	if (on) {
 		con |= CON_ACTIVE;
@@ -362,9 +376,9 @@ static void i2s_txctrl(struct i2s_dai *i2s, int on)
 		}
 
 		if (any_rx_active(i2s))
-			mod |= MOD_TXRX;
+			mod |= 2 << txr_off;
 		else
-			mod |= MOD_TXONLY;
+			mod |= 0 << txr_off;
 	} else {
 		if (is_secondary(i2s)) {
 			con |=  CON_TXSDMA_PAUSE;
@@ -382,7 +396,7 @@ static void i2s_txctrl(struct i2s_dai *i2s, int on)
 		con |=  CON_TXCH_PAUSE;
 
 		if (any_rx_active(i2s))
-			mod |= MOD_RXONLY;
+			mod |= 1 << txr_off;
 		else
 			con &= ~CON_ACTIVE;
 	}
@@ -395,23 +409,24 @@ static void i2s_txctrl(struct i2s_dai *i2s, int on)
 static void i2s_rxctrl(struct i2s_dai *i2s, int on)
 {
 	void __iomem *addr = i2s->addr;
+	int txr_off = i2s->variant_regs->txr_off;
 	u32 con = readl(addr + I2SCON);
-	u32 mod = readl(addr + I2SMOD) & ~MOD_MASK;
+	u32 mod = readl(addr + I2SMOD) & ~(3 << txr_off);
 
 	if (on) {
 		con |= CON_RXDMA_ACTIVE | CON_ACTIVE;
 		con &= ~(CON_RXDMA_PAUSE | CON_RXCH_PAUSE);
 
 		if (any_tx_active(i2s))
-			mod |= MOD_TXRX;
+			mod |= 2 << txr_off;
 		else
-			mod |= MOD_RXONLY;
+			mod |= 1 << txr_off;
 	} else {
 		con |=  CON_RXDMA_PAUSE | CON_RXCH_PAUSE;
 		con &= ~CON_RXDMA_ACTIVE;
 
 		if (any_tx_active(i2s))
-			mod |= MOD_TXONLY;
+			mod |= 0 << txr_off;
 		else
 			con &= ~CON_ACTIVE;
 	}
@@ -451,6 +466,9 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 	struct i2s_dai *i2s = to_info(dai);
 	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
 	u32 mod = readl(i2s->addr + I2SMOD);
+	const struct samsung_i2s_variant_regs *i2s_regs = i2s->variant_regs;
+	unsigned int cdcon_mask = 1 << i2s_regs->cdclkcon_off;
+	unsigned int rsrc_mask = 1 << i2s_regs->rclksrc_off;
 
 	switch (clk_id) {
 	case SAMSUNG_I2S_OPCLK:
@@ -465,18 +483,18 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 		if ((rfs && other && other->rfs && (other->rfs != rfs)) ||
 				(any_active(i2s) &&
 				(((dir == SND_SOC_CLOCK_IN)
-					&& !(mod & MOD_CDCLKCON)) ||
+					&& !(mod & cdcon_mask)) ||
 				((dir == SND_SOC_CLOCK_OUT)
-					&& (mod & MOD_CDCLKCON))))) {
+					&& (mod & cdcon_mask))))) {
 			dev_err(&i2s->pdev->dev,
 				"%s:%d Other DAI busy\n", __func__, __LINE__);
 			return -EAGAIN;
 		}
 
 		if (dir == SND_SOC_CLOCK_IN)
-			mod |= MOD_CDCLKCON;
+			mod |= 1 << i2s_regs->cdclkcon_off;
 		else
-			mod &= ~MOD_CDCLKCON;
+			mod &= 0 << i2s_regs->cdclkcon_off;
 
 		i2s->rfs = rfs;
 		break;
@@ -491,8 +509,8 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 
 		if (!any_active(i2s)) {
 			if (i2s->op_clk && !IS_ERR(i2s->op_clk)) {
-				if ((clk_id && !(mod & MOD_IMS_SYSMUX)) ||
-					(!clk_id && (mod & MOD_IMS_SYSMUX))) {
+				if ((clk_id && !(mod & rsrc_mask)) ||
+					(!clk_id && (mod & rsrc_mask))) {
 					clk_disable_unprepare(i2s->op_clk);
 					clk_put(i2s->op_clk);
 				} else {
@@ -520,8 +538,8 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 				other->op_clk = i2s->op_clk;
 				other->rclk_srcrate = i2s->rclk_srcrate;
 			}
-		} else if ((!clk_id && (mod & MOD_IMS_SYSMUX))
-				|| (clk_id && !(mod & MOD_IMS_SYSMUX))) {
+		} else if ((!clk_id && (mod & rsrc_mask))
+				|| (clk_id && !(mod & rsrc_mask))) {
 			dev_err(&i2s->pdev->dev,
 				"%s:%d Other DAI busy\n", __func__, __LINE__);
 			return -EAGAIN;
@@ -533,10 +551,9 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 		}
 
 		if (clk_id == 0)
-			mod &= ~MOD_IMS_SYSMUX;
+			mod &= 0 << i2s_regs->rclksrc_off;
 		else
-			mod |= MOD_IMS_SYSMUX;
-		break;
+			mod |= 1 << i2s_regs->rclksrc_off;
 
 	default:
 		dev_err(&i2s->pdev->dev, "We don't serve that!\n");
@@ -553,16 +570,12 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 {
 	struct i2s_dai *i2s = to_info(dai);
 	u32 mod = readl(i2s->addr + I2SMOD);
-	int lrp_shift, sdf_shift, sdf_mask, lrp_rlow;
+	int lrp_shift, sdf_shift, sdf_mask, lrp_rlow, mod_slave;
 	u32 tmp = 0;
 
-	if (i2s->quirks & QUIRK_SUPPORTS_TDM) {
-		lrp_shift = EXYNOS5420_MOD_LRP_SHIFT;
-		sdf_shift = EXYNOS5420_MOD_SDF_SHIFT;
-	} else {
-		lrp_shift = MOD_LRP_SHIFT;
-		sdf_shift = MOD_SDF_SHIFT;
-	}
+	lrp_shift = i2s->variant_regs->lrp_off;
+	sdf_shift = i2s->variant_regs->sdf_off;
+	mod_slave = 1 << i2s->variant_regs->mss_off;
 
 	sdf_mask = MOD_SDF_MASK << sdf_shift;
 	lrp_rlow = MOD_LR_RLOW << lrp_shift;
@@ -605,7 +618,7 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
-		tmp |= MOD_SLAVE;
+		tmp |= mod_slave;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
 		/* Set default source clock in Master mode */
@@ -623,13 +636,13 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 	 * channel.
 	 */
 	if (any_active(i2s) &&
-		((mod & (sdf_mask | lrp_rlow | MOD_SLAVE)) != tmp)) {
+		((mod & (sdf_mask | lrp_rlow | mod_slave)) != tmp)) {
 		dev_err(&i2s->pdev->dev,
 				"%s:%d Other DAI busy\n", __func__, __LINE__);
 		return -EAGAIN;
 	}
 
-	mod &= ~(sdf_mask | lrp_rlow | MOD_SLAVE);
+	mod &= ~(sdf_mask | lrp_rlow | mod_slave);
 	mod |= tmp;
 	writel(mod, i2s->addr + I2SMOD);
 
@@ -751,6 +764,7 @@ static void i2s_shutdown(struct snd_pcm_substream *substream,
 	struct i2s_dai *i2s = to_info(dai);
 	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
 	unsigned long flags;
+	const struct samsung_i2s_variant_regs *i2s_regs = i2s->variant_regs;
 
 	spin_lock_irqsave(&lock, flags);
 
@@ -761,7 +775,7 @@ static void i2s_shutdown(struct snd_pcm_substream *substream,
 		other->mode |= DAI_MANAGER;
 	} else {
 		u32 mod = readl(i2s->addr + I2SMOD);
-		i2s->cdclk_out = !(mod & MOD_CDCLKCON);
+		i2s->cdclk_out = !(mod & (1 << i2s_regs->cdclkcon_off));
 		if (other)
 			other->cdclk_out = i2s->cdclk_out;
 	}
@@ -914,13 +928,14 @@ i2s_delay(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 	struct i2s_dai *i2s = to_info(dai);
 	u32 reg = readl(i2s->addr + I2SFIC);
 	snd_pcm_sframes_t delay;
+	const struct samsung_i2s_variant_regs *i2s_regs = i2s->variant_regs;
 
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
 		delay = FIC_RXCOUNT(reg);
 	else if (is_secondary(i2s))
 		delay = FICS_TXCOUNT(readl(i2s->addr + I2SFICS));
 	else
-		delay = FIC_TXCOUNT(reg);
+		delay = (reg >> i2s_regs->ftx0cnt_off) & 0x7f;
 
 	return delay;
 }
@@ -1227,6 +1242,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pri_dai->dma_capture.dma_size = 4;
 	pri_dai->base = regs_base;
 	pri_dai->quirks = quirks;
+	pri_dai->variant_regs = i2s_dai_data->i2s_variant_regs;
 
 	if (quirks & QUIRK_PRI_6CHAN)
 		pri_dai->i2s_dai_drv.playback.channels_max = 6;
@@ -1301,21 +1317,93 @@ static int samsung_i2s_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct samsung_i2s_variant_regs i2sv3_regs = {
+	.bfs_off = 1,
+	.rfs_off = 3,
+	.sdf_off = 5,
+	.txr_off = 8,
+	.rclksrc_off = 10,
+	.mss_off = 11,
+	.cdclkcon_off = 12,
+	.lrp_off = 7,
+	.bfs_mask = 0x3,
+	.rfs_mask = 0x3,
+	.ftx0cnt_off = 8,
+};
+
+static const struct samsung_i2s_variant_regs i2sv6_regs = {
+	.bfs_off = 0,
+	.rfs_off = 4,
+	.sdf_off = 6,
+	.txr_off = 8,
+	.rclksrc_off = 10,
+	.mss_off = 11,
+	.cdclkcon_off = 12,
+	.lrp_off = 15,
+	.bfs_mask = 0xf,
+	.rfs_mask = 0x3,
+	.ftx0cnt_off = 8,
+};
+
+static const struct samsung_i2s_variant_regs i2sv7_regs = {
+	.bfs_off = 0,
+	.rfs_off = 4,
+	.sdf_off = 7,
+	.txr_off = 9,
+	.rclksrc_off = 11,
+	.mss_off = 12,
+	.cdclkcon_off = 22,
+	.lrp_off = 15,
+	.bfs_mask = 0xf,
+	.rfs_mask = 0x7,
+	.ftx0cnt_off = 0,
+};
+
+static const struct samsung_i2s_variant_regs i2sv5_i2s1_regs = {
+	.bfs_off = 0,
+	.rfs_off = 3,
+	.sdf_off = 6,
+	.txr_off = 8,
+	.rclksrc_off = 10,
+	.mss_off = 11,
+	.cdclkcon_off = 12,
+	.lrp_off = 15,
+	.bfs_mask = 0x7,
+	.rfs_mask = 0x7,
+	.ftx0cnt_off = 8,
+};
+
 static const struct samsung_i2s_dai_data i2sv3_dai_type = {
 	.dai_type = TYPE_PRI,
 	.quirks = QUIRK_NO_MUXPSR,
+	.i2s_variant_regs = &i2sv3_regs,
 };
 
 static const struct samsung_i2s_dai_data i2sv5_dai_type = {
 	.dai_type = TYPE_PRI,
 	.quirks = QUIRK_PRI_6CHAN | QUIRK_SEC_DAI | QUIRK_NEED_RSTCLR |
 			QUIRK_SUPPORTS_IDMA,
+	.i2s_variant_regs = &i2sv3_regs,
 };
 
 static const struct samsung_i2s_dai_data i2sv6_dai_type = {
 	.dai_type = TYPE_PRI,
 	.quirks = QUIRK_PRI_6CHAN | QUIRK_SEC_DAI | QUIRK_NEED_RSTCLR |
 			QUIRK_SUPPORTS_TDM | QUIRK_SUPPORTS_IDMA,
+	.i2s_variant_regs = &i2sv6_regs,
+};
+
+static const struct samsung_i2s_dai_data i2sv7_dai_type = {
+	.dai_type = TYPE_PRI,
+	.quirks = QUIRK_PRI_6CHAN | QUIRK_SEC_DAI | QUIRK_NEED_RSTCLR |
+			QUIRK_SUPPORTS_TDM,
+	.i2s_variant_regs = &i2sv7_regs,
+};
+
+static const struct samsung_i2s_dai_data i2sv5_dai_type_i2s1 = {
+	.dai_type = TYPE_PRI,
+	.quirks = QUIRK_PRI_6CHAN | QUIRK_NEED_RSTCLR,
+	.i2s_variant_regs = &i2sv5_i2s1_regs,
 };
 
 static const struct samsung_i2s_dai_data samsung_dai_type_pri = {
@@ -1349,6 +1437,12 @@ static const struct of_device_id exynos_i2s_match[] = {
 	}, {
 		.compatible = "samsung,exynos5420-i2s",
 		.data = &i2sv6_dai_type,
+	}, {
+		.compatible = "samsung,exynos7-i2s",
+		.data = &i2sv7_dai_type,
+	}, {
+		.compatible = "samsung,exynos7-i2s1",
+		.data = &i2sv5_dai_type_i2s1,
 	},
 	{},
 };
-- 
1.7.4.4
