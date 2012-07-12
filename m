From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 12 Jul 2012 15:01:41 +0800
Subject: [PATCH 01/12] USB: chipidea: imx: add pinctrl support
In-Reply-To: <1342076512-19207-1-git-send-email-richard.zhao@freescale.com>
References: <1342076512-19207-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1342076512-19207-2-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some controllers may not need to setup pinctrl, so we don't fail the
probe if pinctrl get/select failed.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/usb/chipidea/ci13xxx_imx.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index ef60d06..c94e30f 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -20,6 +20,7 @@
 #include <linux/usb/chipidea.h>
 #include <linux/clk.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pinctrl/consumer.h>
 
 #include "ci.h"
 
@@ -49,6 +50,7 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
 	struct device_node *phy_np;
 	struct resource *res;
 	struct regulator *reg_vbus;
+	struct pinctrl *pinctrl;
 	int ret;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
@@ -63,6 +65,11 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl))
+		dev_warn(&pdev->dev, "pinctrl get/select failed, err=%ld\n",
+			PTR_ERR(pinctrl));
+
 	data->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(data->clk)) {
 		dev_err(&pdev->dev,
-- 
1.7.9.5
