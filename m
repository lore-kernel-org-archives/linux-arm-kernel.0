From: sriram.dash@nxp.com (Sriram Dash)
Date: Wed, 21 Sep 2016 11:06:47 +0000
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <3189648.KnWLgq0lTY@wuerfel>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <12021424.cItk3A7CfE@wuerfel> <87inu8kny0.fsf@linux.intel.com>
 <3189648.KnWLgq0lTY@wuerfel>
Message-ID: <DB5PR0401MB19259C5DBD40BEEC70F0B7CEF5F60@DB5PR0401MB1925.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: linux-usb-owner@vger.kernel.org [mailto:linux-usb-owner at vger.kernel.org]
>On Wednesday, September 7, 2016 1:24:07 PM CEST Felipe Balbi wrote:
>>
>> Hi,
>>
>> Arnd Bergmann <arnd@arndb.de> writes:
>>
>> [...]
>>
>> > Regarding the DMA configuration that you mention in
>> > ci_hdrc_add_device(), I think we should replace
>> >
>> >         pdev->dev.dma_mask = dev->dma_mask;
>> >         pdev->dev.dma_parms = dev->dma_parms;
>> >         dma_set_coherent_mask(&pdev->dev, dev->coherent_dma_mask);
>> >
>> > with of_dma_configure(), which has the chance to configure more than
>> > just those three, as the dma API might look into different aspects:
>> >
>> > - iommu specific configuration
>> > - cache coherency information
>> > - bus type
>> > - dma offset
>> > - dma_map_ops pointer
>> >
>> > We try to handle everything in of_dma_configure() at configuration
>> > time, and that would be the place to add anything else that we might
>> > need in the future.
>>
>> There are a couple problems with this:
>>
>> 1) won't work for PCI-based systems.
>>
>> DWC3 is used in production PCI-based HW and also in Synopsys HAPS DX
>> platform (FPGA that appears like a PCI card to host PC)
>
>Right, I was specifically talking about the code in chipidea here, which I think is
>never used on the PCI bus, and how the current code is broken. We can probably do
>better than of_dma_configure() (see below), but it would be an improvement.
>
>> 2) not very robust solution
>>
>> of_dma_configure() will hardcode 32-bit DMA dmask for xhci-plat
>> because that's not created by DT. The only reason why this works at
>> all is because of the default 32-bit dma mask thing :-) So, how is it
>> any different than copying 32-bit dma mask from parent?
>
>The idea here is that you pass in the parent of_node along with the child device
>pointer, so it would behave exactly like the parent already does.
>The difference is that it also handles all the other attributes besides the mask.
>
>However, to summarize the discussion so far, I agree that
>of_dma_configure() is not the solution to these problems, and I think we can do
>much better:
>
>Splitting the usb_bus->controller field into the Linux-internal device (used for the
>sysfs hierarchy, for printks and for power management) and a new pointer (used for
>DMA, DT enumeration and phy lookup) probably covers all that we really need.
>
>I've prototyped it below, with the dwc3, xhci and chipidea changes together with
>the core changes. I've surely made mistakes there and don't expect it to work out
>of the box, but this should give an idea of how I think this can all be solved in the
>least invasive way.
>

Hello Arnd,

We tried this patch on NXP platforms (ls2085 and ls1043) which use dwc3 
controller without any glue layer. On first go, this did not work. But after
minimal reworks mention snippet below, we are able to verify that the USB
was working OK.

 drivers/usb/host/xhci-mem.c | 12 ++++++------
 drivers/usb/host/xhci.c     | 20 ++++++++++----------

-       struct device *dev = xhci_to_hcd(xhci)->self.controller;
+       struct device *dev = xhci_to_hcd(xhci)->self.sysdev;

We believe the patch needs little modification to work or there might be chances
we may have missed something. Any idea?

Regards,
Sriram

>I noticed that the gadget interface already has a way to handle the DMA allocation
>by device, so I added that in as well.
>
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> drivers/usb/chipidea/core.c    |  4 ----
> drivers/usb/chipidea/host.c    |  3 ++-
> drivers/usb/chipidea/udc.c     |  8 ++++----
> drivers/usb/core/buffer.c      | 12 ++++++------
> drivers/usb/core/hcd.c         | 48 +++++++++++++++++++++++++++++------------------
>-
> drivers/usb/core/usb.c         | 16 ++++++++--------
> drivers/usb/dwc3/core.c        | 28 +++++++++++++++-------------
> drivers/usb/dwc3/core.h        |  1 +
> drivers/usb/dwc3/dwc3-exynos.c | 10 ----------
> drivers/usb/dwc3/dwc3-st.c     |  1 -
> drivers/usb/dwc3/ep0.c         |  8 ++++----
> drivers/usb/dwc3/gadget.c      | 34 +++++++++++++++++-----------------
> drivers/usb/dwc3/host.c        | 13 ++++---------
> drivers/usb/host/ehci-fsl.c    |  4 ++--
> drivers/usb/host/xhci-plat.c   | 32 +++++++++++++++++++++++++-------
> include/linux/usb.h            |  1 +
> include/linux/usb/hcd.h        |  3 +++
>
>diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c index
>69426e644d17..dff69837b349 100644
>--- a/drivers/usb/chipidea/core.c
>+++ b/drivers/usb/chipidea/core.c
>@@ -833,10 +833,6 @@ struct platform_device *ci_hdrc_add_device(struct device
>*dev,
> 	}
>
> 	pdev->dev.parent = dev;
>-	pdev->dev.dma_mask = dev->dma_mask;
>-	pdev->dev.dma_parms = dev->dma_parms;
>-	dma_set_coherent_mask(&pdev->dev, dev->coherent_dma_mask);
>-
> 	ret = platform_device_add_resources(pdev, res, nres);
> 	if (ret)
> 		goto err;
>diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c index
>053bac9d983c..40d29c4d7772 100644
>--- a/drivers/usb/chipidea/host.c
>+++ b/drivers/usb/chipidea/host.c
>@@ -113,7 +113,8 @@ static int host_start(struct ci_hdrc *ci)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	hcd = usb_create_hcd(&ci_ehci_hc_driver, ci->dev, dev_name(ci->dev));
>+	hcd = __usb_create_hcd(&ci_ehci_hc_driver, ci->dev->parent,
>+			       ci->dev, dev_name(ci->dev), NULL);
> 	if (!hcd)
> 		return -ENOMEM;
>
>diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c index
>0f692fcda638..4cbfff7934c6 100644
>--- a/drivers/usb/chipidea/udc.c
>+++ b/drivers/usb/chipidea/udc.c
>@@ -424,7 +424,7 @@ static int _hardware_enqueue(struct ci_hw_ep *hwep,
>struct ci_hw_req *hwreq)
>
> 	hwreq->req.status = -EALREADY;
>
>-	ret = usb_gadget_map_request(&ci->gadget, &hwreq->req, hwep->dir);
>+	ret = usb_gadget_map_request_by_dev(&ci->dev->parent, &hwreq->req,
>+hwep->dir);
> 	if (ret)
> 		return ret;
>
>@@ -604,7 +604,7 @@ static int _hardware_dequeue(struct ci_hw_ep *hwep,
>struct ci_hw_req *hwreq)
> 		list_del_init(&node->td);
> 	}
>
>-	usb_gadget_unmap_request(&hwep->ci->gadget, &hwreq->req, hwep-
>>dir);
>+	usb_gadget_unmap_request_by_dev(&hwep->ci->dev->parent, &hwreq-
>>req,
>+hwep->dir);
>
> 	hwreq->req.actual += actual;
>
>@@ -1898,13 +1898,13 @@ static int udc_start(struct ci_hdrc *ci)
> 	INIT_LIST_HEAD(&ci->gadget.ep_list);
>
> 	/* alloc resources */
>-	ci->qh_pool = dma_pool_create("ci_hw_qh", dev,
>+	ci->qh_pool = dma_pool_create("ci_hw_qh", dev->parent,
> 				       sizeof(struct ci_hw_qh),
> 				       64, CI_HDRC_PAGE_SIZE);
> 	if (ci->qh_pool == NULL)
> 		return -ENOMEM;
>
>-	ci->td_pool = dma_pool_create("ci_hw_td", dev,
>+	ci->td_pool = dma_pool_create("ci_hw_td", dev->parent,
> 				       sizeof(struct ci_hw_td),
> 				       64, CI_HDRC_PAGE_SIZE);
> 	if (ci->td_pool == NULL) {
>diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c index
>98e39f91723a..1e41ef7f3c1f 100644
>--- a/drivers/usb/core/buffer.c
>+++ b/drivers/usb/core/buffer.c
>@@ -63,7 +63,7 @@ int hcd_buffer_create(struct usb_hcd *hcd)
> 	int		i, size;
>
> 	if (!IS_ENABLED(CONFIG_HAS_DMA) ||
>-	    (!hcd->self.controller->dma_mask &&
>+	    (!hcd->self.sysdev->dma_mask &&
> 	     !(hcd->driver->flags & HCD_LOCAL_MEM)))
> 		return 0;
>
>@@ -72,7 +72,7 @@ int hcd_buffer_create(struct usb_hcd *hcd)
> 		if (!size)
> 			continue;
> 		snprintf(name, sizeof(name), "buffer-%d", size);
>-		hcd->pool[i] = dma_pool_create(name, hcd->self.controller,
>+		hcd->pool[i] = dma_pool_create(name, hcd->self.sysdev,
> 				size, size, 0);
> 		if (!hcd->pool[i]) {
> 			hcd_buffer_destroy(hcd);
>@@ -127,7 +127,7 @@ void *hcd_buffer_alloc(
>
> 	/* some USB hosts just use PIO */
> 	if (!IS_ENABLED(CONFIG_HAS_DMA) ||
>-	    (!bus->controller->dma_mask &&
>+	    (!bus->sysdev->dma_mask &&
> 	     !(hcd->driver->flags & HCD_LOCAL_MEM))) {
> 		*dma = ~(dma_addr_t) 0;
> 		return kmalloc(size, mem_flags);
>@@ -137,7 +137,7 @@ void *hcd_buffer_alloc(
> 		if (size <= pool_max[i])
> 			return dma_pool_alloc(hcd->pool[i], mem_flags, dma);
> 	}
>-	return dma_alloc_coherent(hcd->self.controller, size, dma, mem_flags);
>+	return dma_alloc_coherent(hcd->self.sysdev, size, dma, mem_flags);
> }
>
> void hcd_buffer_free(
>@@ -154,7 +154,7 @@ void hcd_buffer_free(
> 		return;
>
> 	if (!IS_ENABLED(CONFIG_HAS_DMA) ||
>-	    (!bus->controller->dma_mask &&
>+	    (!bus->sysdev->dma_mask &&
> 	     !(hcd->driver->flags & HCD_LOCAL_MEM))) {
> 		kfree(addr);
> 		return;
>@@ -166,5 +166,5 @@ void hcd_buffer_free(
> 			return;
> 		}
> 	}
>-	dma_free_coherent(hcd->self.controller, size, addr, dma);
>+	dma_free_coherent(hcd->self.sysdev, size, addr, dma);
> }
>diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c index
>746c47d86cf5..70d48941f8f4 100644
>--- a/drivers/usb/core/hcd.c
>+++ b/drivers/usb/core/hcd.c
>@@ -1072,6 +1072,7 @@ static void usb_deregister_bus (struct usb_bus *bus)
>static int register_root_hub(struct usb_hcd *hcd)  {
> 	struct device *parent_dev = hcd->self.controller;
>+	struct device *sysdev = hcd->self.sysdev;
> 	struct usb_device *usb_dev = hcd->self.root_hub;
> 	const int devnum = 1;
> 	int retval;
>@@ -1118,7 +1119,7 @@ static int register_root_hub(struct usb_hcd *hcd)
> 		/* Did the HC die before the root hub was registered? */
> 		if (HCD_DEAD(hcd))
> 			usb_hc_died (hcd);	/* This time clean up */
>-		usb_dev->dev.of_node = parent_dev->of_node;
>+		usb_dev->dev.of_node = sysdev->of_node;
> 	}
> 	mutex_unlock(&usb_bus_idr_lock);
>
>@@ -1464,19 +1465,19 @@ void usb_hcd_unmap_urb_for_dma(struct usb_hcd
>*hcd, struct urb *urb)
> 	dir = usb_urb_dir_in(urb) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
> 	if (IS_ENABLED(CONFIG_HAS_DMA) &&
> 	    (urb->transfer_flags & URB_DMA_MAP_SG))
>-		dma_unmap_sg(hcd->self.controller,
>+		dma_unmap_sg(hcd->self.sysdev,
> 				urb->sg,
> 				urb->num_sgs,
> 				dir);
> 	else if (IS_ENABLED(CONFIG_HAS_DMA) &&
> 		 (urb->transfer_flags & URB_DMA_MAP_PAGE))
>-		dma_unmap_page(hcd->self.controller,
>+		dma_unmap_page(hcd->self.sysdev,
> 				urb->transfer_dma,
> 				urb->transfer_buffer_length,
> 				dir);
> 	else if (IS_ENABLED(CONFIG_HAS_DMA) &&
> 		 (urb->transfer_flags & URB_DMA_MAP_SINGLE))
>-		dma_unmap_single(hcd->self.controller,
>+		dma_unmap_single(hcd->self.sysdev,
> 				urb->transfer_dma,
> 				urb->transfer_buffer_length,
> 				dir);
>@@ -1519,11 +1520,11 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd,
>struct urb *urb,
> 			return ret;
> 		if (IS_ENABLED(CONFIG_HAS_DMA) && hcd->self.uses_dma) {
> 			urb->setup_dma = dma_map_single(
>-					hcd->self.controller,
>+					hcd->self.sysdev,
> 					urb->setup_packet,
> 					sizeof(struct usb_ctrlrequest),
> 					DMA_TO_DEVICE);
>-			if (dma_mapping_error(hcd->self.controller,
>+			if (dma_mapping_error(hcd->self.sysdev,
> 						urb->setup_dma))
> 				return -EAGAIN;
> 			urb->transfer_flags |= URB_SETUP_MAP_SINGLE; @@ -
>1554,7 +1555,7 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb
>*urb,
> 				}
>
> 				n = dma_map_sg(
>-						hcd->self.controller,
>+						hcd->self.sysdev,
> 						urb->sg,
> 						urb->num_sgs,
> 						dir);
>@@ -1569,12 +1570,12 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd,
>struct urb *urb,
> 			} else if (urb->sg) {
> 				struct scatterlist *sg = urb->sg;
> 				urb->transfer_dma = dma_map_page(
>-						hcd->self.controller,
>+						hcd->self.sysdev,
> 						sg_page(sg),
> 						sg->offset,
> 						urb->transfer_buffer_length,
> 						dir);
>-				if (dma_mapping_error(hcd->self.controller,
>+				if (dma_mapping_error(hcd->self.sysdev,
> 						urb->transfer_dma))
> 					ret = -EAGAIN;
> 				else
>@@ -1584,11 +1585,11 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd,
>struct urb *urb,
> 				ret = -EAGAIN;
> 			} else {
> 				urb->transfer_dma = dma_map_single(
>-						hcd->self.controller,
>+						hcd->self.sysdev,
> 						urb->transfer_buffer,
> 						urb->transfer_buffer_length,
> 						dir);
>-				if (dma_mapping_error(hcd->self.controller,
>+				if (dma_mapping_error(hcd->self.sysdev,
> 						urb->transfer_dma))
> 					ret = -EAGAIN;
> 				else
>@@ -2510,8 +2511,8 @@ static void init_giveback_urb_bh(struct giveback_urb_bh
>*bh)
>  * Return: On success, a pointer to the created and initialized HCD structure.
>  * On failure (e.g. if memory is unavailable), %NULL.
>  */
>-struct usb_hcd *usb_create_shared_hcd(const struct hc_driver *driver,
>-		struct device *dev, const char *bus_name,
>+struct usb_hcd *__usb_create_hcd(const struct hc_driver *driver,
>+		struct device *sysdev, struct device *dev, const char *bus_name,
> 		struct usb_hcd *primary_hcd)
> {
> 	struct usb_hcd *hcd;
>@@ -2552,8 +2553,9 @@ struct usb_hcd *usb_create_shared_hcd(const struct
>hc_driver *driver,
>
> 	usb_bus_init(&hcd->self);
> 	hcd->self.controller = dev;
>+	hcd->self.sysdev = sysdev;
> 	hcd->self.bus_name = bus_name;
>-	hcd->self.uses_dma = (dev->dma_mask != NULL);
>+	hcd->self.uses_dma = (sysdev->dma_mask != NULL);
>
> 	init_timer(&hcd->rh_timer);
> 	hcd->rh_timer.function = rh_timer_func; @@ -2568,6 +2570,14 @@ struct
>usb_hcd *usb_create_shared_hcd(const struct hc_driver *driver,
> 			"USB Host Controller";
> 	return hcd;
> }
>+EXPORT_SYMBOL_GPL(__usb_create_hcd);
>+
>+struct usb_hcd *usb_create_shared_hcd(const struct hc_driver *driver,
>+		struct device *dev, const char *bus_name,
>+		struct usb_hcd *primary_hcd)
>+{
>+	return __usb_create_hcd(driver, dev, dev, bus_name, primary_hcd); }
> EXPORT_SYMBOL_GPL(usb_create_shared_hcd);
>
> /**
>@@ -2587,7 +2597,7 @@ EXPORT_SYMBOL_GPL(usb_create_shared_hcd);
> struct usb_hcd *usb_create_hcd(const struct hc_driver *driver,
> 		struct device *dev, const char *bus_name)  {
>-	return usb_create_shared_hcd(driver, dev, bus_name, NULL);
>+	return __usb_create_hcd(driver, dev, dev, bus_name, NULL);
> }
> EXPORT_SYMBOL_GPL(usb_create_hcd);
>
>@@ -2714,7 +2724,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
> 	struct usb_device *rhdev;
>
> 	if (IS_ENABLED(CONFIG_USB_PHY) && !hcd->usb_phy) {
>-		struct usb_phy *phy = usb_get_phy_dev(hcd->self.controller, 0);
>+		struct usb_phy *phy = usb_get_phy_dev(hcd->self.sysdev, 0);
>
> 		if (IS_ERR(phy)) {
> 			retval = PTR_ERR(phy);
>@@ -2732,7 +2742,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
> 	}
>
> 	if (IS_ENABLED(CONFIG_GENERIC_PHY) && !hcd->phy) {
>-		struct phy *phy = phy_get(hcd->self.controller, "usb");
>+		struct phy *phy = phy_get(hcd->self.sysdev, "usb");
>
> 		if (IS_ERR(phy)) {
> 			retval = PTR_ERR(phy);
>@@ -2780,7 +2790,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
> 	 */
> 	retval = hcd_buffer_create(hcd);
> 	if (retval != 0) {
>-		dev_dbg(hcd->self.controller, "pool alloc failed\n");
>+		dev_dbg(hcd->self.sysdev, "pool alloc failed\n");
> 		goto err_create_buf;
> 	}
>
>@@ -2790,7 +2800,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
>
> 	rhdev = usb_alloc_dev(NULL, &hcd->self, 0);
> 	if (rhdev == NULL) {
>-		dev_err(hcd->self.controller, "unable to allocate root hub\n");
>+		dev_err(hcd->self.sysdev, "unable to allocate root hub\n");
> 		retval = -ENOMEM;
> 		goto err_allocate_root_hub;
> 	}
>diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c index
>5e80697ef952..199f67ae8857 100644
>--- a/drivers/usb/core/usb.c
>+++ b/drivers/usb/core/usb.c
>@@ -440,8 +440,8 @@ struct usb_device *usb_alloc_dev(struct usb_device
>*parent,
> 	dev->dev.bus = &usb_bus_type;
> 	dev->dev.type = &usb_device_type;
> 	dev->dev.groups = usb_device_groups;
>-	dev->dev.dma_mask = bus->controller->dma_mask;
>-	set_dev_node(&dev->dev, dev_to_node(bus->controller));
>+	dev->dev.dma_mask = bus->sysdev->dma_mask;
>+	set_dev_node(&dev->dev, dev_to_node(bus->sysdev));
> 	dev->state = USB_STATE_ATTACHED;
> 	dev->lpm_disable_count = 1;
> 	atomic_set(&dev->urbnum, 0);
>@@ -789,7 +789,7 @@ struct urb *usb_buffer_map(struct urb *urb)
> 	if (!urb
> 			|| !urb->dev
> 			|| !(bus = urb->dev->bus)
>-			|| !(controller = bus->controller))
>+			|| !(controller = bus->sysdev))
> 		return NULL;
>
> 	if (controller->dma_mask) {
>@@ -827,7 +827,7 @@ void usb_buffer_dmasync(struct urb *urb)
> 			|| !(urb->transfer_flags &
>URB_NO_TRANSFER_DMA_MAP)
> 			|| !urb->dev
> 			|| !(bus = urb->dev->bus)
>-			|| !(controller = bus->controller))
>+			|| !(controller = bus->sysdev))
> 		return;
>
> 	if (controller->dma_mask) {
>@@ -861,7 +861,7 @@ void usb_buffer_unmap(struct urb *urb)
> 			|| !(urb->transfer_flags &
>URB_NO_TRANSFER_DMA_MAP)
> 			|| !urb->dev
> 			|| !(bus = urb->dev->bus)
>-			|| !(controller = bus->controller))
>+			|| !(controller = bus->sysdev))
> 		return;
>
> 	if (controller->dma_mask) {
>@@ -911,7 +911,7 @@ int usb_buffer_map_sg(const struct usb_device *dev, int
>is_in,
>
> 	if (!dev
> 			|| !(bus = dev->bus)
>-			|| !(controller = bus->controller)
>+			|| !(controller = bus->sysdev)
> 			|| !controller->dma_mask)
> 		return -EINVAL;
>
>@@ -947,7 +947,7 @@ void usb_buffer_dmasync_sg(const struct usb_device *dev,
>int is_in,
>
> 	if (!dev
> 			|| !(bus = dev->bus)
>-			|| !(controller = bus->controller)
>+			|| !(controller = bus->sysdev)
> 			|| !controller->dma_mask)
> 		return;
>
>@@ -975,7 +975,7 @@ void usb_buffer_unmap_sg(const struct usb_device *dev,
>int is_in,
>
> 	if (!dev
> 			|| !(bus = dev->bus)
>-			|| !(controller = bus->controller)
>+			|| !(controller = bus->sysdev)
> 			|| !controller->dma_mask)
> 		return;
>
>diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c index
>35d092456bec..08db66c64c66 100644
>--- a/drivers/usb/dwc3/core.c
>+++ b/drivers/usb/dwc3/core.c
>@@ -25,6 +25,7 @@
> #include <linux/slab.h>
> #include <linux/spinlock.h>
> #include <linux/platform_device.h>
>+#include <linux/pci.h>
> #include <linux/pm_runtime.h>
> #include <linux/interrupt.h>
> #include <linux/ioport.h>
>@@ -178,7 +179,7 @@ static void dwc3_frame_length_adjustment(struct dwc3
>*dwc)  static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
> 		struct dwc3_event_buffer *evt)
> {
>-	dma_free_coherent(dwc->dev, evt->length, evt->buf, evt->dma);
>+	dma_free_coherent(dwc->sysdev, evt->length, evt->buf, evt->dma);
> }
>
> /**
>@@ -200,7 +201,7 @@ static struct dwc3_event_buffer
>*dwc3_alloc_one_event_buffer(struct dwc3 *dwc,
>
> 	evt->dwc	= dwc;
> 	evt->length	= length;
>-	evt->buf	= dma_alloc_coherent(dwc->dev, length,
>+	evt->buf	= dma_alloc_coherent(dwc->sysdev, length,
> 			&evt->dma, GFP_KERNEL);
> 	if (!evt->buf)
> 		return ERR_PTR(-ENOMEM);
>@@ -319,11 +320,11 @@ static int dwc3_setup_scratch_buffers(struct dwc3 *dwc)
> 	if (!WARN_ON(dwc->scratchbuf))
> 		return 0;
>
>-	scratch_addr = dma_map_single(dwc->dev, dwc->scratchbuf,
>+	scratch_addr = dma_map_single(dwc->sysdev, dwc->scratchbuf,
> 			dwc->nr_scratch * DWC3_SCRATCHBUF_SIZE,
> 			DMA_BIDIRECTIONAL);
>-	if (dma_mapping_error(dwc->dev, scratch_addr)) {
>-		dev_err(dwc->dev, "failed to map scratch buffer\n");
>+	if (dma_mapping_error(dwc->sysdev, scratch_addr)) {
>+		dev_err(dwc->sysdev, "failed to map scratch buffer\n");
> 		ret = -EFAULT;
> 		goto err0;
> 	}
>@@ -347,7 +348,7 @@ static int dwc3_setup_scratch_buffers(struct dwc3 *dwc)
> 	return 0;
>
> err1:
>-	dma_unmap_single(dwc->dev, dwc->scratch_addr, dwc->nr_scratch *
>+	dma_unmap_single(dwc->sysdev, dwc->scratch_addr, dwc->nr_scratch *
> 			DWC3_SCRATCHBUF_SIZE, DMA_BIDIRECTIONAL);
>
> err0:
>@@ -366,7 +367,7 @@ static void dwc3_free_scratch_buffers(struct dwc3 *dwc)
> 	if (!WARN_ON(dwc->scratchbuf))
> 		return;
>
>-	dma_unmap_single(dwc->dev, dwc->scratch_addr, dwc->nr_scratch *
>+	dma_unmap_single(dwc->sysdev, dwc->scratch_addr, dwc->nr_scratch *
> 			DWC3_SCRATCHBUF_SIZE, DMA_BIDIRECTIONAL);
> 	kfree(dwc->scratchbuf);
> }
>@@ -846,6 +847,13 @@ static int dwc3_probe(struct platform_device *pdev)
> 	dwc = PTR_ALIGN(mem, DWC3_ALIGN_MASK + 1);
> 	dwc->mem = mem;
> 	dwc->dev = dev;
>+#ifdef CONFIG_PCI
>+	/* TODO: or some other way of detecting this? */
>+	if (dwc->dev->parent && dwc->dev->parent->bus == &pci_bus_type)
>+		dwc->sysdev = dwc->dev->parent;
>+	else
>+#endif
>+		dwc->sysdev = dwc->dev;
>
> 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 	if (!res) {
>@@ -949,12 +957,6 @@ static int dwc3_probe(struct platform_device *pdev)
>
> 	spin_lock_init(&dwc->lock);
>
>-	if (!dev->dma_mask) {
>-		dev->dma_mask = dev->parent->dma_mask;
>-		dev->dma_parms = dev->parent->dma_parms;
>-		dma_set_coherent_mask(dev, dev->parent-
>>coherent_dma_mask);
>-	}
>-
> 	pm_runtime_set_active(dev);
> 	pm_runtime_use_autosuspend(dev);
> 	pm_runtime_set_autosuspend_delay(dev,
>DWC3_DEFAULT_AUTOSUSPEND_DELAY); diff --git a/drivers/usb/dwc3/core.h
>b/drivers/usb/dwc3/core.h index 45d6de5107c7..2fbc92143ab9 100644
>--- a/drivers/usb/dwc3/core.h
>+++ b/drivers/usb/dwc3/core.h
>@@ -823,6 +823,7 @@ struct dwc3 {
> 	spinlock_t		lock;
>
> 	struct device		*dev;
>+	struct device		*sysdev;
>
> 	struct platform_device	*xhci;
> 	struct resource		xhci_resources[DWC3_XHCI_RESOURCES_NUM];
>diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
>index 2f1fb7e7aa54..e27899bb5706 100644
>--- a/drivers/usb/dwc3/dwc3-exynos.c
>+++ b/drivers/usb/dwc3/dwc3-exynos.c
>@@ -20,7 +20,6 @@
> #include <linux/kernel.h>
> #include <linux/slab.h>
> #include <linux/platform_device.h>
>-#include <linux/dma-mapping.h>
> #include <linux/clk.h>
> #include <linux/usb/otg.h>
> #include <linux/usb/usb_phy_generic.h>
>@@ -117,15 +116,6 @@ static int dwc3_exynos_probe(struct platform_device
>*pdev)
> 	if (!exynos)
> 		return -ENOMEM;
>
>-	/*
>-	 * Right now device-tree probed devices don't get dma_mask set.
>-	 * Since shared usb code relies on it, set it here for now.
>-	 * Once we move to full device tree support this will vanish off.
>-	 */
>-	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
>-	if (ret)
>-		return ret;
>-
> 	platform_set_drvdata(pdev, exynos);
>
> 	exynos->dev	= dev;
>diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c index
>89a2f712fdfe..4d7439cb8cd8 100644
>--- a/drivers/usb/dwc3/dwc3-st.c
>+++ b/drivers/usb/dwc3/dwc3-st.c
>@@ -218,7 +218,6 @@ static int st_dwc3_probe(struct platform_device *pdev)
> 	if (IS_ERR(regmap))
> 		return PTR_ERR(regmap);
>
>-	dma_set_coherent_mask(dev, dev->coherent_dma_mask);
> 	dwc3_data->dev = dev;
> 	dwc3_data->regmap = regmap;
>
>diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c index
>ae4c5e89c134..9cda9ee91b9d 100644
>--- a/drivers/usb/dwc3/ep0.c
>+++ b/drivers/usb/dwc3/ep0.c
>@@ -974,8 +974,8 @@ static void __dwc3_ep0_do_control_data(struct dwc3
>*dwc,
> 		u32	transfer_size = 0;
> 		u32	maxpacket;
>
>-		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
>-				dep->number);
>+		ret = usb_gadget_map_request_by_dev(dwc->sysdev,
>+				&req->request, dep->number);
> 		if (ret) {
> 			dwc3_trace(trace_dwc3_ep0, "failed to map request");
> 			return;
>@@ -1002,8 +1002,8 @@ static void __dwc3_ep0_do_control_data(struct dwc3
>*dwc,
> 				dwc->ep0_bounce_addr, transfer_size,
> 				DWC3_TRBCTL_CONTROL_DATA, false);
> 	} else {
>-		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
>-				dep->number);
>+		ret = usb_gadget_map_request_by_dev(dwc->sysdev,
>+				&req->request, dep->number);
> 		if (ret) {
> 			dwc3_trace(trace_dwc3_ep0, "failed to map request");
> 			return;
>diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c index
>122e64df2f4d..77d62ce4547f 100644
>--- a/drivers/usb/dwc3/gadget.c
>+++ b/drivers/usb/dwc3/gadget.c
>@@ -192,8 +192,8 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct
>dwc3_request *req,
> 	if (dwc->ep0_bounced && dep->number == 0)
> 		dwc->ep0_bounced = false;
> 	else
>-		usb_gadget_unmap_request(&dwc->gadget, &req->request,
>-				req->direction);
>+		usb_gadget_unmap_request_by_dev(dwc->sysdev,
>+				&req->request, req->direction);
>
> 	trace_dwc3_gadget_giveback(req);
>
>@@ -371,7 +371,7 @@ static int dwc3_alloc_trb_pool(struct dwc3_ep *dep)
> 	if (dep->trb_pool)
> 		return 0;
>
>-	dep->trb_pool = dma_alloc_coherent(dwc->dev,
>+	dep->trb_pool = dma_alloc_coherent(dwc->sysdev,
> 			sizeof(struct dwc3_trb) * DWC3_TRB_NUM,
> 			&dep->trb_pool_dma, GFP_KERNEL);
> 	if (!dep->trb_pool) {
>@@ -387,7 +387,7 @@ static void dwc3_free_trb_pool(struct dwc3_ep *dep)  {
> 	struct dwc3		*dwc = dep->dwc;
>
>-	dma_free_coherent(dwc->dev, sizeof(struct dwc3_trb) *
>DWC3_TRB_NUM,
>+	dma_free_coherent(dwc->sysdev, sizeof(struct dwc3_trb) *
>DWC3_TRB_NUM,
> 			dep->trb_pool, dep->trb_pool_dma);
>
> 	dep->trb_pool = NULL;
>@@ -1027,8 +1027,8 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep
>*dep, u16 cmd_param)
> 		 * here and stop, unmap, free and del each of the linked
> 		 * requests instead of what we do now.
> 		 */
>-		usb_gadget_unmap_request(&dwc->gadget, &req->request,
>-				req->direction);
>+		usb_gadget_unmap_request_by_dev(dwc->sysdev,
>+				&req->request, req->direction);
> 		list_del(&req->list);
> 		return ret;
> 	}
>@@ -1113,8 +1113,8 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep
>*dep, struct dwc3_request *req)
> 	 * This will also avoid Host cancelling URBs due to too
> 	 * many NAKs.
> 	 */
>-	ret = usb_gadget_map_request(&dwc->gadget, &req->request,
>-			dep->direction);
>+	ret = usb_gadget_map_request_by_dev(dwc->sysdev,
>+		&req->request, dep->direction);
> 	if (ret)
> 		return ret;
>
>@@ -2953,7 +2953,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
>
> 	dwc->irq_gadget = irq;
>
>-	dwc->ctrl_req = dma_alloc_coherent(dwc->dev, sizeof(*dwc->ctrl_req),
>+	dwc->ctrl_req = dma_alloc_coherent(dwc->sysdev,
>+sizeof(*dwc->ctrl_req),
> 			&dwc->ctrl_req_addr, GFP_KERNEL);
> 	if (!dwc->ctrl_req) {
> 		dev_err(dwc->dev, "failed to allocate ctrl request\n"); @@ -2961,7
>+2961,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
> 		goto err0;
> 	}
>
>-	dwc->ep0_trb = dma_alloc_coherent(dwc->dev, sizeof(*dwc->ep0_trb) * 2,
>+	dwc->ep0_trb = dma_alloc_coherent(dwc->sysdev, sizeof(*dwc->ep0_trb)
>*
>+2,
> 			&dwc->ep0_trb_addr, GFP_KERNEL);
> 	if (!dwc->ep0_trb) {
> 		dev_err(dwc->dev, "failed to allocate ep0 trb\n"); @@ -2975,7
>+2975,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
> 		goto err2;
> 	}
>
>-	dwc->ep0_bounce = dma_alloc_coherent(dwc->dev,
>+	dwc->ep0_bounce = dma_alloc_coherent(dwc->sysdev,
> 			DWC3_EP0_BOUNCE_SIZE, &dwc->ep0_bounce_addr,
> 			GFP_KERNEL);
> 	if (!dwc->ep0_bounce) {
>@@ -3047,18 +3047,18 @@ err5:
>
> err4:
> 	dwc3_gadget_free_endpoints(dwc);
>-	dma_free_coherent(dwc->dev, DWC3_EP0_BOUNCE_SIZE,
>+	dma_free_coherent(dwc->sysdev, DWC3_EP0_BOUNCE_SIZE,
> 			dwc->ep0_bounce, dwc->ep0_bounce_addr);
>
> err3:
> 	kfree(dwc->setup_buf);
>
> err2:
>-	dma_free_coherent(dwc->dev, sizeof(*dwc->ep0_trb),
>+	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ep0_trb),
> 			dwc->ep0_trb, dwc->ep0_trb_addr);
>
> err1:
>-	dma_free_coherent(dwc->dev, sizeof(*dwc->ctrl_req),
>+	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ctrl_req),
> 			dwc->ctrl_req, dwc->ctrl_req_addr);
>
> err0:
>@@ -3073,16 +3073,16 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
>
> 	dwc3_gadget_free_endpoints(dwc);
>
>-	dma_free_coherent(dwc->dev, DWC3_EP0_BOUNCE_SIZE,
>+	dma_free_coherent(dwc->sysdev, DWC3_EP0_BOUNCE_SIZE,
> 			dwc->ep0_bounce, dwc->ep0_bounce_addr);
>
> 	kfree(dwc->setup_buf);
> 	kfree(dwc->zlp_buf);
>
>-	dma_free_coherent(dwc->dev, sizeof(*dwc->ep0_trb),
>+	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ep0_trb),
> 			dwc->ep0_trb, dwc->ep0_trb_addr);
>
>-	dma_free_coherent(dwc->dev, sizeof(*dwc->ctrl_req),
>+	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ctrl_req),
> 			dwc->ctrl_req, dwc->ctrl_req_addr);
> }
>
>diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c index
>f6533c68fed1..3c078e85fa98 100644
>--- a/drivers/usb/dwc3/host.c
>+++ b/drivers/usb/dwc3/host.c
>@@ -72,12 +72,7 @@ int dwc3_host_init(struct dwc3 *dwc)
> 		return -ENOMEM;
> 	}
>
>-	dma_set_coherent_mask(&xhci->dev, dwc->dev->coherent_dma_mask);
>-
> 	xhci->dev.parent	= dwc->dev;
>-	xhci->dev.dma_mask	= dwc->dev->dma_mask;
>-	xhci->dev.dma_parms	= dwc->dev->dma_parms;
>-
> 	dwc->xhci = xhci;
>
> 	ret = platform_device_add_resources(xhci, dwc->xhci_resources, @@ -
>112,9 +107,9 @@ int dwc3_host_init(struct dwc3 *dwc)
> 	return 0;
> err2:
> 	phy_remove_lookup(dwc->usb2_generic_phy, "usb2-phy",
>-			  dev_name(&xhci->dev));
>+			  dev_name(dwc->dev));
> 	phy_remove_lookup(dwc->usb3_generic_phy, "usb3-phy",
>-			  dev_name(&xhci->dev));
>+			  dev_name(dwc->dev));
> err1:
> 	platform_device_put(xhci);
> 	return ret;
>@@ -123,8 +118,8 @@ err1:
> void dwc3_host_exit(struct dwc3 *dwc)
> {
> 	phy_remove_lookup(dwc->usb2_generic_phy, "usb2-phy",
>-			  dev_name(&dwc->xhci->dev));
>+			  dev_name(dwc->dev));
> 	phy_remove_lookup(dwc->usb3_generic_phy, "usb3-phy",
>-			  dev_name(&dwc->xhci->dev));
>+			  dev_name(dwc->dev));
> 	platform_device_unregister(dwc->xhci);
> }
>diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c index
>9f5ffb629973..b2419950221f 100644
>--- a/drivers/usb/host/ehci-fsl.c
>+++ b/drivers/usb/host/ehci-fsl.c
>@@ -96,8 +96,8 @@ static int fsl_ehci_drv_probe(struct platform_device *pdev)
> 	}
> 	irq = res->start;
>
>-	hcd = usb_create_hcd(&fsl_ehci_hc_driver, &pdev->dev,
>-				dev_name(&pdev->dev));
>+	hcd = __usb_create_hcd(&fsl_ehci_hc_driver, &pdev->dev.parent,
>+				&pdev->dev, dev_name(&pdev->dev), NULL);
> 	if (!hcd) {
> 		retval = -ENOMEM;
> 		goto err1;
>diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c index
>ed56bf9ed885..c1d69e14432d 100644
>--- a/drivers/usb/host/xhci-plat.c
>+++ b/drivers/usb/host/xhci-plat.c
>@@ -14,6 +14,7 @@
> #include <linux/clk.h>
> #include <linux/dma-mapping.h>
> #include <linux/module.h>
>+#include <linux/pci.h>
> #include <linux/of.h>
> #include <linux/platform_device.h>
> #include <linux/usb/phy.h>
>@@ -139,6 +140,7 @@ static int xhci_plat_probe(struct platform_device *pdev)  {
> 	const struct of_device_id *match;
> 	const struct hc_driver	*driver;
>+	struct device		*sysdev;
> 	struct xhci_hcd		*xhci;
> 	struct resource         *res;
> 	struct usb_hcd		*hcd;
>@@ -155,22 +157,38 @@ static int xhci_plat_probe(struct platform_device *pdev)
> 	if (irq < 0)
> 		return -ENODEV;
>
>+	/*
>+	 * sysdev must point to a device that is known to the system firmware
>+	 * or PCI hardware. We handle these three cases here:
>+	 * 1. xhci_plat comes from firmware
>+	 * 2. xhci_plat is child of a device from firmware (dwc3-plat)
>+	 * 3. xhci_plat is grandchild of a pci device (dwc3-pci)
>+	 */
>+	sysdev = &pdev->dev;
>+	if (sysdev->parent && !sysdev->of_node && sysdev->parent->of_node)
>+		sysdev = sysdev->parent;
>+#ifdef CONFIG_PCI
>+	else if (sysdev->parent && sysdev->parent->parent &&
>+		 sysdev->parent->parent->bus == &pci_bus_type)
>+		sysdev = sysdev->parent->parent;
>+#endif
>+
> 	/* Try to set 64-bit DMA first */
>-	if (WARN_ON(!pdev->dev.dma_mask))
>+	if (WARN_ON(!sysdev->dma_mask))
> 		/* Platform did not initialize dma_mask */
>-		ret = dma_coerce_mask_and_coherent(&pdev->dev,
>+		ret = dma_coerce_mask_and_coherent(sysdev,
> 						   DMA_BIT_MASK(64));
> 	else
>-		ret = dma_set_mask_and_coherent(&pdev->dev,
>DMA_BIT_MASK(64));
>+		ret = dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
>
> 	/* If seting 64-bit DMA mask fails, fall back to 32-bit DMA mask */
> 	if (ret) {
>-		ret = dma_set_mask_and_coherent(&pdev->dev,
>DMA_BIT_MASK(32));
>+		ret = dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(32));
> 		if (ret)
> 			return ret;
> 	}
>
>-	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
>+	hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
>+dev_name(&pdev->dev), NULL);
> 	if (!hcd)
> 		return -ENOMEM;
>
>@@ -220,13 +238,13 @@ static int xhci_plat_probe(struct platform_device *pdev)
> 		goto disable_clk;
> 	}
>
>-	if (device_property_read_bool(&pdev->dev, "usb3-lpm-capable"))
>+	if (device_property_read_bool(sysdev, "usb3-lpm-capable"))
> 		xhci->quirks |= XHCI_LPM_SUPPORT;
>
> 	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
> 		xhci->shared_hcd->can_do_streams = 1;
>
>-	hcd->usb_phy = devm_usb_get_phy_by_phandle(&pdev->dev, "usb-phy",
>0);
>+	hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
> 	if (IS_ERR(hcd->usb_phy)) {
> 		ret = PTR_ERR(hcd->usb_phy);
> 		if (ret == -EPROBE_DEFER)
>diff --git a/include/linux/usb.h b/include/linux/usb.h index
>eba1f10e8cfd..f3f5d8a396e4 100644
>--- a/include/linux/usb.h
>+++ b/include/linux/usb.h
>@@ -354,6 +354,7 @@ struct usb_devmap {
>  */
> struct usb_bus {
> 	struct device *controller;	/* host/master side hardware */
>+	struct device *sysdev;		/* as seen from firmware or bus */
> 	int busnum;			/* Bus number (in order of reg) */
> 	const char *bus_name;		/* stable id (PCI slot_name etc) */
> 	u8 uses_dma;			/* Does the host controller use DMA? */
>diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h index
>66fc13705ab7..3860560a61bb 100644
>--- a/include/linux/usb/hcd.h
>+++ b/include/linux/usb/hcd.h
>@@ -437,6 +437,9 @@ extern int usb_hcd_alloc_bandwidth(struct usb_device
>*udev,
> 		struct usb_host_interface *new_alt);
> extern int usb_hcd_get_frame_number(struct usb_device *udev);
>
>+struct usb_hcd *__usb_create_hcd(const struct hc_driver *driver,
>+		struct device *sysdev, struct device *dev, const char *bus_name,
>+		struct usb_hcd *primary_hcd);
> extern struct usb_hcd *usb_create_hcd(const struct hc_driver *driver,
> 		struct device *dev, const char *bus_name);  extern struct usb_hcd
>*usb_create_shared_hcd(const struct hc_driver *driver,
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-usb" in the body of a
>message to majordomo at vger.kernel.org More majordomo info at
>http://vger.kernel.org/majordomo-info.html
