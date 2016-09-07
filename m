From: rogerq@ti.com (Roger Quadros)
Date: Wed, 7 Sep 2016 16:04:52 +0300
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <8802454.xFheq55hVP@wuerfel>
References: <Pine.LNX.4.44L0.1609021019260.2027-100000@iolanthe.rowland.org>
 <5147808.apZTAZ3VPE@wuerfel> <340685cd-7f06-21db-94cb-a87d0df36286@ti.com>
 <8802454.xFheq55hVP@wuerfel>
Message-ID: <632cd67b-34de-2177-529f-e1437924bae2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/16 11:29, Arnd Bergmann wrote:
> On Wednesday, September 7, 2016 10:17:31 AM CEST Roger Quadros wrote:
>>>
>>> Speaking of that flag, I suppose we need the same logic to know where
>>> to look for USB devices attached to a dwc3 host when we need to describe
>>> them in DT. By default we look for child device nodes under the
>>> node of the HCD device node, but that would be wrong here too.
>>
>> I didn't get this part. Information about USB devices attached to a USB host
>> is never provided in DT because they are always dynamically created via
>> usb_new_device(), whether they are hard-wired on the board or hot-plugged.
>>
>> These USB devices inherit their DMA masks in the usb_alloc_dev() routine
>> whereas each interface within the USB device inherits its DMA mask in
>> usb_set_configuration().
> 
> We had talked about adding support for this for at least six years (probably
> much more), but Peter Chen finally added it this year in commit 69bec72598
> ("USB: core: let USB device know device node").

OK. Thanks for this pointer.
> 
> The main use for it is to let you specify a MAC address for on-board
> ethernet devices that lack an EPROM, but any other information can be
> added that way too.
> 
>> There is a bug  in the USB core because of which the ISB device and interfaces
>> do not inherit dma_pfn_offset correctly for which I've sent a patch
>> https://lkml.org/lkml/2016/8/17/275
> 
> I'm a bit skeptical about this. Clearly if we set the dma_mask, we should
> also set the dma_pfn_offset, but what exactly is this used for in USB
> devices?

Consider the mass storage device case.
USB storage driver creates a scsi host for the mass storage interface in
drivers/usb/storage/usb.c
The scsi host parent device is nothing but the the USB interface device.

Now, __scsi_init_queue() calls scsi_calculate_bounce_limit() to find out
and set the block layer bounce limit.

scsi_calculate_bounce_limit() uses dma_max_pfn(host_dev) to get the bounce_limit.

host_dev is nothing but the device representing the mass storage interface.

If that device doesn't have the right dma_pfn_offset, then dma_max_pfn()
is messed up and the bounce buffer limit is wrong.

> 
> As I understand it, the dma_mask/dma_pfn_offset etc is used for the DMA
> mapping interface, but that can't really be used on USB devices, which
> I assume use usb_alloc_coherent() and the URB interfaces for passing data
> between a USB driver and the HCD. My knowledge of USB device drivers
> is a bit lacking, so it's possible I'm misunderstanding things here.
> 

cheers,
-roger
