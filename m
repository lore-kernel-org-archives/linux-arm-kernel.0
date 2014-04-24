From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 24 Apr 2014 11:22:29 +0100
Subject: [PATCH V2 0/5] Huge pages for short descriptors on ARM
In-Reply-To: <1397648803-15961-1-git-send-email-steve.capper@linaro.org>
References: <1397648803-15961-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20140424102229.GA28014@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 12:46:38PM +0100, Steve Capper wrote:
> Hello,
> This series brings HugeTLB pages and Transparent Huge Pages (THP) to
> ARM on short descriptors.
> 
> Russell, Andrew,
> I would like to get this in next (and hopefully 3.16 if no problems
> arise) if that sounds reasonable?
> 
> There's one patch at the beginning of the series for mm:
>   mm: hugetlb: Introduce huge_pte_{page,present,young}
> This has been tested on ARM and s390 and should compile out for other
> architectures.
> 
> The rest of the series targets arch/arm.
> 
> I've bumped the series to V2 as it was rebased (and tested against)
> v3.15-rc1. On ARM the libhugetlbfs test suite, some THP PROT_NONE
> tests and the recursive execve test all passed successfully.
> 
> Thanks,
> --
> Steve

Hello,
Just a ping on this...

I would really like to get huge page support for short descriptors on
ARM merged as I've been carrying around these patches for a long time.

Recently I've had no issues raised about the code. The patches have
been tested and found to be both beneficial to system performance and
stable.

There are two parts to the series, the first patch is a core mm/ patch
that introduces some huge_pte_ helper functions that allows for a much
simpler ARM (without LPAE) implementation. The second part is the
actual arch/arm code.

I'm not sure how to proceed with these patches. I was thinking that
they could be picked up into linux-next? If that sounds reasonable;
Andrew, would you like to take the mm/ patch and Russell could you
please take the arch/arm patches?

Also, I was hoping to get these into 3.16. Are there any objections to
that?

Thank you,
-- 
Steve

> 
> 
> Steve Capper (5):
>   mm: hugetlb: Introduce huge_pte_{page,present,young}
>   arm: mm: Adjust the parameters for __sync_icache_dcache
>   arm: mm: Make mmu_gather aware of huge pages
>   arm: mm: HugeTLB support for non-LPAE systems
>   arm: mm: Add Transparent HugePage support for non-LPAE
> 
>  arch/arm/Kconfig                      |   4 +-
>  arch/arm/include/asm/hugetlb-2level.h | 136 ++++++++++++++++++++++++++++++++++
>  arch/arm/include/asm/hugetlb-3level.h |   6 ++
>  arch/arm/include/asm/hugetlb.h        |  10 +--
>  arch/arm/include/asm/pgtable-2level.h | 129 +++++++++++++++++++++++++++++++-
>  arch/arm/include/asm/pgtable-3level.h |   3 +-
>  arch/arm/include/asm/pgtable.h        |   9 +--
>  arch/arm/include/asm/tlb.h            |  14 +++-
>  arch/arm/kernel/head.S                |  10 ++-
>  arch/arm/mm/fault.c                   |  13 ----
>  arch/arm/mm/flush.c                   |   9 +--
>  arch/arm/mm/fsr-2level.c              |   4 +-
>  arch/arm/mm/hugetlbpage.c             |   2 +-
>  arch/arm/mm/mmu.c                     |  51 +++++++++++++
>  arch/s390/include/asm/hugetlb.h       |  15 ++++
>  include/asm-generic/hugetlb.h         |  15 ++++
>  mm/hugetlb.c                          |  22 +++---
>  17 files changed, 399 insertions(+), 53 deletions(-)
>  create mode 100644 arch/arm/include/asm/hugetlb-2level.h
> 
> -- 
> 1.8.1.4
> 
