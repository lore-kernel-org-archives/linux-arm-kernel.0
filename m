From: qiuxishi@huawei.com (Xishi Qiu)
Date: Thu, 5 Nov 2015 19:29:50 +0800
Subject: [PATCH 2/2] arm64: Allow changing of attributes outside of modules
In-Reply-To: <1446587315-18145-3-git-send-email-labbott@fedoraproject.org>
References: <1446587315-18145-1-git-send-email-labbott@fedoraproject.org>
 <1446587315-18145-3-git-send-email-labbott@fedoraproject.org>
Message-ID: <563B3DAE.10405@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/11/4 5:48, Laura Abbott wrote:

> 
> Currently, the set_memory_* functions that are implemented for arm64
> are restricted to module addresses only. This was mostly done
> because arm64 maps normal zone memory with larger page sizes to
> improve TLB performance. This has the side effect though of making it
> difficult to adjust attributes at the PAGE_SIZE granularity. There are
> an increasing number of use cases related to security where it is
> necessary to change the attributes of kernel memory. Add functionality
> to the page attribute changing code under a Kconfig to let systems
> designers decide if they want to make the trade off of security for TLB
> pressure.
> 
> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
> ---
>  arch/arm64/Kconfig.debug | 11 +++++++
>  arch/arm64/mm/mm.h       |  3 ++
>  arch/arm64/mm/mmu.c      |  2 +-
>  arch/arm64/mm/pageattr.c | 74 ++++++++++++++++++++++++++++++++++++++++++++----
>  4 files changed, 84 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
> index d6285ef..abc6922 100644
> --- a/arch/arm64/Kconfig.debug
> +++ b/arch/arm64/Kconfig.debug
> @@ -89,6 +89,17 @@ config DEBUG_ALIGN_RODATA
>  
>  	  If in doubt, say N
>  
> +config DEBUG_CHANGE_PAGEATTR
> +	bool "Allow all kernel memory to have attributes changed"
> +	help
> +	  If this option is selected, APIs that change page attributes
> +	  (RW <-> RO, X <-> NX) will be valid for all memory mapped in
> +	  the kernel space. The trade off is that there may be increased
> +	  TLB pressure from finer grained page mapping. Turn on this option
> +	  if performance is more important than security
> +
> +	  If in doubt, say N
> +
>  source "drivers/hwtracing/coresight/Kconfig"
>  
>  endmenu
> diff --git a/arch/arm64/mm/mm.h b/arch/arm64/mm/mm.h
> index ef47d99..7b0dcc4 100644
> --- a/arch/arm64/mm/mm.h
> +++ b/arch/arm64/mm/mm.h
> @@ -1,3 +1,6 @@
>  extern void __init bootmem_init(void);
>  
>  void fixup_init(void);
> +
> +void split_pud(pud_t *old_pud, pmd_t *pmd);
> +void split_pmd(pmd_t *pmd, pte_t *pte);
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index ff41efa..cefad2d 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -72,7 +72,7 @@ static void __init *early_alloc(unsigned long sz)
>  /*
>   * remap a PMD into pages
>   */
> -static void split_pmd(pmd_t *pmd, pte_t *pte)
> +void split_pmd(pmd_t *pmd, pte_t *pte)
>  {
>  	unsigned long pfn = pmd_pfn(*pmd);
>  	unsigned long addr = pfn << PAGE_SHIFT;
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index e47ed1c..48a4ce9 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -15,9 +15,12 @@
>  #include <linux/module.h>
>  #include <linux/sched.h>
>  
> +#include <asm/pgalloc.h>
>  #include <asm/pgtable.h>
>  #include <asm/tlbflush.h>
>  
> +#include "mm.h"
> +
>  struct page_change_data {
>  	pgprot_t set_mask;
>  	pgprot_t clear_mask;
> @@ -36,6 +39,66 @@ static int change_page_range(pte_t *ptep, pgtable_t token, unsigned long addr,
>  	return 0;
>  }
>  
> +#ifdef CONFIG_DEBUG_CHANGE_PAGEATTR
> +static int check_address(unsigned long addr)
> +{
> +	pgd_t *pgd = pgd_offset_k(addr);
> +	pud_t *pud;
> +	pmd_t *pmd;
> +	pte_t *pte;
> +	int ret = -EFAULT;
> +
> +	if (pgd_none(*pgd))
> +		goto out;
> +
> +	pud = pud_offset(pgd, addr);
> +	if (pud_none(*pud))
> +		goto out;
> +
> +	if (pud_sect(*pud)) {
> +		pmd = pmd_alloc_one(&init_mm, addr);
> +		if (!pmd) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		split_pud(pud, pmd);
> +		pud_populate(&init_mm, pud, pmd);
> +	}
> +
> +	pmd = pmd_offset(pud, addr);
> +	if (pmd_none(*pmd))
> +		goto out;
> +
> +	if (pmd_sect(*pmd)) {
> +		pte = pte_alloc_one_kernel(&init_mm, addr);
> +		if (!pte) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		split_pmd(pmd, pte);
> +		__pmd_populate(pmd, __pa(pte), PMD_TYPE_TABLE);
> +	}
> +
> +	pte = pte_offset_kernel(pmd, addr);
> +	if (pte_none(*pte))
> +		goto out;
> +
> +	flush_tlb_all();
> +	ret = 0;
> +
> +out:
> +	return ret;
> +}
> +#else
> +static int check_address(unsigned long addr)
> +{
> +	if (addr < MODULES_VADDR || addr >= MODULES_END)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +#endif
> +
>  static int change_memory_common(unsigned long addr, int numpages,
>  				pgprot_t set_mask, pgprot_t clear_mask)
>  {
> @@ -45,17 +108,18 @@ static int change_memory_common(unsigned long addr, int numpages,
>  	int ret;
>  	struct page_change_data data;
>  
> +	if (addr < PAGE_OFFSET && !is_vmalloc_addr((void *)addr))
> +		return -EINVAL;
> +
>  	if (!IS_ALIGNED(addr, PAGE_SIZE)) {
>  		start &= PAGE_MASK;
>  		end = start + size;
>  		WARN_ON_ONCE(1);
>  	}
>  
> -	if (start < MODULES_VADDR || start >= MODULES_END)
> -		return -EINVAL;
> -
> -	if (end < MODULES_VADDR || end >= MODULES_END)
> -		return -EINVAL;
> +	ret = check_address(addr);

Hi Laura,

We only split the first page here, if the numpages is not 1, it's
wrong, right?

Thanks,
Xishi Qiu

> +	if (ret)
> +		return ret;
>  
>  	data.set_mask = set_mask;
>  	data.clear_mask = clear_mask;
