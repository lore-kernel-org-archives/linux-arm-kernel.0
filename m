From: dhdang@apm.com (Duc Dang)
Date: Thu, 10 Sep 2015 13:53:01 -0700
Subject: [PATCH v7 1/2] usb: make xhci platform driver use 64 bit or 32
 bit DMA
In-Reply-To: <55E591E9.60008@linux.intel.com>
References: <1522889.9kdnRk8vHo@wuerfel>
 <69e6f5bf693d02fba001d02047453bed0519499d.1440098398.git.dhdang@apm.com>
 <CADaLNDnPaeHcMjywsuQ4oiUpWsNpStshdKVtW=tuUorrcQkZ=g@mail.gmail.com>
 <55E591E9.60008@linux.intel.com>
Message-ID: <CADaLNDno0cLXH3_4NG75fk6T31Pe5BCrbcUpA0cGriCwSh6OyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 1, 2015 at 4:54 AM, Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
> On 31.08.2015 21:58, Duc Dang wrote:
>>
>> On Thu, Aug 20, 2015 at 12:38 PM, Duc Dang <dhdang@apm.com> wrote:
>>>
>>> The xhci platform driver needs to work on systems that
>>> either only support 64-bit DMA or only support 32-bit DMA.
>>> Attempt to set a coherent dma mask for 64-bit DMA, and
>>> attempt again with 32-bit DMA if that fails.
>>>
>>> [dhdang: regenerate the patch over 4.2-rc5 and address new comments]
>>> Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>
>>> Tested-by: Mark Salter <msalter@redhat.com>
>>> Signed-off-by: Duc Dang <dhdang@apm.com>
>>>
>>> ---
>>> Changes from v6:
>>>          -Add WARN_ON if dma_mask is NULL
>>>          -Use dma_coerce_mask_and_coherent to assign
>>>          dma_mask and coherent_dma_mask
>>>
>>> Changes from v5:
>>>          -Change comment
>>>          -Assign dma_mask to coherent_dma_mask if dma_mask is NULL
>>>          to make sure dma_set_mask_and_coherent does not fail
>>> prematurely.
>>>
>>> Changes from v4:
>>>          -None
>>>
>>> Changes from v3:
>>>          -Re-generate the patch over 4.2-rc5
>>>          -No code change.
>>>
>>> Changes from v2:
>>>          -None
>>>
>>> Changes from v1:
>>>          -Consolidated to use dma_set_mask_and_coherent
>>>          -Got rid of the check against sizeof(dma_addr_t)
>>>
>>>   drivers/usb/host/xhci-plat.c | 21 +++++++++++++--------
>>>   1 file changed, 13 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
>>> index 890ad9d..e4c7f9d 100644
>>> --- a/drivers/usb/host/xhci-plat.c
>>> +++ b/drivers/usb/host/xhci-plat.c
>>> @@ -93,14 +93,19 @@ static int xhci_plat_probe(struct platform_device
>>> *pdev)
>>>          if (irq < 0)
>>>                  return -ENODEV;
>>>
>>> -       /* Initialize dma_mask and coherent_dma_mask to 32-bits */
>>> -       ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
>>> -       if (ret)
>>> -               return ret;
>>> -       if (!pdev->dev.dma_mask)
>>> -               pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
>>> -       else
>>> -               dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
>>> +       /* Throw a waring if broken platform code didn't initialize
>>> dma_mask */
>>> +       WARN_ON(!pdev->dev.dma_mask);
>>> +       /*
>>> +        * Try setting dma_mask and coherent_dma_mask to 64 bits,
>>> +        * then try 32 bits
>>> +        */
>>> +       ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>>> +       if (ret) {
>>> +               ret = dma_coerce_mask_and_coherent(&pdev->dev,
>>> +                                                  DMA_BIT_MASK(32));
>>> +               if (ret)
>>> +                       return ret;
>>> +       }
>>>
>>>          hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
>>>          if (!hcd)
>>> --
>>> 1.9.1
>>>
>>
>> Hi Greg, Arnd, Russell,
>>
>> Do you have any more comment about this patch set?
>>
>
> I'm not sure I fully understand why we need to try the 64 bit DMA mask in
> platform probe.
>
> As I understood it we just want to have some DMA mask set before calling
> usb_create_hcd()
> to make sure USB core gets the "uses_dma" flag set and dma_set_mask() won't
> fail because of
> missing dev->dma_mask.
>
> The correct DMA mask is set later in xhci_gen_setup()
>
> We also need to make sure the controller supports 64bit addressing
> capability before setting a 64 bit DMA mask.
> (bit 0 in HCCPARAMS)
>
> So for platform devices it goes look go this:
>
> xhci_plat_probe()
>   usb_create_hcd()
>     usb_create_shared_hcd()
>       hcd->self.uses_dma = (dev->dma_mask != NULL);
>   usb_add_hcd()
>     hcd->driver->reset()  (.reset = xhci_plat_setup)
>       xhci_plat_setup()
>         xhci_gen_setup()
>           if (HCC_64BIT_ADDR(xhci->hcc_params) && !dma_set_mask(dev,
> DMA_BIT_MASK(64))) {
>             xhci_dbg(xhci, "Enabling 64-bit DMA addresses.\n");
>             dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
>           }
>
> or do we end up with dev->dma_mask = NULL on 64-bit DMA only after trying to
> set it to 32 in xhci_plat_probe(),
> and thus also failing the dma_set_mask() in xhci_gen_setup()?
>

Hi Mathias,

dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32)) in xhci_plat_probe
fails on our Arm64 X-Gene platform as we do not have DMA memory below 4GB. As a
consequence, xhci_plat_probe exits very early without creating any hcd.

The xhci_gen_setup code assumes that the dma_mask and
coherent_dma_mask were already
set to DMA_BIT_MASK(32) and only check to switch to DMA_BIT_MASK(64)
if the controller
supports 64-bit DMA. So I also see possible regression if a 32-bit
controller is used on 64-bit
system with my patch.

I will integrate Russell's suggestion and add changes to address the
case of 32-bit controller on 64-bit system
in my next version of this patch set.

> -Mathias
>
>
>
>
>
>
>
>
>
>


Regards,
-- 
Duc Dang.
