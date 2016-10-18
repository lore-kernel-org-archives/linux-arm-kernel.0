From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 17 Oct 2016 18:56:28 -0700
Subject: [PATCH v5 15/23] usb: chipidea: msm: Add proper clk and reset support
In-Reply-To: <20161018015636.11701-1-stephen.boyd@linaro.org>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
Message-ID: <20161018015636.11701-16-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The msm chipidea controller uses two main clks, an AHB clk to
read/write the MMIO registers and a core clk called the system
clk that drives the controller itself. Add support for these clks
as they're required in all designs.

Also add support for an optional third clk that we need to turn
on to reset the controller and wrapper logic and other
"housekeeping" things. This clk was removed in later revisions of
the hardware because the reset methodology no longer required
clks to be enabled to propagate resets.

Acked-by: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/chipidea/ci_hdrc_msm.c | 72 +++++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index b282a717bf8c..7e870a253f55 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -10,11 +10,20 @@
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
+	struct clk *fs_clk;
+};
+
 static void ci_hdrc_msm_notify_event(struct ci_hdrc *ci, unsigned event)
 {
 	struct device *dev = ci->gadget.dev.parent;
@@ -52,11 +61,20 @@ static struct ci_hdrc_platform_data ci_hdrc_msm_platdata = {
 
 static int ci_hdrc_msm_probe(struct platform_device *pdev)
 {
+	struct ci_hdrc_msm *ci;
 	struct platform_device *plat_ci;
 	struct usb_phy *phy;
+	struct clk *clk;
+	struct reset_control *reset;
+	int ret;
 
 	dev_dbg(&pdev->dev, "ci_hdrc_msm_probe\n");
 
+	ci = devm_kzalloc(&pdev->dev, sizeof(*ci), GFP_KERNEL);
+	if (!ci)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, ci);
+
 	/*
 	 * OTG(PHY) driver takes care of PHY initialization, clock management,
 	 * powering up VBUS, mapping of registers address space and power
@@ -68,29 +86,75 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 
 	ci_hdrc_msm_platdata.usb_phy = phy;
 
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
+	ci->fs_clk = clk = devm_clk_get(&pdev->dev, "fs");
+	if (IS_ERR(clk)) {
+		if (PTR_ERR(clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		ci->fs_clk = NULL;
+	}
+
+	ret = clk_prepare_enable(ci->fs_clk);
+	if (ret)
+		return ret;
+
+	reset_control_assert(reset);
+	usleep_range(10000, 12000);
+	reset_control_deassert(reset);
+
+	clk_disable_unprepare(ci->fs_clk);
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
 
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_no_callbacks(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
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
 
 	pm_runtime_disable(&pdev->dev);
-	ci_hdrc_remove_device(plat_ci);
+	ci_hdrc_remove_device(ci->ci);
+	clk_disable_unprepare(ci->iface_clk);
+	clk_disable_unprepare(ci->core_clk);
 
 	return 0;
 }
-- 
2.10.0.297.gf6727b0
