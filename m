From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Nov 2018 16:05:54 +0000 (GMT)
Subject: Applied "spi: at91-usart: add power management support" to the spi
 tree
In-Reply-To: <20181121112732.15690-2-radu_nicolae.pirea@upb.ro>
Message-ID: <20181128160554.460C0112521B@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: at91-usart: add power management support

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

>From 96ed3ecde2c0911ffa11838050a058c2a40742f0 Mon Sep 17 00:00:00 2001
From: Radu Pirea <radu_nicolae.pirea@upb.ro>
Date: Wed, 21 Nov 2018 13:27:30 +0200
Subject: [PATCH] spi: at91-usart: add power management support

This patch implements power management callback function for USART as
SPI driver.

Signed-off-by: Radu Pirea <radu_nicolae.pirea@upb.ro>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-at91-usart.c | 61 ++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index a924657642fa..0b07c746453d 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of_gpio.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/spi/spi.h>
 
@@ -399,6 +400,59 @@ static int at91_usart_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
+__maybe_unused static int at91_usart_spi_runtime_suspend(struct device *dev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
+
+	clk_disable_unprepare(aus->clk);
+	pinctrl_pm_select_sleep_state(dev);
+
+	return 0;
+}
+
+__maybe_unused static int at91_usart_spi_runtime_resume(struct device *dev)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	struct at91_usart_spi *aus = spi_master_get_devdata(ctrl);
+
+	pinctrl_pm_select_default_state(dev);
+
+	return clk_prepare_enable(aus->clk);
+}
+
+__maybe_unused static int at91_usart_spi_suspend(struct device *dev)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	int ret;
+
+	ret = spi_controller_suspend(ctrl);
+	if (ret)
+		return ret;
+
+	if (!pm_runtime_suspended(dev))
+		at91_usart_spi_runtime_suspend(dev);
+
+	return 0;
+}
+
+__maybe_unused static int at91_usart_spi_resume(struct device *dev)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	struct at91_usart_spi *aus = spi_master_get_devdata(ctrl);
+	int ret;
+
+	if (!pm_runtime_suspended(dev)) {
+		ret = at91_usart_spi_runtime_resume(dev);
+		if (ret)
+			return ret;
+	}
+
+	at91_usart_spi_init(aus);
+
+	return spi_controller_resume(ctrl);
+}
+
 static int at91_usart_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
@@ -409,6 +463,12 @@ static int at91_usart_spi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct dev_pm_ops at91_usart_spi_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(at91_usart_spi_suspend, at91_usart_spi_resume)
+	SET_RUNTIME_PM_OPS(at91_usart_spi_runtime_suspend,
+			   at91_usart_spi_runtime_resume, NULL)
+};
+
 static const struct of_device_id at91_usart_spi_dt_ids[] = {
 	{ .compatible = "microchip,at91sam9g45-usart-spi"},
 	{ /* sentinel */}
@@ -419,6 +479,7 @@ MODULE_DEVICE_TABLE(of, at91_usart_spi_dt_ids);
 static struct platform_driver at91_usart_spi_driver = {
 	.driver = {
 		.name = "at91_usart_spi",
+		.pm = &at91_usart_spi_pm_ops,
 	},
 	.probe = at91_usart_spi_probe,
 	.remove = at91_usart_spi_remove,
-- 
2.19.0.rc2
