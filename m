From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Thu, 23 May 2013 16:41:44 +0530
Subject: [RFC V6 PATCH 1/3] USB: OHCI: prepare to make ohci-hcd a library
 module
In-Reply-To: <1369307506-4458-1-git-send-email-manjunath.goudar@linaro.org>
References: <1365746856-7772-2-git-send-email-manjunath.goudar@linaro.org>
 <1369307506-4458-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1369307506-4458-2-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch prepares ohci-hcd for being split up into a core
library and separate platform driver modules.  A generic
ohci_hc_driver structure is created, containing all the "standard"
values, and a new mechanism is added whereby a driver module can
specify a set of overrides to those values.  In addition the
ohci_restart(),ohci_suspend() and ohci_resume() routines need
to be EXPORTed for use by the drivers.

Added ohci_setip(() and ohci_start() routine for to start the generic
controller rather than each having its own idiosyncratic approach.
This allow to clean duplicated code in most of SOC driver

In V2:
 -ohci_hcd_init() ohci_run() and ohci_stop() are not made non-static.
 -Adds the ohci_setup() and ohci_start() routine.

In V3:
 -purpose of ohci_setup() and ohci_start() function description written in the patch
  description.
 -ohci_init() are not made non-static but now called beginning of the ohci_restart().
 -ohci_run() signature change reverted back.
 -unrelated changes removed.
 -duplicate comment line removed.
 -inline ohci_suspend() and ohci_resume() is not needed so removed from ohci.h file.

In V4:
 -ohci-init() EXPORTed because it is called by all bus glue modules.
 -ohci-setup() removed from 1/2 added into 2/2 patch.

In V5:
 -Again ohci_setup() is added and EXPORTed because to replace the ohci_init() from
  all bus glues.
 -ohci_init() is not made non-static function.

In V6:
  -ohci_init() call is removed from ohci_quirk_nec_worker(), because it is already called in ohci_restart().

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-hcd.c |  103 +++++++++++++++++++++++++++++++++++++++----
 drivers/usb/host/ohci-hub.c |    1 -
 drivers/usb/host/ohci-pci.c |    7 ---
 drivers/usb/host/ohci.h     |   17 +++++++
 4 files changed, 111 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 9e6de95..13ebbb7 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -79,13 +79,7 @@ static const char	hcd_name [] = "ohci_hcd";
 #include "pci-quirks.h"
 
 static void ohci_dump (struct ohci_hcd *ohci, int verbose);
-static int ohci_init (struct ohci_hcd *ohci);
 static void ohci_stop (struct usb_hcd *hcd);
-
-#if defined(CONFIG_PM) || defined(CONFIG_PCI)
-static int ohci_restart (struct ohci_hcd *ohci);
-#endif
-
 #ifdef CONFIG_PCI
 static void sb800_prefetch(struct ohci_hcd *ohci, int on);
 #else
@@ -768,6 +762,30 @@ retry:
 	return 0;
 }
 
+/* ohci_setup routine for generic controller initialization */
+
+int ohci_setup(struct usb_hcd *hcd)
+{
+	struct ohci_hcd		*ohci = hcd_to_ohci(hcd);
+
+	return ohci_init(ohci);
+}
+EXPORT_SYMBOL_GPL(ohci_setup);
+
+/* ohci_start routine for generic controller start of all OHCI bus glue */
+static int ohci_start(struct usb_hcd *hcd)
+{
+	struct ohci_hcd		*ohci = hcd_to_ohci(hcd);
+	int	ret;
+
+	ret = ohci_run(ohci);
+	if (ret < 0) {
+		ohci_err(ohci, "can't start\n");
+		ohci_stop(hcd);
+	}
+	return ret;
+}
+
 /*-------------------------------------------------------------------------*/
 
 /* an interrupt happens */
@@ -949,12 +967,13 @@ static void ohci_stop (struct usb_hcd *hcd)
 #if defined(CONFIG_PM) || defined(CONFIG_PCI)
 
 /* must not be called from interrupt context */
-static int ohci_restart (struct ohci_hcd *ohci)
+int ohci_restart(struct ohci_hcd *ohci)
 {
 	int temp;
 	int i;
 	struct urb_priv *priv;
 
+	ohci_init(ohci);
 	spin_lock_irq(&ohci->lock);
 	ohci->rh_state = OHCI_RH_HALTED;
 
@@ -1008,12 +1027,13 @@ static int ohci_restart (struct ohci_hcd *ohci)
 	ohci_dbg(ohci, "restart complete\n");
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ohci_restart);
 
 #endif
 
 #ifdef CONFIG_PM
 
-static int __maybe_unused ohci_suspend(struct usb_hcd *hcd, bool do_wakeup)
+int ohci_suspend(struct usb_hcd *hcd, bool do_wakeup)
 {
 	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
 	unsigned long	flags;
@@ -1031,9 +1051,10 @@ static int __maybe_unused ohci_suspend(struct usb_hcd *hcd, bool do_wakeup)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ohci_suspend);
 
 
-static int __maybe_unused ohci_resume(struct usb_hcd *hcd, bool hibernated)
+int ohci_resume(struct usb_hcd *hcd, bool hibernated)
 {
 	struct ohci_hcd		*ohci = hcd_to_ohci(hcd);
 	int			port;
@@ -1081,8 +1102,72 @@ static int __maybe_unused ohci_resume(struct usb_hcd *hcd, bool hibernated)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ohci_resume);
+
+#endif
+
+/*-------------------------------------------------------------------------*/
+
+/*
+ * Generic structure: This gets copied for platform drivers so that
+ * individual entries can be overridden as needed.
+ */
 
+static const struct hc_driver ohci_hc_driver = {
+	.description =          hcd_name,
+	.product_desc =         "OHCI Host Controller",
+	.hcd_priv_size =        sizeof(struct ohci_hcd),
+
+	/*
+	 * generic hardware linkage
+	*/
+	.irq =                  ohci_irq,
+	.flags =                HCD_MEMORY | HCD_USB11,
+
+	/*
+	* basic lifecycle operations
+	*/
+	.reset =                ohci_setup,
+	.start =                ohci_start,
+	.stop =                 ohci_stop,
+	.shutdown =             ohci_shutdown,
+
+	/*
+	 * managing i/o requests and associated device resources
+	*/
+	.urb_enqueue =          ohci_urb_enqueue,
+	.urb_dequeue =          ohci_urb_dequeue,
+	.endpoint_disable =     ohci_endpoint_disable,
+
+	/*
+	* scheduling support
+	*/
+	.get_frame_number =     ohci_get_frame,
+
+	/*
+	* root hub support
+	*/
+	.hub_status_data =      ohci_hub_status_data,
+	.hub_control =          ohci_hub_control,
+#ifdef CONFIG_PM
+	.bus_suspend =          ohci_bus_suspend,
+	.bus_resume =           ohci_bus_resume,
 #endif
+	.start_port_reset =	ohci_start_port_reset,
+};
+
+void ohci_init_driver(struct hc_driver *drv,
+		const struct ohci_driver_overrides *over)
+{
+	/* Copy the generic table to drv and then apply the overrides */
+	*drv = ohci_hc_driver;
+
+	drv->product_desc = over->product_desc;
+	drv->hcd_priv_size += over->extra_priv_size;
+	if (over->reset)
+		drv->reset = over->reset;
+}
+EXPORT_SYMBOL_GPL(ohci_init_driver);
 
 /*-------------------------------------------------------------------------*/
 
diff --git a/drivers/usb/host/ohci-hub.c b/drivers/usb/host/ohci-hub.c
index 60ff422..2347ab8 100644
--- a/drivers/usb/host/ohci-hub.c
+++ b/drivers/usb/host/ohci-hub.c
@@ -176,7 +176,6 @@ __acquires(ohci->lock)
 	if (status == -EBUSY) {
 		if (!autostopped) {
 			spin_unlock_irq (&ohci->lock);
-			(void) ohci_init (ohci);
 			status = ohci_restart (ohci);
 
 			usb_root_hub_lost_power(hcd->self.root_hub);
diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
index 951514e..2c27a5f 100644
--- a/drivers/usb/host/ohci-pci.c
+++ b/drivers/usb/host/ohci-pci.c
@@ -123,13 +123,6 @@ static void ohci_quirk_nec_worker(struct work_struct *work)
 	struct ohci_hcd *ohci = container_of(work, struct ohci_hcd, nec_work);
 	int status;
 
-	status = ohci_init(ohci);
-	if (status != 0) {
-		ohci_err(ohci, "Restarting NEC controller failed in %s, %d\n",
-			 "ohci_init", status);
-		return;
-	}
-
 	status = ohci_restart(ohci);
 	if (status != 0)
 		ohci_err(ohci, "Restarting NEC controller failed in %s, %d\n",
diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index d329914..3b58482 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -718,3 +718,20 @@ static inline u32 roothub_status (struct ohci_hcd *hc)
 	{ return ohci_readl (hc, &hc->regs->roothub.status); }
 static inline u32 roothub_portstatus (struct ohci_hcd *hc, int i)
 	{ return read_roothub (hc, portstatus [i], 0xffe0fce0); }
+
+/* Declarations of things exported for use by ohci platform drivers */
+
+struct ohci_driver_overrides {
+	const char	*product_desc;
+	size_t		extra_priv_size;
+	int		(*reset)(struct usb_hcd *hcd);
+};
+
+extern void	ohci_init_driver(struct hc_driver *drv,
+				const struct ohci_driver_overrides *over);
+extern int	ohci_restart(struct ohci_hcd *ohci);
+extern int	ohci_setup(struct usb_hcd *hcd);
+#ifdef CONFIG_PM
+extern int	ohci_suspend(struct usb_hcd *hcd, bool do_wakeup);
+extern int	ohci_resume(struct usb_hcd *hcd, bool hibernated);
+#endif
-- 
1.7.9.5
