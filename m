From: broonie@kernel.org (Mark Brown)
Date: Tue, 13 Nov 2018 18:34:53 +0000 (GMT)
Subject: Applied "spi: pxa2xx: Add ready signal" to the spi tree
In-Reply-To: <20181113102228.820214-6-lkundrak@v3.sk>
Message-ID: <20181113183454.099FD440079@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: pxa2xx: Add ready signal

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

>From 77d33897c68d56797a3201e06bdf10e2094a96d6 Mon Sep 17 00:00:00 2001
From: Lubomir Rintel <lkundrak@v3.sk>
Date: Tue, 13 Nov 2018 11:22:27 +0100
Subject: [PATCH] spi: pxa2xx: Add ready signal

Strobe a GPIO line when the slave TX FIFO is filled. This is how the
Embedded Controller on an OLPC XO-1.75 machine, that happens to be a SPI
master, learns that it can initiate a transaction.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Tested-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 16 +++++++++++++++-
 drivers/spi/spi-pxa2xx.h |  3 +++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index a057c3be7e3b..69b221e34b2d 100644
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
