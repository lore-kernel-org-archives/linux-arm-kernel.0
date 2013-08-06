From: gsi@denx.de (Gerhard Sittig)
Date: Tue,  6 Aug 2013 22:43:43 +0200
Subject: [PATCH v4 03/31] USB: fsl-mph-dr-of: cleanup clock API use
In-Reply-To: <1375821851-31609-1-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
Message-ID: <1375821851-31609-4-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use devm_get_clk() for automatic put upon device close, check for and
propagate errors when enabling clocks, must prepare clocks before they
can get enabled, unprepare after disable

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/usb/host/fsl-mph-dr-of.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
index 11e0b79..b8a1866 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -260,6 +260,7 @@ int fsl_usb2_mpc5121_init(struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
 	struct clk *clk;
+	int err;
 	char clk_name[10];
 	int base, clk_num;
 
@@ -272,13 +273,16 @@ int fsl_usb2_mpc5121_init(struct platform_device *pdev)
 		return -ENODEV;
 
 	snprintf(clk_name, sizeof(clk_name), "usb%d_clk", clk_num);
-	clk = clk_get(&pdev->dev, clk_name);
+	clk = devm_clk_get(&pdev->dev, clk_name);
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clk\n");
 		return PTR_ERR(clk);
 	}
-
-	clk_enable(clk);
+	err = clk_prepare_enable(clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable clk\n");
+		return err;
+	}
 	pdata->clk = clk;
 
 	if (pdata->phy_mode == FSL_USB2_PHY_UTMI_WIDE) {
@@ -302,10 +306,8 @@ static void fsl_usb2_mpc5121_exit(struct platform_device *pdev)
 
 	pdata->regs = NULL;
 
-	if (pdata->clk) {
-		clk_disable(pdata->clk);
-		clk_put(pdata->clk);
-	}
+	if (pdata->clk)
+		clk_disable_unprepare(pdata->clk);
 }
 
 static struct fsl_usb2_platform_data fsl_usb2_mpc5121_pd = {
-- 
1.7.10.4
