From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 14 Dec 2017 18:39:37 +0530
Subject: [PATCH 08/12] mmc: sdhci-omap: Add support to override f_max and
 iodelay from pdata
In-Reply-To: <20171214130941.26666-1-kishon@ti.com>
References: <20171214130941.26666-1-kishon@ti.com>
Message-ID: <20171214130941.26666-9-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DRA74x EVM Rev H EVM comes with revision 2.0 silicon. However, earlier
versions of EVM can come with either revision 1.1 or revision 1.0 of
silicon.

The device-tree file is written to support rev 2.0 of silicon.
pdata-quirks are used to then override the settings needed for
PG 1.1 silicon.

PG 1.1 silicon has limitations w.r.t frequencies at which MMC1/2/3
can operate as well as different IOdelay numbers.

Add support in sdhci-omap driver to get platform data if available
(added using pdata quirks) and override the data (max-frequency and
iodelay data) obtained from device tree.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci-omap.c            | 17 ++++++++++++++++
 include/linux/platform_data/sdhci-omap.h | 35 ++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 include/linux/platform_data/sdhci-omap.h

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 6dee275b2e57..cddc3ad1331f 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/platform_data/sdhci-omap.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
@@ -102,6 +103,7 @@ struct sdhci_omap_data {
 };
 
 struct sdhci_omap_host {
+	char			*version;
 	void __iomem		*base;
 	struct device		*dev;
 	struct	regulator	*pbias;
@@ -781,11 +783,18 @@ static struct pinctrl_state
 				  u32 *caps, u32 capmask)
 {
 	struct device *dev = omap_host->dev;
+	char *version = omap_host->version;
 	struct pinctrl_state *pinctrl_state = ERR_PTR(-ENODEV);
+	char str[20];
 
 	if (!(*caps & capmask))
 		goto ret;
 
+	if (version) {
+		sprintf(str, "%s-%s", mode, version);
+		pinctrl_state = pinctrl_lookup_state(omap_host->pinctrl, str);
+	}
+
 	pinctrl_state = pinctrl_lookup_state(omap_host->pinctrl, mode);
 	if (IS_ERR(pinctrl_state)) {
 		dev_err(dev, "no pinctrl state for %s mode", mode);
@@ -879,6 +888,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	const struct of_device_id *match;
 	struct sdhci_omap_data *data;
+	struct sdhci_omap_platform_data *platform_data;
 
 	match = of_match_device(omap_sdhci_match, dev);
 	if (!match)
@@ -913,6 +923,13 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_pltfm_free;
 
+	platform_data = dev_get_platdata(dev);
+	if (platform_data) {
+		omap_host->version = platform_data->version;
+		if (platform_data->max_freq)
+			mmc->f_max = platform_data->max_freq;
+	}
+
 	pltfm_host->clk = devm_clk_get(dev, "fck");
 	if (IS_ERR(pltfm_host->clk)) {
 		ret = PTR_ERR(pltfm_host->clk);
diff --git a/include/linux/platform_data/sdhci-omap.h b/include/linux/platform_data/sdhci-omap.h
new file mode 100644
index 000000000000..a46e1240956a
--- /dev/null
+++ b/include/linux/platform_data/sdhci-omap.h
@@ -0,0 +1,35 @@
+/**
+ * SDHCI Controller Platform Data for TI's OMAP SoCs
+ *
+ * Copyright (C) 2017 Texas Instruments
+ * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __SDHCI_OMAP_PDATA_H__
+#define __SDHCI_OMAP_PDATA_H__
+
+struct sdhci_omap_platform_data {
+	const char *name;
+
+	/*
+	 * set if your board has components or wiring that limits the
+	 * maximum frequency on the MMC bus
+	 */
+	unsigned int max_freq;
+
+	/* string specifying a particular variant of hardware */
+	char *version;
+};
+
+#endif
-- 
2.11.0
