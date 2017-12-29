From: guohanjun@huawei.com (Hanjun Guo)
Date: Fri, 29 Dec 2017 16:00:25 +0800
Subject: [RFC patch] ioremap: don't set up huge I/O mappings when
 p4d/pud/pmd is zero
In-Reply-To: <1514460261-65222-1-git-send-email-guohanjun@huawei.com>
References: <1514460261-65222-1-git-send-email-guohanjun@huawei.com>
Message-ID: <17c8384a-7748-3acc-a56f-78698087560a@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

oops, the title of this patch is wrong, should be:
ioremap: skip setting up huge I/O mappings when p4d/pud/pmd is zero

On 2017/12/28 19:24, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> When we using iounmap() to free the 4K mapping, it just clear the PTEs
> but leave P4D/PUD/PMD unchanged, also will not free the memory of page
> tables.
> 
> This will cause issues on ARM64 platform (not sure if other archs have
> the same issue) for this case:
> 
> 1. ioremap a 4K size, valid page table will build,
> 2. iounmap it, pte0 will set to 0;
> 3. ioremap the same address with 2M size, pgd/pmd is unchanged,
>    then set the a new value for pmd;
> 4. pte0 is leaked;
> 5. CPU may meet exception because the old pmd is still in TLB,
>    which will lead to kernel panic.
> 
> Fix it by skip setting up the huge I/O mappings when p4d/pud/pmd is
> zero.
> 
> Reported-by: Lei Li <lious.lilei@hisilicon.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Toshi Kani <toshi.kani@hpe.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Xuefeng Wang <wxf.wang@hisilicon.com>
> ---
> 
> Not sure if this is the right direction, this patch has a obvious
> side effect that a mapped address with 4K will not back to 2M.  I may
> miss something and just wrong, so this is just a RFC version, comments
> are welcomed.
> 
>  lib/ioremap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/ioremap.c b/lib/ioremap.c
> index b808a39..4e6f19a 100644
> --- a/lib/ioremap.c
> +++ b/lib/ioremap.c
> @@ -89,7 +89,7 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
>  	do {
>  		next = pmd_addr_end(addr, end);
>  
> -		if (ioremap_pmd_enabled() &&
> +		if (ioremap_pmd_enabled() && pmd_none(*pmd) &&
>  		    ((next - addr) == PMD_SIZE) &&
>  		    IS_ALIGNED(phys_addr + addr, PMD_SIZE)) {
>  			if (pmd_set_huge(pmd, phys_addr + addr, prot))
> @@ -115,7 +115,7 @@ static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
>  	do {
>  		next = pud_addr_end(addr, end);
>  
> -		if (ioremap_pud_enabled() &&
> +		if (ioremap_pud_enabled() && pud_none(*pud) &&
>  		    ((next - addr) == PUD_SIZE) &&
>  		    IS_ALIGNED(phys_addr + addr, PUD_SIZE)) {
>  			if (pud_set_huge(pud, phys_addr + addr, prot))
> @@ -141,7 +141,7 @@ static inline int ioremap_p4d_range(pgd_t *pgd, unsigned long addr,
>  	do {
>  		next = p4d_addr_end(addr, end);
>  
> -		if (ioremap_p4d_enabled() &&
> +		if (ioremap_p4d_enabled() && p4d_none(*p4d) &&
>  		    ((next - addr) == P4D_SIZE) &&
>  		    IS_ALIGNED(phys_addr + addr, P4D_SIZE)) {
>  			if (p4d_set_huge(p4d, phys_addr + addr, prot))
> 
