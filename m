From: mhocko@kernel.org (Michal Hocko)
Date: Fri, 23 Dec 2016 10:17:25 +0100
Subject: [PATCH] mm: pmd dirty emulation in page fault handler
In-Reply-To: <20161222145203.GA18970@bbox>
References: <1482364101-16204-1-git-send-email-minchan@kernel.org>
 <20161222081713.GA32480@node.shutemov.name>
 <20161222145203.GA18970@bbox>
Message-ID: <20161223091725.GA23117@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 22-12-16 23:52:03, Minchan Kim wrote:
[...]
> >From b3ec95c0df91ad113525968a4a6b53030fd0b48d Mon Sep 17 00:00:00 2001
> From: Minchan Kim <minchan@kernel.org>
> Date: Thu, 22 Dec 2016 23:43:49 +0900
> Subject: [PATCH v2] mm: pmd dirty emulation in page fault handler
> 
> Andreas reported [1] made a test in jemalloc hang in THP mode in arm64.
> http://lkml.kernel.org/r/mvmmvfy37g1.fsf at hawking.suse.de
> 
> The problem is page fault handler supports only accessed flag emulation
> for THP page of SW-dirty/accessed architecture.
> 
> This patch enables dirty-bit emulation for those architectures.
> Without it, MADV_FREE makes application hang by repeated fault forever.

The changelog is rather terse and considering the issue is rather subtle
and it aims the stable tree I think it could see more information. How
do we end up looping in the page fault and why the dirty pmd stops it.
Could you update the changelog to be more verbose, please? I am still
digesting this patch but I believe it is correct fwiw...

Thanks!

> [1] b8d3c4c3009d, mm/huge_memory.c: don't split THP page when MADV_FREE syscall is called
> 
> Cc: Jason Evans <je@fb.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: linux-arch at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: <stable@vger.kernel.org> [4.5+]
> Fixes: b8d3c4c3009d ("mm/huge_memory.c: don't split THP page when MADV_FREE syscall is called")
> Reported-by: Andreas Schwab <schwab@suse.de>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
> * from v1
>   * Remove __handle_mm_fault part - Kirill
> 
>  mm/huge_memory.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 10eedbf..29ec8a4 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -883,15 +883,17 @@ void huge_pmd_set_accessed(struct vm_fault *vmf, pmd_t orig_pmd)
>  {
>  	pmd_t entry;
>  	unsigned long haddr;
> +	bool write = vmf->flags & FAULT_FLAG_WRITE;
>  
>  	vmf->ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
>  	if (unlikely(!pmd_same(*vmf->pmd, orig_pmd)))
>  		goto unlock;
>  
>  	entry = pmd_mkyoung(orig_pmd);
> +	if (write)
> +		entry = pmd_mkdirty(entry);
>  	haddr = vmf->address & HPAGE_PMD_MASK;
> -	if (pmdp_set_access_flags(vmf->vma, haddr, vmf->pmd, entry,
> -				vmf->flags & FAULT_FLAG_WRITE))
> +	if (pmdp_set_access_flags(vmf->vma, haddr, vmf->pmd, entry, write))
>  		update_mmu_cache_pmd(vmf->vma, vmf->address, vmf->pmd);
>  
>  unlock:
> -- 
> 2.7.4
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo at kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email at kvack.org </a>

-- 
Michal Hocko
SUSE Labs
