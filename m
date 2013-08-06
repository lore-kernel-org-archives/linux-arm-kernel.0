From: gsi@denx.de (Gerhard Sittig)
Date: Tue,  6 Aug 2013 22:44:04 +0200
Subject: [PATCH v4 24/31] USB: fsl-mph-dr-of: remove now obsolete clock lookup
 name
In-Reply-To: <1375821851-31609-1-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
Message-ID: <1375821851-31609-25-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

after device tree based clock lookup became available, the peripheral
driver need no longer construct clock names which include the component
index -- remove the "usb%d_clk" template and unconditionally use "per",
remove the clock driver's clkdev registration

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/platforms/512x/clock-commonclk.c |    2 --
 drivers/usb/host/fsl-mph-dr-of.c              |   13 +------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index 803f3be..4615fad 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -658,8 +658,6 @@ static void mpc512x_clk_setup_clock_tree(int busfreq)
 	clk_register_clkdev(clks[MPC512x_CLK_SYS], "sys_clk", NULL);
 	clk_register_clkdev(clks[MPC512x_CLK_VIU], "viu_clk", NULL);
 	clk_register_clkdev(clks[MPC512x_CLK_NFC], "nfc_clk", NULL);
-	clk_register_clkdev(clks[MPC512x_CLK_USB1], "usb1_clk", NULL);
-	clk_register_clkdev(clks[MPC512x_CLK_USB2], "usb2_clk", NULL);
 
 	/* enable some of the clocks here unconditionally because ... */
 	pr_debug("automatically enabling some clocks\n");
diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
index b8a1866..2b323fb 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -261,19 +261,8 @@ int fsl_usb2_mpc5121_init(struct platform_device *pdev)
 	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
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
-	clk = devm_clk_get(&pdev->dev, clk_name);
+	clk = devm_clk_get(&pdev->dev, "per");
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clk\n");
 		return PTR_ERR(clk);
-- 
1.7.10.4
