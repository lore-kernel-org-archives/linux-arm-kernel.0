From: will.deacon@arm.com (Will Deacon)
Date: Fri, 31 Jul 2015 12:32:17 +0100
Subject: [PATCH v3 3/6] iommu: add ARM short descriptor page table
 allocator.
In-Reply-To: <1438329337.25925.147.camel@mhfsdcap03>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
 <1437037475-9065-4-git-send-email-yong.wu@mediatek.com>
 <20150721171101.GN31095@arm.com>
 <1437715466.23932.68.camel@mhfsdcap03>
 <20150724165325.GC21177@arm.com>
 <1437970868.25925.20.camel@mhfsdcap03>
 <1438329337.25925.147.camel@mhfsdcap03>
Message-ID: <20150731113217.GE29497@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 08:55:37AM +0100, Yong Wu wrote:
>     About the AP bits, I may have to add a new quirk for it...
> 
>   Current I add AP in pte like this:
> #define ARM_SHORT_PTE_RD_WR        (3 << 4)
> #define ARM_SHORT_PTE_RDONLY       BIT(9)
> 
> pteprot |=  ARM_SHORT_PTE_RD_WR;
> 
> 
>  If(!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
> 
> 
>       pteprot |= ARM_SHORT_PTE_RDONLY;
> 
> The problem is that the BIT(9) in the level1 and level2 pagetable of our
> HW has been used for PA[32] that is for the dram size over 4G.

Aha, now *thats* a case of page-table abuse!

> so I had to add a quirk to disable bit9 while RDONLY case.
> (If BIT9 isn't disabled, the HW treat it as the PA[32] case then it will
> translation fault..)
> 
> like: IO_PGTABLE_QUIRK_SHORT_MTK ?

Given that you don't have XN either, maybe IO_PGTABLE_QUIRK_NO_PERMS?
When set, IOMMU_READ/WRITE/EXEC are ignored and the mapping will never
generate a permission fault.

Will
