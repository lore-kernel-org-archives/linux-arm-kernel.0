From: gsi@denx.de (Gerhard Sittig)
Date: Mon, 22 Jul 2013 14:14:51 +0200
Subject: [PATCH v3 24/31] USB: fsl-mph-dr-of: remove now obsolete clock lookup
 name
In-Reply-To: <1374495298-22019-1-git-send-email-gsi@denx.de>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
Message-ID: <1374495298-22019-25-git-send-email-gsi@denx.de>
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
index 53f772b..d0286a5 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -678,8 +678,6 @@ static void mpc512x_clk_setup_clock_tree(int busfreq)
 	clk_register_clkdev(clks[MPC512x_CLK_SYS], "sys_clk", NULL);
 	clk_register_clkdev(clks[MPC512x_CLK_VIU], "viu_clk", NULL);
 	clk_register_clkdev(clks[MPC512x_CLK_NFC], "nfc_clk", NULL);
-	clk_register_clkdev(clks[MPC512x_CLK_USB1], "usb1_clk", NULL);
-	clk_register_clkdev(clks[MPC512x_CLK_USB2], "usb2_clk", NULL);
 
 	pr_debug("clock tree setup complete\n");
 	freq = clk_get_rate(clks[MPC512x_CLK_E300]);
diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
index 5e51384..49c1da8 100644
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
