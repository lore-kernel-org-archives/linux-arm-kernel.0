From: qiuxishi@huawei.com (Xishi Qiu)
Date: Thu, 5 Nov 2015 18:15:14 +0800
Subject: [PATCH 1/2] arm64: Get existing page protections in split_pmd
In-Reply-To: <1446587315-18145-2-git-send-email-labbott@fedoraproject.org>
References: <1446587315-18145-1-git-send-email-labbott@fedoraproject.org>
 <1446587315-18145-2-git-send-email-labbott@fedoraproject.org>
Message-ID: <563B2C32.10307@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/11/4 5:48, Laura Abbott wrote:

> 
> Rather than always putting the least restrictived permissions
> (PAGE_KERNEL_EXEC) when spliting a pmd into pages, use
> the existing permissions from the pmd for the page.
> 
> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
> ---
>  arch/arm64/mm/mmu.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 9211b85..ff41efa 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -75,14 +75,13 @@ static void __init *early_alloc(unsigned long sz)
>  static void split_pmd(pmd_t *pmd, pte_t *pte)
>  {
>  	unsigned long pfn = pmd_pfn(*pmd);
> +	unsigned long addr = pfn << PAGE_SHIFT;
> +	pgprot_t prot = __pgprot(pmd_val(*pmd) ^ addr) | PTE_TYPE_PAGE;
> +

Hi Laura,

I'm not quite understand, I find split_pud() doesn't set the flag
PMD_TYPE_TABLE. If we clear xx_TABLE_BIT, does that means the page
is large page? 
And what is the different from the flag xx_TYPE_SECT?

Thanks,
Xishi Qiu

>  	int i = 0;
>  
>  	do {
> -		/*
> -		 * Need to have the least restrictive permissions available
> -		 * permissions will be fixed up later
> -		 */
> -		set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));
> +		set_pte(pte, pfn_pte(pfn, prot));

>  		pfn++;
>  	} while (pte++, i++, i < PTRS_PER_PTE);
>  }
