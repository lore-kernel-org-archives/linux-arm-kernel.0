From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 15 Apr 2014 18:06:43 +0200
Subject: [PATCH v2 2/4] USB: EHCI: Export the ehci_hub_control function
In-Reply-To: <1397578005-3341-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1397578005-3341-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1397578005-3341-3-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platform drivers sometimes need to perform specific handling of hub
control requests. Make this possible by exporting the ehci_hub_control()
function which can then be called from a custom hub control handler in
the default case.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/usb/host/ehci-hub.c   | 12 ++----------
 drivers/usb/host/ehci-tegra.c |  8 +-------
 drivers/usb/host/ehci.h       |  3 +++
 3 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
index 7ae0c4d..fa2ede7 100644
--- a/drivers/usb/host/ehci-hub.c
+++ b/drivers/usb/host/ehci-hub.c
@@ -33,15 +33,6 @@
 
 #ifdef	CONFIG_PM
 
-static int ehci_hub_control(
-	struct usb_hcd	*hcd,
-	u16		typeReq,
-	u16		wValue,
-	u16		wIndex,
-	char		*buf,
-	u16		wLength
-);
-
 static int persist_enabled_on_companion(struct usb_device *udev, void *unused)
 {
 	return !udev->maxchild && udev->persist_enabled &&
@@ -865,7 +856,7 @@ cleanup:
 #endif /* CONFIG_USB_HCD_TEST_MODE */
 /*-------------------------------------------------------------------------*/
 
-static int ehci_hub_control (
+int ehci_hub_control (
 	struct usb_hcd	*hcd,
 	u16		typeReq,
 	u16		wValue,
@@ -1285,6 +1276,7 @@ error_exit:
 	spin_unlock_irqrestore (&ehci->lock, flags);
 	return retval;
 }
+EXPORT_SYMBOL_GPL(ehci_hub_control);
 
 static void ehci_relinquish_port(struct usb_hcd *hcd, int portnum)
 {
diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index 27ac6ad..8325a23 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -51,10 +51,6 @@ struct tegra_ehci_soc_config {
 	bool has_hostpc;
 };
 
-static int (*orig_hub_control)(struct usb_hcd *hcd,
-				u16 typeReq, u16 wValue, u16 wIndex,
-				char *buf, u16 wLength);
-
 struct tegra_ehci_hcd {
 	struct tegra_usb_phy *phy;
 	struct clk *clk;
@@ -236,7 +232,7 @@ static int tegra_ehci_hub_control(
 	spin_unlock_irqrestore(&ehci->lock, flags);
 
 	/* Handle the hub control events here */
-	return orig_hub_control(hcd, typeReq, wValue, wIndex, buf, wLength);
+	return ehci_hub_control(hcd, typeReq, wValue, wIndex, buf, wLength);
 
 done:
 	spin_unlock_irqrestore(&ehci->lock, flags);
@@ -531,8 +527,6 @@ static int __init ehci_tegra_init(void)
 	 * too easy.
 	 */
 
-	orig_hub_control = tegra_ehci_hc_driver.hub_control;
-
 	tegra_ehci_hc_driver.map_urb_for_dma = tegra_ehci_map_urb_for_dma;
 	tegra_ehci_hc_driver.unmap_urb_for_dma = tegra_ehci_unmap_urb_for_dma;
 	tegra_ehci_hc_driver.hub_control = tegra_ehci_hub_control;
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index 9dfc6c1..eee228a 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -872,4 +872,7 @@ extern int	ehci_suspend(struct usb_hcd *hcd, bool do_wakeup);
 extern int	ehci_resume(struct usb_hcd *hcd, bool hibernated);
 #endif	/* CONFIG_PM */
 
+extern int	ehci_hub_control(struct usb_hcd	*hcd, u16 typeReq, u16 wValue,
+				 u16 wIndex, char *buf, u16 wLength);
+
 #endif /* __LINUX_EHCI_HCD_H */
-- 
1.8.3.2
