From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun,  6 May 2012 20:58:14 +0800
Subject: [PATCH 5/5] spi/imx: adopt pinctrl API
In-Reply-To: <1336309094-18517-1-git-send-email-shawn.guo@linaro.org>
References: <1336309094-18517-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1336309094-18517-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/spi/spi-imx.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 570f220..69c9a66 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -37,6 +37,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <mach/spi.h>
 
@@ -758,6 +759,7 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct spi_imx_data *spi_imx;
 	struct resource *res;
+	struct pinctrl *pinctrl;
 	int i, ret, num_cs;
 
 	if (!np && !mxc_platform_info) {
@@ -845,6 +847,12 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 		goto out_iounmap;
 	}
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		ret = PTR_ERR(pinctrl);
+		goto out_free_irq;
+	}
+
 	spi_imx->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(spi_imx->clk)) {
 		dev_err(&pdev->dev, "unable to get clock\n");
-- 
1.7.5.4
