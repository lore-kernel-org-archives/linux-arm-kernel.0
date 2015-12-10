From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 10 Dec 2015 12:10:12 +0100
Subject: [PATCH] gpio: zynq: Do PM initialization earlier to support gpio hogs
Message-ID: <fc67101afc0d10efbaeeb6bc3d881ab49e3f4671.1449745801.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO hogs registration is call at the end of gpiochip_add() function.
Calling sequence is:
gpiochip_add -> of_gpiochip_add -> of_gpiochip_scan_hogs ->
gpiod_hog -> gpiochip_request_own_desc -> __gpiod_request ->
chip->request -> zynq_gpio_request which calls pm_runtime_get_sync()
which returns -13 because PM is not initialized yet.

Initialize PM before gpiochip_add is called to fix this issue.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---

 drivers/gpio/gpio-zynq.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 00306e70a420..a0cabd17c9d0 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -710,23 +710,23 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 	chip->base = -1;
 	chip->ngpio = gpio->p_data->ngpio;
 
-	/* Enable GPIO clock */
+	/* Retrieve GPIO clock */
 	gpio->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(gpio->clk)) {
 		dev_err(&pdev->dev, "input clock not found.\n");
 		return PTR_ERR(gpio->clk);
 	}
-	ret = clk_prepare_enable(gpio->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Unable to enable clock.\n");
+
+	pm_runtime_enable(&pdev->dev);
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	/* report a bug if gpio chip registration fails */
 	ret = gpiochip_add(chip);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to add gpio chip\n");
-		goto err_disable_clk;
+		goto err_pm_put;
 	}
 
 	/* disable interrupts for all banks */
@@ -744,15 +744,14 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 	gpiochip_set_chained_irqchip(chip, &zynq_gpio_edge_irqchip, gpio->irq,
 				     zynq_gpio_irqhandler);
 
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_put(&pdev->dev);
 
 	return 0;
 
 err_rm_gpiochip:
 	gpiochip_remove(chip);
-err_disable_clk:
-	clk_disable_unprepare(gpio->clk);
+err_pm_put:
+	pm_runtime_put(&pdev->dev);
 
 	return ret;
 }
-- 
1.9.1
