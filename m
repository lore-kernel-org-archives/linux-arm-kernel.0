From: balbi@kernel.org (Felipe Balbi)
Date: Thu, 08 Sep 2016 11:29:04 +0300
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <6739240.VDAnDBppH0@wuerfel>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <3189648.KnWLgq0lTY@wuerfel> <8737lakedd.fsf@linux.intel.com>
 <6739240.VDAnDBppH0@wuerfel>
Message-ID: <87y432iylr.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Arnd Bergmann <arnd@arndb.de> writes:
>> > @@ -178,7 +179,7 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
>> >  static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
>> >  		struct dwc3_event_buffer *evt)
>> >  {
>> > -	dma_free_coherent(dwc->dev, evt->length, evt->buf, evt->dma);
>> > +	dma_free_coherent(dwc->sysdev, evt->length, evt->buf, evt->dma);
>> 
>> how about "dma_dev" instead? Is this used for anything other than DMA?
>
> The two other things we have discussed in this thread are:
>
> - connecting of_node pointers to usb_device structures for children
>   of sysdev->of_node. Note that this can happen even for PCI devices
>   in case you have a USB ethernet device hardwired to a PCI-USB bridge
>   and put the mac address in DT.
>
> - finding the PHY device for a HCD
>
> There might be others. Basically sysdev here is what the USB core code
> can use for looking up any kind of properties provided by the firmware.

fair enough

>> > @@ -846,6 +847,13 @@ static int dwc3_probe(struct platform_device *pdev)
>> >  	dwc = PTR_ALIGN(mem, DWC3_ALIGN_MASK + 1);
>> >  	dwc->mem = mem;
>> >  	dwc->dev = dev;
>> > +#ifdef CONFIG_PCI
>> > +	/* TODO: or some other way of detecting this? */
>> > +	if (dwc->dev->parent && dwc->dev->parent->bus == &pci_bus_type)
>> > +		dwc->sysdev = dwc->dev->parent;
>> > +	else
>> > +#endif
>> > +		dwc->sysdev = dwc->dev;
>> 
>> Well, we can remove this ifdef and *always* use the parent. We will just
>> require that dwc3 users provide a glue layer. In that case, your check
>> becomes:
>> 
>> 	if (dwc->dev->parent)
>>         	dwc->sysdev = dwc->dev->parent;
>> 	else
>>         	dev_info(dwc->dev, "Please provide a glue layer!\n");
>
> If we do that, we have to put child devices of the dwc3 devices into
> the platform glue, and it also breaks those dwc3 devices that don't
> have a parent driver.

Well, this is easy to fix:

 	if (dwc->dev->parent) {
         	dwc->sysdev = dwc->dev->parent;
 	} else {
         	dev_info(dwc->dev, "Please provide a glue layer!\n");
		dwc->sysdev = dwc->dev;
	}

>> > diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
>> > index 89a2f712fdfe..4d7439cb8cd8 100644
>> > --- a/drivers/usb/dwc3/dwc3-st.c
>> > +++ b/drivers/usb/dwc3/dwc3-st.c
>> > @@ -218,7 +218,6 @@ static int st_dwc3_probe(struct platform_device *pdev)
>> >  	if (IS_ERR(regmap))
>> >  		return PTR_ERR(regmap);
>> >  
>> > -	dma_set_coherent_mask(dev, dev->coherent_dma_mask);
>> 
>> so is this.
>> 
>> All in all, I like where you're going with this, we just need a matching
>> acpi_dma_configure() and problems will be sorted out.
>
> With this patch, I don't think we even need that any more, as the device
> that we use the dma-mapping API is the one that already gets configured
> correctly by the platform code for all cases: PCI, OF, ACPI and combinations
> of those.

sounds good to me

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/4f027449/attachment.sig>
