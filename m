From: gsi@denx.de (Gerhard Sittig)
Date: Mon, 22 Jul 2013 14:14:30 +0200
Subject: [PATCH v3 03/31] USB: fsl-mph-dr-of: cleanup clock API use
In-Reply-To: <1374495298-22019-1-git-send-email-gsi@denx.de>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
Message-ID: <1374495298-22019-4-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

error check in the clock setup, must prepare clocks before they
can get enabled, unprepare after disable, use devm_{get,put}_clk()

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/usb/host/fsl-mph-dr-of.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
index 11e0b79..5e51384 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -260,6 +260,7 @@ int fsl_usb2_mpc5121_init(struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
 	struct clk *clk;
+	int err;
 	char clk_name[10];
 	int base, clk_num;
 
@@ -272,13 +273,17 @@ int fsl_usb2_mpc5121_init(struct platform_device *pdev)
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
+		devm_clk_put(&pdev->dev, clk);
+		return err;
+	}
 	pdata->clk = clk;
 
 	if (pdata->phy_mode == FSL_USB2_PHY_UTMI_WIDE) {
@@ -303,8 +308,8 @@ static void fsl_usb2_mpc5121_exit(struct platform_device *pdev)
 	pdata->regs = NULL;
 
 	if (pdata->clk) {
-		clk_disable(pdata->clk);
-		clk_put(pdata->clk);
+		clk_disable_unprepare(pdata->clk);
+		devm_clk_put(&pdev->dev, pdata->clk);
 	}
 }
 
-- 
1.7.10.4
