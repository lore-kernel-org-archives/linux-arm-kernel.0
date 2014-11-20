From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 08:40 +0100
Subject: For the problem when using swiotlb
In-Reply-To: <546D58B1.60108@huawei.com>
References: <5469E26B.2010905@huawei.com> <1535751.CcvIi3DN4F@wuerfel>
 <546D58B1.60108@huawei.com>
Message-ID: <2522857.bNQToYpBNt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 November 2014 10:57:53 Ding Tianhong wrote:
> On 2014/11/19 16:45, Arnd Bergmann wrote:
> > On Wednesday 19 November 2014 11:17:15 Ding Tianhong wrote:
> >> On 2014/11/18 2:09, Catalin Marinas wrote:
> >>> On Mon, Nov 17, 2014 at 12:18:42PM +0000, Arnd Bergmann wrote:
> >> Thanks everyone, I think I found the way to fix it, need to enable DMA_CMA, to reserve a big memory
> >> for CMA and set coherent mask for dev, then dma_alloc and dma_mapping will not use the swiotlb until
> >> the memory out of mask or swiotlb_force is enabled.
> >>
> >> If I still understand uncorrectly, please inform me.
> >>
> > 
> > Please do not use CMA to work around the problem, but fix the underlying bug
> > instead.
> > 
> > The driver should call 'dma_set_mask_and_coherent()' with the appropriate
> > dma mask, and check whether that succeeded. However, the code implementing
> > dma_set_mask_and_coherent on arm64 also needs to be changed to look up
> > the dma-ranges property (see of_dma_configure()), and check if the mask
> > is possible.
> > 
> The dma_pfn_offset looks only support arm32, but my platform is aarch64 and I check the latest kernel version, 
> I think the dma-rangs still could not work for aarch64, so maybe we should add dma_pfn_offset for aarch64 first.
> 

I didn't mean the dma_pfn_offset. The problem is that the of_dma_configure
code currently doesn't look at the mask. As I explained in my reply to
Catalin, it should set the mask to the size of the dma-ranges if that is
32-bit or smaller, and dma_set_mask should look at the same dma-ranges
property to decide what to set the mask to when a driver asks for a
mask larger than 64-bit.

	Arnd
