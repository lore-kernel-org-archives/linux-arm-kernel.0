From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 25 Apr 2017 15:11:08 +0100
Subject: [PATCH] arm64/dma-mapping: fix DMA_ATTR_FORCE_CONTIGUOUS mmaping
 code
In-Reply-To: <a344c9c8-8a1f-cfc4-4dcd-1b49f3e1ac6c@redhat.com>
References: <CGME20170329100540eucas1p22d428e33aa678cbef0a24dd249820451@eucas1p2.samsung.com>
 <1490781926-6209-1-git-send-email-a.hajda@samsung.com>
 <15b1be13-625f-db74-d213-ad1df86f7eb5@arm.com>
 <20170421161234.GD5312@e104818-lin.cambridge.arm.com>
 <a344c9c8-8a1f-cfc4-4dcd-1b49f3e1ac6c@redhat.com>
Message-ID: <20170425141107.GD18225@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 09:58:23AM -0700, Laura Abbott wrote:
> On 04/21/2017 09:12 AM, Catalin Marinas wrote:
> > On Wed, Mar 29, 2017 at 01:55:32PM +0100, Robin Murphy wrote:
> >> On 29/03/17 11:05, Andrzej Hajda wrote:
> >>> In case of DMA_ATTR_FORCE_CONTIGUOUS allocations vm_area->pages
> >>> is invalid. __iommu_mmap_attrs and __iommu_get_sgtable cannot use
> >>> it. In first case temporary pages array is passed to iommu_dma_mmap,
> >>> in 2nd case single entry sg table is created directly instead
> >>> of calling helper.
> >>>
> >>> Fixes: 44176bb ("arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to IOMMU")
> >>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> >>> ---
> >>> Hi,
> >>>
> >>> I am not familiar with this framework so please don't be too cruel ;)
> >>> Alternative solution I see is to always create vm_area->pages,
> >>> I do not know which approach is preferred.
> >>>
> >>> Regards
> >>> Andrzej
> >>> ---
> >>>  arch/arm64/mm/dma-mapping.c | 40 ++++++++++++++++++++++++++++++++++++++--
> >>>  1 file changed, 38 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> >>> index f7b5401..bba2bc8 100644
> >>> --- a/arch/arm64/mm/dma-mapping.c
> >>> +++ b/arch/arm64/mm/dma-mapping.c
> >>> @@ -704,7 +704,30 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
> >>>  		return ret;
> >>>  
> >>>  	area = find_vm_area(cpu_addr);
> >>> -	if (WARN_ON(!area || !area->pages))
> >>> +	if (WARN_ON(!area))
> >>
> >> From the look of things, it doesn't seem strictly necessary to change
> >> this, but whether that's a good thing is another matter. I'm not sure
> >> that dma_common_contiguous_remap() should really be leaving a dangling
> >> pointer in area->pages as it apparently does... :/
> > 
> > On this specific point, I don't think area->pages should be set either
> > (cc'ing Laura). As in the vmalloc vs vmap case, area->pages when pages
> > need to be freed (via vfree), which is not the case here. The
> > dma_common_pages_remap() would need to set area->pages when called
> > directly from the iommu DMA ops. Proposal below, not tested with the
> > iommu ops. I assume the patch would cause __iommu_mmap_attrs() to return
> > -ENXIO if DMA_ATTR_FORCE_CONTIGUOUS is set.
[...]
> From a quick glance, this looks okay. I can give a proper tag when
> the fix to allow mmaping comes in since I'm guessing -ENXIO is not the
> end goal.

I'll post a proper patch and description. Strictly speaking, the above
fix is independent and we should rather get -ENXIO on arm64's
__iommu_mmap_attrs than dereferencing an already freed pointer. However,
I'm not sure anyone else would trigger this. Even on arm64, once we fix
the mmap case with DMA_ATTR_FORCE_CONTIGUOUS, we wouldn't dereference
the dangling area->pages pointer.

-- 
Catalin
