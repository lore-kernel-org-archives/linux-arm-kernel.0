From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 30 Jan 2017 12:41:14 +0100
Subject: [PATCH 12/14] usb: dwc2: simplify optional reset handling
In-Reply-To: <20170130114116.22089-1-p.zabel@pengutronix.de>
References: <20170130114116.22089-1-p.zabel@pengutronix.de>
Message-ID: <20170130114116.22089-12-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit bb475230b8e5 ("reset: make optional functions really
optional"), the reset framework API calls use NULL pointers to describe
optional, non-present reset controls.

This allows to return errors from devm_reset_control_get_optional and to
call reset_control_(de)assert unconditionally.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
Cc: John Youn <johnyoun@synopsys.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/platform.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 4fc8c603afb8b..c6aa2710cecfe 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -214,20 +214,11 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 	hsotg->reset = devm_reset_control_get_optional(hsotg->dev, "dwc2");
 	if (IS_ERR(hsotg->reset)) {
 		ret = PTR_ERR(hsotg->reset);
-		switch (ret) {
-		case -ENOENT:
-		case -ENOTSUPP:
-			hsotg->reset = NULL;
-			break;
-		default:
-			dev_err(hsotg->dev, "error getting reset control %d\n",
-				ret);
-			return ret;
-		}
+		dev_err(hsotg->dev, "error getting reset control %d\n", ret);
+		return ret;
 	}
 
-	if (hsotg->reset)
-		reset_control_deassert(hsotg->reset);
+	reset_control_deassert(hsotg->reset);
 
 	/* Set default UTMI width */
 	hsotg->phyif = GUSBCFG_PHYIF16;
@@ -326,8 +317,7 @@ static int dwc2_driver_remove(struct platform_device *dev)
 	if (hsotg->ll_hw_enabled)
 		dwc2_lowlevel_hw_disable(hsotg);
 
-	if (hsotg->reset)
-		reset_control_assert(hsotg->reset);
+	reset_control_assert(hsotg->reset);
 
 	return 0;
 }
-- 
2.11.0
