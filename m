From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 15:45:51 +0200
Subject: [PATCH 38/40] USB gadget i.MX: fix clock handling
In-Reply-To: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334065553-7565-39-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usbotg core generally has three different clocks:

ipg: Bus register accesses
ahb: DMA clock
per: Clock for generating the 60MHz for the phy

The old i.MX clock support messed this up completely, there
were different clocks for different SoCs, but there meaning
varied from SoC to SoC. This patch cleans up the breakage
introduced by the generic clock support. While at it, also
use the managed version of clk_get to make the error path
easier.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/usb/gadget/fsl_mxc_udc.c |   74 ++++++++++++--------------------------
 1 file changed, 23 insertions(+), 51 deletions(-)

diff --git a/drivers/usb/gadget/fsl_mxc_udc.c b/drivers/usb/gadget/fsl_mxc_udc.c
index dcbc0a2..cfaa40a 100644
--- a/drivers/usb/gadget/fsl_mxc_udc.c
+++ b/drivers/usb/gadget/fsl_mxc_udc.c
@@ -21,7 +21,8 @@
 #include <mach/hardware.h>
 
 static struct clk *mxc_ahb_clk;
-static struct clk *mxc_usb_clk;
+static struct clk *mxc_ipg_clk;
+static struct clk *mxc_per_clk;
 
 /* workaround ENGcm09152 for i.MX35 */
 #define USBPHYCTRL_OTGBASE_OFFSET	0x608
@@ -35,55 +36,31 @@ int fsl_udc_clk_init(struct platform_device *pdev)
 
 	pdata = pdev->dev.platform_data;
 
-	if (!cpu_is_mx35() && !cpu_is_mx25()) {
-		mxc_ahb_clk = clk_get(&pdev->dev, "usb_ahb");
-		if (IS_ERR(mxc_ahb_clk))
-			return PTR_ERR(mxc_ahb_clk);
+	mxc_ahb_clk = devm_clk_get(&pdev->dev, "ahb");
+	if (IS_ERR(mxc_ahb_clk))
+		return PTR_ERR(mxc_ahb_clk);
 
-		ret = clk_enable(mxc_ahb_clk);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "clk_enable(\"usb_ahb\") failed\n");
-			goto eenahb;
-		}
-	}
+	mxc_per_clk = devm_clk_get(&pdev->dev, "per");
+	if (IS_ERR(mxc_per_clk))
+		return PTR_ERR(mxc_per_clk);
 
-	/* make sure USB_CLK is running at 60 MHz +/- 1000 Hz */
-	mxc_usb_clk = clk_get(&pdev->dev, "usb");
-	if (IS_ERR(mxc_usb_clk)) {
-		dev_err(&pdev->dev, "clk_get(\"usb\") failed\n");
-		ret = PTR_ERR(mxc_usb_clk);
-		goto egusb;
-	}
+	mxc_ipg_clk = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(mxc_ipg_clk))
+		return PTR_ERR(mxc_ipg_clk);
 
-	if (!cpu_is_mx51()) {
-		freq = clk_get_rate(mxc_usb_clk);
-		if (pdata->phy_mode != FSL_USB2_PHY_ULPI &&
-		    (freq < 59999000 || freq > 60001000)) {
-			dev_err(&pdev->dev, "USB_CLK=%lu, should be 60MHz\n", freq);
-			ret = -EINVAL;
-			goto eclkrate;
-		}
+	/* make sure USB_CLK is running at 60 MHz +/- 1000 Hz */
+	freq = clk_get_rate(mxc_usb_clk);
+	if (pdata->phy_mode != FSL_USB2_PHY_ULPI &&
+	    (freq < 59999000 || freq > 60001000)) {
+		dev_err(&pdev->dev, "USB_CLK=%lu, should be 60MHz\n", freq);
+		return -EINVAL;
 	}
 
-	ret = clk_enable(mxc_usb_clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "clk_enable(\"usb_clk\") failed\n");
-		goto eenusb;
-	}
+	clk_prepare_enable(mxc_ahb_clk);
+	clk_prepare_enable(mxc_per_clk);
+	clk_prepare_enable(mxc_ipg_clk);
 
 	return 0;
-
-eenusb:
-eclkrate:
-	clk_put(mxc_usb_clk);
-	mxc_usb_clk = NULL;
-egusb:
-	if (!cpu_is_mx35())
-		clk_disable(mxc_ahb_clk);
-eenahb:
-	if (!cpu_is_mx35())
-		clk_put(mxc_ahb_clk);
-	return ret;
 }
 
 void fsl_udc_clk_finalize(struct platform_device *pdev)
@@ -112,12 +89,7 @@ void fsl_udc_clk_finalize(struct platform_device *pdev)
 
 void fsl_udc_clk_release(void)
 {
-	if (mxc_usb_clk) {
-		clk_disable(mxc_usb_clk);
-		clk_put(mxc_usb_clk);
-	}
-	if (!cpu_is_mx35()) {
-		clk_disable(mxc_ahb_clk);
-		clk_put(mxc_ahb_clk);
-	}
+	clk_disable_unprepare(mxc_ahb_clk);
+	clk_disable_unprepare(mxc_ipg_clk);
+	clk_disable_unprepare(mxc_per_clk);
 }
-- 
1.7.9.5
