From: balbi@kernel.org (Felipe Balbi)
Date: Fri, 02 Sep 2016 14:08:13 +0300
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <20160902104707.GC1041@n2100.armlinux.org.uk>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <87vb31kdvh.fsf@intel.com>
 <CADRPPNTQURmuwyuXCjHZcCq6jmQDFiyEUqfcqO-us15nosGCDA@mail.gmail.com>
 <6414695.LEIYfGPUEg@wuerfel> <20160902104707.GC1041@n2100.armlinux.org.uk>
Message-ID: <87a8fq8spu.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Russell King - ARM Linux <linux@armlinux.org.uk> writes:
> On Fri, Sep 02, 2016 at 12:43:39PM +0200, Arnd Bergmann wrote:
>> On Thursday, September 1, 2016 5:14:28 PM CEST Leo Li wrote:
>> > 
>> > Hi Felipe and Arnd,
>> > 
>> > It has been a while since the last response to this discussion, but we
>> > haven't reached an agreement yet!  Can we get to a conclusion on if it
>> > is valid to create child platform device for abstraction purpose?  If
>> > yes, can this child device do DMA by itself?
>> 
>> I'd say it's no problem for a driver to create child devices in order
>> to represent different aspects of a device, but you should not rely on
>> those devices working when used with the dma-mapping interfaces.
>
> That's absolutely right.  Consider the USB model - only the USB host
> controller can perform DMA, not the USB devices themselves.  All DMA
> mappings need to be mapped using the USB host controller device struct
> not the USB device struct.
>
> The same _should_ be true everywhere else: the struct device representing
> the device performing DMA must be the one used to map the transfer.

How do we fix dwc3 in dual-role, then?

Peripheral-side dwc3 is easy, we just require a glue-layer to be present
and use dwc3.ko's parent device (which will be the PCI device or OF
device). But for host side dwc3, the problem is slightly more complex
because we're using xhci-plat.ko by just instantiating a xhci-platform
device so xhci-plat can probe.

xhci core has no means to know if its own device or the parent of its
parent should be used for DMA. Any ideas?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160902/359a1892/attachment.sig>
