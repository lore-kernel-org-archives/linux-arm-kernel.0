From: tpiepho@impinj.com (Trent Piepho)
Date: Fri, 13 Oct 2017 12:54:07 -0700
Subject: [PATCH 1/4] spi: imx: GPIO based chip selects should not be required
Message-ID: <20171013195410.30767-1-tpiepho@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver will fail to load if no gpio chip selects are specified,
this patch changes this so that it no longer fails.

It's possible to use all native chip selects, in which case there is
no reason to have a gpio chip select array.  This is what happens if
the *optional* device tree property "cs-gpios" is omitted.

The spi core already checks for the absence of gpio chip selects in
the master and assigns any slaves the gpio_cs value of -ENOENT.

Signed-off-by: Trent Piepho <tpiepho@impinj.com>
---
 drivers/spi/spi-imx.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index babb15f07995..07e6250f2dad 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1457,22 +1457,19 @@ static int spi_imx_probe(struct platform_device *pdev)
 		goto out_clk_put;
 	}
 
-	if (!master->cs_gpios) {
-		dev_err(&pdev->dev, "No CS GPIOs available\n");
-		ret = -EINVAL;
-		goto out_clk_put;
-	}
-
-	for (i = 0; i < master->num_chipselect; i++) {
-		if (!gpio_is_valid(master->cs_gpios[i]))
-			continue;
-
-		ret = devm_gpio_request(&pdev->dev, master->cs_gpios[i],
-					DRIVER_NAME);
-		if (ret) {
-			dev_err(&pdev->dev, "Can't get CS GPIO %i\n",
-				master->cs_gpios[i]);
-			goto out_clk_put;
+	/* Request GPIO CS lines, if any */
+	if (master->cs_gpios) {
+		for (i = 0; i < master->num_chipselect; i++) {
+			if (!gpio_is_valid(master->cs_gpios[i]))
+				continue;
+
+			ret = devm_gpio_request(&pdev->dev, master->cs_gpios[i],
+						DRIVER_NAME);
+			if (ret) {
+				dev_err(&pdev->dev, "Can't get CS GPIO %i\n",
+					master->cs_gpios[i]);
+				goto out_clk_put;
+			}
 		}
 	}
 
-- 
2.13.6
