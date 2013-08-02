From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 2 Aug 2013 16:37:41 +0800
Subject: [PATCH 2/3] usb: chipidea: move platform related things to
 ci_get_platdata
In-Reply-To: <1375432662-32018-1-git-send-email-peter.chen@freescale.com>
References: <1375432662-32018-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1375432662-32018-3-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It will make probe cleaner, meanwhile, it fixes the problem
http://marc.info/?l=linux-usb&m=137528143523296&w=2
described indirectly.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/core.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index f09b4db..61c928c 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -381,6 +381,15 @@ static int ci_get_platdata(struct device *dev,
 		return PTR_ERR(platdata->reg_vbus);
 	}
 
+	if (!platdata->phy_mode)
+		platdata->phy_mode = of_usb_get_phy_mode(dev->of_node);
+
+	if (!platdata->dr_mode)
+		platdata->dr_mode = of_usb_get_dr_mode(dev->of_node);
+
+	if (platdata->dr_mode == USB_DR_MODE_UNKNOWN)
+		platdata->dr_mode = USB_DR_MODE_OTG;
+
 	return 0;
 }
 
@@ -479,9 +488,6 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	if (!dev->of_node && dev->parent)
-		dev->of_node = dev->parent->of_node;
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base))
@@ -517,17 +523,8 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	/* To know if controller is OTG capable or not */
 	ci_get_otg_capable(ci);
 
-	if (!ci->platdata->phy_mode)
-		ci->platdata->phy_mode = of_usb_get_phy_mode(dev->of_node);
-
 	hw_phymode_configure(ci);
 
-	if (!ci->platdata->dr_mode)
-		ci->platdata->dr_mode = of_usb_get_dr_mode(dev->of_node);
-
-	if (ci->platdata->dr_mode == USB_DR_MODE_UNKNOWN)
-		ci->platdata->dr_mode = USB_DR_MODE_OTG;
-
 	dr_mode = ci->platdata->dr_mode;
 	/* initialize role(s) before the interrupt is requested */
 	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
-- 
1.7.0.4
