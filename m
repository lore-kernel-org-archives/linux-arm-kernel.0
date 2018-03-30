From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Fri, 30 Mar 2018 10:22:41 +0300
Subject: [PATCH 4/6] spi: sun6i: use completion provided by SPI core
In-Reply-To: <20180330072243.19368-1-ssuloev@orpaltech.com>
References: <20180330072243.19368-1-ssuloev@orpaltech.com>
Message-ID: <20180330072243.19368-5-ssuloev@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As long as the completion is already provided by the SPI core
then there is no need to waste extra-memory on this.
Also a waiting function was added to avoid code duplication.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>

---
 drivers/spi/spi-sun6i.c | 50 ++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 13396bd..fc43752 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -99,8 +99,6 @@ struct sun6i_spi {
 	struct clk		*mclk;
 	struct reset_control	*rstc;
 
-	struct completion	done;
-
 	const u8		*tx_buf;
 	u8			*rx_buf;
 	int			len;
@@ -255,6 +253,30 @@ static int sun6i_spi_prepare_message(struct spi_master *master,
 	return 0;
 }
 
+static int sun6i_spi_wait_for_transfer(struct spi_device *spi,
+				       struct spi_transfer *tfr)
+{
+	struct spi_master *master = spi->master;
+	unsigned int start, end, tx_time;
+	unsigned int timeout;
+
+	/* smart wait for completion */
+	tx_time = max(tfr->len * 8 * 2 / (tfr->speed_hz / 1000), 100U);
+	start = jiffies;
+	timeout = wait_for_completion_timeout(&master->xfer_completion,
+					      msecs_to_jiffies(tx_time));
+	end = jiffies;
+	if (!timeout) {
+		dev_warn(&master->dev,
+			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
+			 dev_name(&spi->dev), tfr->len, tfr->speed_hz,
+			 jiffies_to_msecs(end - start), tx_time);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static int sun6i_spi_transfer_one(struct spi_master *master,
 				  struct spi_device *spi,
 				  struct spi_transfer *tfr)
@@ -275,7 +297,6 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	if (tfr->len > sspi->fifo_depth)
 		return -EMSGSIZE;
 
-	reinit_completion(&sspi->done);
 	sspi->tx_buf = tfr->tx_buf;
 	sspi->rx_buf = tfr->rx_buf;
 	sspi->len = tfr->len;
@@ -342,21 +363,9 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
 	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg | SUN6I_TFR_CTL_XCH);
 
-	tx_time = max(tfr->len * 8 * 2 / (tfr->speed_hz / 1000), 100U);
-	start = jiffies;
-	timeout = wait_for_completion_timeout(&sspi->done,
-					      msecs_to_jiffies(tx_time));
-	end = jiffies;
-	if (!timeout) {
-		dev_warn(&master->dev,
-			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
-			 dev_name(&spi->dev), tfr->len, tfr->speed_hz,
-			 jiffies_to_msecs(end - start), tx_time);
-		ret = -ETIMEDOUT;
-		goto out;
-	}
+	/* Wait for completion */
+	ret = sun6i_spi_wait_for_transfer(spi, tfr);
 
-out:
 	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, 0);
 
 	return ret;
@@ -364,7 +373,8 @@ out:
 
 static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
 {
-	struct sun6i_spi *sspi = dev_id;
+	struct spi_master *master = dev_id;
+	struct sun6i_spi *sspi = spi_master_get_devdata(master);
 	u32 status;
 
 	status = sun6i_spi_read(sspi, SUN6I_INT_STA_REG);
@@ -373,7 +383,7 @@ static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
 	if (status & SUN6I_INT_CTL_TC) {
 		sun6i_spi_write(sspi, SUN6I_INT_STA_REG, SUN6I_INT_CTL_TC);
 		sun6i_spi_drain_fifo(sspi, sspi->fifo_depth);
-		complete(&sspi->done);
+		spi_finalize_current_transfer(master);
 		return IRQ_HANDLED;
 	}
 
@@ -494,8 +504,6 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 		goto err_free_master;
 	}
 
-	init_completion(&sspi->done);
-
 	sspi->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(sspi->rstc)) {
 		dev_err(&pdev->dev, "Couldn't get reset controller\n");
-- 
2.16.2
