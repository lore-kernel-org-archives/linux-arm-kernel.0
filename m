From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 25 Mar 2013 03:06:52 -0400
Subject: [PATCH V2 1/6] usb: gadget: mv_udc_core: remove unused clock
In-Reply-To: <1364195217-1226-1-git-send-email-chao.xie@marvell.com>
References: <1364195217-1226-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1364195217-1226-2-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The origianl understanding of clock is wrong. The UDC controller
only have one clock input.
Passing clock name by pdata is wrong. The clock is defined by device
iteself.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/usb/gadget/mv_udc.h      |    3 +--
 drivers/usb/gadget/mv_udc_core.c |   27 +++++++--------------------
 2 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/gadget/mv_udc.h b/drivers/usb/gadget/mv_udc.h
index 9073436..be77f20 100644
--- a/drivers/usb/gadget/mv_udc.h
+++ b/drivers/usb/gadget/mv_udc.h
@@ -222,8 +222,7 @@ struct mv_udc {
 	struct mv_usb_platform_data     *pdata;
 
 	/* some SOC has mutiple clock sources for USB*/
-	unsigned int    clknum;
-	struct clk      *clk[0];
+	struct clk      *clk;
 };
 
 /* endpoint data structure */
diff --git a/drivers/usb/gadget/mv_udc_core.c b/drivers/usb/gadget/mv_udc_core.c
index 9a68c05..593147b 100644
--- a/drivers/usb/gadget/mv_udc_core.c
+++ b/drivers/usb/gadget/mv_udc_core.c
@@ -972,18 +972,12 @@ static struct usb_ep_ops mv_ep_ops = {
 
 static void udc_clock_enable(struct mv_udc *udc)
 {
-	unsigned int i;
-
-	for (i = 0; i < udc->clknum; i++)
-		clk_prepare_enable(udc->clk[i]);
+	clk_prepare_enable(udc->clk);
 }
 
 static void udc_clock_disable(struct mv_udc *udc)
 {
-	unsigned int i;
-
-	for (i = 0; i < udc->clknum; i++)
-		clk_disable_unprepare(udc->clk[i]);
+	clk_disable_unprepare(udc->clk);
 }
 
 static void udc_stop(struct mv_udc *udc)
@@ -2105,7 +2099,6 @@ static int mv_udc_probe(struct platform_device *pdev)
 	struct mv_usb_platform_data *pdata = pdev->dev.platform_data;
 	struct mv_udc *udc;
 	int retval = 0;
-	int clk_i = 0;
 	struct resource *r;
 	size_t size;
 
@@ -2114,8 +2107,7 @@ static int mv_udc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	size = sizeof(*udc) + sizeof(struct clk *) * pdata->clknum;
-	udc = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
+	udc = devm_kzalloc(&pdev->dev, sizeof(*udc), GFP_KERNEL);
 	if (udc == NULL) {
 		dev_err(&pdev->dev, "failed to allocate memory for udc\n");
 		return -ENOMEM;
@@ -2141,15 +2133,10 @@ static int mv_udc_probe(struct platform_device *pdev)
 		}
 	}
 
-	udc->clknum = pdata->clknum;
-	for (clk_i = 0; clk_i < udc->clknum; clk_i++) {
-		udc->clk[clk_i] = devm_clk_get(&pdev->dev,
-					pdata->clkname[clk_i]);
-		if (IS_ERR(udc->clk[clk_i])) {
-			retval = PTR_ERR(udc->clk[clk_i]);
-			return retval;
-		}
-	}
+	/* udc only have one sysclk. */
+	udc->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(udc->clk))
+		return PTR_ERR(udc->clk);
 
 	r = platform_get_resource_byname(udc->dev, IORESOURCE_MEM, "capregs");
 	if (r == NULL) {
-- 
1.7.4.1
