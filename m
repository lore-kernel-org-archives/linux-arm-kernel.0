From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Mon,  9 Jan 2017 19:21:31 -0700
Subject: [PATCH] usb: dwc3-exynos fix unspecified suspend clk error handling
Message-ID: <20170110022131.31042-1-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix dwc3_exynos_probe() to call clk_prepare_enable() only when suspend
clock is specified. Call clk_disable_unprepare() from remove and probe
error path only when susp_clk has been set from remove and probe error
paths.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/usb/dwc3/dwc3-exynos.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index e27899b..f97a3d7 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -131,8 +131,8 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 	if (IS_ERR(exynos->susp_clk)) {
 		dev_info(dev, "no suspend clk specified\n");
 		exynos->susp_clk = NULL;
-	}
-	clk_prepare_enable(exynos->susp_clk);
+	} else
+		clk_prepare_enable(exynos->susp_clk);
 
 	if (of_device_is_compatible(node, "samsung,exynos7-dwusb3")) {
 		exynos->axius_clk = devm_clk_get(dev, "usbdrd30_axius_clk");
@@ -196,7 +196,8 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 	regulator_disable(exynos->vdd33);
 err2:
 	clk_disable_unprepare(exynos->axius_clk);
-	clk_disable_unprepare(exynos->susp_clk);
+	if (exynos->susp_clk)
+		clk_disable_unprepare(exynos->susp_clk);
 	clk_disable_unprepare(exynos->clk);
 	return ret;
 }
@@ -210,7 +211,8 @@ static int dwc3_exynos_remove(struct platform_device *pdev)
 	platform_device_unregister(exynos->usb3_phy);
 
 	clk_disable_unprepare(exynos->axius_clk);
-	clk_disable_unprepare(exynos->susp_clk);
+	if (exynos->susp_clk)
+		clk_disable_unprepare(exynos->susp_clk);
 	clk_disable_unprepare(exynos->clk);
 
 	regulator_disable(exynos->vdd33);
-- 
2.7.4
