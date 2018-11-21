From: radu_nicolae.pirea@upb.ro (Radu Pirea)
Date: Wed, 21 Nov 2018 13:27:30 +0200
Subject: [PATCH 1/3] spi: at91-usart: add power management support
In-Reply-To: <20181121112732.15690-1-radu_nicolae.pirea@upb.ro>
References: <20181121112732.15690-1-radu_nicolae.pirea@upb.ro>
Message-ID: <20181121112732.15690-2-radu_nicolae.pirea@upb.ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements power management callback function for USART as
SPI driver.

Signed-off-by: Radu Pirea <radu_nicolae.pirea@upb.ro>
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
2.19.1
