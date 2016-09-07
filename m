From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Sep 2016 16:38:40 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <632cd67b-34de-2177-529f-e1437924bae2@ti.com>
References: <Pine.LNX.4.44L0.1609021019260.2027-100000@iolanthe.rowland.org>
 <8802454.xFheq55hVP@wuerfel> <632cd67b-34de-2177-529f-e1437924bae2@ti.com>
Message-ID: <4842968.834OEr0s9G@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 7, 2016 4:04:52 PM CEST Roger Quadros wrote:
> > The main use for it is to let you specify a MAC address for on-board
> > ethernet devices that lack an EPROM, but any other information can be
> > added that way too.
> > 
> >> There is a bug  in the USB core because of which the ISB device and interfaces
> >> do not inherit dma_pfn_offset correctly for which I've sent a patch
> >> https://lkml.org/lkml/2016/8/17/275
> > 
> > I'm a bit skeptical about this. Clearly if we set the dma_mask, we should
> > also set the dma_pfn_offset, but what exactly is this used for in USB
> > devices?
> 
> Consider the mass storage device case.
> USB storage driver creates a scsi host for the mass storage interface in
> drivers/usb/storage/usb.c
> The scsi host parent device is nothing but the the USB interface device.
> 
> Now, __scsi_init_queue() calls scsi_calculate_bounce_limit() to find out
> and set the block layer bounce limit.
> 
> scsi_calculate_bounce_limit() uses dma_max_pfn(host_dev) to get the bounce_limit.
> 
> host_dev is nothing but the device representing the mass storage interface.
> 
> If that device doesn't have the right dma_pfn_offset, then dma_max_pfn()
> is messed up and the bounce buffer limit is wrong.

I see. The same thing probably happens in the network and mmc subsystems,
which have similar code.

This shows the inconsistencies we have in the handling for bounce buffers
in the kernel, which are sometimes handled by subsystems but sometimes
rely on swiotlb instead. I don't have any better idea than your patch
here, but maybe we should add a comment explaining that next to the
code.

	Arnd
