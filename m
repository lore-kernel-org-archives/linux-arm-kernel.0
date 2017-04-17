From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Sun, 16 Apr 2017 19:10:21 -0600
Subject: [PATCH] arm: dma: fix sharing of coherent DMA memory without
 struct page
In-Reply-To: <20170414094643.GG17774@n2100.armlinux.org.uk>
References: <CGME20170405160251epcas4p14cc5d5f6064c84b133b9e280ac987a93@epcas4p1.samsung.com>
 <20170405160242.14195-1-shuahkh@osg.samsung.com>
 <e49715a3-b925-79ad-7d1d-ce2cb5673a97@samsung.com>
 <3afd77e5-2a98-42fd-b5c9-cbf4c32baa4f@osg.samsung.com>
 <6d0c3e3c-8d1b-89bb-1392-6ffc7d8073c1@samsung.com>
 <20170414094643.GG17774@n2100.armlinux.org.uk>
Message-ID: <4c51bf1a-00cb-84bb-f661-6bb6c83d8134@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/2017 03:46 AM, Russell King - ARM Linux wrote:
> On Fri, Apr 14, 2017 at 09:56:07AM +0200, Marek Szyprowski wrote:
>>>> This would be however quite large task, especially taking into account
>>>> all current users of DMA-buf framework...
>>> Yeah it will be a large task.
>>
>> Maybe once scatterlist are switched to pfns, changing dmabuf internal
>> memory representation to pfn array might be much easier.
> 
> Switching to a PFN array won't work either as we have no cross-arch
> way to translate PFNs to a DMA address and vice versa.  Yes, we have
> them in ARM, but they are an _implementation detail_ of ARM's
> DMA API support, they are not for use by drivers.
> 
> So, the very first problem that needs solving is this:
> 
>   How do we go from a coherent DMA allocation for device X to a set
>   of DMA addresses for device Y.
> 
> Essentially, we need a way of remapping the DMA buffer for use with
> another device, and returning a DMA address suitable for that device.
> This could well mean that we need to deal with setting up an IOMMU
> mapping.  My guess is that this needs to happen at the DMA coherent
> API level - the DMA coherent API needs to be augmented with support
> for this.  I'll call this "DMA coherent remap".
> 
> We then need to think about how to pass this through the dma-buf API.
> dma_map_sg() is done by the exporter, who should know what kind of
> memory is being exported.  The exporter can avoid calling dma_map_sg()
> if it knows in advance that it is exporting DMA coherent memory.
> Instead, the exporter can simply create a scatterlist with the DMA
> address and DMA length prepopulated with the results of the DMA
> coherent remap operation above.

The only way to conclusively say that it is coming from coherent area
is at the time it is getting allocated in dma_alloc_from_coherent().
Since dma_alloc_attrs() will go on to find memory from other areas if
dma_alloc_from_coherent() doesn't allocate memory.

dma_get_sgtable_attrs() is what is used by the exporter to create the
sg_table. One way to do this cleanly without needing to check buffer
type flags would be to add a set of sg_table ops: get_sgtable,
map_sg, and unmap_sg. Sounds like sg_table interfaces need to be in
dma_buf_ops level. More below.

> 
> What the scatterlist can't carry in this case is a set of valid
> struct page pointers, and an importer must not walk the scatterlist
> expecting to get at the virtual address parameters or struct page
> pointers.
> 
> On the mmap() side of things, remember that DMA coherent allocations
> may require special mapping into userspace, and which can only be
> mapped by the DMA coherent mmap support.  kmap etc will also need to
> be different.  So it probably makes sense for DMA coherent dma-buf
> exports to use a completely separate set of dma_buf_ops from the
> streaming version.

How about adding get_sgtable, map_sg, unmap_sg to dma_buf_ops. The right
ops need to be installed based on buffer type. As I mentioned before, we
don't know which memory we got until dma_alloc_from_coherent() finds
memory in dev->mem area. So how about using the dma_check_dev_coherent()
to determine which ops we need. These could be set based on buffer type.
vb2_dc_get_dmabuf() can do that.

I think this will work.

thanks,
-- Shuah
