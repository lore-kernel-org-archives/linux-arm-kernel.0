From: stigge@antcom.de (Roland Stigge)
Date: Sun,  3 Jun 2012 20:24:52 +0200
Subject: [PATCH] ohci-nxp: Use ohci_finish_controller_resume()
Message-ID: <1338747893-29338-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OHCI drivers are supposed to use ohci_finish_controller_resume(). This patch
adds respective suspend and resume code to ohci-nxp. The following compiler
warning is fixed this way:

drivers/usb/host/ohci-hub.c:321: warning: 'ohci_finish_controller_resume'
defined but not used

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
Applies to v3.5-rc1

 drivers/usb/host/ohci-nxp.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- linux-2.6.orig/drivers/usb/host/ohci-nxp.c
+++ linux-2.6/drivers/usb/host/ohci-nxp.c
@@ -432,6 +432,23 @@ static int usb_hcd_nxp_remove(struct pla
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int usb_hcd_suspend(struct platform_device *pdev, pm_message_t message)
+{
+	clk_disable(usb_clk);
+	return 0;
+}
+
+static int usb_hcd_resume(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+
+	clk_enable(usb_clk);
+	ohci_finish_controller_resume(hcd);
+	return 0;
+}
+#endif
+
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:usb-ohci");
 
@@ -451,5 +468,9 @@ static struct platform_driver usb_hcd_nx
 	},
 	.probe = usb_hcd_nxp_probe,
 	.remove = usb_hcd_nxp_remove,
+#ifdef CONFIG_PM
+	.suspend = usb_hcd_suspend,
+	.resume = usb_hcd_resume,
+#endif
 };
 
