From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Wed, 16 Apr 2014 14:40:08 +0200
Subject: [PATCH 1/4] mmc: sdhci: add a driver for Berlin SoCs
In-Reply-To: <1397652011-21284-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1397652011-21284-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1397652011-21284-2-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a Driver to support the SDHCI controller of the Marvell Berlin SoCs.
This controller supports 3 sockets.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 drivers/mmc/host/Kconfig        |  11 ++++
 drivers/mmc/host/Makefile       |   1 +
 drivers/mmc/host/sdhci-berlin.c | 129 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-berlin.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 1384f67abe21..42db70031eb2 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -283,6 +283,17 @@ config MMC_SDHCI_BCM2835
 
 	  If unsure, say N.
 
+config MMC_SDHCI_BERLIN
+	tristate "Marvell Berlin SD/MMC Host Controller support"
+	depends on ARCH_BERLIN
+	depends on MMC_SDHCI_PLTFM
+	select MMC_SDHCI_IO_ACCESSORS
+	help
+	  This selects the Berlin SD/MMC controller. If you have a Berlin
+	  platform with SD or MMC devices, say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_OMAP
 	tristate "TI OMAP Multimedia Card Interface support"
 	depends on ARCH_OMAP
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 3483b6b6b880..b0256290530c 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
 obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
 obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+= sdhci-bcm-kona.o
 obj-$(CONFIG_MMC_SDHCI_BCM2835)		+= sdhci-bcm2835.o
+obj-$(CONFIG_MMC_SDHCI_BERLIN)		+= sdhci-berlin.o
 
 ifeq ($(CONFIG_CB710_DEBUG),y)
 	CFLAGS-cb710-mmc	+= -DDEBUG
diff --git a/drivers/mmc/host/sdhci-berlin.c b/drivers/mmc/host/sdhci-berlin.c
new file mode 100644
index 000000000000..ece8f7863937
--- /dev/null
+++ b/drivers/mmc/host/sdhci-berlin.c
@@ -0,0 +1,129 @@
+/*
+ * Marvell Berlin SDHCI driver
+ *
+ * Copyright (C) 2014 Marvell Technology Group Ltd.
+ *
+ * Antoine T?nart <antoine.tenart@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/mmc/host.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#include "sdhci-pltfm.h"
+
+static struct sdhci_ops sdhci_berlin_ops = {
+	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
+};
+
+static struct sdhci_pltfm_data sdhci_berlin2_pdata = {
+	.quirks	= SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+		  SDHCI_QUIRK_BROKEN_ADMA |
+		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
+	.ops = &sdhci_berlin_ops,
+};
+
+static struct sdhci_pltfm_data sdhci_berlin2q_pdata = {
+	.quirks	= SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
+		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
+	.ops = &sdhci_berlin_ops,
+};
+
+static const struct of_device_id sdhci_berlin_of_match_table[] = {
+	{
+		.compatible = "marvell,berlin2-sdhci",
+		.data = &sdhci_berlin2_pdata,
+	},
+	{
+		.compatible = "marvell,berlin2cd-sdhci",
+		.data = &sdhci_berlin2_pdata,
+	},
+	{
+		.compatible = "marvell,berlin2q-sdhci",
+		.data = &sdhci_berlin2q_pdata,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, sdhci_berlin_of_match_table);
+
+static int sdhci_berlin_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sdhci_host *host;
+	struct sdhci_pltfm_host *pltfm_host;
+	struct clk *clk;
+	const struct of_device_id *device =
+		of_match_device(sdhci_berlin_of_match_table, dev);
+	int ret;
+
+	host = sdhci_pltfm_init(pdev,
+				(struct sdhci_pltfm_data *)device->data, 0);
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	pltfm_host = sdhci_priv(host);
+
+	clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(clk)) {
+		dev_err(dev, "could not get clock: %ld\n", PTR_ERR(clk));
+		ret = PTR_ERR(clk);
+		goto err_clk_get;
+	}
+
+	clk_prepare_enable(clk);
+	pltfm_host->clk = clk;
+
+	sdhci_get_of_property(pdev);
+
+	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
+		host->mmc->caps |= MMC_CAP_NONREMOVABLE;
+
+	ret = sdhci_add_host(host);
+	if (ret)
+		goto err_add_host;
+
+	return 0;
+
+err_add_host:
+	clk_disable_unprepare(pltfm_host->clk);
+err_clk_get:
+	sdhci_pltfm_free(pdev);
+
+	return ret;
+}
+
+static int sdhci_berlin_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	sdhci_pltfm_unregister(pdev);
+	clk_disable_unprepare(pltfm_host->clk);
+
+	return 0;
+}
+
+static struct platform_driver sdhci_berlin_driver = {
+	.driver		= {
+		.name	= "berlin-sdhci",
+		.owner	= THIS_MODULE,
+		.pm	= SDHCI_PLTFM_PMOPS,
+		.of_match_table = sdhci_berlin_of_match_table,
+	},
+	.probe		= sdhci_berlin_probe,
+	.remove		= sdhci_berlin_remove,
+};
+module_platform_driver(sdhci_berlin_driver);
+
+MODULE_DESCRIPTION("SDHCI driver for Marvell Berlin SoC");
+MODULE_AUTHOR("Antoine T?nart <antoine.tenart@free-electrons.com>");
+MODULE_LICENSE("GPL");
-- 
1.8.3.2
