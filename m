From: matt@genesi-usa.com (Matt Sealey)
Date: Sun, 23 Dec 2012 05:18:21 -0600
Subject: [PATCH] ehci-mxc: remove Efika MX-specific CHRGVBUS hack
Message-ID: <1356261501-8465-1-git-send-email-matt@genesi-usa.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since Efika MX platform support (pre-devicetree) was removed from the tree
this code no longer has any possibility of running and clutters up the
driver which is being replaced by the chipidea host in the future anyway.

Signed-off-by: Matt Sealey <matt@genesi-usa.com>
Tested-by: Steev Klimazewski <steev@genesi-usa.com>
CC: Sascha Hauer <kernel@pengutronix.de>
CC: Alan Stern <stern@rowland.harvard.edu>

---
 drivers/usb/host/ehci-mxc.c |   20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index 8e58a5f..b62c3a8 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -102,7 +102,6 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	struct usb_hcd *hcd;
 	struct resource *res;
 	int irq, ret;
-	unsigned int flags;
 	struct ehci_mxc_priv *priv;
 	struct device *dev = &pdev->dev;
 	struct ehci_hcd *ehci;
@@ -213,25 +212,6 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_add;
 
-	if (pdata->otg) {
-		/*
-		 * efikamx and efikasb have some hardware bug which is
-		 * preventing usb to work unless CHRGVBUS is set.
-		 * It's in violation of USB specs
-		 */
-		if (machine_is_mx51_efikamx() || machine_is_mx51_efikasb()) {
-			flags = usb_phy_io_read(pdata->otg,
-							ULPI_OTG_CTRL);
-			flags |= ULPI_OTG_CTRL_CHRGVBUS;
-			ret = usb_phy_io_write(pdata->otg, flags,
-							ULPI_OTG_CTRL);
-			if (ret) {
-				dev_err(dev, "unable to set CHRVBUS\n");
-				goto err_add;
-			}
-		}
-	}
-
 	return 0;
 
 err_add:
-- 
1.7.10.4
