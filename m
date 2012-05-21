From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 21 May 2012 17:23:47 +0800
Subject: [PATCH v2 02/12] usb: chipidea: permit driver bindings pass phy
 pointer
In-Reply-To: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1337592237-5090-3-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sometimes, the driver bindings may know what phy they use.
For example, when using device tree, the usb controller may have a
phandler pointing to usb phy.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/usb/chipidea/ci.h    |    2 ++
 drivers/usb/chipidea/core.c  |    4 ++++
 drivers/usb/chipidea/host.c  |    1 +
 drivers/usb/chipidea/udc.c   |   11 +++++++----
 include/linux/usb/chipidea.h |    3 +++
 5 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index 50911f8..71d7080 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -160,6 +160,8 @@ struct ci13xxx {
 
 	struct ci13xxx_udc_driver	*udc_driver;
 	int				vbus_active;
+	/* FIXME: some day, we'll not use global phy */
+	bool				global_phy;
 	struct usb_phy			*transceiver;
 	struct usb_hcd			*hcd;
 };
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 15e03b3..0492786 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -365,6 +365,10 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
 
 	ci->dev = dev;
 	ci->udc_driver = dev->platform_data;
+	if (ci->udc_driver->phy)
+		ci->transceiver = ci->udc_driver->phy;
+	else
+		ci->global_phy = 1;
 
 	ret = hw_device_init(ci, base);
 	if (ret < 0) {
diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index 9eacd21..7bc11a5 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -121,6 +121,7 @@ static int host_start(struct ci13xxx *ci)
 	ehci = hcd_to_ehci(hcd);
 	ehci->caps = ci->hw_bank.cap;
 	ehci->has_hostpc = ci->hw_bank.lpm;
+	ehci->transceiver = ci->transceiver;
 
 	ret = usb_add_hcd(hcd, 0, 0);
 	if (ret)
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 51f9694..22139fae 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1687,7 +1687,8 @@ static int udc_start(struct ci13xxx *udc)
 
 	udc->gadget.ep0 = &udc->ep0in->ep;
 
-	udc->transceiver = usb_get_transceiver();
+	if (udc->global_phy) {
+		udc->transceiver = usb_get_transceiver();
 
 	if (udc->udc_driver->flags & CI13XXX_REQUIRE_TRANSCEIVER) {
 		if (udc->transceiver == NULL) {
@@ -1731,7 +1732,8 @@ static int udc_start(struct ci13xxx *udc)
 remove_trans:
 	if (udc->transceiver) {
 		otg_set_peripheral(udc->transceiver->otg, &udc->gadget);
-		usb_put_transceiver(udc->transceiver);
+		if (udc->global_phy)
+			usb_put_transceiver(udc->transceiver);
 	}
 
 	dev_err(dev, "error = %i\n", retval);
@@ -1740,7 +1742,7 @@ remove_dbg:
 unreg_device:
 	device_unregister(&udc->gadget.dev);
 put_transceiver:
-	if (udc->transceiver)
+	if (udc->transceiver && udc->global_phy)
 		usb_put_transceiver(udc->transceiver);
 free_pools:
 	dma_pool_destroy(udc->td_pool);
@@ -1774,7 +1776,8 @@ static void udc_stop(struct ci13xxx *udc)
 
 	if (udc->transceiver) {
 		otg_set_peripheral(udc->transceiver->otg, NULL);
-		usb_put_transceiver(udc->transceiver);
+		if (udc->global_phy)
+			usb_put_transceiver(udc->transceiver);
 	}
 	dbg_remove_files(&udc->gadget.dev);
 	device_unregister(&udc->gadget.dev);
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index edb90d6..c46c9e9 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -5,12 +5,15 @@
 #ifndef __LINUX_USB_CHIPIDEA_H
 #define __LINUX_USB_CHIPIDEA_H
 
+#include <linux/usb/otg.h>
+
 struct ci13xxx;
 struct ci13xxx_udc_driver {
 	const char	*name;
 	/* offset of the capability registers */
 	uintptr_t	 capoffset;
 	unsigned	 power_budget;
+	struct usb_phy	*phy;
 	unsigned long	 flags;
 #define CI13XXX_REGS_SHARED		BIT(0)
 #define CI13XXX_REQUIRE_TRANSCEIVER	BIT(1)
-- 
1.7.5.4
