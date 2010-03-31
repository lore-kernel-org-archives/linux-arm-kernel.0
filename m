From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 31 Mar 2010 15:08:55 -0400
Subject: [PATCH] [ARM] pxa: add namespace on ssp
Message-ID: <mailman.282.1270039610.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to prevent code ambiguous, add namespace on functions in ssp driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/plat-pxa/include/plat/ssp.h |   12 ++--
 arch/arm/plat-pxa/ssp.c              |   22 +++---
 drivers/spi/pxa2xx_spi.c             |    8 +-
 sound/soc/pxa/pxa-ssp.c              |  132 +++++++++++++++++-----------------
 4 files changed, 87 insertions(+), 87 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/ssp.h
b/arch/arm/plat-pxa/include/plat/ssp.h
index d16d79a..fe43150 100644
--- a/arch/arm/plat-pxa/include/plat/ssp.h
+++ b/arch/arm/plat-pxa/include/plat/ssp.h
@@ -159,28 +159,28 @@ struct ssp_device {
 };

 /**
- * ssp_write_reg - Write to a SSP register
+ * pxa_ssp_write_reg - Write to a SSP register
  *
  * @dev: SSP device to access
  * @reg: Register to write to
  * @val: Value to be written.
  */
-static inline void ssp_write_reg(struct ssp_device *dev, u32 reg, u32 val)
+static inline void pxa_ssp_write_reg(struct ssp_device *dev, u32 reg, u32 val)
 {
 	__raw_writel(val, dev->mmio_base + reg);
 }

 /**
- * ssp_read_reg - Read from a SSP register
+ * pxa_ssp_read_reg - Read from a SSP register
  *
  * @dev: SSP device to access
  * @reg: Register to read from
  */
-static inline u32 ssp_read_reg(struct ssp_device *dev, u32 reg)
+static inline u32 pxa_ssp_read_reg(struct ssp_device *dev, u32 reg)
 {
 	return __raw_readl(dev->mmio_base + reg);
 }

-struct ssp_device *ssp_request(int port, const char *label);
-void ssp_free(struct ssp_device *);
+struct ssp_device *pxa_ssp_request(int port, const char *label);
+void pxa_ssp_free(struct ssp_device *);
 #endif /* __ASM_ARCH_SSP_H */
diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index cfebcd8..511805e 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -37,7 +37,7 @@
 static DEFINE_MUTEX(ssp_lock);
 static LIST_HEAD(ssp_list);

-struct ssp_device *ssp_request(int port, const char *label)
+struct ssp_device *pxa_ssp_request(int port, const char *label)
 {
 	struct ssp_device *ssp = NULL;

@@ -58,9 +58,9 @@ struct ssp_device *ssp_request(int port, const char *label)

 	return ssp;
 }
-EXPORT_SYMBOL(ssp_request);
+EXPORT_SYMBOL(pxa_ssp_request);

-void ssp_free(struct ssp_device *ssp)
+void pxa_ssp_free(struct ssp_device *ssp)
 {
 	mutex_lock(&ssp_lock);
 	if (ssp->use_count) {
@@ -70,9 +70,9 @@ void ssp_free(struct ssp_device *ssp)
 		dev_err(&ssp->pdev->dev, "device already free\n");
 	mutex_unlock(&ssp_lock);
 }
-EXPORT_SYMBOL(ssp_free);
+EXPORT_SYMBOL(pxa_ssp_free);

-static int __devinit ssp_probe(struct platform_device *pdev)
+static int __devinit pxa_ssp_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct resource *res;
@@ -164,7 +164,7 @@ err_free:
 	return ret;
 }

-static int __devexit ssp_remove(struct platform_device *pdev)
+static int __devexit pxa_ssp_remove(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct ssp_device *ssp;
@@ -196,9 +196,9 @@ static const struct platform_device_id ssp_id_table[] = {
 	{ },
 };

-static struct platform_driver ssp_driver = {
-	.probe		= ssp_probe,
-	.remove		= __devexit_p(ssp_remove),
+static struct platform_driver pxa_ssp_driver = {
+	.probe		= pxa_ssp_probe,
+	.remove		= __devexit_p(pxa_ssp_remove),
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "pxa2xx-ssp",
@@ -208,12 +208,12 @@ static struct platform_driver ssp_driver = {

 static int __init pxa_ssp_init(void)
 {
-	return platform_driver_register(&ssp_driver);
+	return platform_driver_register(&pxa_ssp_driver);
 }

 static void __exit pxa_ssp_exit(void)
 {
-	platform_driver_unregister(&ssp_driver);
+	platform_driver_unregister(&pxa_ssp_driver);
 }

 arch_initcall(pxa_ssp_init);
diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index 4a64da7..2fd7d5a 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -1464,7 +1464,7 @@ static int __init pxa2xx_spi_probe(struct
platform_device *pdev)

 	platform_info = dev->platform_data;

-	ssp = ssp_request(pdev->id, pdev->name);
+	ssp = pxa_ssp_request(pdev->id, pdev->name);
 	if (ssp == NULL) {
 		dev_err(&pdev->dev, "failed to request SSP%d\n", pdev->id);
 		return -ENODEV;
@@ -1474,7 +1474,7 @@ static int __init pxa2xx_spi_probe(struct
platform_device *pdev)
 	master = spi_alloc_master(dev, sizeof(struct driver_data) + 16);
 	if (!master) {
 		dev_err(&pdev->dev, "cannot alloc spi_master\n");
-		ssp_free(ssp);
+		pxa_ssp_free(ssp);
 		return -ENOMEM;
 	}
 	drv_data = spi_master_get_devdata(master);
@@ -1603,7 +1603,7 @@ out_error_irq_alloc:

 out_error_master_alloc:
 	spi_master_put(master);
-	ssp_free(ssp);
+	pxa_ssp_free(ssp);
 	return status;
 }

@@ -1647,7 +1647,7 @@ static int pxa2xx_spi_remove(struct platform_device *pdev)
 	free_irq(ssp->irq, drv_data);

 	/* Release SSP */
-	ssp_free(ssp);
+	pxa_ssp_free(ssp);

 	/* Disconnect from the SPI framework */
 	spi_unregister_master(drv_data->master);
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 4ca9245..ed54bef 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -55,15 +55,15 @@ struct ssp_priv {
 static void dump_registers(struct ssp_device *ssp)
 {
 	dev_dbg(&ssp->pdev->dev, "SSCR0 0x%08x SSCR1 0x%08x SSTO 0x%08x\n",
-		 ssp_read_reg(ssp, SSCR0), ssp_read_reg(ssp, SSCR1),
-		 ssp_read_reg(ssp, SSTO));
+		 pxa_ssp_read_reg(ssp, SSCR0), pxa_ssp_read_reg(ssp, SSCR1),
+		 pxa_ssp_read_reg(ssp, SSTO));

 	dev_dbg(&ssp->pdev->dev, "SSPSP 0x%08x SSSR 0x%08x SSACD 0x%08x\n",
-		 ssp_read_reg(ssp, SSPSP), ssp_read_reg(ssp, SSSR),
-		 ssp_read_reg(ssp, SSACD));
+		 pxa_ssp_read_reg(ssp, SSPSP), pxa_ssp_read_reg(ssp, SSSR),
+		 pxa_ssp_read_reg(ssp, SSACD));
 }

-static void ssp_enable(struct ssp_device *ssp)
+static void pxa_ssp_enable(struct ssp_device *ssp)
 {
 	uint32_t sscr0;

@@ -71,7 +71,7 @@ static void ssp_enable(struct ssp_device *ssp)
 	__raw_writel(sscr0, ssp->mmio_base + SSCR0);
 }

-static void ssp_disable(struct ssp_device *ssp)
+static void pxa_ssp_disable(struct ssp_device *ssp)
 {
 	uint32_t sscr0;

@@ -85,7 +85,7 @@ struct pxa2xx_pcm_dma_data {
 };

 static struct pxa2xx_pcm_dma_params *
-ssp_get_dma_params(struct ssp_device *ssp, int width4, int out)
+pxa_ssp_get_dma_params(struct ssp_device *ssp, int width4, int out)
 {
 	struct pxa2xx_pcm_dma_data *dma;

@@ -117,7 +117,7 @@ static int pxa_ssp_startup(struct
snd_pcm_substream *substream,

 	if (!cpu_dai->active) {
 		clk_enable(ssp->clk);
-		ssp_disable(ssp);
+		pxa_ssp_disable(ssp);
 	}

 	if (cpu_dai->dma_data) {
@@ -136,7 +136,7 @@ static void pxa_ssp_shutdown(struct
snd_pcm_substream *substream,
 	struct ssp_device *ssp = priv->ssp;

 	if (!cpu_dai->active) {
-		ssp_disable(ssp);
+		pxa_ssp_disable(ssp);
 		clk_disable(ssp->clk);
 	}

@@ -161,7 +161,7 @@ static int pxa_ssp_suspend(struct snd_soc_dai *cpu_dai)
 	priv->to  = __raw_readl(ssp->mmio_base + SSTO);
 	priv->psp = __raw_readl(ssp->mmio_base + SSPSP);

-	ssp_disable(ssp);
+	pxa_ssp_disable(ssp);
 	clk_disable(ssp->clk);
 	return 0;
 }
@@ -181,7 +181,7 @@ static int pxa_ssp_resume(struct snd_soc_dai *cpu_dai)
 	__raw_writel(priv->psp, ssp->mmio_base + SSPSP);

 	if (cpu_dai->active)
-		ssp_enable(ssp);
+		pxa_ssp_enable(ssp);
 	else
 		clk_disable(ssp->clk);

@@ -197,9 +197,9 @@ static int pxa_ssp_resume(struct snd_soc_dai *cpu_dai)
  * ssp_set_clkdiv - set SSP clock divider
  * @div: serial clock rate divider
  */
-static void ssp_set_scr(struct ssp_device *ssp, u32 div)
+static void pxa_ssp_set_scr(struct ssp_device *ssp, u32 div)
 {
-	u32 sscr0 = ssp_read_reg(ssp, SSCR0);
+	u32 sscr0 = pxa_ssp_read_reg(ssp, SSCR0);

 	if (cpu_is_pxa25x() && ssp->type == PXA25x_SSP) {
 		sscr0 &= ~0x0000ff00;
@@ -208,15 +208,15 @@ static void ssp_set_scr(struct ssp_device *ssp, u32 div)
 		sscr0 &= ~0x000fff00;
 		sscr0 |= (div - 1) << 8;     /* 1..4096 */
 	}
-	ssp_write_reg(ssp, SSCR0, sscr0);
+	pxa_ssp_write_reg(ssp, SSCR0, sscr0);
 }

 /**
- * ssp_get_clkdiv - get SSP clock divider
+ * pxa_ssp_get_clkdiv - get SSP clock divider
  */
-static u32 ssp_get_scr(struct ssp_device *ssp)
+static u32 pxa_ssp_get_scr(struct ssp_device *ssp)
 {
-	u32 sscr0 = ssp_read_reg(ssp, SSCR0);
+	u32 sscr0 = pxa_ssp_read_reg(ssp, SSCR0);
 	u32 div;

 	if (cpu_is_pxa25x() && ssp->type == PXA25x_SSP)
@@ -236,7 +236,7 @@ static int pxa_ssp_set_dai_sysclk(struct
snd_soc_dai *cpu_dai,
 	struct ssp_device *ssp = priv->ssp;
 	int val;

-	u32 sscr0 = ssp_read_reg(ssp, SSCR0) &
+	u32 sscr0 = pxa_ssp_read_reg(ssp, SSCR0) &
 		~(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);

 	dev_dbg(&ssp->pdev->dev,
@@ -264,7 +264,7 @@ static int pxa_ssp_set_dai_sysclk(struct
snd_soc_dai *cpu_dai,
 		break;
 	case PXA_SSP_CLK_AUDIO:
 		priv->sysclk = 0;
-		ssp_set_scr(ssp, 1);
+		pxa_ssp_set_scr(ssp, 1);
 		sscr0 |= SSCR0_ACS;
 		break;
 	default:
@@ -275,8 +275,8 @@ static int pxa_ssp_set_dai_sysclk(struct
snd_soc_dai *cpu_dai,
 	 * on PXA2xx.  On PXA3xx it must be enabled when doing so. */
 	if (!cpu_is_pxa3xx())
 		clk_disable(ssp->clk);
-	val = ssp_read_reg(ssp, SSCR0) | sscr0;
-	ssp_write_reg(ssp, SSCR0, val);
+	val = pxa_ssp_read_reg(ssp, SSCR0) | sscr0;
+	pxa_ssp_write_reg(ssp, SSCR0, val);
 	if (!cpu_is_pxa3xx())
 		clk_enable(ssp->clk);

@@ -295,11 +295,11 @@ static int pxa_ssp_set_dai_clkdiv(struct
snd_soc_dai *cpu_dai,

 	switch (div_id) {
 	case PXA_SSP_AUDIO_DIV_ACDS:
-		val = (ssp_read_reg(ssp, SSACD) & ~0x7) | SSACD_ACDS(div);
-		ssp_write_reg(ssp, SSACD, val);
+		val = (pxa_ssp_read_reg(ssp, SSACD) & ~0x7) | SSACD_ACDS(div);
+		pxa_ssp_write_reg(ssp, SSACD, val);
 		break;
 	case PXA_SSP_AUDIO_DIV_SCDB:
-		val = ssp_read_reg(ssp, SSACD);
+		val = pxa_ssp_read_reg(ssp, SSACD);
 		val &= ~SSACD_SCDB;
 #if defined(CONFIG_PXA3xx)
 		if (cpu_is_pxa3xx())
@@ -322,10 +322,10 @@ static int pxa_ssp_set_dai_clkdiv(struct
snd_soc_dai *cpu_dai,
 		default:
 			return -EINVAL;
 		}
-		ssp_write_reg(ssp, SSACD, val);
+		pxa_ssp_write_reg(ssp, SSACD, val);
 		break;
 	case PXA_SSP_DIV_SCR:
-		ssp_set_scr(ssp, div);
+		pxa_ssp_set_scr(ssp, div);
 		break;
 	default:
 		return -ENODEV;
@@ -342,11 +342,11 @@ static int pxa_ssp_set_dai_pll(struct
snd_soc_dai *cpu_dai, int pll_id,
 {
 	struct ssp_priv *priv = cpu_dai->private_data;
 	struct ssp_device *ssp = priv->ssp;
-	u32 ssacd = ssp_read_reg(ssp, SSACD) & ~0x70;
+	u32 ssacd = pxa_ssp_read_reg(ssp, SSACD) & ~0x70;

 #if defined(CONFIG_PXA3xx)
 	if (cpu_is_pxa3xx())
-		ssp_write_reg(ssp, SSACDD, 0);
+		pxa_ssp_write_reg(ssp, SSACDD, 0);
 #endif

 	switch (freq_out) {
@@ -384,7 +384,7 @@ static int pxa_ssp_set_dai_pll(struct snd_soc_dai
*cpu_dai, int pll_id,
 			val = tmp;

 			val = (val << 16) | 64;
-			ssp_write_reg(ssp, SSACDD, val);
+			pxa_ssp_write_reg(ssp, SSACDD, val);

 			ssacd |= (0x6 << 4);

@@ -398,7 +398,7 @@ static int pxa_ssp_set_dai_pll(struct snd_soc_dai
*cpu_dai, int pll_id,
 		return -EINVAL;
 	}

-	ssp_write_reg(ssp, SSACD, ssacd);
+	pxa_ssp_write_reg(ssp, SSACD, ssacd);

 	return 0;
 }
@@ -413,7 +413,7 @@ static int pxa_ssp_set_dai_tdm_slot(struct
snd_soc_dai *cpu_dai,
 	struct ssp_device *ssp = priv->ssp;
 	u32 sscr0;

-	sscr0 = ssp_read_reg(ssp, SSCR0);
+	sscr0 = pxa_ssp_read_reg(ssp, SSCR0);
 	sscr0 &= ~(SSCR0_MOD | SSCR0_SlotsPerFrm(8) | SSCR0_EDSS | SSCR0_DSS);

 	/* set slot width */
@@ -430,10 +430,10 @@ static int pxa_ssp_set_dai_tdm_slot(struct
snd_soc_dai *cpu_dai,
 		sscr0 |= SSCR0_SlotsPerFrm(slots);

 		/* set active slot mask */
-		ssp_write_reg(ssp, SSTSA, tx_mask);
-		ssp_write_reg(ssp, SSRSA, rx_mask);
+		pxa_ssp_write_reg(ssp, SSTSA, tx_mask);
+		pxa_ssp_write_reg(ssp, SSRSA, rx_mask);
 	}
-	ssp_write_reg(ssp, SSCR0, sscr0);
+	pxa_ssp_write_reg(ssp, SSCR0, sscr0);

 	return 0;
 }
@@ -448,12 +448,12 @@ static int pxa_ssp_set_dai_tristate(struct
snd_soc_dai *cpu_dai,
 	struct ssp_device *ssp = priv->ssp;
 	u32 sscr1;

-	sscr1 = ssp_read_reg(ssp, SSCR1);
+	sscr1 = pxa_ssp_read_reg(ssp, SSCR1);
 	if (tristate)
 		sscr1 &= ~SSCR1_TTE;
 	else
 		sscr1 |= SSCR1_TTE;
-	ssp_write_reg(ssp, SSCR1, sscr1);
+	pxa_ssp_write_reg(ssp, SSCR1, sscr1);

 	return 0;
 }
@@ -477,14 +477,14 @@ static int pxa_ssp_set_dai_fmt(struct
snd_soc_dai *cpu_dai,
 		return 0;

 	/* we can only change the settings if the port is not in use */
-	if (ssp_read_reg(ssp, SSCR0) & SSCR0_SSE) {
+	if (pxa_ssp_read_reg(ssp, SSCR0) & SSCR0_SSE) {
 		dev_err(&ssp->pdev->dev,
 			"can't change hardware dai format: stream is in use");
 		return -EINVAL;
 	}

 	/* reset port settings */
-	sscr0 = ssp_read_reg(ssp, SSCR0) &
+	sscr0 = pxa_ssp_read_reg(ssp, SSCR0) &
 		(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
 	sscr1 = SSCR1_RxTresh(8) | SSCR1_TxTresh(7);
 	sspsp = 0;
@@ -536,9 +536,9 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		return -EINVAL;
 	}

-	ssp_write_reg(ssp, SSCR0, sscr0);
-	ssp_write_reg(ssp, SSCR1, sscr1);
-	ssp_write_reg(ssp, SSPSP, sspsp);
+	pxa_ssp_write_reg(ssp, SSCR0, sscr0);
+	pxa_ssp_write_reg(ssp, SSCR1, sscr1);
+	pxa_ssp_write_reg(ssp, SSPSP, sspsp);

 	dump_registers(ssp);

@@ -567,7 +567,7 @@ static int pxa_ssp_hw_params(struct
snd_pcm_substream *substream,
 	u32 sscr0;
 	u32 sspsp;
 	int width = snd_pcm_format_physical_width(params_format(params));
-	int ttsa = ssp_read_reg(ssp, SSTSA) & 0xf;
+	int ttsa = pxa_ssp_read_reg(ssp, SSTSA) & 0xf;

 	/* generate correct DMA params */
 	if (cpu_dai->dma_data)
@@ -577,20 +577,20 @@ static int pxa_ssp_hw_params(struct
snd_pcm_substream *substream,
 	 * to force 16-bit frame width on the wire (for S16_LE), even
 	 * with two channels. Use 16-bit DMA transfers for this case.
 	 */
-	cpu_dai->dma_data = ssp_get_dma_params(ssp,
+	cpu_dai->dma_data = pxa_ssp_get_dma_params(ssp,
 			((chn == 2) && (ttsa != 1)) || (width == 32),
 			substream->stream == SNDRV_PCM_STREAM_PLAYBACK);

 	/* we can only change the settings if the port is not in use */
-	if (ssp_read_reg(ssp, SSCR0) & SSCR0_SSE)
+	if (pxa_ssp_read_reg(ssp, SSCR0) & SSCR0_SSE)
 		return 0;

 	/* clear selected SSP bits */
-	sscr0 = ssp_read_reg(ssp, SSCR0) & ~(SSCR0_DSS | SSCR0_EDSS);
-	ssp_write_reg(ssp, SSCR0, sscr0);
+	sscr0 = pxa_ssp_read_reg(ssp, SSCR0) & ~(SSCR0_DSS | SSCR0_EDSS);
+	pxa_ssp_write_reg(ssp, SSCR0, sscr0);

 	/* bit size */
-	sscr0 = ssp_read_reg(ssp, SSCR0);
+	sscr0 = pxa_ssp_read_reg(ssp, SSCR0);
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 #ifdef CONFIG_PXA3xx
@@ -606,13 +606,13 @@ static int pxa_ssp_hw_params(struct
snd_pcm_substream *substream,
 		sscr0 |= (SSCR0_EDSS | SSCR0_DataSize(16));
 		break;
 	}
-	ssp_write_reg(ssp, SSCR0, sscr0);
+	pxa_ssp_write_reg(ssp, SSCR0, sscr0);

 	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-	       sspsp = ssp_read_reg(ssp, SSPSP);
+	       sspsp = pxa_ssp_read_reg(ssp, SSPSP);

-		if ((ssp_get_scr(ssp) == 4) && (width == 16)) {
+		if ((pxa_ssp_get_scr(ssp) == 4) && (width == 16)) {
 			/* This is a special case where the bitclk is 64fs
 			* and we're not dealing with 2*32 bits of audio
 			* samples.
@@ -646,7 +646,7 @@ static int pxa_ssp_hw_params(struct
snd_pcm_substream *substream,
 			sspsp |= SSPSP_DMYSTRT(1);
 		}

-		ssp_write_reg(ssp, SSPSP, sspsp);
+		pxa_ssp_write_reg(ssp, SSPSP, sspsp);
 		break;
 	default:
 		break;
@@ -677,45 +677,45 @@ static int pxa_ssp_trigger(struct
snd_pcm_substream *substream, int cmd,

 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
-		ssp_enable(ssp);
+		pxa_ssp_enable(ssp);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		val = ssp_read_reg(ssp, SSCR1);
+		val = pxa_ssp_read_reg(ssp, SSCR1);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			val |= SSCR1_TSRE;
 		else
 			val |= SSCR1_RSRE;
-		ssp_write_reg(ssp, SSCR1, val);
-		val = ssp_read_reg(ssp, SSSR);
-		ssp_write_reg(ssp, SSSR, val);
+		pxa_ssp_write_reg(ssp, SSCR1, val);
+		val = pxa_ssp_read_reg(ssp, SSSR);
+		pxa_ssp_write_reg(ssp, SSSR, val);
 		break;
 	case SNDRV_PCM_TRIGGER_START:
-		val = ssp_read_reg(ssp, SSCR1);
+		val = pxa_ssp_read_reg(ssp, SSCR1);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			val |= SSCR1_TSRE;
 		else
 			val |= SSCR1_RSRE;
-		ssp_write_reg(ssp, SSCR1, val);
-		ssp_enable(ssp);
+		pxa_ssp_write_reg(ssp, SSCR1, val);
+		pxa_ssp_enable(ssp);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		val = ssp_read_reg(ssp, SSCR1);
+		val = pxa_ssp_read_reg(ssp, SSCR1);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			val &= ~SSCR1_TSRE;
 		else
 			val &= ~SSCR1_RSRE;
-		ssp_write_reg(ssp, SSCR1, val);
+		pxa_ssp_write_reg(ssp, SSCR1, val);
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		ssp_disable(ssp);
+		pxa_ssp_disable(ssp);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		val = ssp_read_reg(ssp, SSCR1);
+		val = pxa_ssp_read_reg(ssp, SSCR1);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			val &= ~SSCR1_TSRE;
 		else
 			val &= ~SSCR1_RSRE;
-		ssp_write_reg(ssp, SSCR1, val);
+		pxa_ssp_write_reg(ssp, SSCR1, val);
 		break;

 	default:
@@ -737,7 +737,7 @@ static int pxa_ssp_probe(struct platform_device *pdev,
 	if (!priv)
 		return -ENOMEM;

-	priv->ssp = ssp_request(dai->id + 1, "SoC audio");
+	priv->ssp = pxa_ssp_request(dai->id + 1, "SoC audio");
 	if (priv->ssp == NULL) {
 		ret = -ENODEV;
 		goto err_priv;
@@ -757,7 +757,7 @@ static void pxa_ssp_remove(struct platform_device *pdev,
 			      struct snd_soc_dai *dai)
 {
 	struct ssp_priv *priv = dai->private_data;
-	ssp_free(priv->ssp);
+	pxa_ssp_free(priv->ssp);
 }

 #define PXA_SSP_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
-- 
1.5.6.5
