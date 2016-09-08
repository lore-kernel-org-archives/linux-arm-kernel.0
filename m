From: balbi@kernel.org (Felipe Balbi)
Date: Thu, 08 Sep 2016 11:03:10 +0300
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <3189648.KnWLgq0lTY@wuerfel>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <12021424.cItk3A7CfE@wuerfel> <87inu8kny0.fsf@linux.intel.com>
 <3189648.KnWLgq0lTY@wuerfel>
Message-ID: <8737lakedd.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Arnd Bergmann <arnd@arndb.de> writes:
>> Arnd Bergmann <arnd@arndb.de> writes:
>> 
>> [...]
>> 
>> > Regarding the DMA configuration that you mention in ci_hdrc_add_device(),
>> > I think we should replace 
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
> Right, I was specifically talking about the code in chipidea here,
> which I think is never used on the PCI bus, and how the current

just look at the history of the file, you'll see that an Intel employee
was a maintainer of chipidea driver. Also:

$ git ls-files drivers/usb/chipidea/ | grep pci
drivers/usb/chipidea/ci_hdrc_pci.c

> code is broken. We can probably do better than of_dma_configure()
> (see below), but it would be an improvement.
>
>> 2) not very robust solution
>> 
>> of_dma_configure() will hardcode 32-bit DMA dmask for xhci-plat because
>> that's not created by DT. The only reason why this works at all is
>> because of the default 32-bit dma mask thing :-) So, how is it any
>> different than copying 32-bit dma mask from parent?
>
> The idea here is that you pass in the parent of_node along with the child
> device pointer, so it would behave exactly like the parent already does.
> The difference is that it also handles all the other attributes besides the mask.

Now we're talking :-) I like that. We just need a matching API for
ACPI/PCI-based systems.

> However, to summarize the discussion so far, I agree that
> of_dma_configure() is not the solution to these problems, and I think
> we can do much better:
>
> Splitting the usb_bus->controller field into the Linux-internal device
> (used for the sysfs hierarchy, for printks and for power management)
> and a new pointer (used for DMA, DT enumeration and phy lookup) probably
> covers all that we really need.
>
> I've prototyped it below, with the dwc3, xhci and chipidea changes
> together with the core changes. I've surely made mistakes there and
> don't expect it to work out of the box, but this should give an
> idea of how I think this can all be solved in the least invasive
> way.
>
> I noticed that the gadget interface already has a way to handle the
> DMA allocation by device, so I added that in as well.

yeah, I wanna use that :-)

> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 35d092456bec..08db66c64c66 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -25,6 +25,7 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/platform_device.h>
> +#include <linux/pci.h>

actually, we don't want the core to know what it's attached to.

>  #include <linux/pm_runtime.h>
>  #include <linux/interrupt.h>
>  #include <linux/ioport.h>
> @@ -178,7 +179,7 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
>  static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
>  		struct dwc3_event_buffer *evt)
>  {
> -	dma_free_coherent(dwc->dev, evt->length, evt->buf, evt->dma);
> +	dma_free_coherent(dwc->sysdev, evt->length, evt->buf, evt->dma);

how about "dma_dev" instead? Is this used for anything other than DMA?

> @@ -846,6 +847,13 @@ static int dwc3_probe(struct platform_device *pdev)
>  	dwc = PTR_ALIGN(mem, DWC3_ALIGN_MASK + 1);
>  	dwc->mem = mem;
>  	dwc->dev = dev;
> +#ifdef CONFIG_PCI
> +	/* TODO: or some other way of detecting this? */
> +	if (dwc->dev->parent && dwc->dev->parent->bus == &pci_bus_type)
> +		dwc->sysdev = dwc->dev->parent;
> +	else
> +#endif
> +		dwc->sysdev = dwc->dev;

Well, we can remove this ifdef and *always* use the parent. We will just
require that dwc3 users provide a glue layer. In that case, your check
becomes:

	if (dwc->dev->parent)
        	dwc->sysdev = dwc->dev->parent;
	else
        	dev_info(dwc->dev, "Please provide a glue layer!\n");

> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
> index 2f1fb7e7aa54..e27899bb5706 100644
> --- a/drivers/usb/dwc3/dwc3-exynos.c
> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> @@ -20,7 +20,6 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
> -#include <linux/dma-mapping.h>
>  #include <linux/clk.h>
>  #include <linux/usb/otg.h>
>  #include <linux/usb/usb_phy_generic.h>
> @@ -117,15 +116,6 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>  	if (!exynos)
>  		return -ENOMEM;
>  
> -	/*
> -	 * Right now device-tree probed devices don't get dma_mask set.
> -	 * Since shared usb code relies on it, set it here for now.
> -	 * Once we move to full device tree support this will vanish off.
> -	 */
> -	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
> -	if (ret)
> -		return ret;

this is a separate patch, right?

> diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
> index 89a2f712fdfe..4d7439cb8cd8 100644
> --- a/drivers/usb/dwc3/dwc3-st.c
> +++ b/drivers/usb/dwc3/dwc3-st.c
> @@ -218,7 +218,6 @@ static int st_dwc3_probe(struct platform_device *pdev)
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
>  
> -	dma_set_coherent_mask(dev, dev->coherent_dma_mask);

so is this.

All in all, I like where you're going with this, we just need a matching
acpi_dma_configure() and problems will be sorted out.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/031d1e45/attachment-0001.sig>
