From: sriram.dash@nxp.com (Sriram Dash)
Date: Wed, 21 Sep 2016 11:43:59 +0000
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <3596831.dckG5peiyF@wuerfel>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <3189648.KnWLgq0lTY@wuerfel>
 <DB5PR0401MB19259C5DBD40BEEC70F0B7CEF5F60@DB5PR0401MB1925.eurprd04.prod.outlook.com>
 <3596831.dckG5peiyF@wuerfel>
Message-ID: <DB5PR0401MB1925CDF6CBD45ACBEE95D152F5F60@DB5PR0401MB1925.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From: Arnd Bergmann [mailto:arnd at arndb.de]
>On Wednesday, September 21, 2016 11:06:47 AM CEST Sriram Dash wrote:
>>
>> Hello Arnd,
>>
>> We tried this patch on NXP platforms (ls2085 and ls1043) which use
>> dwc3 controller without any glue layer. On first go, this did not
>> work. But after minimal reworks mention snippet below, we are able to
>> verify that the USB was working OK.
>>
>>  drivers/usb/host/xhci-mem.c | 12 ++++++------
>>  drivers/usb/host/xhci.c     | 20 ++++++++++----------
>>
>> -       struct device *dev = xhci_to_hcd(xhci)->self.controller;
>> +       struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
>>
>> We believe the patch needs little modification to work or there might
>> be chances we may have missed something. Any idea?
>
>
>I had not tried the patch, it was just sent for clarification what I meant, so I'm glad
>you got it working with just minimal changes.
>
>Unfortunately, I can't tell from your lines above what exactly you changed, can you
>send that again as a proper patch?
>

Sure.

==============================================================
>From 8b0dea1513e9e73a11dcfa802ddc71cca11d66f8 Mon Sep 17 00:00:00 2001
From: Sriram Dash <sriram.dash@nxp.com>
Date: Wed, 21 Sep 2016 11:39:30 +0530
Subject: [PATCH] usb: xhci: Fix the patch inherit dma configuration from
 parent dev

Fixes the patch https://patchwork.kernel.org/patch/9319527/
("usb: dwc3: host: inherit dma configuration from parent dev").

Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
---
 drivers/usb/host/xhci-mem.c | 12 ++++++------
 drivers/usb/host/xhci.c     | 20 ++++++++++----------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 6afe323..79608df 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -586,7 +586,7 @@ static void xhci_free_stream_ctx(struct xhci_hcd *xhci,
 		unsigned int num_stream_ctxs,
 		struct xhci_stream_ctx *stream_ctx, dma_addr_t dma)
 {
-	struct device *dev = xhci_to_hcd(xhci)->self.controller;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	size_t size = sizeof(struct xhci_stream_ctx) * num_stream_ctxs;
 
 	if (size > MEDIUM_STREAM_ARRAY_SIZE)
@@ -614,7 +614,7 @@ static struct xhci_stream_ctx *xhci_alloc_stream_ctx(struct xhci_hcd *xhci,
 		unsigned int num_stream_ctxs, dma_addr_t *dma,
 		gfp_t mem_flags)
 {
-	struct device *dev = xhci_to_hcd(xhci)->self.controller;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	size_t size = sizeof(struct xhci_stream_ctx) * num_stream_ctxs;
 
 	if (size > MEDIUM_STREAM_ARRAY_SIZE)
@@ -1644,7 +1644,7 @@ void xhci_slot_copy(struct xhci_hcd *xhci,
 static int scratchpad_alloc(struct xhci_hcd *xhci, gfp_t flags)
 {
 	int i;
-	struct device *dev = xhci_to_hcd(xhci)->self.controller;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	int num_sp = HCS_MAX_SCRATCHPAD(xhci->hcs_params2);
 
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
@@ -1716,7 +1716,7 @@ static void scratchpad_free(struct xhci_hcd *xhci)
 {
 	int num_sp;
 	int i;
-	struct device *dev = xhci_to_hcd(xhci)->self.controller;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 
 	if (!xhci->scratchpad)
 		return;
@@ -1792,7 +1792,7 @@ void xhci_free_command(struct xhci_hcd *xhci,
 
 void xhci_mem_cleanup(struct xhci_hcd *xhci)
 {
-	struct device	*dev = xhci_to_hcd(xhci)->self.controller;
+	struct device	*dev = xhci_to_hcd(xhci)->self.sysdev;
 	int size;
 	int i, j, num_ports;
 
@@ -2334,7 +2334,7 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
 int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 {
 	dma_addr_t	dma;
-	struct device	*dev = xhci_to_hcd(xhci)->self.controller;
+	struct device	*dev = xhci_to_hcd(xhci)->self.sysdev;
 	unsigned int	val, val2;
 	u64		val_64;
 	struct xhci_segment	*seg;
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 01d96c9..9a1ff09 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -231,7 +231,7 @@ static int xhci_free_msi(struct xhci_hcd *xhci)
 static int xhci_setup_msi(struct xhci_hcd *xhci)
 {
 	int ret;
-	struct pci_dev  *pdev = to_pci_dev(xhci_to_hcd(xhci)->self.controller);
+	struct pci_dev  *pdev = to_pci_dev(xhci_to_hcd(xhci)->self.sysdev);
 
 	ret = pci_enable_msi(pdev);
 	if (ret) {
@@ -257,7 +257,7 @@ static int xhci_setup_msi(struct xhci_hcd *xhci)
  */
 static void xhci_free_irq(struct xhci_hcd *xhci)
 {
-	struct pci_dev *pdev = to_pci_dev(xhci_to_hcd(xhci)->self.controller);
+	struct pci_dev *pdev = to_pci_dev(xhci_to_hcd(xhci)->self.sysdev);
 	int ret;
 
 	/* return if using legacy interrupt */
@@ -280,7 +280,7 @@ static int xhci_setup_msix(struct xhci_hcd *xhci)
 {
 	int i, ret = 0;
 	struct usb_hcd *hcd = xhci_to_hcd(xhci);
-	struct pci_dev *pdev = to_pci_dev(hcd->self.controller);
+	struct pci_dev *pdev = to_pci_dev(hcd->self.sysdev);
 
 	/*
 	 * calculate number of msi-x vectors supported.
@@ -337,7 +337,7 @@ free_entries:
 static void xhci_cleanup_msix(struct xhci_hcd *xhci)
 {
 	struct usb_hcd *hcd = xhci_to_hcd(xhci);
-	struct pci_dev *pdev = to_pci_dev(hcd->self.controller);
+	struct pci_dev *pdev = to_pci_dev(hcd->self.sysdev);
 
 	if (xhci->quirks & XHCI_PLAT)
 		return;
@@ -376,7 +376,7 @@ static int xhci_try_enable_msi(struct usb_hcd *hcd)
 	if (xhci->quirks & XHCI_PLAT)
 		return 0;
 
-	pdev = to_pci_dev(xhci_to_hcd(xhci)->self.controller);
+	pdev = to_pci_dev(xhci_to_hcd(xhci)->self.sysdev);
 	/*
 	 * Some Fresco Logic host controllers advertise MSI, but fail to
 	 * generate interrupts.  Don't even try to enable MSI.
@@ -745,7 +745,7 @@ void xhci_shutdown(struct usb_hcd *hcd)
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
 
 	if (xhci->quirks & XHCI_SPURIOUS_REBOOT)
-		usb_disable_xhci_ports(to_pci_dev(hcd->self.controller));
+		usb_disable_xhci_ports(to_pci_dev(hcd->self.sysdev));
 
 	spin_lock_irq(&xhci->lock);
 	xhci_halt(xhci);
@@ -762,7 +762,7 @@ void xhci_shutdown(struct usb_hcd *hcd)
 
 	/* Yet another workaround for spurious wakeups at shutdown with HSW */
 	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
-		pci_set_power_state(to_pci_dev(hcd->self.controller), PCI_D3hot);
+		pci_set_power_state(to_pci_dev(hcd->self.sysdev), PCI_D3hot);
 }
 
 #ifdef CONFIG_PM
@@ -3605,7 +3605,7 @@ void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	 * if no devices remain.
 	 */
 	if (xhci->quirks & XHCI_RESET_ON_RESUME)
-		pm_runtime_put_noidle(hcd->self.controller);
+		pm_runtime_put_noidle(hcd->self.sysdev);
 #endif
 
 	ret = xhci_check_args(hcd, udev, NULL, 0, true, __func__);
@@ -3745,7 +3745,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	 * suspend if there is a device attached.
 	 */
 	if (xhci->quirks & XHCI_RESET_ON_RESUME)
-		pm_runtime_get_noresume(hcd->self.controller);
+		pm_runtime_get_noresume(hcd->self.sysdev);
 #endif
 
 
@@ -4834,7 +4834,7 @@ int xhci_get_frame(struct usb_hcd *hcd)
 int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 {
 	struct xhci_hcd		*xhci;
-	struct device		*dev = hcd->self.controller;
+	struct device		*dev = hcd->self.sysdev;
 	int			retval;
 
 	/* Accept arbitrarily long scatter-gather lists */
-- 
2.1.0

==============================================================

>I think I also had some minimal changes that I did myself in order to fix a build
>regression I introduced.
>
>	Arnd
