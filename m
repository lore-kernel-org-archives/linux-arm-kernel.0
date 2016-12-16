From: schwab@suse.de (Andreas Schwab)
Date: Fri, 16 Dec 2016 15:16:20 +0100
Subject: jemalloc testsuite stalls in memset
In-Reply-To: <20161216063940.GA1334@bbox> (Minchan Kim's message of "Fri, 16
 Dec 2016 15:39:40 +0900")
References: <mvmmvfy37g1.fsf@hawking.suse.de> <20161214235031.GA2912@bbox>
 <mvm4m2535pc.fsf@hawking.suse.de> <20161216063940.GA1334@bbox>
Message-ID: <87d1gshscr.fsf@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Dez 16 2016, Minchan Kim <minchan@kernel.org> wrote:

> Below helps?
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e10a4fe..dc37c9a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1611,6 +1611,7 @@ int madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  			tlb->fullmm);
>  		orig_pmd = pmd_mkold(orig_pmd);
>  		orig_pmd = pmd_mkclean(orig_pmd);
> +		orig_pmd = pmd_wrprotect(orig_pmd);
>  
>  		set_pmd_at(mm, addr, pmd, orig_pmd);
>  		tlb_remove_pmd_tlb_entry(tlb, pmd, addr);

Thanks, this fixes the issue (tested with 4.9).

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
