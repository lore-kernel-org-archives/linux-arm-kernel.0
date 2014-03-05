From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 5 Mar 2014 09:58:49 +0800
Subject: [PATCH 1/2] spi: atmel: adopt pinctrl support
In-Reply-To: <1393984730-14828-1-git-send-email-wenyou.yang@atmel.com>
References: <1393984730-14828-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1393984730-14828-2-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amend the spi atmel pin controller to optionally take a pin control
handle and set the state of the pins to:

- "default" on boot, resume and before performing an spitransfer
- "sleep" on suspend()

This should make it possible to optimize energy usage for the pins
both for the suspend/resume cycle

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 drivers/spi/spi-atmel.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index b0842f7..54b4436 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -26,6 +26,7 @@
 
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/pinctrl/consumer.h>
 
 /* SPI register offsets */
 #define SPI_CR					0x0000
@@ -1303,6 +1304,9 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	struct spi_master	*master;
 	struct atmel_spi	*as;
 
+	/* Select default pin state */
+	pinctrl_pm_select_default_state(&pdev->dev);
+
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs)
 		return -ENXIO;
@@ -1457,6 +1461,9 @@ static int atmel_spi_suspend(struct device *dev)
 	struct atmel_spi	*as = spi_master_get_devdata(master);
 
 	clk_disable_unprepare(as->clk);
+
+	pinctrl_pm_select_sleep_state(dev);
+
 	return 0;
 }
 
@@ -1465,6 +1472,8 @@ static int atmel_spi_resume(struct device *dev)
 	struct spi_master	*master = dev_get_drvdata(dev);
 	struct atmel_spi	*as = spi_master_get_devdata(master);
 
+	pinctrl_pm_select_default_state(dev);
+
 	clk_prepare_enable(as->clk);
 	return 0;
 }
-- 
1.7.9.5
