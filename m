From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Sun, 26 Jun 2016 00:28:31 -0700
Subject: [PATCH 14/21] usb: chipidea: msm: Add proper clk and reset support
In-Reply-To: <20160626072838.28082-1-stephen.boyd@linaro.org>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
Message-ID: <20160626072838.28082-15-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The msm chipidea controller uses two main clks, an AHB clk to
read/write the MMIO registers and a core clk called the system
clk that drives the controller itself. Add support for these clks
as they're required in all designs.

Also add support for an optional third clk that we need to turn
on to read/write the ULPI phy registers. Some ULPI phys drive
this clk themselves and so it isn't necessary to turn on to probe
a ULPI device, but the HSIC phy doesn't provide one itself, so we
must turn it on here.

Cc: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/chipidea/ci_hdrc_msm.c | 58 +++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index 07cccd24a87f..40249b0e3e93 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -10,11 +10,19 @@
 #include <linux/pm_runtime.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/chipidea.h>
+#include <linux/clk.h>
+#include <linux/reset.h>
 
 #include "ci.h"
 
 #define HS_PHY_AHB_MODE			0x0098
 
+struct ci_hdrc_msm {
+	struct platform_device *ci;
+	struct clk *core_clk;
+	struct clk *iface_clk;
+};
+
 static void ci_hdrc_msm_notify_event(struct ci_hdrc *ci, unsigned event)
 {
 	struct device *dev = ci->gadget.dev.parent;
@@ -43,34 +51,76 @@ static struct ci_hdrc_platform_data ci_hdrc_msm_platdata = {
 
 static int ci_hdrc_msm_probe(struct platform_device *pdev)
 {
+	struct ci_hdrc_msm *ci;
 	struct platform_device *plat_ci;
+	struct clk *clk;
+	struct reset_control *reset;
+	int ret;
 
 	dev_dbg(&pdev->dev, "ci_hdrc_msm_probe\n");
 
+	ci = devm_kzalloc(&pdev->dev, sizeof(*ci), GFP_KERNEL);
+	if (!ci)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, ci);
+
+	reset = devm_reset_control_get(&pdev->dev, "core");
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
+	ci->core_clk = clk = devm_clk_get(&pdev->dev, "core");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ci->iface_clk = clk = devm_clk_get(&pdev->dev, "iface");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	reset_control_assert(reset);
+	usleep_range(10000, 12000);
+	reset_control_deassert(reset);
+
+	ret = clk_prepare_enable(ci->core_clk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(ci->iface_clk);
+	if (ret)
+		goto err_iface;
+
 	plat_ci = ci_hdrc_add_device(&pdev->dev,
 				pdev->resource, pdev->num_resources,
 				&ci_hdrc_msm_platdata);
 	if (IS_ERR(plat_ci)) {
 		dev_err(&pdev->dev, "ci_hdrc_add_device failed!\n");
-		return PTR_ERR(plat_ci);
+		ret = PTR_ERR(plat_ci);
+		goto err_mux;
 	}
 
-	platform_set_drvdata(pdev, plat_ci);
+	ci->ci = plat_ci;
 
 	pm_runtime_no_callbacks(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get(&pdev->dev);
 
 	return 0;
+
+err_mux:
+	clk_disable_unprepare(ci->iface_clk);
+err_iface:
+	clk_disable_unprepare(ci->core_clk);
+	return ret;
 }
 
 static int ci_hdrc_msm_remove(struct platform_device *pdev)
 {
-	struct platform_device *plat_ci = platform_get_drvdata(pdev);
+	struct ci_hdrc_msm *ci = platform_get_drvdata(pdev);
 
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	ci_hdrc_remove_device(plat_ci);
+	ci_hdrc_remove_device(ci->ci);
+	clk_disable_unprepare(ci->iface_clk);
+	clk_disable_unprepare(ci->core_clk);
 
 	return 0;
 }
-- 
2.9.0.rc2.8.ga28705d
