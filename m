From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  7 May 2012 08:53:59 +0800
Subject: [PATCH RESEND 4/5] i2c: imx: adopt pinctrl support
In-Reply-To: <1336352040-28447-1-git-send-email-shawn.guo@linaro.org>
References: <1336352040-28447-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1336352040-28447-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: linux-i2c at vger.kernel.org
Cc: Wolfram Sang <w.sang@pengutronix.de>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/i2c/busses/i2c-imx.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index dfb84b7..56bce9a 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -51,6 +51,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_i2c.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <mach/irqs.h>
 #include <mach/hardware.h>
@@ -470,6 +471,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	struct imx_i2c_struct *i2c_imx;
 	struct resource *res;
 	struct imxi2c_platform_data *pdata = pdev->dev.platform_data;
+	struct pinctrl *pinctrl;
 	void __iomem *base;
 	resource_size_t res_size;
 	int irq, bitrate;
@@ -520,6 +522,12 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	i2c_imx->base			= base;
 	i2c_imx->res			= res;
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		ret = PTR_ERR(pinctrl);
+		goto fail3;
+	}
+
 	/* Get I2C clock */
 	i2c_imx->clk = clk_get(&pdev->dev, "i2c_clk");
 	if (IS_ERR(i2c_imx->clk)) {
-- 
1.7.5.4
