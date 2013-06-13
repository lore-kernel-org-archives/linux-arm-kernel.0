From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Jun 2013 16:00:26 +0900
Subject: [PATCH 02/12] ehci-platform: add pre_setup() method to platform data
In-Reply-To: <1371106836-25388-1-git-send-email-horms+renesas@verge.net.au>
References: <1371106836-25388-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371106836-25388-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Sometimes there is a need  to initialize some non-standard registers mapped to
the EHCI region before accessing the standard EHCI registers.  Add pre_setup()
method with 'struct usb_hcd *' parameter to be called just before ehci_setup()
to the 'ehci-platform'  driver's platform data for this purpose...

While at it, add the missing incomplete declaration of 'struct platform_device'
to <linux/usb/ehci_pdriver.h>...

The patch has been tested on the Marzen and BOCK-W boards.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/usb/host/ehci-platform.c | 6 ++++++
 include/linux/usb/ehci_pdriver.h | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index f47f259..d1f5cea 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -48,6 +48,12 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
 	ehci->big_endian_desc = pdata->big_endian_desc;
 	ehci->big_endian_mmio = pdata->big_endian_mmio;
 
+	if (pdata->pre_setup) {
+		retval = pdata->pre_setup(hcd);
+		if (retval < 0)
+			return retval;
+	}
+
 	ehci->caps = hcd->regs + pdata->caps_offset;
 	retval = ehci_setup(hcd);
 	if (retval)
diff --git a/include/linux/usb/ehci_pdriver.h b/include/linux/usb/ehci_pdriver.h
index 99238b0..7eb4dcd 100644
--- a/include/linux/usb/ehci_pdriver.h
+++ b/include/linux/usb/ehci_pdriver.h
@@ -19,6 +19,9 @@
 #ifndef __USB_CORE_EHCI_PDRIVER_H
 #define __USB_CORE_EHCI_PDRIVER_H
 
+struct platform_device;
+struct usb_hcd;
+
 /**
  * struct usb_ehci_pdata - platform_data for generic ehci driver
  *
@@ -50,6 +53,7 @@ struct usb_ehci_pdata {
 	/* Turn on only VBUS suspend power and hotplug detection,
 	 * turn off everything else */
 	void (*power_suspend)(struct platform_device *pdev);
+	int (*pre_setup)(struct usb_hcd *hcd);
 };
 
 #endif /* __USB_CORE_EHCI_PDRIVER_H */
-- 
1.8.2.1
