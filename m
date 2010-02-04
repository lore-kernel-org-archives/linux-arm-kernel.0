From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  4 Feb 2010 16:03:38 +0100
Subject: [PATCH 1/8] fsl_mx3_udc: Add i.MX35 support
In-Reply-To: <1265295825-8705-1-git-send-email-s.hauer@pengutronix.de>
References: <1265295825-8705-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1265295825-8705-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX35 works fine with this driver, but we do not have
the usb_ahb clock.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/usb/gadget/fsl_mx3_udc.c |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/fsl_mx3_udc.c b/drivers/usb/gadget/fsl_mx3_udc.c
index 4bc2bf3..20a802e 100644
--- a/drivers/usb/gadget/fsl_mx3_udc.c
+++ b/drivers/usb/gadget/fsl_mx3_udc.c
@@ -17,6 +17,8 @@
 #include <linux/fsl_devices.h>
 #include <linux/platform_device.h>
 
+#include <mach/hardware.h>
+
 static struct clk *mxc_ahb_clk;
 static struct clk *mxc_usb_clk;
 
@@ -28,14 +30,16 @@ int fsl_udc_clk_init(struct platform_device *pdev)
 
 	pdata = pdev->dev.platform_data;
 
-	mxc_ahb_clk = clk_get(&pdev->dev, "usb_ahb");
-	if (IS_ERR(mxc_ahb_clk))
-		return PTR_ERR(mxc_ahb_clk);
+	if (!cpu_is_mx35()) {
+		mxc_ahb_clk = clk_get(&pdev->dev, "usb_ahb");
+		if (IS_ERR(mxc_ahb_clk))
+			return PTR_ERR(mxc_ahb_clk);
 
-	ret = clk_enable(mxc_ahb_clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "clk_enable(\"usb_ahb\") failed\n");
-		goto eenahb;
+		ret = clk_enable(mxc_ahb_clk);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "clk_enable(\"usb_ahb\") failed\n");
+			goto eenahb;
+		}
 	}
 
 	/* make sure USB_CLK is running at 60 MHz +/- 1000 Hz */
@@ -50,6 +54,7 @@ int fsl_udc_clk_init(struct platform_device *pdev)
 	if (pdata->phy_mode != FSL_USB2_PHY_ULPI &&
 	    (freq < 59999000 || freq > 60001000)) {
 		dev_err(&pdev->dev, "USB_CLK=%lu, should be 60MHz\n", freq);
+		ret = -EINVAL;
 		goto eclkrate;
 	}
 
@@ -66,9 +71,11 @@ eclkrate:
 	clk_put(mxc_usb_clk);
 	mxc_usb_clk = NULL;
 egusb:
-	clk_disable(mxc_ahb_clk);
+	if (!cpu_is_mx35())
+		clk_disable(mxc_ahb_clk);
 eenahb:
-	clk_put(mxc_ahb_clk);
+	if (!cpu_is_mx35())
+		clk_put(mxc_ahb_clk);
 	return ret;
 }
 
@@ -90,6 +97,8 @@ void fsl_udc_clk_release(void)
 		clk_disable(mxc_usb_clk);
 		clk_put(mxc_usb_clk);
 	}
-	clk_disable(mxc_ahb_clk);
-	clk_put(mxc_ahb_clk);
+	if (!cpu_is_mx35()) {
+		clk_disable(mxc_ahb_clk);
+		clk_put(mxc_ahb_clk);
+	}
 }
-- 
1.6.6
