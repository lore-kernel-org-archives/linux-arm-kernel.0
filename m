From: gores@marvell.com (Siddarth Gore)
Date: Fri, 16 Apr 2010 15:55:06 +0530
Subject: usb device controller driver for port 1 of isp1760
Message-ID: <1271413506.9554.39.camel@pe-dt434>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello All,

I did not find any code to get port 1 of Philips isp1760 to work as an
upstream port. so i am trying to write a isp1760-udc driver for it.

I am using ARM PB1176 board (which has isp1760 onboard) for debugging.
After initialization I get a SUSPEND interrupt and after that no
interrupt is generated even when I insert the usb cable.

Any idea what might be going wrong or how I can debug this? The register
initializations are done in udc_init_regs() function.

I am attaching the work so far, just for reference. but it is very raw
and far from finished, so please bare with me.

-siddarth

diff --git a/arch/arm/mach-realview/core.c
b/arch/arm/mach-realview/core.c
index 90bd4ef..3b58d4d 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -175,7 +175,7 @@ int realview_eth_register(const char *name, struct
resource *res)
 }
 
 struct platform_device realview_usb_device = {
-	.name			= "isp1760",
+	.name			= "isp1760-udc",
 	.num_resources		= 2,
 };
 
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 11a3e0f..e373140 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -504,6 +504,18 @@ config USB_LANGWELL
 	default USB_GADGET
 	select USB_GADGET_SELECTED
 
+config USB_GADGET_ISP1760_UDC
+	boolean "ISP 1760 USB Device Controller"
+	select USB_GADGET_DUALSPEED
+	help
+	   ISP 1760 USB Device Controller.
+
+config USB_ISP1760_UDC
+	tristate
+	depends on USB_GADGET_ISP1760_UDC
+	default USB_GADGET
+	select USB_GADGET_SELECTED
+
 
 #
 # LAST -- dummy/emulated controller
diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
index 43b51da..02adaed 100644
--- a/drivers/usb/gadget/Makefile
+++ b/drivers/usb/gadget/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_USB_FSL_QE)	+= fsl_qe_udc.o
 obj-$(CONFIG_USB_CI13XXX)	+= ci13xxx_udc.o
 obj-$(CONFIG_USB_S3C_HSOTG)	+= s3c-hsotg.o
 obj-$(CONFIG_USB_LANGWELL)	+= langwell_udc.o
+obj-$(CONFIG_USB_ISP1760_UDC)	+= isp1760-udc.o
 
 #
 # USB gadget drivers
diff --git a/drivers/usb/gadget/gadget_chips.h
b/drivers/usb/gadget/gadget_chips.h
index e511fec..50c5c8e 100644
--- a/drivers/usb/gadget/gadget_chips.h
+++ b/drivers/usb/gadget/gadget_chips.h
@@ -142,6 +142,12 @@
 #define gadget_is_s3c_hsotg(g)    0
 #endif
 
+#ifdef CONFIG_USB_ISP1760_UDC
+#define gadget_is_isp1760_udc(g)    (!strcmp("isp1760-udc", (g)->name))
+#else
+#define gadget_is_isp1760_udc(g)    0
+#endif
+
 
 /**
  * usb_gadget_controller_number - support bcdDevice id convention
@@ -200,6 +206,8 @@ static inline int
usb_gadget_controller_number(struct usb_gadget *gadget)
 		return 0x25;
 	else if (gadget_is_s3c_hsotg(gadget))
 		return 0x26;
+	else if (gadget_is_isp1760_udc(gadget))
+		return 0x27;
 	return -ENOENT;
 }
 
diff --git a/drivers/usb/gadget/isp1760-udc.c
b/drivers/usb/gadget/isp1760-udc.c
new file mode 100644
index 0000000..b5f18d0
--- /dev/null
+++ b/drivers/usb/gadget/isp1760-udc.c
@@ -0,0 +1,858 @@
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/ioport.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/interrupt.h>
+#include <linux/usb/ch9.h>
+#include <linux/usb/gadget.h>
+
+#include <asm/byteorder.h>
+#include <mach/hardware.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/system.h>
+
+#include "isp1760-udc.h"
+
+
+#define	DRIVER_VERSION	"15 Apr 2010"
+
+static const char driver_name [] = "isp1760-udc";
+static const char ep0name[] = "ep0-setup";
+
+static void udc_init_regs(struct isp1760_udc *udc)
+{
+	u32 i;
+
+	/* unlock */
+	writel(0xaa37, udc->regs + DC_UNLOCK_DEV_REG);
+
+	/* reset */
+	writel(0x1 << 4, udc->regs + DC_MODE_REG);
+	mdelay(10);
+	writel(0x0, udc->regs + DC_MODE_REG);
+
+	writel(0xa5a5, udc->regs + DC_SCRATCH_REG);
+	readl(udc->regs + 0x304);
+	i = readl(udc->regs + DC_SCRATCH_REG);
+	printk("isp1760-udc: ret = %x\n", i);
+
+	/* global interrupt enabled, clock set to
+	 * always on */
+	writel(0x88, udc->regs + DC_MODE_REG);
+
+	/* interrupt on ack/nak for control and IN pipe,
+	 * ack/nyet/nak for OUT pipe, level triggered,
+	 * active low */
+	writel(0x0, udc->regs + DC_INT_CFG_REG);
+
+	/* enable all interrupts */
+//	writel(0x3ffffff, udc->regs + DC_INT_EN_REG);
+	writel(0xfb, udc->regs + DC_INT_EN_REG);
+
+	/* mode 0, 32-bit data bus */
+	writel(0x0, udc->regs + DC_DMA_CFG_REG);
+
+	/* DACK active low, DREQ active high */
+	writel(0x4, udc->regs + DC_DMA_HW_REG);
+
+	/* DREQ will drop at every DMA read/write */
+	writel(0x4, udc->regs + DC_DMA_BURST_CNT_REG);
+
+	/* enable all DMA interrupts */
+//	writel(0x1d00, udc->regs + DC_DMA_INT_EN_REG);
+
+	for (i = 1; i < NUM_ENDPOINTS; i++) {
+		/* max packet size for OUT ep */
+		writel(i << 1, udc->regs + DC_EP_INDEX_REG);
+		writel(udc->ep[i].maxpacket,
+			udc->regs + DC_EP_MAX_PKT_SIZE_REG);
+
+		/* max packet size for IN ep */
+		writel((i << 1) | 0x1, udc->regs + DC_EP_INDEX_REG);
+		writel(udc->ep[i].maxpacket,
+			udc->regs + DC_EP_MAX_PKT_SIZE_REG);
+	}
+}
+
+static int isp1760_ep_enable(struct usb_ep *_ep,
+				const struct usb_endpoint_descriptor *desc)
+{
+	struct isp1760_ep *ep = container_of(_ep, struct isp1760_ep, ep);
+	struct isp1760_udc *udc = ep->udc;
+	u16 maxpacket;
+	u32 tmp;
+	unsigned long flags;
+
+	if (!_ep || !ep
+			|| !desc || ep->desc
+			|| _ep->name == ep0name
+			|| desc->bDescriptorType != USB_DT_ENDPOINT
+			|| (maxpacket = le16_to_cpu(desc->wMaxPacketSize)) == 0
+			|| maxpacket > ep->maxpacket) {
+		printk("isp1760-udc: bad ep or descriptor\n");
+		return -EINVAL;
+	}
+
+	if (!udc->driver || udc->gadget.speed == USB_SPEED_UNKNOWN) {
+		printk("isp1760-udc: bogus device state\n");
+		return -ESHUTDOWN;
+	}
+
+	tmp = usb_endpoint_type(desc);
+	switch (tmp) {
+	case USB_ENDPOINT_XFER_CONTROL:
+		printk("isp1760-udc: only one control endpoint\n");
+		return -EINVAL;
+	case USB_ENDPOINT_XFER_INT:
+		if (maxpacket > 64)
+			goto bogus_max;
+		break;
+	case USB_ENDPOINT_XFER_BULK:
+		switch (maxpacket) {
+		case 8:
+		case 16:
+		case 32:
+		case 64:
+			goto ok;
+		}
+bogus_max:
+		printk("isp1760-udc: bogus maxpacket %d\n", maxpacket);
+		return -EINVAL;
+	case USB_ENDPOINT_XFER_ISOC:
+		if (!ep->is_pingpong) {
+			printk("isp1760-udc: iso requires double buffering\n");
+			return -EINVAL;
+		}
+		break;
+	}
+
+ok:
+	local_irq_save(flags);
+
+	/* initialize endpoint to match this descriptor */
+	ep->is_in = usb_endpoint_dir_in(desc);
+	ep->is_iso = (tmp == USB_ENDPOINT_XFER_ISOC);
+	ep->stopped = 0;
+	ep->desc = desc;
+	ep->ep.maxpacket = maxpacket;
+
+	/* set type, double buffering and enable ep */
+	writel(ep->index, udc->regs + DC_EP_INDEX_REG);
+	writel(maxpacket, udc->regs + DC_EP_MAX_PKT_SIZE_REG);
+	writel(ep->is_pingpong << 2 | tmp, udc->regs + DC_EP_TYPE_REG);
+	writel(1 << 3, udc->regs + DC_EP_TYPE_REG);
+
+	/* enable interrupt */
+	writel(ep->int_mask, udc->regs + DC_INT_EN_REG);
+
+	local_irq_restore(flags);
+	return 0;
+}
+
+static void done(struct isp1760_ep *ep, struct isp1760_request *req,
int status)
+{
+	unsigned stopped = ep->stopped;
+	struct isp1760_udc *udc = ep->udc;
+	struct isp1760_ep *_ep;
+
+	list_del_init(&req->queue);
+	if (req->req.status == -EINPROGRESS)
+		req->req.status = status;
+	else
+		status = req->req.status;
+	if (status && status != -ESHUTDOWN)
+		printk("isp1760-udc: %s done %p, status %d\n", ep->ep.name, req,
status);
+
+	ep->stopped = 1;
+	req->req.complete(&ep->ep, &req->req);
+	ep->stopped = stopped;
+
+	/* terminate setup token */
+	if (ep == &udc->ep[1]) {
+		_ep = &udc->ep[2];
+		writel(ep->index, udc->regs + DC_EP_INDEX_REG);
+		writel(1 << 1, udc->regs + DC_CTRL_FUNC_REG);
+	} else if (ep == &udc->ep[2]) {
+		_ep = &udc->ep[1];
+		writel(ep->index, udc->regs + DC_EP_INDEX_REG);
+		writel(1 << 1, udc->regs + DC_CTRL_FUNC_REG);
+	}
+}
+
+static void nuke(struct isp1760_ep *ep, int status)
+{
+	struct isp1760_request *req;
+
+	ep->stopped = 1;
+	if (list_empty(&ep->queue))
+		return;
+
+	while (!list_empty(&ep->queue)) {
+		req = list_entry(ep->queue.next, struct isp1760_request, queue);
+		done(ep, req, status);
+	}
+}
+
+static int isp1760_ep_disable (struct usb_ep * _ep)
+{
+	struct isp1760_ep *ep = container_of(_ep, struct isp1760_ep, ep);
+	struct isp1760_udc *udc = ep->udc;
+	unsigned long flags;
+	u32 reg;
+
+	if (ep == &ep->udc->ep[0])
+		return -EINVAL;
+
+	local_irq_save(flags);
+
+	nuke(ep, -ESHUTDOWN);
+
+	/* disable interrupt for this ep */
+	reg = readl(udc->regs + DC_INT_EN_REG);
+	writel(reg & ~ep->int_mask, udc->regs + DC_INT_EN_REG);
+	/* restore the endpoint's pristine config */
+	ep->desc = NULL;
+	ep->ep.maxpacket = ep->maxpacket;
+
+	local_irq_restore(flags);
+	return 0;
+}
+
+static struct usb_request *
+isp1760_ep_alloc_request(struct usb_ep *_ep, gfp_t gfp_flags)
+{
+	struct isp1760_request *req;
+
+	req = kzalloc(sizeof (struct isp1760_request), gfp_flags);
+	if (!req)
+		return NULL;
+
+	INIT_LIST_HEAD(&req->queue);
+	return &req->req;
+}
+
+static void isp1760_ep_free_request(struct usb_ep *_ep, struct
usb_request *_req)
+{
+	struct isp1760_request *req;
+
+	req = container_of(_req, struct isp1760_request, req);
+	BUG_ON(!list_empty(&req->queue));
+	kfree(req);
+}
+
+static int read_fifo(struct isp1760_ep *ep, struct isp1760_request
*req)
+{
+	struct isp1760_udc *udc = ep->udc;
+	u8 *buf;
+	u32 reg;
+	unsigned int buflen, count;
+
+	buf = req->req.buf + req->req.actual;
+	buflen = req->req.length - req->req.actual;
+
+	writel(ep->index, udc->regs + DC_EP_INDEX_REG);
+	reg = readl(udc->regs + DC_BUF_STATUS_REG);
+	if (!reg) {
+		printk("isp1760-udc: buffers not filled\n");
+		return 0;
+	}
+
+	count = readl(udc->regs + DC_BUF_LEN_REG);
+	if (count > ep->ep.maxpacket)
+		count = ep->ep.maxpacket;
+	if (count > buflen) {
+		printk("isp1760-udc: %s buffer overflow\n", ep->ep.name);
+		req->req.status = -EOVERFLOW;
+		count = buflen;
+	}
+	insl((unsigned long)(udc->regs + DC_DATA_PORT_REG), buf, count);
+
+	req->req.actual += count;
+
+	if (count == buflen)
+		done(ep, req, 0);
+
+	return 1;
+}
+
+static int write_fifo(struct isp1760_ep *ep, struct isp1760_request
*req)
+{
+	struct isp1760_udc *udc = ep->udc;
+	u8 *buf;
+	unsigned int buflen, count, is_last;
+
+	buf = req->req.buf + req->req.actual;
+	prefetch(buf);
+	buflen = req->req.length - req->req.actual;
+	if (ep->ep.maxpacket < buflen) {
+		count = ep->ep.maxpacket;
+		is_last = 0;
+	} else {
+		count = buflen;
+		is_last = (count < ep->ep.maxpacket) || !req->req.zero;
+	}
+	writel(ep->index, udc->regs + DC_EP_INDEX_REG);
+	writel(count, udc->regs + DC_BUF_LEN_REG);
+
+	outsl((unsigned long)(udc->regs + DC_DATA_PORT_REG), buf, count);
+
+	req->req.actual += count;
+	if (is_last)
+		done(ep, req, 0);
+	return is_last;
+}
+
+static int isp1760_ep_queue(struct usb_ep *_ep,
+			struct usb_request *_req, gfp_t gfp_flags)
+{
+	struct isp1760_request *req;
+	struct isp1760_ep *ep;
+	struct isp1760_udc *udc;
+	int status;
+	unsigned long flags;
+
+	req = container_of(_req, struct isp1760_request, req);
+	ep = container_of(_ep, struct isp1760_ep, ep);
+
+	if (!_req || !_req->complete
+			|| !_req->buf || !list_empty(&req->queue)) {
+		printk("isp1760-udc: invalid request\n");
+		return -EINVAL;
+	}
+
+	if (!_ep || (!ep->desc && ep->ep.name != ep0name)) {
+		printk("isp1760-udc: invalid ep\n");
+		return -EINVAL;
+	}
+
+	udc = ep->udc;
+
+	if (!udc || !udc->driver || udc->gadget.speed == USB_SPEED_UNKNOWN) {
+		printk("isp1760-udc: invalid device\n");
+		return -EINVAL;
+	}
+
+	_req->status = -EINPROGRESS;
+	_req->actual = 0;
+
+	local_irq_save(flags);
+
+	if (list_empty(&ep->queue) && !ep->stopped) {
+		if (ep->is_in)
+			status = write_fifo(ep, req);
+		else
+			status = read_fifo(ep, req);
+	} else
+		status = 0;
+
+	if (req && !status)
+		list_add_tail (&req->queue, &ep->queue);
+	local_irq_restore(flags);
+	return (status < 0) ? status : 0;
+}
+
+static int isp1760_ep_dequeue(struct usb_ep *_ep, struct usb_request
*_req)
+{
+	struct isp1760_ep *ep;
+	struct isp1760_request *req;
+
+	ep = container_of(_ep, struct isp1760_ep, ep);
+	if (!_ep || ep->ep.name == ep0name)
+		return -EINVAL;
+
+	/* make sure it's actually queued on this endpoint */
+	list_for_each_entry (req, &ep->queue, queue) {
+		if (&req->req == _req)
+			break;
+	}
+	if (&req->req != _req)
+		return -EINVAL;
+
+	done(ep, req, -ECONNRESET);
+	return 0;
+}
+
+static int isp1760_ep_set_halt(struct usb_ep *_ep, int value)
+{
+	struct isp1760_ep *ep = container_of(_ep, struct isp1760_ep, ep);
+	struct isp1760_udc *udc = ep->udc;
+	unsigned long flags;
+	int status = 0;
+	u32 reg;
+
+	if (!_ep || ep->is_iso)
+		return -EINVAL;
+
+	local_irq_save(flags);
+
+	writel(ep->index, udc->regs + DC_EP_INDEX_REG);
+	reg = readl(udc->regs + DC_BUF_STATUS_REG);
+	if (ep->is_in && (!list_empty(&ep->queue) || (reg & 0x3)))
+		status = -EAGAIN;
+	else {
+		/* stall ep */
+		reg = readl(udc->regs + DC_CTRL_FUNC_REG);
+		writel(reg | 1, udc->regs + DC_CTRL_FUNC_REG);
+		if (!value) {
+			/* reset ep */
+			reg = readl(udc->regs + DC_EP_TYPE_REG);
+			writel(reg & ~(1 << 3), udc->regs + DC_EP_TYPE_REG);
+			writel(reg | 1 << 3, udc->regs + DC_EP_TYPE_REG);
+		}
+	}
+
+	local_irq_restore(flags);
+	return status;
+}
+
+/*static int isp1760_ep_fifo_status(struct usb_ep *_ep)
+{
+}
+
+static void isp1760_ep_fifo_flush(struct usb_ep *_ep)
+{
+}*/
+
+static const struct usb_ep_ops isp1760_ep_ops = {
+	.enable		= isp1760_ep_enable,
+	.disable	= isp1760_ep_disable,
+	.alloc_request	= isp1760_ep_alloc_request,
+	.free_request	= isp1760_ep_free_request,
+	.queue		= isp1760_ep_queue,
+	.dequeue	= isp1760_ep_dequeue,
+	.set_halt	= isp1760_ep_set_halt,
+/*	.fifo_status	= isp1760_ep_fifo_status,
+	.fifo_flush	= isp1760_ep_fifo_flush,*/
+};
+
+static int isp1760_get_frame(struct usb_gadget *gadget)
+{
+	struct isp1760_udc *udc = to_udc(gadget);
+
+	return readl(udc->regs + DC_FRM_NUM_REG) & 0x7ff;
+}
+
+static const struct usb_gadget_ops isp1760_udc_ops = {
+	.get_frame		= isp1760_get_frame,
+};
+
+static void nop_release(struct device *dev)
+{
+	/* nothing to free */
+}
+
+static void udc_reinit(struct isp1760_udc *udc)
+{
+	u32 i;
+
+	INIT_LIST_HEAD(&udc->gadget.ep_list);
+	INIT_LIST_HEAD(&udc->gadget.ep0->ep_list);
+
+	for (i = 0; i < NUM_ENDPOINTS; i++) {
+		struct isp1760_ep *ep = &udc->ep[i];
+
+		if (i != 0)
+			list_add_tail(&ep->ep.ep_list, &udc->gadget.ep_list);
+		ep->desc = NULL;
+		ep->stopped = 0;
+		ep->fifo_bank = 0;
+		ep->ep.maxpacket = ep->maxpacket;
+
+		INIT_LIST_HEAD(&ep->queue);
+	}
+}
+
+static void stop_activity(struct isp1760_udc *udc)
+{
+	struct usb_gadget_driver *driver = udc->driver;
+	int i;
+
+	if (udc->gadget.speed == USB_SPEED_UNKNOWN)
+		driver = NULL;
+	udc->gadget.speed = USB_SPEED_UNKNOWN;
+
+	for (i = 0; i < NUM_ENDPOINTS; i++) {
+		struct isp1760_ep *ep = &udc->ep[i];
+		nuke(ep, -ESHUTDOWN);
+	}
+	if (driver)
+		driver->disconnect(&udc->gadget);
+
+	udc_reinit(udc);
+}
+
+union setup {
+	u8			raw[8];
+	struct usb_ctrlrequest	r;
+};
+
+static void handle_setup(struct isp1760_ep *ep)
+{
+	struct isp1760_udc *udc = ep->udc;
+	struct isp1760_ep *_ep;
+	u32 reg;
+	unsigned int count;
+	union setup pkt;
+
+	nuke(ep, 0);
+
+	/* read token */
+	writel(ep->index, udc->regs + DC_EP_INDEX_REG);
+	reg = readl(udc->regs + DC_BUF_STATUS_REG);
+	if (!reg) {
+		printk("isp1760-udc: setup token buffer not filled\n");
+		return;
+	}
+
+	count = readl(udc->regs + DC_BUF_LEN_REG);
+	if (count != 8) {
+		printk("isp1760-udc: invalid token\n");
+		return;
+	}
+	insl((unsigned long)(udc->regs + DC_DATA_PORT_REG), pkt.raw, count);
+
+	if (!pkt.r.wLength) {
+		/* no data stage */
+		_ep = &udc->ep[2];
+		writel(ep->index, udc->regs + DC_EP_INDEX_REG);
+		writel(1 << 1, udc->regs + DC_CTRL_FUNC_REG);
+	} else if (pkt.r.bRequestType & USB_DIR_IN) {
+		/* data IN stage */
+		_ep = &udc->ep[2];
+		writel(ep->index, udc->regs + DC_EP_INDEX_REG);
+		writel(1 << 2, udc->regs + DC_CTRL_FUNC_REG);
+	} else {
+		/* data OUT stage */
+		_ep = &udc->ep[1];
+		writel(ep->index, udc->regs + DC_EP_INDEX_REG);
+		writel(1 << 2, udc->regs + DC_CTRL_FUNC_REG);
+	}
+
+	/* pass request up to the gadget driver */
+	if (udc->driver)
+		udc->driver->setup(&udc->gadget, &pkt.r);
+
+	/* clear interrupt */
+	writel(ep->int_mask, udc->regs + DC_INT_REG);
+}
+
+static int handle_ep(struct isp1760_ep *ep)
+{
+	struct isp1760_udc *udc = ep->udc;
+	struct isp1760_request *req;
+	int ret = 0;
+
+	if (!list_empty(&ep->queue)) {
+		req = list_entry(ep->queue.next,
+			struct isp1760_request, queue);
+
+		if (ep->is_in)
+			ret = write_fifo(ep, req);
+		else
+			ret = read_fifo(ep, req);
+	}
+
+	/* clear interrupt */
+	writel(ep->int_mask, udc->regs + DC_INT_REG);
+
+	return ret;
+}
+
+static irqreturn_t isp1760_udc_irq (int irq, void *_udc)
+{
+	struct isp1760_udc *udc = _udc;
+	u32 rescans = 5;
+
+	while (rescans--) {
+		u32 status;
+
+		status = readl(udc->regs + DC_INT_REG)
+				& readl(udc->regs + DC_INT_EN_REG);
+
+		if (!status)
+			break;
+
+		if (status & 1) {
+			/* bus reset */
+			stop_activity(udc);
+			writel(1, udc->regs + DC_INT_REG);
+		} else if (status & 1 << 3) {
+			/* suspend */
+			printk("isp1760-udc: in suspend\n");
+			writel(1 << 3, udc->regs + DC_INT_REG);
+		} else if (status & 1 << 4) {
+			/* suspend */
+			printk("isp1760-udc: in resume\n");
+			writel(1 << 4, udc->regs + DC_INT_REG);
+		} else if (status & 1 << 7) {
+			/* vbus */
+			printk("isp1760-udc: USB device connected\n");
+			writel(1 << 7, udc->regs + DC_INT_REG);
+		} else if (status & 1 << 5) {
+			/* hs_stat */
+			printk("isp1760-udc: device high speed mode\n");
+			writel(1 << 5, udc->regs + DC_INT_REG);
+		} else if (status & 1 << 6) {
+			/* dma */
+			printk("isp1760-udc: dma interrupt\n");
+			writel(1 << 6, udc->regs + DC_INT_REG);
+		} else {
+			int i;
+			unsigned mask = 1 << 10;
+			struct isp1760_ep *ep = &udc->ep[1];
+
+			if (status & 1 << 8)
+				handle_setup(&udc->ep[0]);
+			for (i = 1; i < NUM_ENDPOINTS; i++) {
+				mask <<= 1;
+				if (status & mask)
+					handle_ep(ep);
+				ep++;
+			}
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct isp1760_udc controller = {
+	.gadget = {
+		.ops	= &isp1760_udc_ops,
+		.ep0	= &controller.ep[0].ep,
+		.name	= driver_name,
+		.dev	= {
+			.init_name = "gadget",
+			.release = nop_release,
+		}
+	},
+	.ep[0] = {
+		.ep = {
+			.name	= ep0name,
+			.ops	= &isp1760_ep_ops,
+		},
+		.udc		= &controller,
+		.maxpacket	= 8,
+		.index		= 1 << 5,
+		.int_mask	= 1 << 8,
+	},
+	.ep[1] = {
+		.ep = {
+			.name	= "ep0-out",
+			.ops	= &isp1760_ep_ops,
+		},
+		.udc		= &controller,
+		.is_pingpong	= 0,
+		.maxpacket	= 64,
+		.index		= 0,
+		.int_mask	= 1 << 10,
+	},
+	.ep[2] = {
+		.ep = {
+			.name	= "ep0-in",
+			.ops	= &isp1760_ep_ops,
+		},
+		.udc		= &controller,
+		.is_pingpong	= 0,
+		.maxpacket	= 64,
+		.index		= 1,
+		.int_mask	= 1 << 11,
+	},
+	.ep[3] = {
+		.ep = {
+			.name	= "ep1out-bulk",
+			.ops	= &isp1760_ep_ops,
+		},
+		.udc		= &controller,
+		.is_pingpong	= 1,
+		.maxpacket	= 64,
+		.index		= 1 << 1,
+		.int_mask	= 1 << 12,
+	},
+	.ep[4] = {
+		.ep = {
+			.name	= "ep1in-bulk",
+			.ops	= &isp1760_ep_ops,
+		},
+		.udc		= &controller,
+		.is_pingpong	= 1,
+		.maxpacket	= 64,
+		.index		= 1 << 1 | 1,
+		.int_mask	= 1 << 13,
+	},
+	.ep[5] = {
+		.ep = {
+			.name	= "ep2out-bulk",
+			.ops	= &isp1760_ep_ops,
+		},
+		.udc		= &controller,
+		.is_pingpong	= 1,
+		.maxpacket	= 64,
+		.index		= 2 << 1,
+		.int_mask	= 1 << 14,
+	},
+	.ep[6] = {
+		.ep = {
+			.name	= "ep2in-bulk",
+			.ops	= &isp1760_ep_ops,
+		},
+		.udc		= &controller,
+		.is_pingpong	= 1,
+		.maxpacket	= 64,
+		.index		= 1 << 2 | 1,
+		.int_mask	= 1 << 15,
+	},
+
+
+};
+
+static int __init isp1760_udc_probe(struct platform_device *pdev)
+{
+	struct device	*dev = &pdev->dev;
+	struct resource	*res;
+	struct isp1760_udc *udc;
+	int retval;
+
+	if (pdev->num_resources != 2) {
+		printk("isp1760-udc: invalid num_resources\n");
+		return -ENODEV;
+	}
+	if ((pdev->resource[0].flags != IORESOURCE_MEM)
+			|| (pdev->resource[1].flags != IORESOURCE_IRQ)) {
+		printk("isp1760-udc: invalid resource type\n");
+		return -ENODEV;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENXIO;
+
+	if (!request_mem_region(res->start,
+			res->end - res->start + 1,
+			driver_name)) {
+		printk("isp1760-udc: someone's using UDC memory\n");
+		return -EBUSY;
+	}
+
+
+
+	udc = &controller;
+	udc->gadget.dev.parent = dev;
+	udc->pdev = pdev;
+
+	udc->regs = ioremap(res->start, res->end - res->start + 1);
+	if (!udc->regs) {
+		retval = -ENOMEM;
+		goto fail0;
+	}
+
+	udc_reinit(udc);
+	udc_init_regs(udc);
+	retval = device_register(&udc->gadget.dev);
+	if (retval < 0)
+		goto fail1;
+
+	udc->irq = platform_get_irq(pdev, 0);
+	retval = request_irq(udc->irq, isp1760_udc_irq,
+			IRQF_SHARED | IRQF_TRIGGER_MASK, driver_name, udc);
+	if (retval < 0) {
+		printk("isp1760-udc: request irq %d failed\n", udc->irq);
+		goto fail2;
+	}
+
+	return 0;
+
+fail2:
+	device_unregister(&udc->gadget.dev);
+fail1:
+	iounmap(udc->regs);
+fail0:
+	release_mem_region(res->start, res->end - res->start + 1);
+	printk("isp1760-udc: %s probe failed, %d\n", driver_name, retval);
+	return retval;
+}
+
+int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+{
+	struct isp1760_udc *udc = &controller;
+	int retval;
+
+	if (!driver
+			|| driver->speed < USB_SPEED_FULL
+			|| !driver->bind
+			|| !driver->setup) {
+		printk("isp1760-udc: bad parameter.\n");
+		return -EINVAL;
+	}
+
+	if (udc->driver) {
+		printk("isp1760-udc: UDC already has a gadget driver\n");
+		return -EBUSY;
+	}
+
+	udc->driver = driver;
+	udc->gadget.dev.driver = &driver->driver;
+	dev_set_drvdata(&udc->gadget.dev, &driver->driver);
+
+	retval = driver->bind(&udc->gadget);
+	if (retval) {
+		printk("isp1760-udc: driver->bind() returned %d\n", retval);
+		udc->driver = NULL;
+		udc->gadget.dev.driver = NULL;
+		dev_set_drvdata(&udc->gadget.dev, NULL);
+		return retval;
+	}
+
+	printk("isp1760-udc: bound to %s\n", driver->driver.name);
+	return 0;
+
+}
+EXPORT_SYMBOL(usb_gadget_register_driver);
+
+int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
+{
+	struct isp1760_udc *udc = &controller;
+
+	if (!driver || driver != udc->driver || !driver->unbind)
+		return -EINVAL;
+
+	driver->unbind(&udc->gadget);
+	udc->gadget.dev.driver = NULL;
+	dev_set_drvdata(&udc->gadget.dev, NULL);
+	udc->driver = NULL;
+
+	printk("isp1760-udc: unbound from %s\n", driver->driver.name);
+	return 0;
+}
+EXPORT_SYMBOL(usb_gadget_unregister_driver);
+
+static struct platform_driver isp1760_udc_driver = {
+	.remove		= __exit_p(isp1760_udc_remove),
+	.driver		= {
+		.name	= (char *) driver_name,
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init udc_init_module(void)
+{
+	return platform_driver_probe(&isp1760_udc_driver, isp1760_udc_probe);
+}
+module_init(udc_init_module);
+
+static void __exit udc_exit_module(void)
+{
+	platform_driver_unregister(&isp1760_udc_driver);
+}
+module_exit(udc_exit_module);
+
+
+MODULE_DESCRIPTION("Driver for the ISP1760 USB device controller from
NXP");
+MODULE_AUTHOR("Siddarth Gore <gores@marvell.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:isp1760-udc");
diff --git a/drivers/usb/gadget/isp1760-udc.h
b/drivers/usb/gadget/isp1760-udc.h
new file mode 100644
index 0000000..91b8db3
--- /dev/null
+++ b/drivers/usb/gadget/isp1760-udc.h
@@ -0,0 +1,63 @@
+#ifndef ISP1760_UDC_H
+#define ISP1760_UDC_H
+
+#define DC_EP_MAX_PKT_SIZE_REG	0x0204
+#define DC_EP_TYPE_REG		0x0208
+#define DC_MODE_REG		0x020c
+#define DC_INT_CFG_REG		0x0210
+#define DC_INT_EN_REG		0x0214
+#define DC_INT_REG		0x0218
+#define DC_BUF_LEN_REG		0x021c
+#define DC_BUF_STATUS_REG	0x021e
+#define DC_DATA_PORT_REG	0x0220
+#define DC_CTRL_FUNC_REG	0x0228
+#define DC_EP_INDEX_REG		0x022c
+#define DC_DMA_CFG_REG		0x0238
+#define DC_DMA_HW_REG		0x023c
+#define DC_DMA_INT_EN_REG	0x0254
+#define DC_DMA_BURST_CNT_REG	0x0264
+#define DC_FRM_NUM_REG		0x0274
+#define DC_SCRATCH_REG		0x0278
+#define DC_UNLOCK_DEV_REG	0x027c
+
+#define	NUM_ENDPOINTS	7
+
+struct isp1760_ep {
+	struct usb_ep			ep;
+	struct list_head		queue;
+	struct isp1760_udc		*udc;
+
+	unsigned			maxpacket:16;
+	u8				index;
+	u32				int_mask;
+	unsigned			is_pingpong:1;
+
+	unsigned			stopped:1;
+	unsigned			is_in:1;
+	unsigned			is_iso:1;
+	unsigned			fifo_bank:1;
+
+	const struct usb_endpoint_descriptor
+					*desc;
+};
+
+
+struct isp1760_udc {
+	struct usb_gadget		gadget;
+	struct isp1760_ep		ep[NUM_ENDPOINTS];
+	struct usb_gadget_driver	*driver;
+	void __iomem			*regs;
+	struct platform_device		*pdev;
+	int				irq;
+};
+
+static inline struct isp1760_udc *to_udc(struct usb_gadget *g)
+{
+	return container_of(g, struct isp1760_udc, gadget);
+}
+
+struct isp1760_request {
+	struct usb_request		req;
+	struct list_head		queue;
+};
+#endif
-- 
1.6.0.3
