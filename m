From: b29396@freescale.com (Dong Aisheng)
Date: Thu, 15 Dec 2011 00:03:42 +0800
Subject: [RFC PATCH v2 4/4] mmc: sdhci-esdhc-imx: using pinmux subsystem
In-Reply-To: <1323878622-26602-1-git-send-email-b29396@freescale.com>
References: <1323878622-26602-1-git-send-email-b29396@freescale.com>
Message-ID: <1323878622-26602-5-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Chris Ball <cjb@laptop.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 4b976f0..4504136 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
+#include <linux/pinctrl/pinmux.h>
 #include <mach/esdhc.h>
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
@@ -68,6 +69,7 @@ struct pltfm_imx_data {
 	int flags;
 	u32 scratchpad;
 	enum imx_esdhc_type devtype;
+	struct pinmux *pmx;
 	struct esdhc_platform_data boarddata;
 };
 
@@ -439,6 +441,7 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	struct clk *clk;
 	int err;
 	struct pltfm_imx_data *imx_data;
+	struct pinmux *pmx;
 
 	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pdata);
 	if (IS_ERR(host))
@@ -466,6 +469,16 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	clk_enable(clk);
 	pltfm_host->clk = clk;
 
+	pmx = pinmux_get(&pdev->dev, NULL);
+	if (IS_ERR(pmx)) {
+		err = PTR_ERR(pmx);
+		goto err_pmx_get;
+	}
+	err = pinmux_enable(pmx);
+	if (err)
+		goto err_pmx_enable;
+	imx_data->pmx = pmx;
+
 	if (!is_imx25_esdhc(imx_data))
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
@@ -558,6 +571,10 @@ no_card_detect_irq:
 		gpio_free(boarddata->wp_gpio);
 no_card_detect_pin:
 no_board_data:
+	pinmux_disable(imx_data->pmx);
+err_pmx_enable:
+	pinmux_put(imx_data->pmx);
+err_pmx_get:
 	clk_disable(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
 err_clk_get:
@@ -585,6 +602,9 @@ static int __devexit sdhci_esdhc_imx_remove(struct platform_device *pdev)
 		gpio_free(boarddata->cd_gpio);
 	}
 
+	pinmux_disable(imx_data->pmx);
+	pinmux_put(imx_data->pmx);
+
 	clk_disable(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
 	kfree(imx_data);
-- 
1.7.0.4
