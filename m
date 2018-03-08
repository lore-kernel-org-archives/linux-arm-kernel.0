From: will.deacon@arm.com (Will Deacon)
Date: Thu, 8 Mar 2018 18:04:47 +0000
Subject: [PATCH 1/2] mm/vmalloc: Add interfaces to free unused page table
In-Reply-To: <20180307183227.17983-2-toshi.kani@hpe.com>
References: <20180307183227.17983-1-toshi.kani@hpe.com>
 <20180307183227.17983-2-toshi.kani@hpe.com>
Message-ID: <20180308180446.GF14918@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Toshi,

Thanks for the patches!

On Wed, Mar 07, 2018 at 11:32:26AM -0700, Toshi Kani wrote:
> On architectures with CONFIG_HAVE_ARCH_HUGE_VMAP set, ioremap()
> may create pud/pmd mappings.  Kernel panic was observed on arm64
> systems with Cortex-A75 in the following steps as described by
> Hanjun Guo.
> 
> 1. ioremap a 4K size, valid page table will build,
> 2. iounmap it, pte0 will set to 0;
> 3. ioremap the same address with 2M size, pgd/pmd is unchanged,
>    then set the a new value for pmd;
> 4. pte0 is leaked;
> 5. CPU may meet exception because the old pmd is still in TLB,
>    which will lead to kernel panic.
> 
> This panic is not reproducible on x86.  INVLPG, called from iounmap,
> purges all levels of entries associated with purged address on x86.
> x86 still has memory leak.
> 
> Add two interfaces, pud_free_pmd_page() and pmd_free_pte_page(),
> which clear a given pud/pmd entry and free up a page for the lower
> level entries.
> 
> This patch implements their stub functions on x86 and arm64, which
> work as workaround.
> 
> Reported-by: Lei Li <lious.lilei@hisilicon.com>
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Wang Xuefeng <wxf.wang@hisilicon.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Borislav Petkov <bp@suse.de>
> ---
>  arch/arm64/mm/mmu.c           |   10 ++++++++++
>  arch/x86/mm/pgtable.c         |   20 ++++++++++++++++++++
>  include/asm-generic/pgtable.h |   10 ++++++++++
>  lib/ioremap.c                 |    6 ++++--
>  4 files changed, 44 insertions(+), 2 deletions(-)

[...]

> diff --git a/lib/ioremap.c b/lib/ioremap.c
> index b808a390e4c3..54e5bbaa3200 100644
> --- a/lib/ioremap.c
> +++ b/lib/ioremap.c
> @@ -91,7 +91,8 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
>  
>  		if (ioremap_pmd_enabled() &&
>  		    ((next - addr) == PMD_SIZE) &&
> -		    IS_ALIGNED(phys_addr + addr, PMD_SIZE)) {
> +		    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
> +		    pmd_free_pte_page(pmd)) {

I find it a bit weird that we're postponing this to the subsequent map. If
we want to address the break-before-make issue that was causing a panic on
arm64, then I think it would be better to do this on the unmap path to avoid
duplicating TLB invalidation.

Will
