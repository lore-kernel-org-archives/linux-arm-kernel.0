From: hramrach@gmail.com (Michal Suchanek)
Date: 28 Jul 2015 09:37:03 -0000
Subject: [PATCH v2 2/2] spi: s3c64xx: add more debug prints.
In-Reply-To: <cover.1438075797.git.hramrach@gmail.com>
References: <cover.1438075797.git.hramrach@gmail.com>
Message-ID: <8b628c8d38c4a01f5c4657a4213984d98789d757.1438075797.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SPI transfers can mysteriously fail so add more debug prints about
SPI parameters set by the driver.

The hardware specific SPI driver is the only place where the programmed
SPI parameters are known so there is no other reasonable place for these
prints.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>

--

 - simplify by using dev_dbg and %pC
---
 drivers/spi/spi-s3c64xx.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index cd1cfac..3574525 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -469,6 +469,7 @@ static int wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
 {
 	void __iomem *regs = sdd->regs;
 	unsigned long val;
+	unsigned long start, end;
 	u32 status;
 	int ms;
 
@@ -476,8 +477,17 @@ static int wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
 	ms = xfer->len * 8 * 1000 / sdd->cur_speed;
 	ms += 10; /* some tolerance */
 
+	dev_dbg(&sdd->master->dev,
+		"%s: waiting for %ims transferring %zubytes@%iHz",
+		 __func__, ms, xfer->len, sdd->cur_speed);
+
 	val = msecs_to_jiffies(ms) + 10;
+	start = jiffies;
 	val = wait_for_completion_timeout(&sdd->xfer_completion, val);
+	end = jiffies;
+
+	dev_dbg(&sdd->master->dev, "%s: waited %u ms",
+		 __func__, jiffies_to_msecs(end - start));
 
 	/*
 	 * If the previous xfer was completed within timeout, then
@@ -576,6 +586,13 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 	void __iomem *regs = sdd->regs;
 	u32 val;
 
+	dev_dbg(&sdd->master->dev,
+		"%s: clk_from_cmu %i src_clk %pC mode%s%s bpw %i",
+		 __func__, sdd->port_conf->clk_from_cmu, sdd->src_clk,
+		 (sdd->cur_mode & SPI_CPOL) ? " SPI_CPOL" : "",
+		 (sdd->cur_mode & SPI_CPHA) ? " SPI_CPHA" : "",
+		 sdd->cur_bpw);
+
 	/* Disable Clock */
 	if (sdd->port_conf->clk_from_cmu) {
 		clk_disable_unprepare(sdd->src_clk);
@@ -678,6 +695,9 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	unsigned long flags;
 	int use_dma;
 
+	dev_dbg(&master->dev, "%s %s: xfer bpw %i speed %i",
+		 dev_name(&spi->dev), __func__,
+		 xfer->bits_per_word, xfer->speed_hz);
 	reinit_completion(&sdd->xfer_completion);
 
 	/* Only BPW and Speed may change across transfers */
@@ -696,6 +716,9 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	    (sdd->rx_dma.ch && sdd->tx_dma.ch &&
 	     (xfer->len > ((FIFO_LVL_MASK(sdd) >> 1) + 1))))
 		use_dma = 1;
+	dev_dbg(&master->dev, "%s %s: %susing dma",
+		 dev_name(&spi->dev), __func__,
+		 use_dma ? "" : "not ");
 
 	spin_lock_irqsave(&sdd->lock, flags);
 
-- 
2.1.4
