From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Sep 2015 18:05:05 +0100
Subject: [PATCH] arm64: Add support for PTE contiguous bit.
In-Reply-To: <1442340117-3964-1-git-send-email-dwoods@ezchip.com>
References: <1442340117-3964-1-git-send-email-dwoods@ezchip.com>
Message-ID: <20150916170505.GR28771@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Tue, Sep 15, 2015 at 07:01:57PM +0100, David Woods wrote:
> The arm64 MMU supports a Contiguous bit which is a hint that the TTE
> is one of a set of contiguous entries which can be cached in a single
> TLB entry.  Supporting this bit adds new intermediate huge page sizes.
> 
> The set of huge page sizes available depends on the base page size.
> Without using contiguous pages the huge page sizes are as follows.
> 
>  4KB:   2MB  1GB
> 64KB: 512MB  4TB
> 
> With 4KB pages, the contiguous bit groups together sets of 16 pages
> and with 64KB pages it groups sets of 32 pages.  This enables two new
> huge page sizes in each case, so that the full set of available sizes
> is as follows.
> 
>  4KB:  64KB   2MB  32MB  1GB
> 64KB:   2MB 512MB  16GB  4TB
> 
> If the base page size is set to 64KB then 2MB pages are enabled by
> default.  It is possible in the future to make 2MB the default huge
> page size for both 4KB and 64KB pages.
> 
> Signed-off-by: David Woods <dwoods@ezchip.com>
> Reviewed-by: Chris Metcalf <cmetcalf@ezchip.com>
> ---
>  arch/arm64/Kconfig                     |   3 -
>  arch/arm64/include/asm/hugetlb.h       |   4 +
>  arch/arm64/include/asm/pgtable-hwdef.h |  15 +++
>  arch/arm64/include/asm/pgtable.h       |  30 +++++-
>  arch/arm64/mm/hugetlbpage.c            | 165 ++++++++++++++++++++++++++++++++-
>  5 files changed, 210 insertions(+), 7 deletions(-)

I glanced briefly at this, and I think you'll need to do some extra work
for the CONFIG_HW_AFDBM=y case, where the CPU can set access/dirty bits
in any (i.e. not necessarily all) of the page table entries in a
contiguous mapping. In this case, things like huge_pte_dirty might need
overriding.

Will
