From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Mon, 27 May 2013 17:55:49 +0530
Subject: [RFC V7 PATCH 2/3] USB: OHCI: Generic changes to make ohci-pci a
 separate driver
In-Reply-To: <1369657550-24101-1-git-send-email-manjunath.goudar@linaro.org>
References: <1365746856-7772-2-git-send-email-manjunath.goudar@linaro.org>
 <1369657550-24101-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1369657550-24101-3-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Note that this changes is part of separating the ohci pci host controller
driver from ohci-hcd host code.
This contains :
     -Moved sb800_prefetch() function from ohci-pci.c to pci-quirks.c file
      and EXPORTed, this is part of the effort to move the ohci pci related
      code to generic pci code.
     -Passed "device" argument instead  of "ohci_hcd" in sb800_prefetch()
      function to avoid extra include file in pci-quirks.c.

V2:
     -Passed "device" argment instead of "pci_dev", then we use to_pci_dev()
      to get the "pci_dev" structure.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-hcd.c   |    9 ---------
 drivers/usb/host/ohci-pci.c   |   13 -------------
 drivers/usb/host/ohci-q.c     |    6 ++++--
 drivers/usb/host/pci-quirks.c |   13 +++++++++++++
 drivers/usb/host/pci-quirks.h |    2 ++
 5 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 13ebbb7..82f586a 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -80,15 +80,6 @@ static const char	hcd_name [] = "ohci_hcd";
 
 static void ohci_dump (struct ohci_hcd *ohci, int verbose);
 static void ohci_stop (struct usb_hcd *hcd);
-#ifdef CONFIG_PCI
-static void sb800_prefetch(struct ohci_hcd *ohci, int on);
-#else
-static inline void sb800_prefetch(struct ohci_hcd *ohci, int on)
-{
-	return;
-}
-#endif
-
 
 #include "ohci-hub.c"
 #include "ohci-dbg.c"
diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
index 2c27a5f..c3fa936 100644
--- a/drivers/usb/host/ohci-pci.c
+++ b/drivers/usb/host/ohci-pci.c
@@ -168,19 +168,6 @@ static int ohci_quirk_amd700(struct usb_hcd *hcd)
 	return 0;
 }
 
-static void sb800_prefetch(struct ohci_hcd *ohci, int on)
-{
-	struct pci_dev *pdev;
-	u16 misc;
-
-	pdev = to_pci_dev(ohci_to_hcd(ohci)->self.controller);
-	pci_read_config_word(pdev, 0x50, &misc);
-	if (on == 0)
-		pci_write_config_word(pdev, 0x50, misc & 0xfcff);
-	else
-		pci_write_config_word(pdev, 0x50, misc | 0x0300);
-}
-
 /* List of quirks for OHCI */
 static const struct pci_device_id ohci_pci_quirks[] = {
 	{
diff --git a/drivers/usb/host/ohci-q.c b/drivers/usb/host/ohci-q.c
index 88731b7..df4a670 100644
--- a/drivers/usb/host/ohci-q.c
+++ b/drivers/usb/host/ohci-q.c
@@ -41,6 +41,7 @@ finish_urb(struct ohci_hcd *ohci, struct urb *urb, int status)
 __releases(ohci->lock)
 __acquires(ohci->lock)
 {
+	 struct device *dev = ohci_to_hcd(ohci)->self.controller;
 	// ASSERT (urb->hcpriv != 0);
 
 	urb_free_priv (ohci, urb->hcpriv);
@@ -55,7 +56,7 @@ __acquires(ohci->lock)
 			if (quirk_amdiso(ohci))
 				usb_amd_quirk_pll_enable();
 			if (quirk_amdprefetch(ohci))
-				sb800_prefetch(ohci, 0);
+				sb800_prefetch(dev, 0);
 		}
 		break;
 	case PIPE_INTERRUPT:
@@ -580,6 +581,7 @@ static void td_submit_urb (
 	struct urb	*urb
 ) {
 	struct urb_priv	*urb_priv = urb->hcpriv;
+	struct device *dev = ohci_to_hcd(ohci)->self.controller;
 	dma_addr_t	data;
 	int		data_len = urb->transfer_buffer_length;
 	int		cnt = 0;
@@ -689,7 +691,7 @@ static void td_submit_urb (
 			if (quirk_amdiso(ohci))
 				usb_amd_quirk_pll_disable();
 			if (quirk_amdprefetch(ohci))
-				sb800_prefetch(ohci, 1);
+				sb800_prefetch(dev, 1);
 		}
 		periodic = ohci_to_hcd(ohci)->self.bandwidth_isoc_reqs++ == 0
 			&& ohci_to_hcd(ohci)->self.bandwidth_int_reqs == 0;
diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 4c338ec..b9848e4 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -91,6 +91,19 @@ static struct amd_chipset_info {
 
 static DEFINE_SPINLOCK(amd_lock);
 
+void sb800_prefetch(struct device *dev, int on)
+{
+	u16 misc;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	pci_read_config_word(pdev, 0x50, &misc);
+	if (on == 0)
+		pci_write_config_word(pdev, 0x50, misc & 0xfcff);
+	else
+		pci_write_config_word(pdev, 0x50, misc | 0x0300);
+}
+EXPORT_SYMBOL_GPL(sb800_prefetch);
+
 int usb_amd_find_chipset_info(void)
 {
 	u8 rev = 0;
diff --git a/drivers/usb/host/pci-quirks.h b/drivers/usb/host/pci-quirks.h
index 7f69a39..4b8a209 100644
--- a/drivers/usb/host/pci-quirks.h
+++ b/drivers/usb/host/pci-quirks.h
@@ -11,11 +11,13 @@ void usb_amd_quirk_pll_enable(void);
 bool usb_is_intel_switchable_xhci(struct pci_dev *pdev);
 void usb_enable_xhci_ports(struct pci_dev *xhci_pdev);
 void usb_disable_xhci_ports(struct pci_dev *xhci_pdev);
+void sb800_prefetch(struct device *dev, int on);
 #else
 static inline void usb_amd_quirk_pll_disable(void) {}
 static inline void usb_amd_quirk_pll_enable(void) {}
 static inline void usb_amd_dev_put(void) {}
 static inline void usb_disable_xhci_ports(struct pci_dev *xhci_pdev) {}
+static inline void sb800_prefetch(struct device *dev, int on) {}
 #endif  /* CONFIG_PCI */
 
 #endif  /*  __LINUX_USB_PCI_QUIRKS_H  */
-- 
1.7.9.5
