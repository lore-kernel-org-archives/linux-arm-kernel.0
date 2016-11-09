From: broonie@kernel.org (Mark Brown)
Date: Wed, 09 Nov 2016 15:00:42 +0000
Subject: Applied "spi: atmel: use managed resource for gpio chip select" to
 the spi tree
In-Reply-To: <20161108174852.14311-1-nicolas.ferre@atmel.com>
Message-ID: <E1c4UMk-0002p4-LW@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: atmel: use managed resource for gpio chip select

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 9610620078a3900e7fad82de620ce809fd29ba60 Mon Sep 17 00:00:00 2001
From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Tue, 8 Nov 2016 18:48:52 +0100
Subject: [PATCH] spi: atmel: use managed resource for gpio chip select

Use the managed gpio CS pin request so that we avoid having trouble
in the cleanup code.
In fact, if module was configured with DT, cleanup code released
invalid pin.  Since resource wasn't freed, module cannot be reinserted.

This require to extract the gpio request call from the "setup" function
and call it in the appropriate probe function.

Reported-by: Alexander Morozov <linux@meltdown.ru>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c | 50 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 8feac599e9ab..d3affa6afe7e 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -24,6 +24,7 @@
 
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
 
@@ -1204,7 +1205,6 @@ static int atmel_spi_setup(struct spi_device *spi)
 	u32			csr;
 	unsigned int		bits = spi->bits_per_word;
 	unsigned int		npcs_pin;
-	int			ret;
 
 	as = spi_master_get_devdata(spi->master);
 
@@ -1247,16 +1247,9 @@ static int atmel_spi_setup(struct spi_device *spi)
 		if (!asd)
 			return -ENOMEM;
 
-		if (as->use_cs_gpios) {
-			ret = gpio_request(npcs_pin, dev_name(&spi->dev));
-			if (ret) {
-				kfree(asd);
-				return ret;
-			}
-
+		if (as->use_cs_gpios)
 			gpio_direction_output(npcs_pin,
 					      !(spi->mode & SPI_CS_HIGH));
-		}
 
 		asd->npcs_pin = npcs_pin;
 		spi->controller_state = asd;
@@ -1471,13 +1464,11 @@ static int atmel_spi_transfer_one_message(struct spi_master *master,
 static void atmel_spi_cleanup(struct spi_device *spi)
 {
 	struct atmel_spi_device	*asd = spi->controller_state;
-	unsigned		gpio = (unsigned long) spi->controller_data;
 
 	if (!asd)
 		return;
 
 	spi->controller_state = NULL;
-	gpio_free(gpio);
 	kfree(asd);
 }
 
@@ -1499,6 +1490,39 @@ static void atmel_get_caps(struct atmel_spi *as)
 }
 
 /*-------------------------------------------------------------------------*/
+static int atmel_spi_gpio_cs(struct platform_device *pdev)
+{
+	struct spi_master	*master = platform_get_drvdata(pdev);
+	struct atmel_spi	*as = spi_master_get_devdata(master);
+	struct device_node	*np = master->dev.of_node;
+	int			i;
+	int			ret = 0;
+	int			nb = 0;
+
+	if (!as->use_cs_gpios)
+		return 0;
+
+	if (!np)
+		return 0;
+
+	nb = of_gpio_named_count(np, "cs-gpios");
+	for (i = 0; i < nb; i++) {
+		int cs_gpio = of_get_named_gpio(pdev->dev.of_node,
+						"cs-gpios", i);
+
+			if (cs_gpio == -EPROBE_DEFER)
+				return cs_gpio;
+
+			if (gpio_is_valid(cs_gpio)) {
+				ret = devm_gpio_request(&pdev->dev, cs_gpio,
+							dev_name(&pdev->dev));
+				if (ret)
+					return ret;
+			}
+	}
+
+	return 0;
+}
 
 static int atmel_spi_probe(struct platform_device *pdev)
 {
@@ -1577,6 +1601,10 @@ static int atmel_spi_probe(struct platform_device *pdev)
 		master->num_chipselect = 4;
 	}
 
+	ret = atmel_spi_gpio_cs(pdev);
+	if (ret)
+		goto out_unmap_regs;
+
 	as->use_dma = false;
 	as->use_pdc = false;
 	if (as->caps.has_dma_support) {
-- 
2.10.2
