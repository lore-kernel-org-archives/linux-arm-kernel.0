From: davidm@egauge.net (David Mosberger)
Date: Mon, 12 Oct 2015 16:32:01 -0600
Subject: [PATCH] spi-atmel.c: fix DMA for bits_per_word > 8
Message-ID: <CALnQHM3WxNDV3xzJwRfGRVTMYL1mo44VbBb2YawZVUzn0CzFfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I need the patch below to make DMA work in spi-atmel.c when bits_per_word > 8.

  --david
-- 
eGauge Systems LLC, http://egauge.net/, 1.877-EGAUGE1, fax 720.545.9768

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 04e48e5..7bb361a 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -711,6 +711,7 @@ static void atmel_spi_next_xfer_pio(struct
spi_master *master,
  * Submit next transfer for DMA.
  */
 static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
+  struct spi_message *msg,
  struct spi_transfer *xfer,
  u32 *plen)
 {
@@ -721,7 +722,7 @@ static int atmel_spi_next_xfer_dma_submit(struct
spi_master *master,
  struct dma_async_tx_descriptor *txdesc;
  struct dma_slave_config slave_config;
  dma_cookie_t cookie;
- u32 len = *plen;
+ u32 len = *plen, bpw;

  dev_vdbg(master->dev.parent, "atmel_spi_next_xfer_dma_submit\n");

@@ -758,7 +759,11 @@ static int atmel_spi_next_xfer_dma_submit(struct
spi_master *master,

  *plen = len;

- if (atmel_spi_dma_slave_config(as, &slave_config, 8))
+ bpw = xfer->bits_per_word;
+ if (!bpw)
+ bpw = msg->spi->bits_per_word;
+
+ if (atmel_spi_dma_slave_config(as, &slave_config, bpw))
  goto err_exit;

  /* Send both scatterlists */
@@ -1316,8 +1321,8 @@ static int atmel_spi_one_transfer(struct
spi_master *master,
  atmel_spi_pdc_next_xfer(master, msg, xfer);
  } else if (atmel_spi_use_dma(as, xfer)) {
  len = as->current_remaining_bytes;
- ret = atmel_spi_next_xfer_dma_submit(master,
- xfer, &len);
+ ret = atmel_spi_next_xfer_dma_submit(master, msg,
+     xfer, &len);
  if (ret) {
  dev_err(&spi->dev,
  "unable to use DMA, fallback to PIO\n");
