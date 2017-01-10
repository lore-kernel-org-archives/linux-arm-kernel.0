From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Tue, 10 Jan 2017 16:05:28 -0700
Subject: [PATCH] usb: dwc3-exynos fix axius clock error path to do cleanup
Message-ID: <20170110230528.7612-1-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Axius clock error path returns without disabling clock and suspend clock.
Fix it to disable them before returning error.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/usb/dwc3/dwc3-exynos.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 3e8407a..f7421c2 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -136,7 +136,8 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 		exynos->axius_clk = devm_clk_get(dev, "usbdrd30_axius_clk");
 		if (IS_ERR(exynos->axius_clk)) {
 			dev_err(dev, "no AXI UpScaler clk specified\n");
-			return -ENODEV;
+			ret = -ENODEV;
+			goto axius_clk_err;
 		}
 		clk_prepare_enable(exynos->axius_clk);
 	} else {
@@ -194,6 +195,7 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 	regulator_disable(exynos->vdd33);
 err2:
 	clk_disable_unprepare(exynos->axius_clk);
+axius_clk_err:
 	clk_disable_unprepare(exynos->susp_clk);
 	clk_disable_unprepare(exynos->clk);
 	return ret;
-- 
2.7.4
