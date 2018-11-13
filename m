From: lkundrak@v3.sk (Lubomir Rintel)
Date: Tue, 13 Nov 2018 11:22:27 +0100
Subject: [PATCH v3 5/6] spi: pxa2xx: Add ready signal
In-Reply-To: <20181113102228.820214-1-lkundrak@v3.sk>
References: <20181113102228.820214-1-lkundrak@v3.sk>
Message-ID: <20181113102228.820214-6-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Strobe a GPIO line when the slave TX FIFO is filled. This is how the
Embedded Controller on an OLPC XO-1.75 machine, that happens to be a SPI
master, learns that it can initiate a transaction.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Tested-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v2
- Avoid an useless delay if there's no ready GPIO
- Remove useless (int)PTR_ERR(...) casts from pxa2xx_spi_probe()
  (thanks to Geert Uytterhoeven)

 drivers/spi/spi-pxa2xx.c | 16 +++++++++++++++-
 drivers/spi/spi-pxa2xx.h |  3 +++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 54ae77f1227c..7e5aab0af501 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1081,6 +1081,11 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
 	if (spi_controller_is_slave(master)) {
 		while (drv_data->write(drv_data))
 			;
+		if (drv_data->gpiod_ready) {
+			gpiod_set_value(drv_data->gpiod_ready, 1);
+			udelay(1);
+			gpiod_set_value(drv_data->gpiod_ready, 0);
+		}
 	}
 
 	/*
@@ -1778,7 +1783,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 				if (PTR_ERR(gpiod) == -ENOENT)
 					continue;
 
-				status = (int)PTR_ERR(gpiod);
+				status = PTR_ERR(gpiod);
 				goto out_error_clock_enabled;
 			} else {
 				drv_data->cs_gpiods[i] = gpiod;
@@ -1786,6 +1791,15 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (platform_info->is_slave) {
+		drv_data->gpiod_ready = devm_gpiod_get_optional(dev,
+						"ready", GPIOD_OUT_LOW);
+		if (IS_ERR(drv_data->gpiod_ready)) {
+			status = PTR_ERR(drv_data->gpiod_ready);
+			goto out_error_clock_enabled;
+		}
+	}
+
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 513c53aaeab2..4e324da66ef7 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -64,6 +64,9 @@ struct driver_data {
 
 	/* GPIOs for chip selects */
 	struct gpio_desc **cs_gpiods;
+
+	/* Optional slave FIFO ready signal */
+	struct gpio_desc *gpiod_ready;
 };
 
 struct chip_data {
-- 
2.19.1
