From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Dec 2014 10:52:02 +0100
Subject: using DMA-API on ARM
In-Reply-To: <5481794E.4050406@broadcom.com>
References: <5481794E.4050406@broadcom.com>
Message-ID: <4565667.WCBuNmaazQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 December 2014 10:22:22 Arend van Spriel wrote:
> Hi Russell,
> 
> For our brcm80211 development we are working on getting brcmfmac driver
> up and running on a Broadcom ARM-based platform. The wireless device is
> a PCIe device, which is hooked up to the system behind a PCIe host
> bridge, and we transfer information between host and device using a
> descriptor ring buffer allocated using dma_alloc_coherent(). We mostly
> tested on x86 and seen no issue. However, on this ARM platform
> (single-core A9) we detect occasionally that the descriptor content is
> invalid. When this occurs we do a dma_sync_single_for_cpu() and this is
> retried a number of times if the problem persists. Actually, found out
> that someone made a mistake by using virt_to_dma(va) to get the
> dma_handle parameter. So probably we only provided a delay in the retry
> loop. After fixing that a single call to dma_sync_single_for_cpu() is
> sufficient. The DMA-API-HOWTO clearly states that:
> 
> """
> the hardware should guarantee that the device and the CPU can access the
> data in parallel and will see updates made by each other without any
> explicit software flushing.
> """
> 
> So it seems incorrect that we would need to do a dma_sync for this
> memory. That we do need it seems like this memory can end up in
> cache(?), or whatever happens, in some rare condition. Is there anyway
> to investigate this situation either through DMA-API or some low-level
> ARM specific functions.

I think the problem comes down to not following the advice from this
comment in asm/dma-mapping.h:

/*
 * dma_to_pfn/pfn_to_dma/dma_to_virt/virt_to_dma are architecture private
 * functions used internally by the DMA-mapping API to provide DMA
 * addresses. They must not be used by drivers.
 */

The previous behavior of the driver is clearly wrong and cannot work
on any architecture that has noncoherent PCI DMA or uses swiotlb, and
that includes some older 64-bit x86 machines (Pentium D and similar).

I'm still puzzled why you'd need a single dma_sync_single_for_cpu()
after dma_alloc_coherent though, you should not need any. Is it possible
that the driver accidentally uses __raw_readl() instead of readl()
in some places and you are just lacking an appropriate barrier?

	Arnd
