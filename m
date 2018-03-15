From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Mar 2018 13:31:58 +0000
Subject: [PATCH v2 2/4] ioremap: Implement TLB_INV before huge mapping
In-Reply-To: <1521117906-20107-3-git-send-email-cpandya@codeaurora.org>
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
 <1521117906-20107-3-git-send-email-cpandya@codeaurora.org>
Message-ID: <20180315133157.ucbdg25jo5ew3t2h@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 06:15:04PM +0530, Chintan Pandya wrote:
> @@ -91,10 +93,15 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
>  
>  		if (ioremap_pmd_enabled() &&
>  		    ((next - addr) == PMD_SIZE) &&
> -		    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
> -		    pmd_free_pte_page(pmd)) {
> -			if (pmd_set_huge(pmd, phys_addr + addr, prot))
> +		    IS_ALIGNED(phys_addr + addr, PMD_SIZE)) {
> +			old_pmd = *pmd;
> +			pmd_clear(pmd);
> +			flush_tlb_pgtable(&init_mm, addr);
> +			if (pmd_set_huge(pmd, phys_addr + addr, prot)) {
> +				pmd_free_pte_page(&old_pmd);
>  				continue;
> +			} else
> +				set_pmd(pmd, old_pmd);
>  		}
>  

Can we have something like a pmd_can_set_huge() helper? Then we could
avoid pointless modification and TLB invalidation work when
pmd_set_huge() will fail.

	if (ioremap_pmd_enabled() &&
	    ((next - addr) == PMD_SIZE) &&
	    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
	    pmd_can_set_huge(pmd, phys_addr + addr, prot)) {
	    	// clear entries, invalidate TLBs, and free tables
		...
		continue;

	}

Thanks,
MArk.
