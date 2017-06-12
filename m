From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon, 12 Jun 2017 16:23:31 +0530
Subject: [PATCH] usb: dwc3: exynos: Handle return value of clk_prepare_enable
Message-ID: <3e8b3037c345341c2bda612b6de204f6c83dde38.1497264433.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/usb/dwc3/dwc3-exynos.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 98f74ff..e089df7 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -125,12 +125,16 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 		dev_err(dev, "couldn't get clock\n");
 		return -EINVAL;
 	}
-	clk_prepare_enable(exynos->clk);
+	ret = clk_prepare_enable(exynos->clk);
+	if (ret)
+		return ret;
 
 	exynos->susp_clk = devm_clk_get(dev, "usbdrd30_susp_clk");
 	if (IS_ERR(exynos->susp_clk))
 		exynos->susp_clk = NULL;
-	clk_prepare_enable(exynos->susp_clk);
+	ret = clk_prepare_enable(exynos->susp_clk);
+	if (ret)
+		goto susp_clk_err;
 
 	if (of_device_is_compatible(node, "samsung,exynos7-dwusb3")) {
 		exynos->axius_clk = devm_clk_get(dev, "usbdrd30_axius_clk");
@@ -139,7 +143,9 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 			ret = -ENODEV;
 			goto axius_clk_err;
 		}
-		clk_prepare_enable(exynos->axius_clk);
+		ret = clk_prepare_enable(exynos->axius_clk);
+		if (ret)
+			goto axius_clk_err;
 	} else {
 		exynos->axius_clk = NULL;
 	}
@@ -197,6 +203,7 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 	clk_disable_unprepare(exynos->axius_clk);
 axius_clk_err:
 	clk_disable_unprepare(exynos->susp_clk);
+susp_clk_err:
 	clk_disable_unprepare(exynos->clk);
 	return ret;
 }
-- 
1.9.1
