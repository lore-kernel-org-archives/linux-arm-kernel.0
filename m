From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Sep 2016 10:29:25 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <340685cd-7f06-21db-94cb-a87d0df36286@ti.com>
References: <Pine.LNX.4.44L0.1609021019260.2027-100000@iolanthe.rowland.org>
 <5147808.apZTAZ3VPE@wuerfel> <340685cd-7f06-21db-94cb-a87d0df36286@ti.com>
Message-ID: <8802454.xFheq55hVP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 7, 2016 10:17:31 AM CEST Roger Quadros wrote:
> > 
> > Speaking of that flag, I suppose we need the same logic to know where
> > to look for USB devices attached to a dwc3 host when we need to describe
> > them in DT. By default we look for child device nodes under the
> > node of the HCD device node, but that would be wrong here too.
> 
> I didn't get this part. Information about USB devices attached to a USB host
> is never provided in DT because they are always dynamically created via
> usb_new_device(), whether they are hard-wired on the board or hot-plugged.
> 
> These USB devices inherit their DMA masks in the usb_alloc_dev() routine
> whereas each interface within the USB device inherits its DMA mask in
> usb_set_configuration().

We had talked about adding support for this for at least six years (probably
much more), but Peter Chen finally added it this year in commit 69bec72598
("USB: core: let USB device know device node").

The main use for it is to let you specify a MAC address for on-board
ethernet devices that lack an EPROM, but any other information can be
added that way too.

> There is a bug  in the USB core because of which the ISB device and interfaces
> do not inherit dma_pfn_offset correctly for which I've sent a patch
> https://lkml.org/lkml/2016/8/17/275

I'm a bit skeptical about this. Clearly if we set the dma_mask, we should
also set the dma_pfn_offset, but what exactly is this used for in USB
devices?

As I understand it, the dma_mask/dma_pfn_offset etc is used for the DMA
mapping interface, but that can't really be used on USB devices, which
I assume use usb_alloc_coherent() and the URB interfaces for passing data
between a USB driver and the HCD. My knowledge of USB device drivers
is a bit lacking, so it's possible I'm misunderstanding things here.

	Arnd
