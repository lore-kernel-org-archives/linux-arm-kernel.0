From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 2 Sep 2016 12:55:33 +0100
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <87eg528te7.fsf@linux.intel.com>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <87vb31kdvh.fsf@intel.com>
 <CADRPPNTQURmuwyuXCjHZcCq6jmQDFiyEUqfcqO-us15nosGCDA@mail.gmail.com>
 <6414695.LEIYfGPUEg@wuerfel> <87eg528te7.fsf@linux.intel.com>
Message-ID: <956cf653-973a-3bfd-9aaa-bdc922995ea6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/16 11:53, Felipe Balbi wrote:
> 
> Hi,
> 
> Arnd Bergmann <arnd@arndb.de> writes:
>> On Thursday, September 1, 2016 5:14:28 PM CEST Leo Li wrote:
>>>
>>> Hi Felipe and Arnd,
>>>
>>> It has been a while since the last response to this discussion, but we
>>> haven't reached an agreement yet!  Can we get to a conclusion on if it
>>> is valid to create child platform device for abstraction purpose?  If
>>> yes, can this child device do DMA by itself?
>>
>> I'd say it's no problem for a driver to create child devices in order
>> to represent different aspects of a device, but you should not rely on
>> those devices working when used with the dma-mapping interfaces.
> 
> heh, that looks like an excuse to me :-)
> 
> This will always be a problem for e.g. MFD, for example. Are you saying
> MFD child-devices shouldn't be allowed to do DMA? It becomes silly when
> you read it that way, right?
> 
>> This used to be simpler back when we could configure the kernel for
>> only one SoC platform at a time, and the platforms could provide their
>> own overrides for the dma-mapping interfaces. These days, we rely on
> 
> right, so we have a very old regression that just took a complex driver
> such as dwc3 to trigger ;-)
> 
>> firmware or bootloader to describe various aspects of how DMA is done,
> 
> there's no DMA description in DT. Every OF device gets the same 32-bit
> DMA mask and that is, itself, wrong for several devices.

Huh? There's only no DMA description in DT if the device can be assumed
to be happy with the defaults. Anything else should be using
"dma-ranges", "dma-coherent", etc. to describe non-default integration
aspects. For devices with an inherent fixed addressing capability !=32
bits, then it's down to the driver to call dma_set_mask() appropriately
to override the default 32-bit mask (which is not unique to OF-probed
devices either).

Sure, it's by no means a perfect API, but you're railing against
untruths here.

Robin.

>> so you can't assume that passing a device without an of_node pointer
>> or ACPI data into those functions will do the right thing.
> 
> That's not the problem, however. We can very easily pass along
> ACPI_COMPANION() to any platform_device we want, but that's not enough
> because DMA-related bits are passed along with archdata; but archdata
> isn't generic in any way. Some arches (like x86) _do_ use it for DMA,
> but some don't.
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
