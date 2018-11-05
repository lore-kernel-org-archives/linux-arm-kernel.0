From: broonie@kernel.org (Mark Brown)
Date: Mon,  5 Nov 2018 12:06:47 +0000 (GMT)
Subject: Applied "spi: rockchip: use atomic_t state" to the spi tree
In-Reply-To: <20181031105711.19575-5-esmil@mailme.dk>
Message-ID: <20181105120647.0E9EF1124D98@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: rockchip: use atomic_t state

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From fab3e4871f623c8f86e8a0e00749f1480ffa08db Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 31 Oct 2018 11:57:01 +0100
Subject: [PATCH] spi: rockchip: use atomic_t state

The state field is currently only used to make sure
only the last of the tx and rx dma callbacks issue
an spi_finalize_current_transfer.
Rather than using a spinlock we can get away
with just turning the state field into an atomic_t.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 75 +++++++++++++-------------------------
 1 file changed, 25 insertions(+), 50 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 7fac4253075e..1c813797f963 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -142,8 +142,9 @@
 #define RF_DMA_EN					(1 << 0)
 #define TF_DMA_EN					(1 << 1)
 
-#define RXBUSY						(1 << 0)
-#define TXBUSY						(1 << 1)
+/* Driver state flags */
+#define RXDMA					(1 << 0)
+#define TXDMA					(1 << 1)
 
 /* sclk_out: spi master internal logic in rk3x can support 50Mhz */
 #define MAX_SCLK_OUT		50000000
@@ -169,6 +170,9 @@ struct rockchip_spi {
 	struct clk *apb_pclk;
 
 	void __iomem *regs;
+
+	atomic_t state;
+
 	/*depth of the FIFO buffer */
 	u32 fifo_len;
 	/* max bus freq supported */
@@ -187,10 +191,6 @@ struct rockchip_spi {
 	void *rx;
 	void *rx_end;
 
-	u32 state;
-	/* protect state */
-	spinlock_t lock;
-
 	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
 
 	bool use_dma;
@@ -302,28 +302,21 @@ static int rockchip_spi_prepare_message(struct spi_master *master,
 static void rockchip_spi_handle_err(struct spi_master *master,
 				    struct spi_message *msg)
 {
-	unsigned long flags;
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
-	spin_lock_irqsave(&rs->lock, flags);
-
 	/*
 	 * For DMA mode, we need terminate DMA channel and flush
 	 * fifo for the next transfer if DMA thansfer timeout.
 	 * handle_err() was called by core if transfer failed.
 	 * Maybe it is reasonable for error handling here.
 	 */
-	if (rs->use_dma) {
-		if (rs->state & RXBUSY) {
-			dmaengine_terminate_async(rs->dma_rx.ch);
-			flush_fifo(rs);
-		}
+	if (atomic_read(&rs->state) & TXDMA)
+		dmaengine_terminate_async(rs->dma_tx.ch);
 
-		if (rs->state & TXBUSY)
-			dmaengine_terminate_async(rs->dma_tx.ch);
+	if (atomic_read(&rs->state) & RXDMA) {
+		dmaengine_terminate_async(rs->dma_rx.ch);
+		flush_fifo(rs);
 	}
-
-	spin_unlock_irqrestore(&rs->lock, flags);
 }
 
 static int rockchip_spi_unprepare_message(struct spi_master *master,
@@ -398,48 +391,36 @@ static int rockchip_spi_pio_transfer(struct rockchip_spi *rs)
 
 static void rockchip_spi_dma_rxcb(void *data)
 {
-	unsigned long flags;
 	struct rockchip_spi *rs = data;
+	int state = atomic_fetch_andnot(RXDMA, &rs->state);
 
-	spin_lock_irqsave(&rs->lock, flags);
-
-	rs->state &= ~RXBUSY;
-	if (!(rs->state & TXBUSY)) {
-		spi_enable_chip(rs, false);
-		spi_finalize_current_transfer(rs->master);
-	}
+	if (state & TXDMA)
+		return;
 
-	spin_unlock_irqrestore(&rs->lock, flags);
+	spi_enable_chip(rs, false);
+	spi_finalize_current_transfer(rs->master);
 }
 
 static void rockchip_spi_dma_txcb(void *data)
 {
-	unsigned long flags;
 	struct rockchip_spi *rs = data;
+	int state = atomic_fetch_andnot(TXDMA, &rs->state);
+
+	if (state & RXDMA)
+		return;
 
 	/* Wait until the FIFO data completely. */
 	wait_for_idle(rs);
 
-	spin_lock_irqsave(&rs->lock, flags);
-
-	rs->state &= ~TXBUSY;
-	if (!(rs->state & RXBUSY)) {
-		spi_enable_chip(rs, false);
-		spi_finalize_current_transfer(rs->master);
-	}
-
-	spin_unlock_irqrestore(&rs->lock, flags);
+	spi_enable_chip(rs, false);
+	spi_finalize_current_transfer(rs->master);
 }
 
 static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 {
-	unsigned long flags;
 	struct dma_async_tx_descriptor *rxdesc, *txdesc;
 
-	spin_lock_irqsave(&rs->lock, flags);
-	rs->state &= ~RXBUSY;
-	rs->state &= ~TXBUSY;
-	spin_unlock_irqrestore(&rs->lock, flags);
+	atomic_set(&rs->state, 0);
 
 	rxdesc = NULL;
 	if (rs->rx) {
@@ -490,9 +471,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 
 	/* rx must be started before tx due to spi instinct */
 	if (rxdesc) {
-		spin_lock_irqsave(&rs->lock, flags);
-		rs->state |= RXBUSY;
-		spin_unlock_irqrestore(&rs->lock, flags);
+		atomic_or(RXDMA, &rs->state);
 		dmaengine_submit(rxdesc);
 		dma_async_issue_pending(rs->dma_rx.ch);
 	}
@@ -500,9 +479,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 	spi_enable_chip(rs, true);
 
 	if (txdesc) {
-		spin_lock_irqsave(&rs->lock, flags);
-		rs->state |= TXBUSY;
-		spin_unlock_irqrestore(&rs->lock, flags);
+		atomic_or(TXDMA, &rs->state);
 		dmaengine_submit(txdesc);
 		dma_async_issue_pending(rs->dma_tx.ch);
 	}
@@ -716,8 +693,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		goto err_disable_spiclk;
 	}
 
-	spin_lock_init(&rs->lock);
-
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-- 
2.19.0.rc2
