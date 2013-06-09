From: ming.lei@canonical.com (Ming Lei)
Date: Sun,  9 Jun 2013 23:18:28 +0800
Subject: [RFC PATCH 1/4] USB: HCD: support giveback of URB in tasklet context
In-Reply-To: <1370791112-18464-1-git-send-email-ming.lei@canonical.com>
References: <1370791112-18464-1-git-send-email-ming.lei@canonical.com>
Message-ID: <1370791112-18464-2-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements the mechanism of giveback of URB in
tasklet context, so that hardware interrupt handling time for
usb host controller can be saved much, and HCD interrupt handling
can be simplified.

Motivations:

1), on some arch(such as ARM), DMA mapping/unmapping is a bit
time-consuming, for example: when accessing usb mass storage
via EHCI on pandaboard, the common length of transfer buffer is 120KB,
the time consumed on DMA unmapping may reach hundreds of microseconds;
even on A15 based box, the time is still about scores of microseconds

2), on some arch, reading DMA coherent memoery is very time-consuming,
the most common example is usb video class driver[1]

3), driver's complete() callback may do much things which is driver
specific, so the time is consumed unnecessarily in hardware irq context.

4), running driver's complete() callback in hardware irq context causes
that host controller driver has to release its lock in interrupt handler,
so reacquiring the lock after return may busy wait a while and increase
interrupt handling time. More seriously, releasing the HCD lock makes
HCD becoming quite complicated to deal with introduced races.

So the patch proposes to run giveback of URB in tasklet context, then
time consumed in HCD irq handling doesn't depend on drivers' complete and
DMA mapping/unmapping any more, also we can simplify HCD since the HCD
lock isn't needed to be released during irq handling.

The patch should be reasonable and doable:

1), for drivers, they don't care if the complete() is called in hard irq
context or softirq context

2), the biggest change is the situation in which usb_submit_urb() is called
in complete() callback, so the introduced tasklet schedule delay might be a
con, but it shouldn't be a big deal:

	- control/bulk asynchronous transfer isn't sensitive to schedule
	  delay

	- the patch schedules giveback of periodic URBs using
	  tasklet_hi_schedule, so the introduced delay should be very
	  small

	- use percpu tasklset for each HCD to schedule giveback of URB,
	  which are running as much as parallel

	- for ISOC transfer, generally, drivers submit several URBs
	  concurrently to avoid interrupt delay, so it is OK with the
	  little schedule delay.

	- for interrupt transfer, generally, drivers only submit one URB
	  at the same time, but interrupt transfer is often used in event
	  report, polling, ... situations, and a little delay should be OK.

Considered that HCDs may optimize on submitting URB in complete(), the
patch may cause the optimization not working, so introduces one flag to mark
if the HCD supports to run giveback URB in tasklet context. When all HCDs
are ready, the flag can be removed.

[1], http://marc.info/?t=136438111600010&r=1&w=2

Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/usb/core/hcd.c  |  170 ++++++++++++++++++++++++++++++++++++++++-------
 include/linux/usb/hcd.h |   16 +++++
 2 files changed, 162 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 3d27d87..dc319e5 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -676,9 +676,11 @@ error:
 	 * Avoiding calls to local_irq_disable/enable makes the code
 	 * RT-friendly.
 	 */
-	spin_unlock(&hcd_root_hub_lock);
+	if (!hcd_giveback_urb_in_bh(hcd))
+		spin_unlock(&hcd_root_hub_lock);
 	usb_hcd_giveback_urb(hcd, urb, status);
-	spin_lock(&hcd_root_hub_lock);
+	if (!hcd_giveback_urb_in_bh(hcd))
+		spin_lock(&hcd_root_hub_lock);
 
 	spin_unlock_irq(&hcd_root_hub_lock);
 	return 0;
@@ -719,9 +721,11 @@ void usb_hcd_poll_rh_status(struct usb_hcd *hcd)
 			memcpy(urb->transfer_buffer, buffer, length);
 
 			usb_hcd_unlink_urb_from_ep(hcd, urb);
-			spin_unlock(&hcd_root_hub_lock);
+			if (!hcd_giveback_urb_in_bh(hcd))
+				spin_unlock(&hcd_root_hub_lock);
 			usb_hcd_giveback_urb(hcd, urb, 0);
-			spin_lock(&hcd_root_hub_lock);
+			if (!hcd_giveback_urb_in_bh(hcd))
+				spin_lock(&hcd_root_hub_lock);
 		} else {
 			length = 0;
 			set_bit(HCD_FLAG_POLL_PENDING, &hcd->flags);
@@ -812,9 +816,11 @@ static int usb_rh_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 			hcd->status_urb = NULL;
 			usb_hcd_unlink_urb_from_ep(hcd, urb);
 
-			spin_unlock(&hcd_root_hub_lock);
+			if (!hcd_giveback_urb_in_bh(hcd))
+				spin_unlock(&hcd_root_hub_lock);
 			usb_hcd_giveback_urb(hcd, urb, status);
-			spin_lock(&hcd_root_hub_lock);
+			if (!hcd_giveback_urb_in_bh(hcd))
+				spin_lock(&hcd_root_hub_lock);
 		}
 	}
  done:
@@ -1627,25 +1633,11 @@ int usb_hcd_unlink_urb (struct urb *urb, int status)
 
 /*-------------------------------------------------------------------------*/
 
-/**
- * usb_hcd_giveback_urb - return URB from HCD to device driver
- * @hcd: host controller returning the URB
- * @urb: urb being returned to the USB device driver.
- * @status: completion status code for the URB.
- * Context: in_interrupt()
- *
- * This hands the URB from HCD to its USB device driver, using its
- * completion function.  The HCD has freed all per-urb resources
- * (and is done using urb->hcpriv).  It also released all HCD locks;
- * the device driver won't cause problems if it frees, modifies,
- * or resubmits this URB.
- *
- * If @urb was unlinked, the value of @status will be overridden by
- * @urb->unlinked.  Erroneous short transfers are detected in case
- * the HCD hasn't checked for them.
- */
-void usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb, int status)
+static void __usb_hcd_giveback_urb(struct urb *urb)
 {
+	struct usb_hcd *hcd = bus_to_hcd(urb->dev->bus);
+	int status = urb->status;
+
 	urb->hcpriv = NULL;
 	if (unlikely(urb->unlinked))
 		status = urb->unlinked;
@@ -1668,6 +1660,68 @@ void usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb, int status)
 		wake_up (&usb_kill_urb_queue);
 	usb_put_urb (urb);
 }
+
+static void usb_giveback_urb_bh(unsigned long param)
+{
+	struct giveback_urb_bh *bh = (struct giveback_urb_bh *)param;
+	unsigned long flags;
+	struct list_head local_list;
+
+	spin_lock_irqsave(&bh->lock, flags);
+	list_replace_init(&bh->head, &local_list);
+	spin_unlock_irqrestore(&bh->lock, flags);
+
+	while (!list_empty(&local_list)) {
+		struct urb *urb;
+
+		urb = list_entry(local_list.next, struct urb, urb_list);
+		list_del_init(&urb->urb_list);
+		__usb_hcd_giveback_urb(urb);
+	}
+}
+
+/**
+ * usb_hcd_giveback_urb - return URB from HCD to device driver
+ * @hcd: host controller returning the URB
+ * @urb: urb being returned to the USB device driver.
+ * @status: completion status code for the URB.
+ * Context: in_interrupt()
+ *
+ * This hands the URB from HCD to its USB device driver, using its
+ * completion function.  The HCD has freed all per-urb resources
+ * (and is done using urb->hcpriv).  It also released all HCD locks;
+ * the device driver won't cause problems if it frees, modifies,
+ * or resubmits this URB.
+ *
+ * If @urb was unlinked, the value of @status will be overridden by
+ * @urb->unlinked.  Erroneous short transfers are detected in case
+ * the HCD hasn't checked for them.
+ */
+void usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb, int status)
+{
+	struct giveback_urb_bh *bh = __this_cpu_ptr(hcd->async_bh);
+	bool async = 1;
+
+	urb->status = status;
+	if (!hcd_giveback_urb_in_bh(hcd)) {
+		__usb_hcd_giveback_urb(urb);
+		return;
+	}
+
+	if (usb_pipeisoc(urb->pipe) || usb_pipeint(urb->pipe)) {
+		bh = __this_cpu_ptr(hcd->periodic_bh);
+		async = 0;
+	}
+
+	spin_lock(&bh->lock);
+	list_add_tail(&urb->urb_list, &bh->head);
+	spin_unlock(&bh->lock);
+
+	if (async)
+		tasklet_schedule(&bh->bh);
+	else
+		tasklet_hi_schedule(&bh->bh);
+}
 EXPORT_SYMBOL_GPL(usb_hcd_giveback_urb);
 
 /*-------------------------------------------------------------------------*/
@@ -2288,6 +2342,59 @@ EXPORT_SYMBOL_GPL (usb_hc_died);
 
 /*-------------------------------------------------------------------------*/
 
+static void __init_giveback_urb_bh(struct giveback_urb_bh __percpu *bh)
+{
+	int i;
+
+	for_each_possible_cpu(i) {
+		struct giveback_urb_bh *pbh = per_cpu_ptr(bh, i);
+		spin_lock_init(&pbh->lock);
+		INIT_LIST_HEAD(&pbh->head);
+		tasklet_init(&pbh->bh, usb_giveback_urb_bh, (unsigned long)pbh);
+	}
+}
+
+static int init_giveback_urb_bh(struct usb_hcd *hcd)
+{
+	if (!hcd_giveback_urb_in_bh(hcd))
+		return 0;
+
+	hcd->periodic_bh = alloc_percpu(typeof(*hcd->periodic_bh));
+	if (!hcd->periodic_bh)
+		return -ENOMEM;
+
+	hcd->async_bh = alloc_percpu(typeof(*hcd->async_bh));
+	if (!hcd->async_bh) {
+		free_percpu(hcd->periodic_bh);
+		return -ENOMEM;
+	}
+
+	__init_giveback_urb_bh(hcd->periodic_bh);
+	__init_giveback_urb_bh(hcd->async_bh);
+
+	return 0;
+}
+
+static void __exit_giveback_urb_bh(struct giveback_urb_bh __percpu *bh)
+{
+	int i;
+
+	for_each_possible_cpu(i)
+		tasklet_kill(&per_cpu_ptr(bh, i)->bh);
+}
+
+static void exit_giveback_urb_bh(struct usb_hcd *hcd)
+{
+	if (!hcd_giveback_urb_in_bh(hcd))
+		return;
+
+	__exit_giveback_urb_bh(hcd->periodic_bh);
+	__exit_giveback_urb_bh(hcd->async_bh);
+
+	free_percpu(hcd->periodic_bh);
+	free_percpu(hcd->async_bh);
+}
+
 /**
  * usb_create_shared_hcd - create and initialize an HCD structure
  * @driver: HC driver that will use this hcd
@@ -2551,6 +2658,16 @@ int usb_add_hcd(struct usb_hcd *hcd,
 			&& device_can_wakeup(&hcd->self.root_hub->dev))
 		dev_dbg(hcd->self.controller, "supports USB remote wakeup\n");
 
+	if (usb_hcd_is_primary_hcd(hcd)) {
+		retval = init_giveback_urb_bh(hcd);
+		if (retval)
+			goto err_init_giveback_bh;
+	} else {
+		/* share tasklet handling with primary hcd */
+		hcd->async_bh = hcd->primary_hcd->async_bh;
+		hcd->periodic_bh = hcd->primary_hcd->periodic_bh;
+	}
+
 	/* enable irqs just before we start the controller,
 	 * if the BIOS provides legacy PCI irqs.
 	 */
@@ -2614,6 +2731,8 @@ err_hcd_driver_start:
 	if (usb_hcd_is_primary_hcd(hcd) && hcd->irq > 0)
 		free_irq(irqnum, hcd);
 err_request_irq:
+	exit_giveback_urb_bh(hcd);
+err_init_giveback_bh:
 err_hcd_driver_setup:
 err_set_rh_speed:
 	usb_put_dev(hcd->self.root_hub);
@@ -2659,6 +2778,9 @@ void usb_remove_hcd(struct usb_hcd *hcd)
 	usb_disconnect(&rhdev);		/* Sets rhdev to NULL */
 	mutex_unlock(&usb_bus_list_lock);
 
+	if (usb_hcd_is_primary_hcd(hcd))
+		exit_giveback_urb_bh(hcd);
+
 	/* Prevent any more root-hub status calls from the timer.
 	 * The HCD might still restart the timer (if a port status change
 	 * interrupt occurs), but usb_hcd_poll_rh_status() won't invoke
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index f5f5c7d..4e4e174 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -22,6 +22,7 @@
 #ifdef __KERNEL__
 
 #include <linux/rwsem.h>
+#include <linux/interrupt.h>
 
 #define MAX_TOPO_LEVEL		6
 
@@ -67,6 +68,12 @@
 
 /*-------------------------------------------------------------------------*/
 
+struct giveback_urb_bh {
+	spinlock_t lock;
+	struct list_head  head;
+	struct tasklet_struct bh;
+};
+
 struct usb_hcd {
 
 	/*
@@ -139,6 +146,9 @@ struct usb_hcd {
 	resource_size_t		rsrc_len;	/* memory/io resource length */
 	unsigned		power_budget;	/* in mA, 0 = no limit */
 
+	struct giveback_urb_bh __percpu *periodic_bh;
+	struct giveback_urb_bh __percpu *async_bh;
+
 	/* bandwidth_mutex should be taken before adding or removing
 	 * any new bus bandwidth constraints:
 	 *   1. Before adding a configuration for a new device.
@@ -220,6 +230,7 @@ struct hc_driver {
 #define	HCD_USB2	0x0020		/* USB 2.0 */
 #define	HCD_USB3	0x0040		/* USB 3.0 */
 #define	HCD_MASK	0x0070
+#define	HCD_BH		0x0100		/* URB complete in BH context */
 
 	/* called to init HCD and root hub */
 	int	(*reset) (struct usb_hcd *hcd);
@@ -360,6 +371,11 @@ struct hc_driver {
 	int	(*find_raw_port_number)(struct usb_hcd *, int);
 };
 
+static inline int hcd_giveback_urb_in_bh(struct usb_hcd *hcd)
+{
+	return hcd->driver->flags & HCD_BH;
+}
+
 extern int usb_hcd_link_urb_to_ep(struct usb_hcd *hcd, struct urb *urb);
 extern int usb_hcd_check_unlink_urb(struct usb_hcd *hcd, struct urb *urb,
 		int status);
-- 
1.7.9.5
