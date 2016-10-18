From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 17 Oct 2016 18:56:31 -0700
Subject: [PATCH v5 18/23] usb: chipidea: msm: Make platform data driver local
 instead of global
In-Reply-To: <20161018015636.11701-1-stephen.boyd@linaro.org>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
Message-ID: <20161018015636.11701-19-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If two devices are probed with this same driver, they'll share
the same platform data structure, while the chipidea core layer
writes and modifies it. This can lead to interesting results
especially if one device is an OTG type chipidea controller and
another is a host. Let's create a copy of this structure per each
device instance so that odd things don't happen.

Acked-by: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/chipidea/ci_hdrc_msm.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index 333817291798..2489a63d3e75 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -39,6 +39,7 @@ struct ci_hdrc_msm {
 	struct clk *core_clk;
 	struct clk *iface_clk;
 	struct clk *fs_clk;
+	struct ci_hdrc_platform_data pdata;
 	bool secondary_phy;
 	bool hsic;
 	void __iomem *base;
@@ -94,16 +95,6 @@ static void ci_hdrc_msm_notify_event(struct ci_hdrc *ci, unsigned event)
 	}
 }
 
-static struct ci_hdrc_platform_data ci_hdrc_msm_platdata = {
-	.name			= "ci_hdrc_msm",
-	.capoffset		= DEF_CAPOFFSET,
-	.flags			= CI_HDRC_REGS_SHARED |
-				  CI_HDRC_DISABLE_STREAMING |
-				  CI_HDRC_OVERRIDE_AHB_BURST,
-
-	.notify_event		= ci_hdrc_msm_notify_event,
-};
-
 static int ci_hdrc_msm_mux_phy(struct ci_hdrc_msm *ci,
 			       struct platform_device *pdev)
 {
@@ -164,7 +155,12 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 	if (IS_ERR(phy))
 		return PTR_ERR(phy);
 
-	ci_hdrc_msm_platdata.usb_phy = phy;
+	ci->pdata.name = "ci_hdrc_msm";
+	ci->pdata.capoffset = DEF_CAPOFFSET;
+	ci->pdata.flags	= CI_HDRC_REGS_SHARED | CI_HDRC_DISABLE_STREAMING |
+			  CI_HDRC_OVERRIDE_AHB_BURST;
+	ci->pdata.notify_event = ci_hdrc_msm_notify_event;
+	ci->pdata.usb_phy = phy;
 
 	reset = devm_reset_control_get(&pdev->dev, "core");
 	if (IS_ERR(reset))
@@ -220,9 +216,8 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 	}
 	of_node_put(ulpi_node);
 
-	plat_ci = ci_hdrc_add_device(&pdev->dev,
-				pdev->resource, pdev->num_resources,
-				&ci_hdrc_msm_platdata);
+	plat_ci = ci_hdrc_add_device(&pdev->dev, pdev->resource,
+				     pdev->num_resources, &ci->pdata);
 	if (IS_ERR(plat_ci)) {
 		dev_err(&pdev->dev, "ci_hdrc_add_device failed!\n");
 		ret = PTR_ERR(plat_ci);
-- 
2.10.0.297.gf6727b0
