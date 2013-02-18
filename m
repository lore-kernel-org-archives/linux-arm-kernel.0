From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Mon, 18 Feb 2013 21:30:29 +0100
Subject: ARM coherent allocs, Was: ixp4xx eth broken in 3.7.0/3.8-rc5?
In-Reply-To: <20769.61349.124371.633959@pilspetsen.it.uu.se> (Mikael
 Pettersson's message of "Mon, 18 Feb 2013 10:08:53 +0100")
References: <20744.9777.937924.822371@pilspetsen.it.uu.se>
 <m34nhk9ef7.fsf@intrepid.localdomain>
 <m3a9r2d5md.fsf_-_@intrepid.localdomain>
 <20769.61349.124371.633959@pilspetsen.it.uu.se>
Message-ID: <m3ip5p4b6i.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mikael Pettersson <mikpe@it.uu.se> writes:

>  > I'm not sure how is it supposed to work. Environment: IXP4xx CPU,
>  > only 64 MB (of 256 MB) of RAM is available for PCI bus master DMA,
>  > /dev/sda is a PATA CF or SATA SSD using CS5536-based PATA interface
>  > (SATA - with a bridge) in DMA (PCI bus master) mode.
>  >
>  > It works in PIO mode.
>  > The problem seems to be this: pci_dev->dev.coherent_dma_mask is 0x3FFFFFF
>  > (64MB-1). Yet __dma_alloc() called with GFP_DMA returns memory
>  > physically located (dma_handle) above 64MB region.
>
> Isn't that what the ARM-specific dma bounce allocator is supposed to
> handle?  Or did e9da6e9905e639b0f842a244bc770b48ad0523e9 disable that
> one?

The so called "coherent" (aka "consistent") allocations mean that both
CPU and other bus masters can read and write at will, (almost) no
synchronization is needed and no map/unmap/sync calls are issued. This
also means the bounce buffering can't be used.
Streaming allocs (which can bounce) use "dma_mask" and coherent allocs
use "coherent_dma_mask".

> My ixp4xx box only has 64MB RAM so there is never any bouncing there,
> in fact I patch my kernel to disable the bounce support entirely.

Right. The problem is only visible with more than 64 MB RAM.
-- 
Krzysztof Halasa
