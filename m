From: Dave.Martin@arm.com (Dave P Martin)
Date: Wed, 23 Sep 2015 13:08:55 +0100
Subject: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= Question about the sparse
 memory section size
In-Reply-To: <13BC74040D0EF941B37FE727464B56DA8A5E2696@szxema508-mbx.china.huawei.com>
References: <56010DDD.3080803@hisilicon.com>
 <20150922111723.GI6281@e103592.cambridge.arm.com>
 <13BC74040D0EF941B37FE727464B56DA8A5E2696@szxema508-mbx.china.huawei.com>
Message-ID: <20150923120854.GP27273@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2015 at 02:16:45AM +0100, Qijiwen wrote:
> In fact the free_unused_memmap function is not invoked when CONFIG_SPARSEMEM_VMEMMAP is enabled. 
> The reason is that the memmap region is mapped in unit of 2MB, not in unit of 4KB.
> 
> Below is the source code in arch/arm64/mm/init.c:
> void __init mem_init(void)
> {
> 	swiotlb_init(1);
> 
> 	set_max_mapnr(pfn_to_page(max_pfn) - mem_map);
> 
> #ifndef CONFIG_SPARSEMEM_VMEMMAP
> 	free_unused_memmap();
> #endif

Oops, you're right.  But if we're not already doing so, it could still
make sense to unmap useless backing memory from the vmemmap, or try
harder to avoid mapping it in the first place.

However, whether this is is worth it depends on what fraction of
memory is wasted on your platform.  After all, every page struct is
"wasted" memory.  Which means 1-2% of RAM is always "wasted" for
a kernel with 4KB page size anyway.

Cheers
---Dave

[...]

> 
> Best regards,
> 
> Jiwen Qi
> 
> -----????-----
> ???: Dave Martin [mailto:Dave.Martin at arm.com] 
> ????: 2015?9?22? 19:17
> ???: Chenfeng (puck)
> ??: catalin.marinas at arm.com; will.deacon at arm.com; mark.rutland at arm.com; ard.biesheuvel at linaro.org; lauraa at codeaurora.org; linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Dan zhao; Xuyiping; Suzhuangluan; Qijiwen; fujun (F); Panshilin (Peter)
> ??: Re: Question about the sparse memory section size
> 
> On Tue, Sep 22, 2015 at 04:14:21PM +0800, chenfeng wrote:
> > Hi all,
> > The sparse memory section size, SECTION_SIZE_BITS, currently is 1GB 
> > for arm64 by default. However, it might generate wasted memmap memory 
> > space for those memory sections less than 1GB. e.g.
> > 
> > for 512MB memory section, still 14MB(sizeof(struct page) *
> > PAGES_PER_SECTION) memmap needs to be reserved. The wasted memmap 
> > space could be eliminated by changing memory section size from 1GB to 
> > 512M, but still some questions to be answered,
> > 
> > 1) why arm64 uses 1GB as default setting?
> > 2) any risk to change section size from 1GB to 512MB? like, any impact 
> > to performance since memory section number is increased.
> 
> For arm64 we have SPARSEMEM_VMEMMAP enabled by default, which enables much of the wasted memmap backing memory to be reclaimed.
> 
> Take a look at arch/arm64/mm/init.c:free_unused_memmap().
> 
> This should reduce the amount of actual memory wasted on unused parts of memmap.  The virtual space stays wasted as you describe, but that's plentiful on 64-bit arches.
> 
> You could try sticking some printks in there is you want to see how much of the memmap the code successfully frees.
> 
> Cheers
> ---Dave
> 
