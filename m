From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 06 Jan 2017 12:10:33 +0100
Subject: [PATCH 1/2] arm64: dma_mapping: allow PCI host driver to limit
 DMA mask
In-Reply-To: <9d5e32d3-000c-2f95-7ea8-c64d53ab6b56@cogentembedded.com>
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
 <3158203.Yc9Qgx82xo@wuerfel>
 <9d5e32d3-000c-2f95-7ea8-c64d53ab6b56@cogentembedded.com>
Message-ID: <2723285.JORgusvJv4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 4, 2017 6:29:39 PM CET Nikita Yushchenko wrote:

> > Just a guess, but if the inbound translation windows in the host
> > bridge are wider than 32-bit, the reason for setting up a single
> > 32-bit window is probably because that is what the parent bus supports.
> 
> Well anyway applying patch similar to your's will fix pcie-rcar + nvme
> case - thus I don't object :)   But it can break other cases ...
> 
> But why do you hook at set_dma_mask() and overwrite mask inside, instead
> of hooking at dma_supported() and rejecting unsupported mask?
> 
> I think later is better, because it lets drivers to handle unsupported
> high-dma case, like documented in DMA-API_HOWTO.

I think the behavior I put in there is required for swiotlb to make
sense, otherwise you would rely on the driver to handle dma_set_mask()
failure gracefully with its own bounce buffers (as network and
scsi drivers do but others don't).

Having swiotlb or iommu enabled should result in dma_set_mask() always
succeeding unless the mask is too small to cover the swiotlb
bounce buffer area or the iommu virtual address space. This behavior
is particularly important in case the bus address space is narrower
than 32-bit, as we have to guarantee that the fallback to 32-bit
DMA always succeeds. There are also a lot of drivers that try to
set a 64-bit mask but don't implement bounce buffers for streaming
mappings if that fails, and swiotlb is what we use to make those
drivers work.

And yes, the API is a horrible mess.

	Arnd
