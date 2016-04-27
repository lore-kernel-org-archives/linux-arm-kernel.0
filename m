From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 27 Apr 2016 14:55:57 +0300
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <878tzzpq19.fsf@intel.com>
References: <1461612094-30939-1-git-send-email-grygorii.strashko@ti.com>
 <87d1pcrj0t.fsf@intel.com> <571F2357.9080509@ti.com>
 <878tzzpq19.fsf@intel.com>
Message-ID: <5720A8CD.6060103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2016 08:41 AM, Felipe Balbi wrote:
> 
> Hi,
> 
> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>> On 04/26/2016 09:17 AM, Felipe Balbi wrote:
>>>
>>> Hi,
>>>
>>> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>>>> Now not all DMA paremters configured properly for "xhci-hcd" platform
>>>> device which is created manually. For example: dma_pfn_offset, dam_ops
>>>> and iommu configuration will not corresponds "dwc3" devices
>>>> configuration. As result, this will cause problems like wrong DMA
>>>> addresses translation on platforms with LPAE enabled like Keystone 2.
>>>>
>>>> When platform is using DT boot mode the DMA configuration will be
>>>> parsed and applied from DT, so, to fix this issue, reuse
>>>> of_dma_configure() API and retrieve DMA configuartion for "xhci-hcd"
>>>> from DWC3 device node.
>>>
>>> patch is incomplete. You left out non-DT users which might suffer from
>>> the same problem.
>>>
>>
>> Honestly, I don't know how to fix it gracefully for non-DT case.
>> I can update commit message to mention that this is fix for DT case only.
> 
> no, that won't do :-) There are other users for this driver and they are
> all "out-of-compliance" when it comes to DMA usage. Apparently, the
> desired behavior is to pass correct device to DMA API which the gadget
> side is already doing (see below). For the host side, the fix has to be
> more involved.
> 
> Frankly, I'd prefer that DMA setup could be inherited from parent
> device, then it wouldn't really matter and a bunch of this could be
> simplified. Some sort of dma_inherit(struct device *dev, struct device
> *parent) would go a long way, IMHO.
> 
> 8<-------------------------------- cut here ------------------------
> commit 2725d6f974c4c268ae5fb746f8e3b33b76135aa8
> Author: Felipe Balbi <felipe.balbi@linux.intel.com>
> Date:   Tue Apr 19 16:18:12 2016 +0300
> 
>      usb: dwc3: use parent device for DMA
>      
>      our parent device is the one which was initialized
>      by either PCI or DeviceTree and that's the one which
>      is configured properly for DMA access.
>      
>      Instead of copying DMA bits from parent to child,
>      let's just rely on parent device for the entire DMA
>      API.

1) Patch I've sent fixes "xhci-hcd" platform device and not dwc3 core.
On TI boards dwc3 core devices are created from DT and so, I do not see
any problems with dwc3 core. Problem is with xhci.

2) there is minimum one dtsi file where dwc3 ("snps,dwc3") does not have parent device
ls1021a.dtsi (and 5 dtsi in arm64 folder)



>      
>      Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index c050a88c16d4..09e4ff71a50f 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -180,7 +180,7 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc, u32 fladj)
>   static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
>   		struct dwc3_event_buffer *evt)
>   {
> -	dma_free_coherent(dwc->dev, evt->length, evt->buf, evt->dma);
> +	dma_free_coherent(dwc->dev->parent, evt->length, evt->buf, evt->dma);
>   }

[...]

-- 
regards,
-grygorii
