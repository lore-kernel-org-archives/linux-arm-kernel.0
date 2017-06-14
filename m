From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Wed, 14 Jun 2017 11:38:01 +0800
Subject: [PATCH v3 1/3] spi: rockchip: add support for "cs-gpios" dts property
Message-ID: <1497411483-23377-1-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support using "cs-gpios" property to specify cs gpios.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v3:
include linux/gpio/consumer.h for compile errors on ARCH_X86
(reported by kbuild test robot <lkp@intel.com>)

Changes in v2:
1/ request cs gpios in probe for better error handling
2/ use gpiod* function
(suggested by Heiko Stuebner)
3/ split dt-binding changes to new patch
(suggested by Shawn Lin & Heiko Stuebner)

 drivers/spi/spi-rockchip.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index bab9b13..4bcf251 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -16,7 +16,8 @@
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
@@ -663,6 +664,27 @@ static bool rockchip_spi_can_dma(struct spi_master *master,
 	return (xfer->len > rs->fifo_len);
 }
 
+static int rockchip_spi_setup_cs_gpios(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct gpio_desc *cs_gpio;
+	int i, nb;
+
+	if (!np)
+		return 0;
+
+	nb = of_gpio_named_count(np, "cs-gpios");
+	for (i = 0; i < nb; i++) {
+		/* We support both GPIO CS and HW CS */
+		cs_gpio = devm_gpiod_get_index_optional(dev, "cs",
+							i, GPIOD_ASIS);
+		if (IS_ERR(cs_gpio))
+			return PTR_ERR(cs_gpio);
+	}
+
+	return 0;
+}
+
 static int rockchip_spi_probe(struct platform_device *pdev)
 {
 	int ret = 0;
@@ -749,6 +771,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	master->transfer_one = rockchip_spi_transfer_one;
 	master->max_transfer_size = rockchip_spi_max_transfer_size;
 	master->handle_err = rockchip_spi_handle_err;
+	master->flags = SPI_MASTER_GPIO_SS;
 
 	rs->dma_tx.ch = dma_request_chan(rs->dev, "tx");
 	if (IS_ERR(rs->dma_tx.ch)) {
@@ -783,6 +806,12 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		master->dma_rx = rs->dma_rx.ch;
 	}
 
+	ret = rockchip_spi_setup_cs_gpios(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to setup cs gpios\n");
+		goto err_free_dma_rx;
+	}
+
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register master\n");
-- 
2.1.4
