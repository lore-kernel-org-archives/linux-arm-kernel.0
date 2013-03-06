From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 06 Mar 2013 17:12:10 +0530
Subject: [PATCH] spi: s3c64xx: let device core setup the default pin
 configuration
Message-ID: <1362570130-14084-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With device core now able to setup the default pin configuration,
the pin configuration code based on the deprecated Samsung specific
gpio bindings is removed.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 .../devicetree/bindings/spi/spi-samsung.txt        |    8 +--
 drivers/spi/spi-s3c64xx.c                          |   66 +------------------
 2 files changed, 6 insertions(+), 68 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
index a15ffed..86aa061 100644
--- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
+++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
@@ -31,9 +31,6 @@ Required Board Specific Properties:
 
 - #address-cells: should be 1.
 - #size-cells: should be 0.
-- gpios: The gpio specifier for clock, mosi and miso interface lines (in the
-  order specified). The format of the gpio specifier depends on the gpio
-  controller.
 
 Optional Board Specific Properties:
 
@@ -86,9 +83,8 @@ Example:
 	spi_0: spi at 12d20000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		gpios = <&gpa2 4 2 3 0>,
-			<&gpa2 6 2 3 0>,
-			<&gpa2 7 2 3 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi0_bus>;
 
 		w25q80bw at 0 {
 			#address-cells = <1>;
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index e862ab8..8537b17 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1052,41 +1052,6 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd, int channel)
 }
 
 #ifdef CONFIG_OF
-static int s3c64xx_spi_parse_dt_gpio(struct s3c64xx_spi_driver_data *sdd)
-{
-	struct device *dev = &sdd->pdev->dev;
-	int idx, gpio, ret;
-
-	/* find gpios for mosi, miso and clock lines */
-	for (idx = 0; idx < 3; idx++) {
-		gpio = of_get_gpio(dev->of_node, idx);
-		if (!gpio_is_valid(gpio)) {
-			dev_err(dev, "invalid gpio[%d]: %d\n", idx, gpio);
-			goto free_gpio;
-		}
-		sdd->gpios[idx] = gpio;
-		ret = gpio_request(gpio, "spi-bus");
-		if (ret) {
-			dev_err(dev, "gpio [%d] request failed: %d\n",
-				gpio, ret);
-			goto free_gpio;
-		}
-	}
-	return 0;
-
-free_gpio:
-	while (--idx >= 0)
-		gpio_free(sdd->gpios[idx]);
-	return -EINVAL;
-}
-
-static void s3c64xx_spi_dt_gpio_free(struct s3c64xx_spi_driver_data *sdd)
-{
-	unsigned int idx;
-	for (idx = 0; idx < 3; idx++)
-		gpio_free(sdd->gpios[idx]);
-}
-
 static struct s3c64xx_spi_info *s3c64xx_spi_parse_dt(struct device *dev)
 {
 	struct s3c64xx_spi_info *sci;
@@ -1119,15 +1084,6 @@ static struct s3c64xx_spi_info *s3c64xx_spi_parse_dt(struct device *dev)
 {
 	return dev->platform_data;
 }
-
-static int s3c64xx_spi_parse_dt_gpio(struct s3c64xx_spi_driver_data *sdd)
-{
-	return -EINVAL;
-}
-
-static void s3c64xx_spi_dt_gpio_free(struct s3c64xx_spi_driver_data *sdd)
-{
-}
 #endif
 
 static const struct of_device_id s3c64xx_spi_dt_match[];
@@ -1247,10 +1203,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	if (!sci->cfg_gpio && pdev->dev.of_node) {
-		if (s3c64xx_spi_parse_dt_gpio(sdd))
-			return -EBUSY;
-	} else if (sci->cfg_gpio == NULL || sci->cfg_gpio()) {
+	if (sci->cfg_gpio && sci->cfg_gpio()) {
 		dev_err(&pdev->dev, "Unable to config gpio\n");
 		ret = -EBUSY;
 		goto err0;
@@ -1261,13 +1214,13 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(sdd->clk)) {
 		dev_err(&pdev->dev, "Unable to acquire clock 'spi'\n");
 		ret = PTR_ERR(sdd->clk);
-		goto err1;
+		goto err0;
 	}
 
 	if (clk_prepare_enable(sdd->clk)) {
 		dev_err(&pdev->dev, "Couldn't enable clock 'spi'\n");
 		ret = -EBUSY;
-		goto err1;
+		goto err0;
 	}
 
 	sprintf(clk_name, "spi_busclk%d", sci->src_clk_nr);
@@ -1324,9 +1277,6 @@ err3:
 	clk_disable_unprepare(sdd->src_clk);
 err2:
 	clk_disable_unprepare(sdd->clk);
-err1:
-	if (!sdd->cntrlr_info->cfg_gpio && pdev->dev.of_node)
-		s3c64xx_spi_dt_gpio_free(sdd);
 err0:
 	platform_set_drvdata(pdev, NULL);
 	spi_master_put(master);
@@ -1349,9 +1299,6 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(sdd->clk);
 
-	if (!sdd->cntrlr_info->cfg_gpio && pdev->dev.of_node)
-		s3c64xx_spi_dt_gpio_free(sdd);
-
 	platform_set_drvdata(pdev, NULL);
 	spi_master_put(master);
 
@@ -1370,9 +1317,6 @@ static int s3c64xx_spi_suspend(struct device *dev)
 	clk_disable_unprepare(sdd->src_clk);
 	clk_disable_unprepare(sdd->clk);
 
-	if (!sdd->cntrlr_info->cfg_gpio && dev->of_node)
-		s3c64xx_spi_dt_gpio_free(sdd);
-
 	sdd->cur_speed = 0; /* Output Clock is stopped */
 
 	return 0;
@@ -1384,9 +1328,7 @@ static int s3c64xx_spi_resume(struct device *dev)
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 
-	if (!sci->cfg_gpio && dev->of_node)
-		s3c64xx_spi_parse_dt_gpio(sdd);
-	else
+	if (sci->cfg_gpio)
 		sci->cfg_gpio();
 
 	/* Enable the clock */
-- 
1.6.6.rc2
