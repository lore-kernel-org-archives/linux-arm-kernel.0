From: hramrach@gmail.com (Michal Suchanek)
Date: 13 Jun 2016 17:46:49 -0000
Subject: [PATCH v3 02/13] spi: sunxi: fix transfer timeout
In-Reply-To: <cover.1465490774.git.hramrach@gmail.com>
References: <cover.1465490774.git.hramrach@gmail.com>
Message-ID: <064955d033503f129c3e138b0563817d1fffab27.1465490774.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The trasfer timeout is fixed at 1000 ms. Reading a 4Mbyte flash over
1MHz SPI bus takes way longer than that. Calculate the timeout from the
actual time the transfer is supposed to take and multiply by 2 for good
measure.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---

v2:
- fix build error
- use unsigned instead of int in max_t
- use tfr->speed_hz instead of sspi->max_speed_hz
  - commit 47284e3e0f3c427c93f8583549b6c938e8a18015 changes the driver
    to use tfr->speed_hz
v3:
- avoid max_t by using unsigned constant
---
 drivers/spi/spi-sun4i.c | 10 +++++++++-
 drivers/spi/spi-sun6i.c | 10 +++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 4213508..0c2216a 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -173,6 +173,7 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
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
 
+	tx_time = max(tfr->len * 8 * 2 / (tfr->speed_hz / 1000), 100U);
+	start = jiffies;
 	timeout = wait_for_completion_timeout(&sspi->done,
-					      msecs_to_jiffies(1000));
+					      msecs_to_jiffies(tx_time));
+	end = jiffies;
 	if (!timeout) {
+		dev_warn(&master->dev,
+			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
+			 dev_name(&spi->dev), tfr->len, tfr->speed_hz,
+			 jiffies_to_msecs(end - start), tx_time);
 		ret = -ETIMEDOUT;
 		goto out;
 	}
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index fe70695..8f6be86 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -160,6 +160,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 {
 	struct sun6i_spi *sspi = spi_master_get_devdata(master);
 	unsigned int mclk_rate, div, timeout;
+	unsigned int start, end, tx_time;
 	unsigned int tx_len = 0;
 	int ret = 0;
 	u32 reg;
@@ -269,9 +270,16 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
 	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg | SUN6I_TFR_CTL_XCH);
 
+	tx_time = max(tfr->len * 8 * 2 / (tfr->speed_hz / 1000), 100U);
+	start = jiffies;
 	timeout = wait_for_completion_timeout(&sspi->done,
-					      msecs_to_jiffies(1000));
+					      msecs_to_jiffies(tx_time));
+	end = jiffies;
 	if (!timeout) {
+		dev_warn(&master->dev,
+			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
+			 dev_name(&spi->dev), tfr->len, tfr->speed_hz,
+			 jiffies_to_msecs(end - start), tx_time);
 		ret = -ETIMEDOUT;
 		goto out;
 	}
-- 
2.8.1
