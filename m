From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 30 Oct 2012 11:18:02 +0100
Subject: [PATCH v3 10/10] net/macb: add pinctrl consumer support
In-Reply-To: <cover.1351591858.git.nicolas.ferre@atmel.com>
References: <cover.1351591858.git.nicolas.ferre@atmel.com>
Message-ID: <3269426bdd44debc00d027651f8248db9d40f3dc.1351591858.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

If no pinctrl available just report a warning as some architecture may not
need to do anything.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
[nicolas.ferre at atmel.com: adapt the error path]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: netdev at vger.kernel.org
---
 drivers/net/ethernet/cadence/macb.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cadence/macb.c
index 4d51877..eae3d74 100644
--- a/drivers/net/ethernet/cadence/macb.c
+++ b/drivers/net/ethernet/cadence/macb.c
@@ -26,6 +26,9 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_net.h>
+#include <linux/of_gpio.h>
+#include <linux/gpio.h>
+#include <linux/pinctrl/consumer.h>
 
 #include "macb.h"
 
@@ -1472,6 +1475,7 @@ static int __init macb_probe(struct platform_device *pdev)
 	struct phy_device *phydev;
 	u32 config;
 	int err = -ENXIO;
+	struct pinctrl *pinctrl;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs) {
@@ -1479,6 +1483,15 @@ static int __init macb_probe(struct platform_device *pdev)
 		goto err_out;
 	}
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		err = PTR_ERR(pinctrl);
+		if (err == -EPROBE_DEFER)
+			goto err_out;
+
+		dev_warn(&pdev->dev, "No pinctrl provided\n");
+	}
+
 	err = -ENOMEM;
 	dev = alloc_etherdev(sizeof(*bp));
 	if (!dev)
-- 
1.8.0
