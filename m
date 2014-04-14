From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 14 Apr 2014 15:35:47 +0200
Subject: [PATCH v3 17/18] ASoC: fsl-ssi: reorder and document fsl_ssi_private
In-Reply-To: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
References: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1397482548-28463-18-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reorder all variables in struct fsl_ssi_private to have groups that make
sense together. The patch also updates the struct documentation.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 59 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 9425299..f8a30689 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -141,35 +141,62 @@ struct fsl_ssi_soc_data {
 /**
  * fsl_ssi_private: per-SSI private data
  *
- * @ssi: pointer to the SSI's registers
- * @ssi_phys: physical address of the SSI registers
+ * @ssi: Pointer to the memory area
  * @irq: IRQ of this SSI
- * @playback: the number of playback streams opened
- * @capture: the number of capture streams opened
- * @cpu_dai: the CPU DAI for this device
- * @dev_attr: the sysfs device attribute structure
- * @stats: SSI statistics
+ * @cpu_dai_drv: CPU DAI driver for this device
+ *
+ * @dai_fmt: DAI configuration this device is currently used with
+ * @i2s_mode: i2s and network mode configuration of the device. Is used to
+ * switch between normal and i2s/network mode
+ * mode depending on the number of channels
+ * @use_dma: DMA is used or FIQ with stream filter
+ * @use_dual_fifo: DMA with support for both FIFOs used
+ * @fifo_deph: Depth of the SSI FIFOs
+ * @rxtx_reg_val: Specific register settings for receive/transmit configuration
+ *
+ * @clk: SSI clock
+ * @baudclk: SSI baud clock for master mode
+ * @baudclk_locked: SSI baudclk is locked because it is in use
+ *
+ * @dma_params_tx: DMA transmit parameters
+ * @dma_params_rx: DMA receive parameters
+ * @ssi_phys: physical address of the SSI registers
+ *
+ * @fiq_params: FIQ stream filtering parameters
+ *
+ * @pdev: Pointer to pdev used for deprecated fsl-ssi sound card
+ *
+ * @dbg_stats: Debugging statistics
+ *
+ * @soc: SoC specifc data
  */
 struct fsl_ssi_private {
 	struct ccsr_ssi __iomem *ssi;
-	dma_addr_t ssi_phys;
 	unsigned int irq;
-	unsigned int fifo_depth;
 	struct snd_soc_dai_driver cpu_dai_drv;
-	struct platform_device *pdev;
-	unsigned int dai_fmt;
 
+	unsigned int dai_fmt;
+	u8 i2s_mode;
 	bool use_dma;
-	bool baudclk_locked;
 	bool use_dual_fifo;
-	u8 i2s_mode;
-	struct clk *baudclk;
+	unsigned int fifo_depth;
+	struct fsl_ssi_rxtx_reg_val rxtx_reg_val;
+
 	struct clk *clk;
+	struct clk *baudclk;
+	bool baudclk_locked;
+
+	/* DMA params */
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
+	dma_addr_t ssi_phys;
+
+	/* params for non-dma FIQ stream filtered mode */
 	struct imx_pcm_fiq_params fiq_params;
-	/* Register values for rx/tx configuration */
-	struct fsl_ssi_rxtx_reg_val rxtx_reg_val;
+
+	/* Used when using fsl-ssi as sound-card. This is only used by ppc and
+	 * should be replaced with simple-sound-card. */
+	struct platform_device *pdev;
 
 	struct fsl_ssi_dbg dbg_stats;
 
-- 
1.9.1
