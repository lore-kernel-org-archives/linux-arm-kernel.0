From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Tue,  3 Apr 2018 18:44:47 +0300
Subject: [PATCH v3 4/6] spi: sun6i: use completion provided by SPI core
In-Reply-To: <20180403154449.2443-1-ssuloev@orpaltech.com>
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
Message-ID: <20180403154449.2443-5-ssuloev@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As long as the completion is already provided by the SPI core
then there is no need to waste extra-memory on this.
Also a waiting function was added to avoid code duplication.

Changes in v2:
1) Fixed issue with passing an invalid argument into devm_request_irq()
function.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
---
 drivers/spi/spi-sun6i.c | 52 ++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index c09ad10..0912404 100644
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
@@ -246,6 +244,30 @@ static int sun6i_spi_prepare_message(struct spi_master *master,
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
@@ -267,7 +289,6 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	if (tfr->len > sspi->fifo_depth)
 		return -EMSGSIZE;
 
-	reinit_completion(&sspi->done);
 	sspi->tx_buf = tfr->tx_buf;
 	sspi->rx_buf = tfr->rx_buf;
 	sspi->len = tfr->len;
@@ -358,21 +379,9 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
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
@@ -380,7 +389,8 @@ out:
 
 static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
 {
-	struct sun6i_spi *sspi = dev_id;
+	struct spi_master *master = dev_id;
+	struct sun6i_spi *sspi = spi_master_get_devdata(master);
 	u32 status;
 
 	status = sun6i_spi_read(sspi, SUN6I_INT_STA_REG);
@@ -389,7 +399,7 @@ static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
 	if (status & SUN6I_INT_CTL_TC) {
 		sun6i_spi_write(sspi, SUN6I_INT_STA_REG, SUN6I_INT_CTL_TC);
 		sun6i_spi_drain_fifo(sspi, sspi->fifo_depth);
-		complete(&sspi->done);
+		spi_finalize_current_transfer(master);
 		return IRQ_HANDLED;
 	}
 
@@ -496,7 +506,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, sun6i_spi_handler,
-			       0, dev_name(&pdev->dev), sspi);
+			       0, dev_name(&pdev->dev), master);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot request IRQ\n");
 		goto err_free_master;
@@ -518,8 +528,6 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 		goto err_free_master;
 	}
 
-	init_completion(&sspi->done);
-
 	sspi->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(sspi->rstc)) {
 		dev_err(&pdev->dev, "Couldn't get reset controller\n");
-- 
2.16.2
