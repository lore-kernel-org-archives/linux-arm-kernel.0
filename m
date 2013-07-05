From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Jul 2013 23:19:27 +0100
Subject: [PATCH V3] of: Set the DMA mask to 64 bits when dma_addr_t is
 64-bits
In-Reply-To: <CACVXFVPfkqP+UyoGd-+QFRzndSam_DtU=utrBPYCPjQCGQ_F6g@mail.gmail.com>
References: <1367008266-1431-1-git-send-email-lauraa@codeaurora.org>
 <517AF270.8040106@gmail.com>
 <CACVXFVPfkqP+UyoGd-+QFRzndSam_DtU=utrBPYCPjQCGQ_F6g@mail.gmail.com>
Message-ID: <20130705221927.GL24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 03, 2013 at 10:15:50PM +0800, Ming Lei wrote:
> 
> Without the patch, LPAE enabled board may not boot at all, but looks
> it still isn't in -next tree.
> 
> But I am wondering if it is a correct approach, because enabling LPAE
> doesn't mean the I/O devices can support DMA to/from 64bit address, and
> it is very probably devices can't do it at all.
> 
> Another way is to always set arm_dma_limit as 0xFFFFFFFF when
> CONFIG_ZONE_DMA is unset, and let driver override device's dma
> mask if the device supports 64bit DMA.

Okay, here's a teach-in on DMA masks, this is how it's supposed to work:

1. The bus code which creates the devices sets a default mask appropriate
   for the bus type.  For PCI, this is 32-bit, for ISA, it's 24-bit.

2. Before performing DMA, drivers should query the capabilities of the
   platform using dma_set_mask() for streaming transfers, and
   dma_set_coherent_mask() for coherent transfers.  Note: the DMA API
   specifies that a mask accepted by dma_set_mask() will also be
   accepted by dma_set_coherent_mask() - in other words, it is
   permissible _not_ to check the return value of dma_set_coherent_mask()
   iff that same mask is currently in use via dma_set_mask().

   (Side note: I have a patch in my tree which introduces
   dma_set_mask_and_coherent() which sets both.)

3. Drivers should attempt to set a mask appropriate for the device.
   If the device can drive 32-bit addresses, it requests a 32-bit
   mask.  If only 24-bit, a 24-bit mask.  If it wants to do more
   than 32-bit, it should set a larger mask.

   (See the "DMA addressing limitations" section of
    Documentation/DMA-API-HOWTO.txt).

4. PCI drivers use this as part of a negotiation with the rest of the
   system; you can plug a 64-bit capable PCI card into a 32-bit only
   capable host, and it should work - the driver should try to
   request the 64-bit mask first, if that succeeds then it can use
   DMA to 64-bit addresses.  If it fails, then it should then try to
   set a 32-bit mask.

So, that's more or less what's currently "known" of DMA masks.  What a lot
of ARM drivers do is totally ignore (3) and just assume that the platform
code set the mask up appropriately.  This is an incorrect assumption, and
it's something I'm slowly fixing where I have the knowledge.

What we shouldn't be relying upon is the default DMA mask being correct.

Last point is - the device actually doing DMA should be the one which the
DMA mask counts for above; if the device is just a user of DMA, then its
DMA mask should not matter (if it does, it's likely because of x86/PCI
assumptions made in the subsystem code) and actually should _not_ be set.
In other words, the DMA engine probe function should set the DMA mask on
the DMA controller, and you should do DMA mappings against the DMA
controller's struct device, not against the IO peripheral's struct
device.
