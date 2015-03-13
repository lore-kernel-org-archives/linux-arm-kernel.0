From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 13 Mar 2015 11:09:42 -0700
Subject: [PATCH 09/12] usb: phy: msm: Remove dead code
In-Reply-To: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>
References: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1426270185-19510-10-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This code is no longer used now that mach-msm has been removed.
Delete it.

Cc: Felipe Balbi <balbi@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb at vger.kernel.org
Cc: David Brown <davidb@codeaurora.org>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

This needs an ack to go through arm-soc with patch 1 that removes the platform
code using these ops.

 drivers/usb/phy/Kconfig       |  2 +-
 drivers/usb/phy/phy-msm-usb.c | 18 ++----------------
 include/linux/usb/msm_hsusb.h |  4 ----
 3 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 52d3d58252e1..2fb3828b5089 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -139,7 +139,7 @@ config USB_ISP1301
 
 config USB_MSM_OTG
 	tristate "Qualcomm on-chip USB OTG controller support"
-	depends on (USB || USB_GADGET) && (ARCH_MSM || ARCH_QCOM || COMPILE_TEST)
+	depends on (USB || USB_GADGET) && (ARCH_QCOM || COMPILE_TEST)
 	depends on RESET_CONTROLLER
 	select USB_PHY
 	help
diff --git a/drivers/usb/phy/phy-msm-usb.c b/drivers/usb/phy/phy-msm-usb.c
index 000fd892455f..b50c45c62da7 100644
--- a/drivers/usb/phy/phy-msm-usb.c
+++ b/drivers/usb/phy/phy-msm-usb.c
@@ -263,9 +263,7 @@ static int msm_otg_link_clk_reset(struct msm_otg *motg, bool assert)
 {
 	int ret;
 
-	if (motg->pdata->link_clk_reset)
-		ret = motg->pdata->link_clk_reset(motg->clk, assert);
-	else if (assert)
+	if (assert)
 		ret = reset_control_assert(motg->link_rst);
 	else
 		ret = reset_control_deassert(motg->link_rst);
@@ -281,9 +279,7 @@ static int msm_otg_phy_clk_reset(struct msm_otg *motg)
 {
 	int ret = 0;
 
-	if (motg->pdata->phy_clk_reset)
-		ret = motg->pdata->phy_clk_reset(motg->phy_reset_clk);
-	else if (motg->phy_rst)
+	if (motg->phy_rst)
 		ret = reset_control_reset(motg->phy_rst);
 
 	if (ret)
@@ -1551,16 +1547,6 @@ static int msm_otg_probe(struct platform_device *pdev)
 	phy = &motg->phy;
 	phy->dev = &pdev->dev;
 
-	if (motg->pdata->phy_clk_reset) {
-		motg->phy_reset_clk = devm_clk_get(&pdev->dev,
-					   np ? "phy" : "usb_phy_clk");
-
-		if (IS_ERR(motg->phy_reset_clk)) {
-			dev_err(&pdev->dev, "failed to get usb_phy_clk\n");
-			return PTR_ERR(motg->phy_reset_clk);
-		}
-	}
-
 	motg->clk = devm_clk_get(&pdev->dev, np ? "core" : "usb_hs_clk");
 	if (IS_ERR(motg->clk)) {
 		dev_err(&pdev->dev, "failed to get usb_hs_clk\n");
diff --git a/include/linux/usb/msm_hsusb.h b/include/linux/usb/msm_hsusb.h
index b0a39243295a..7dbecf9a4656 100644
--- a/include/linux/usb/msm_hsusb.h
+++ b/include/linux/usb/msm_hsusb.h
@@ -117,8 +117,6 @@ struct msm_otg_platform_data {
 	enum otg_control_type otg_control;
 	enum msm_usb_phy_type phy_type;
 	void (*setup_gpio)(enum usb_otg_state state);
-	int (*link_clk_reset)(struct clk *link_clk, bool assert);
-	int (*phy_clk_reset)(struct clk *phy_clk);
 };
 
 /**
@@ -128,7 +126,6 @@ struct msm_otg_platform_data {
  * @irq: IRQ number assigned for HSUSB controller.
  * @clk: clock struct of usb_hs_clk.
  * @pclk: clock struct of usb_hs_pclk.
- * @phy_reset_clk: clock struct of usb_phy_clk.
  * @core_clk: clock struct of usb_hs_core_clk.
  * @regs: ioremapped register base address.
  * @inputs: OTG state machine inputs(Id, SessValid etc).
@@ -148,7 +145,6 @@ struct msm_otg {
 	int irq;
 	struct clk *clk;
 	struct clk *pclk;
-	struct clk *phy_reset_clk;
 	struct clk *core_clk;
 	void __iomem *regs;
 #define ID		0
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
