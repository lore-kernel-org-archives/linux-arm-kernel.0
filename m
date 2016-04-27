From: balbi@kernel.org (Felipe Balbi)
Date: Wed, 27 Apr 2016 08:41:06 +0300
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <571F2357.9080509@ti.com>
References: <1461612094-30939-1-git-send-email-grygorii.strashko@ti.com>
 <87d1pcrj0t.fsf@intel.com> <571F2357.9080509@ti.com>
Message-ID: <878tzzpq19.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Grygorii Strashko <grygorii.strashko@ti.com> writes:
> On 04/26/2016 09:17 AM, Felipe Balbi wrote:
>> 
>> Hi,
>> 
>> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>>> Now not all DMA paremters configured properly for "xhci-hcd" platform
>>> device which is created manually. For example: dma_pfn_offset, dam_ops
>>> and iommu configuration will not corresponds "dwc3" devices
>>> configuration. As result, this will cause problems like wrong DMA
>>> addresses translation on platforms with LPAE enabled like Keystone 2.
>>>
>>> When platform is using DT boot mode the DMA configuration will be
>>> parsed and applied from DT, so, to fix this issue, reuse
>>> of_dma_configure() API and retrieve DMA configuartion for "xhci-hcd"
>>> from DWC3 device node.
>> 
>> patch is incomplete. You left out non-DT users which might suffer from
>> the same problem.
>> 
>
> Honestly, I don't know how to fix it gracefully for non-DT case.
> I can update commit message to mention that this is fix for DT case only.

no, that won't do :-) There are other users for this driver and they are
all "out-of-compliance" when it comes to DMA usage. Apparently, the
desired behavior is to pass correct device to DMA API which the gadget
side is already doing (see below). For the host side, the fix has to be
more involved.

Frankly, I'd prefer that DMA setup could be inherited from parent
device, then it wouldn't really matter and a bunch of this could be
simplified. Some sort of dma_inherit(struct device *dev, struct device
*parent) would go a long way, IMHO.

8<-------------------------------- cut here ------------------------
commit 2725d6f974c4c268ae5fb746f8e3b33b76135aa8
Author: Felipe Balbi <felipe.balbi@linux.intel.com>
Date:   Tue Apr 19 16:18:12 2016 +0300

    usb: dwc3: use parent device for DMA
    
    our parent device is the one which was initialized
    by either PCI or DeviceTree and that's the one which
    is configured properly for DMA access.
    
    Instead of copying DMA bits from parent to child,
    let's just rely on parent device for the entire DMA
    API.
    
    Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c050a88c16d4..09e4ff71a50f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -180,7 +180,7 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc, u32 fladj)
 static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
 		struct dwc3_event_buffer *evt)
 {
-	dma_free_coherent(dwc->dev, evt->length, evt->buf, evt->dma);
+	dma_free_coherent(dwc->dev->parent, evt->length, evt->buf, evt->dma);
 }
 
 /**
@@ -202,7 +202,7 @@ static struct dwc3_event_buffer *dwc3_alloc_one_event_buffer(struct dwc3 *dwc,
 
 	evt->dwc	= dwc;
 	evt->length	= length;
-	evt->buf	= dma_alloc_coherent(dwc->dev, length,
+	evt->buf	= dma_alloc_coherent(dwc->dev->parent, length,
 			&evt->dma, GFP_KERNEL);
 	if (!evt->buf)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 143deb420481..c78238dc76fc 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -967,7 +967,7 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		u32	transfer_size = 0;
 		u32	maxpacket;
 
-		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
+		ret = usb_gadget_map_request_by_dev(dwc->dev->parent, &req->request,
 				dep->number);
 		if (ret) {
 			dwc3_trace(trace_dwc3_ep0, "failed to map request\n");
@@ -995,7 +995,7 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 				dwc->ep0_bounce_addr, transfer_size,
 				DWC3_TRBCTL_CONTROL_DATA, false);
 	} else {
-		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
+		ret = usb_gadget_map_request_by_dev(dwc->dev->parent, &req->request,
 				dep->number);
 		if (ret) {
 			dwc3_trace(trace_dwc3_ep0, "failed to map request\n");
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 88fd30bf0c46..6929775bde57 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -191,7 +191,7 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 	if (dwc->ep0_bounced && dep->number == 0)
 		dwc->ep0_bounced = false;
 	else
-		usb_gadget_unmap_request(&dwc->gadget, &req->request,
+		usb_gadget_unmap_request_by_dev(dwc->dev->parent, &req->request,
 				req->direction);
 
 	trace_dwc3_gadget_giveback(req);
@@ -335,7 +335,7 @@ static int dwc3_alloc_trb_pool(struct dwc3_ep *dep)
 	if (dep->trb_pool)
 		return 0;
 
-	dep->trb_pool = dma_alloc_coherent(dwc->dev,
+	dep->trb_pool = dma_alloc_coherent(dwc->dev->parent,
 			sizeof(struct dwc3_trb) * DWC3_TRB_NUM,
 			&dep->trb_pool_dma, GFP_KERNEL);
 	if (!dep->trb_pool) {
@@ -351,7 +351,8 @@ static void dwc3_free_trb_pool(struct dwc3_ep *dep)
 {
 	struct dwc3		*dwc = dep->dwc;
 
-	dma_free_coherent(dwc->dev, sizeof(struct dwc3_trb) * DWC3_TRB_NUM,
+	dma_free_coherent(dwc->dev->parent,
+			sizeof(struct dwc3_trb) * DWC3_TRB_NUM,
 			dep->trb_pool, dep->trb_pool_dma);
 
 	dep->trb_pool = NULL;
@@ -972,7 +973,7 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, u16 cmd_param,
 		 * here and stop, unmap, free and del each of the linked
 		 * requests instead of what we do now.
 		 */
-		usb_gadget_unmap_request(&dwc->gadget, &req->request,
+		usb_gadget_unmap_request_by_dev(dwc->dev->parent, &req->request,
 				req->direction);
 		list_del(&req->list);
 		return ret;
@@ -1057,7 +1058,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	 * This will also avoid Host cancelling URBs due to too
 	 * many NAKs.
 	 */
-	ret = usb_gadget_map_request(&dwc->gadget, &req->request,
+	ret = usb_gadget_map_request_by_dev(dwc->dev->parent, &req->request,
 			dep->direction);
 	if (ret)
 		return ret;
@@ -2734,7 +2735,8 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 {
 	int					ret;
 
-	dwc->ctrl_req = dma_alloc_coherent(dwc->dev, sizeof(*dwc->ctrl_req),
+	dwc->ctrl_req = dma_alloc_coherent(dwc->dev->parent,
+			sizeof(*dwc->ctrl_req),
 			&dwc->ctrl_req_addr, GFP_KERNEL);
 	if (!dwc->ctrl_req) {
 		dev_err(dwc->dev, "failed to allocate ctrl request\n");
@@ -2742,7 +2744,8 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err0;
 	}
 
-	dwc->ep0_trb = dma_alloc_coherent(dwc->dev, sizeof(*dwc->ep0_trb) * 2,
+	dwc->ep0_trb = dma_alloc_coherent(dwc->dev->parent,
+			sizeof(*dwc->ep0_trb) * 2,
 			&dwc->ep0_trb_addr, GFP_KERNEL);
 	if (!dwc->ep0_trb) {
 		dev_err(dwc->dev, "failed to allocate ep0 trb\n");
@@ -2756,7 +2759,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err2;
 	}
 
-	dwc->ep0_bounce = dma_alloc_coherent(dwc->dev,
+	dwc->ep0_bounce = dma_alloc_coherent(dwc->dev->parent,
 			DWC3_EP0_BOUNCE_SIZE, &dwc->ep0_bounce_addr,
 			GFP_KERNEL);
 	if (!dwc->ep0_bounce) {
@@ -2828,18 +2831,18 @@ err5:
 
 err4:
 	dwc3_gadget_free_endpoints(dwc);
-	dma_free_coherent(dwc->dev, DWC3_EP0_BOUNCE_SIZE,
+	dma_free_coherent(dwc->dev->parent, DWC3_EP0_BOUNCE_SIZE,
 			dwc->ep0_bounce, dwc->ep0_bounce_addr);
 
 err3:
 	kfree(dwc->setup_buf);
 
 err2:
-	dma_free_coherent(dwc->dev, sizeof(*dwc->ep0_trb),
+	dma_free_coherent(dwc->dev->parent, sizeof(*dwc->ep0_trb),
 			dwc->ep0_trb, dwc->ep0_trb_addr);
 
 err1:
-	dma_free_coherent(dwc->dev, sizeof(*dwc->ctrl_req),
+	dma_free_coherent(dwc->dev->parent, sizeof(*dwc->ctrl_req),
 			dwc->ctrl_req, dwc->ctrl_req_addr);
 
 err0:
@@ -2854,16 +2857,16 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 
 	dwc3_gadget_free_endpoints(dwc);
 
-	dma_free_coherent(dwc->dev, DWC3_EP0_BOUNCE_SIZE,
+	dma_free_coherent(dwc->dev->parent, DWC3_EP0_BOUNCE_SIZE,
 			dwc->ep0_bounce, dwc->ep0_bounce_addr);
 
 	kfree(dwc->setup_buf);
 	kfree(dwc->zlp_buf);
 
-	dma_free_coherent(dwc->dev, sizeof(*dwc->ep0_trb),
+	dma_free_coherent(dwc->dev->parent, sizeof(*dwc->ep0_trb),
 			dwc->ep0_trb, dwc->ep0_trb_addr);
 
-	dma_free_coherent(dwc->dev, sizeof(*dwc->ctrl_req),
+	dma_free_coherent(dwc->dev->parent, sizeof(*dwc->ctrl_req),
 			dwc->ctrl_req, dwc->ctrl_req_addr);
 }
 


-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160427/1df703bd/attachment-0001.sig>
