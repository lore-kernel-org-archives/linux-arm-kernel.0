From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Tue,  7 May 2013 15:20:52 +0530
Subject: [RFC PATCH 1/2] USB: OHCI: prepare to make ohci-hcd a library module
In-Reply-To: <1367920253-15207-1-git-send-email-manjunath.goudar@linaro.org>
References: <1365746856-7772-2-git-send-email-manjunath.goudar@linaro.org>
 <1367920253-15207-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1367920253-15207-2-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch prepares ohci-hcd for being split up into a core
library and separate platform driver modules.  A generic
ohci_hc_driver structure is created, containing all the "standard"
values, and a new mechanism is added whereby a driver module can
specify a set of overrides to those values.  In addition the
ohci_restart(),ohci_suspend() and ohci_resume() routines need
to be EXPORTed for use by the drivers.

In V2:
-ohci_hcd_init(), ohci_run() and ohci_stop revert back to static routine.
-ohci_setup() and ohci_start() functions written to generic OHCI initialization
 for all ohci bus glue.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/Makefile        |    2 +
 drivers/usb/host/ohci-hcd.c      |  123 +++++++++++++++++++++++++++++++++-----
 drivers/usb/host/ohci-pci.c      |    2 +-
 drivers/usb/host/ohci-platform.c |    2 +-
 drivers/usb/host/ohci.h          |   30 +++++++++-
 5 files changed, 138 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 58c14c1..a38d76b 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -40,7 +40,9 @@ obj-$(CONFIG_USB_EHCI_TEGRA)    +=ehci-tegra.o
 obj-$(CONFIG_USB_OXU210HP_HCD)	+= oxu210hp-hcd.o
 obj-$(CONFIG_USB_ISP116X_HCD)	+= isp116x-hcd.o
 obj-$(CONFIG_USB_ISP1362_HCD)	+= isp1362-hcd.o
+
 obj-$(CONFIG_USB_OHCI_HCD)	+= ohci-hcd.o
+
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
 obj-$(CONFIG_USB_XHCI_HCD)	+= xhci-hcd.o
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 9e6de95..7922c61 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -79,13 +79,7 @@ static const char	hcd_name [] = "ohci_hcd";
 #include "pci-quirks.h"
 
 static void ohci_dump (struct ohci_hcd *ohci, int verbose);
-static int ohci_init (struct ohci_hcd *ohci);
-static void ohci_stop (struct usb_hcd *hcd);
-
-#if defined(CONFIG_PM) || defined(CONFIG_PCI)
-static int ohci_restart (struct ohci_hcd *ohci);
-#endif
-
+static void ohci_stop(struct usb_hcd *hcd);
 #ifdef CONFIG_PCI
 static void sb800_prefetch(struct ohci_hcd *ohci, int on);
 #else
@@ -520,7 +514,7 @@ done:
 
 /* init memory, and kick BIOS/SMM off */
 
-static int ohci_init (struct ohci_hcd *ohci)
+int ohci_init(struct ohci_hcd *ohci)
 {
 	int ret;
 	struct usb_hcd *hcd = ohci_to_hcd(ohci);
@@ -590,6 +584,7 @@ static int ohci_init (struct ohci_hcd *ohci)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(ohci_init);
 
 /*-------------------------------------------------------------------------*/
 
@@ -597,11 +592,11 @@ static int ohci_init (struct ohci_hcd *ohci)
  * resets USB and controller
  * enable interrupts
  */
-static int ohci_run (struct ohci_hcd *ohci)
+static int ohci_run(struct usb_hcd *hcd)
 {
+	struct ohci_hcd		*ohci = hcd_to_ohci(hcd);
 	u32			mask, val;
 	int			first = ohci->fminterval == 0;
-	struct usb_hcd		*hcd = ohci_to_hcd(ohci);
 
 	ohci->rh_state = OHCI_RH_HALTED;
 
@@ -767,7 +762,37 @@ retry:
 
 	return 0;
 }
+/*------------------------------------------------------------------------*/
+
+/* ohci generic function for all OHCI bus glue */
+
+static int ohci_setup(struct usb_hcd *hcd)
+{
+	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+	int retval;
+
+	ohci->sbrn = HCD_USB11;
+
+	/* data structure init */
+	retval = ohci_init(ohci);
+	if (retval)
+		return retval;
+	ohci_usb_reset(ohci);
+	return 0;
+}
 
+static int ohci_start(struct usb_hcd *hcd)
+{
+	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+	int	ret;
+	ret = ohci_run(hcd);
+	if (ret < 0) {
+		ohci_err(ohci, "can't start\n");
+		ohci_stop(hcd);
+	}
+	return ret;
+}
+/*-------------------------------------------------------------------------*/
 /*-------------------------------------------------------------------------*/
 
 /* an interrupt happens */
@@ -949,11 +974,12 @@ static void ohci_stop (struct usb_hcd *hcd)
 #if defined(CONFIG_PM) || defined(CONFIG_PCI)
 
 /* must not be called from interrupt context */
-static int ohci_restart (struct ohci_hcd *ohci)
+int ohci_restart(struct ohci_hcd *ohci)
 {
 	int temp;
 	int i;
 	struct urb_priv *priv;
+	struct usb_hcd	*hcd;
 
 	spin_lock_irq(&ohci->lock);
 	ohci->rh_state = OHCI_RH_HALTED;
@@ -1001,19 +1027,22 @@ static int ohci_restart (struct ohci_hcd *ohci)
 	ohci->ed_controltail = NULL;
 	ohci->ed_bulktail    = NULL;
 
-	if ((temp = ohci_run (ohci)) < 0) {
-		ohci_err (ohci, "can't restart, %d\n", temp);
+	hcd = ohci_to_hcd(ohci);
+	temp = ohci_run(hcd);
+	if (temp < 0) {
+		ohci_err(ohci, "can't restart, %d\n", temp);
 		return temp;
 	}
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
@@ -1031,9 +1060,9 @@ static int __maybe_unused ohci_suspend(struct usb_hcd *hcd, bool do_wakeup)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ohci_suspend);
 
-
-static int __maybe_unused ohci_resume(struct usb_hcd *hcd, bool hibernated)
+int ohci_resume(struct usb_hcd *hcd, bool hibernated)
 {
 	struct ohci_hcd		*ohci = hcd_to_ohci(hcd);
 	int			port;
@@ -1081,11 +1110,73 @@ static int __maybe_unused ohci_resume(struct usb_hcd *hcd, bool hibernated)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ohci_resume);
 
 #endif
 
 /*-------------------------------------------------------------------------*/
 
+/*
+ * Generic structure: This gets copied for platform drivers so that
+ * individual entries can be overridden as needed.
+ */
+
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
+	.reset =		ohci_setup,
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
+	.bus_suspend =          ohci_bus_suspend,
+	.bus_resume =           ohci_bus_resume,
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
+
+/*-------------------------------------------------------------------------*/
+
 MODULE_AUTHOR (DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE ("GPL");
diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
index 951514e..0b34b59 100644
--- a/drivers/usb/host/ohci-pci.c
+++ b/drivers/usb/host/ohci-pci.c
@@ -288,7 +288,7 @@ static int ohci_pci_start (struct usb_hcd *hcd)
 	}
 #endif /* CONFIG_PM */
 
-	ret = ohci_run (ohci);
+	ret = ohci_run(hcd);
 	if (ret < 0) {
 		ohci_err (ohci, "can't start\n");
 		ohci_stop (hcd);
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index c3e7287..545c657 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -46,7 +46,7 @@ static int ohci_platform_start(struct usb_hcd *hcd)
 	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
 	int err;
 
-	err = ohci_run(ohci);
+	err = ohci_run(hcd);
 	if (err < 0) {
 		ohci_err(ohci, "can't start\n");
 		ohci_stop(hcd);
diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index d329914..455e9b1 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -357,7 +357,6 @@ struct ohci_hcd {
 	 * I/O memory used to communicate with the HC (dma-consistent)
 	 */
 	struct ohci_regs __iomem *regs;
-
 	/*
 	 * main memory used to communicate with the HC (dma-consistent).
 	 * hcd adds to schedule for a live hc any time, but removals finish
@@ -373,7 +372,6 @@ struct ohci_hcd {
 	struct ed		*periodic [NUM_INTS];	/* shadow int_table */
 
 	void (*start_hnp)(struct ohci_hcd *ohci);
-
 	/*
 	 * memory management for queue data structures
 	 */
@@ -392,7 +390,7 @@ struct ohci_hcd {
 	unsigned long		next_statechange;	/* suspend/resume */
 	u32			fminterval;		/* saved register */
 	unsigned		autostop:1;	/* rh auto stopping/stopped */
-
+	u8			sbrn;
 	unsigned long		flags;		/* for HC bugs */
 #define	OHCI_QUIRK_AMD756	0x01			/* erratum #4 */
 #define	OHCI_QUIRK_SUPERIO	0x02			/* natsemi */
@@ -718,3 +716,29 @@ static inline u32 roothub_status (struct ohci_hcd *hc)
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
+extern int	ohci_init(struct ohci_hcd *ohci);
+extern int	ohci_restart(struct ohci_hcd *ohci);
+#ifdef CONFIG_PM
+extern int	ohci_suspend(struct usb_hcd *hcd, bool do_wakeup);
+extern int	ohci_resume(struct usb_hcd *hcd, bool hibernated);
+#else
+static inline int ohci_suspend(struct usb_hcd *hcd, bool do_wakeup)
+{
+	return 0;
+}
+static inline int ohci_resume(struct usb_hcd *hcd, bool hibernated)
+{
+	return 0;
+}
+#endif
-- 
1.7.9.5
