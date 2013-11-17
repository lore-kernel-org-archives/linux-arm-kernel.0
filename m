From: gsi@denx.de (Gerhard Sittig)
Date: Mon, 18 Nov 2013 00:06:11 +0100
Subject: [PATCH v5 11/17] USB: fsl-mph-dr-of: adjust for OF based clock lookup
In-Reply-To: <1384729577-7336-1-git-send-email-gsi@denx.de>
References: <1384729577-7336-1-git-send-email-gsi@denx.de>
Message-ID: <1384729577-7336-12-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

after device tree based clock lookup became available, the peripheral
driver need no longer construct clock names which include the component
index -- remove the "usb%d_clk" template, always use "ipg" instead

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb at vger.kernel.org
Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/usb/host/fsl-mph-dr-of.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
index abd5050a4899..9162d1b6c0a3 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -261,19 +261,8 @@ int fsl_usb2_mpc5121_init(struct platform_device *pdev)
 	struct fsl_usb2_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct clk *clk;
 	int err;
-	char clk_name[10];
-	int base, clk_num;
-
-	base = pdev->resource->start & 0xf000;
-	if (base == 0x3000)
-		clk_num = 1;
-	else if (base == 0x4000)
-		clk_num = 2;
-	else
-		return -ENODEV;
 
-	snprintf(clk_name, sizeof(clk_name), "usb%d_clk", clk_num);
-	clk = devm_clk_get(pdev->dev.parent, clk_name);
+	clk = devm_clk_get(pdev->dev.parent, "ipg");
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clk\n");
 		return PTR_ERR(clk);
-- 
1.7.10.4
