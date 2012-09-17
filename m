From: mporter@ti.com (Matt Porter)
Date: Mon, 17 Sep 2012 13:22:17 -0400
Subject: [PATCH v2 1/2] spi: omap2-mcspi: add pinctrl support
In-Reply-To: <1347902538-21208-1-git-send-email-mporter@ti.com>
References: <1347902538-21208-1-git-send-email-mporter@ti.com>
Message-ID: <1347902538-21208-2-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds pinctrl support to support OMAP platforms that boot from DT
and rely on pinctrl support to set pinmuxes.

Signed-off-by: Matt Porter <mporter@ti.com>
---
 drivers/spi/spi-omap2-mcspi.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index b2fb141..9502566 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -38,6 +38,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/err.h>
 
 #include <linux/spi/spi.h>
 
@@ -1124,6 +1126,7 @@ static int __devinit omap2_mcspi_probe(struct platform_device *pdev)
 	static int		bus_num = 1;
 	struct device_node	*node = pdev->dev.of_node;
 	const struct of_device_id *match;
+	struct pinctrl *pinctrl;
 
 	master = spi_alloc_master(&pdev->dev, sizeof *mcspi);
 	if (master == NULL) {
@@ -1219,6 +1222,11 @@ static int __devinit omap2_mcspi_probe(struct platform_device *pdev)
 	if (status < 0)
 		goto dma_chnl_free;
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl))
+		dev_warn(&pdev->dev,
+			"pins are not configured from the driver\n");
+
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_enable(&pdev->dev);
-- 
1.7.9.5
