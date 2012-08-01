From: matt@genesi-usa.com (Matt Sealey)
Date: Wed,  1 Aug 2012 12:49:31 -0500
Subject: [PATCH 4/4] efikamx: remove Efika MX-specific CHRGVBUS hack from the
 USB driver
In-Reply-To: <1343843371-14143-1-git-send-email-matt@genesi-usa.com>
References: <1343843371-14143-1-git-send-email-matt@genesi-usa.com>
Message-ID: <1343843371-14143-5-git-send-email-matt@genesi-usa.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we're removing Efika MX support from the tree (for now), remove
the hack present in the USB host driver since it will never run and
isn't useful on any other systems.

Signed-off-by: Matt Sealey <matt@genesi-usa.com>
---
 drivers/usb/host/ehci-mxc.c |   20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index c778ffe..062f871 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -118,7 +118,6 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	struct usb_hcd *hcd;
 	struct resource *res;
 	int irq, ret;
-	unsigned int flags;
 	struct ehci_mxc_priv *priv;
 	struct device *dev = &pdev->dev;
 	struct ehci_hcd *ehci;
@@ -235,25 +234,6 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
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
1.7.9.5
