From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon, 26 Jan 2015 17:45:29 -0800
Subject: [PATCH] usb: phy-generic: Don't fail on missing gpio reset
Message-ID: <1422323129-20969-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A reset through a GPIO is optional. Don't fail probing when it is
missing.

Reported-by: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
Hi Andreas,

does this do the trick?

	Thanks,
	S?ren

 drivers/usb/phy/phy-generic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index dd05254241fb..a73d4c738f0b 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -241,10 +241,8 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop,
 
 	if (err == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
-	if (err) {
-		dev_err(dev, "Error requesting RESET GPIO\n");
-		return err;
-	}
+	if (err)
+		nop->gpiod_reset = NULL;
 
 	nop->phy.otg = devm_kzalloc(dev, sizeof(*nop->phy.otg),
 			GFP_KERNEL);
-- 
2.2.2.1.g63c5777
