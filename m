From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 28 Aug 2012 15:03:07 +0800
Subject: [PATCH v2 01/11] USB: chipidea: imx: add pinctrl support
In-Reply-To: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
References: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1346137397-32374-2-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some controllers may not need to setup pinctrl, so we don't fail the
probe if pinctrl get/select failed.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/usb/chipidea/ci13xxx_imx.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index 96ac67b..0f5ca4b 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -20,6 +20,7 @@
 #include <linux/usb/chipidea.h>
 #include <linux/clk.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pinctrl/consumer.h>
 
 #include "ci.h"
 #include "ci13xxx_imx.h"
@@ -99,6 +100,7 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
 	struct device_node *phy_np;
 	struct resource *res;
 	struct regulator *reg_vbus;
+	struct pinctrl *pinctrl;
 	int ret;
 
 	if (of_find_property(pdev->dev.of_node, "fsl,usbmisc", NULL)
@@ -117,6 +119,11 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
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
