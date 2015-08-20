From: hramrach@gmail.com (Michal Suchanek)
Date: 20 Aug 2015 14:19:45 -0000
Subject: [PATCH 1/9] spi: sunxi: fix transfer timeout
In-Reply-To: <cover.1440080122.git.hramrach@gmail.com>
References: <cover.1440080122.git.hramrach@gmail.com>
Message-ID: <0e0b52774a48ddb71dc8095b66942451cd31ff7d.1440080122.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The trasfer timeout is fixed at 1000 ms. Reading a 4Mbyte flash over
1MHz SPI bus takes way longer than that. Calculate the timeout from the
actual time the transfer is supposed to take and multiply by 2 for good
measure.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/spi/spi-sun4i.c | 10 +++++++++-
 drivers/spi/spi-sun6i.c | 10 +++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index fbb0a4d..48532ec 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -170,6 +170,7 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 {
 	struct sun4i_spi *sspi = spi_master_get_devdata(master);
 	unsigned int mclk_rate, div, timeout;
+	unsigned int start, end, tx_time;
 	unsigned int tx_len = 0;
 	int ret = 0;
 	u32 reg;
@@ -279,9 +280,16 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
 	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg | SUN4I_CTL_XCH);
 
+	tx_time = max_t(int, tfr->len * 8 * 2 / (speed / 1000), 100);
+	start = jiffies;
 	timeout = wait_for_completion_timeout(&sspi->done,
-					      msecs_to_jiffies(1000));
+					      msecs_to_jiffies(tx_time));
+	end = jiffies;
 	if (!timeout) {
+		dev_warn(&master->dev,
+			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
+			 dev_name(&spi->dev), tfr->len, speed,
+			 jiffies_to_msecs(end - start), tx_time);
 		ret = -ETIMEDOUT;
 		goto out;
 	}
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index ac48f59..3d0f66c 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -162,6 +162,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	unsigned int mclk_rate, div, timeout;
 	unsigned int tx_len = 0;
 	int ret = 0;
+	unsigned int start, end, tx_time;
 	u32 reg;
 
 	/* We don't support transfer larger than the FIFO */
@@ -269,9 +270,16 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
 	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg | SUN6I_TFR_CTL_XCH);
 
+	tx_time = max_t(int, tfr->len * 8 * 2 / (speed / 1000), 100);
+	start = jiffies;
 	timeout = wait_for_completion_timeout(&sspi->done,
-					      msecs_to_jiffies(1000));
+					      msecs_to_jiffies(tx_time));
+	end = jiffies;
 	if (!timeout) {
+		dev_warn(&master->dev,
+			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
+			 dev_name(&spi->dev), tfr->len, speed,
+			 jiffies_to_msecs(end - start), tx_time);
 		ret = -ETIMEDOUT;
 		goto out;
 	}
-- 
2.1.4
