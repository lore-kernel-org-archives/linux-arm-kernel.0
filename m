From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Wed, 16 Aug 2017 16:54:07 -0500
Subject: [PATCH v2 1/2] usb: dwc3: keystone: Add PM_RUNTIME Support to DWC3
 Keystone USB driver
In-Reply-To: <20170816215408.13076-1-fcooper@ti.com>
References: <20170816215408.13076-1-fcooper@ti.com>
Message-ID: <20170816215408.13076-2-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For 66AK2Gx there is a requirement to use PM Runtime to properly manage
clocks and the power domains. Therefore, add PM runtime support. Remove
legacy clock api's calls since other users of this driver worked without
these clock apis calls.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 drivers/usb/dwc3/dwc3-keystone.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keystone.c
index 12ee23f..d2ed952 100644
--- a/drivers/usb/dwc3/dwc3-keystone.c
+++ b/drivers/usb/dwc3/dwc3-keystone.c
@@ -15,7 +15,6 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
@@ -23,6 +22,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
 
 /* USBSS register offsets */
 #define USBSS_REVISION		0x0000
@@ -41,7 +41,6 @@
 
 struct dwc3_keystone {
 	struct device			*dev;
-	struct clk			*clk;
 	void __iomem			*usbss;
 };
 
@@ -106,17 +105,13 @@ static int kdwc3_probe(struct platform_device *pdev)
 	if (IS_ERR(kdwc->usbss))
 		return PTR_ERR(kdwc->usbss);
 
-	kdwc->clk = devm_clk_get(kdwc->dev, "usb");
-	if (IS_ERR(kdwc->clk)) {
-		dev_err(kdwc->dev, "unable to get usb clock\n");
-		return PTR_ERR(kdwc->clk);
-	}
+	pm_runtime_enable(kdwc->dev);
 
-	error = clk_prepare_enable(kdwc->clk);
+	error = pm_runtime_get_sync(kdwc->dev);
 	if (error < 0) {
-		dev_err(kdwc->dev, "unable to enable usb clock, error %d\n",
+		dev_err(kdwc->dev, "pm_runtime_get_sync failed, error %d\n",
 			error);
-		return error;
+		goto err_irq;
 	}
 
 	irq = platform_get_irq(pdev, 0);
@@ -147,7 +142,8 @@ static int kdwc3_probe(struct platform_device *pdev)
 err_core:
 	kdwc3_disable_irqs(kdwc);
 err_irq:
-	clk_disable_unprepare(kdwc->clk);
+	pm_runtime_put_sync(kdwc->dev);
+	pm_runtime_disable(kdwc->dev);
 
 	return error;
 }
@@ -167,7 +163,9 @@ static int kdwc3_remove(struct platform_device *pdev)
 
 	kdwc3_disable_irqs(kdwc);
 	device_for_each_child(&pdev->dev, NULL, kdwc3_remove_core);
-	clk_disable_unprepare(kdwc->clk);
+	pm_runtime_put_sync(kdwc->dev);
+	pm_runtime_disable(kdwc->dev);
+
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
-- 
2.9.4.dirty
