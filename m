From: hechtb@gmail.com (Bastian Hecht)
Date: Wed,  7 Nov 2012 12:40:06 +0100
Subject: [PATCH 3/4] spi: sh-msiof: Add device tree parsing to driver
In-Reply-To: <1352288407-20594-1-git-send-email-hechtb@gmail.com>
References: <1352288407-20594-1-git-send-email-hechtb@gmail.com>
Message-ID: <1352288407-20594-4-git-send-email-hechtb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the capability to retrieve setup data from the device tree
node. The usage of platform data is still available.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
 drivers/spi/spi-sh-msiof.c |   54 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 53 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 96358d0..65cd19c 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
@@ -592,6 +593,35 @@ static u32 sh_msiof_spi_txrx_word(struct spi_device *spi, unsigned nsecs,
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct sh_msiof_spi_info *sh_msiof_spi_parse_dt(struct device *dev)
+{
+	struct sh_msiof_spi_info *info;
+	struct device_node *np = dev->of_node;
+	u32 chipselect = 0;
+
+	info = devm_kzalloc(dev, sizeof(struct sh_msiof_spi_info), GFP_KERNEL);
+	if (!info) {
+		dev_err(dev, "failed to allocate setup data\n");
+		return NULL;
+	}
+
+	/* Parse the MSIOF properties */
+	of_property_read_u32(np, "chip-select", &chipselect);
+	of_property_read_u32(np, "tx_fifo_size", &info->tx_fifo_override);
+	of_property_read_u32(np, "rx_fifo_size", &info->rx_fifo_override);
+
+	info->num_chipselect = chipselect;
+
+	return info;
+}
+#else
+static struct sh_msiof_spi_info *sh_msiof_spi_parse_dt(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 static int sh_msiof_spi_probe(struct platform_device *pdev)
 {
 	struct resource	*r;
@@ -610,7 +640,17 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	p = spi_master_get_devdata(master);
 
 	platform_set_drvdata(pdev, p);
-	p->info = pdev->dev.platform_data;
+	if (pdev->dev.of_node)
+		p->info = sh_msiof_spi_parse_dt(&pdev->dev);
+	else
+		p->info = pdev->dev.platform_data;
+
+	if (!p->info) {
+		dev_err(&pdev->dev, "failed to obtain device info\n");
+		ret = -ENXIO;
+		goto err1;
+	}
+
 	init_completion(&p->done);
 
 	p->clk = clk_get(&pdev->dev, NULL);
@@ -715,6 +755,17 @@ static int sh_msiof_spi_runtime_nop(struct device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id sh_msiof_match[] = {
+	{ .compatible = "renesas,sh-msiof", },
+	{ .compatible = "renesas,sh-mobile-msiof", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sh_msiof_match);
+#else
+#define sh_msiof_match NULL
+#endif
+
 static struct dev_pm_ops sh_msiof_spi_dev_pm_ops = {
 	.runtime_suspend = sh_msiof_spi_runtime_nop,
 	.runtime_resume = sh_msiof_spi_runtime_nop,
@@ -727,6 +778,7 @@ static struct platform_driver sh_msiof_spi_drv = {
 		.name		= "spi_sh_msiof",
 		.owner		= THIS_MODULE,
 		.pm		= &sh_msiof_spi_dev_pm_ops,
+		.of_match_table = sh_msiof_match,
 	},
 };
 module_platform_driver(sh_msiof_spi_drv);
-- 
1.7.5.4
