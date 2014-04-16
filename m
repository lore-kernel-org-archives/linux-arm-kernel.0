From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Apr 2014 08:51:44 +0100
Subject: [PATCH] Fix for the arm64 kern_addr_valid() function
In-Reply-To: <1397584404-28762-1-git-send-email-anderson@redhat.com>
References: <1397584404-28762-1-git-send-email-anderson@redhat.com>
Message-ID: <20140416075144.GA29754@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Tue, Apr 15, 2014 at 06:53:24PM +0100, Dave Anderson wrote:
>  Fix for the arm64 kern_addr_valid() function to recognize
>  virtual addresses in the kernel logical memory map.  The
>  function fails as written because it does not check whether
>  the addresses in that region are mapped at the pmd level to
>  2MB or 512MB pages, continues the page table walk to the
>  pte level, and issues a garbage value to pfn_valid().
> 
>  Tested on 4K-page and 64K-page kernels.
> 
> Signed-off-by: Dave Anderson <anderson@redhat.com>
> ---
>  arch/arm64/mm/mmu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 6b7e895..0a472c4 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -374,6 +374,9 @@ int kern_addr_valid(unsigned long addr)
>  	if (pmd_none(*pmd))
>  		return 0;
>  
> +	if (pmd_sect(*pmd))
> +		return pfn_valid(pmd_pfn(*pmd));
> +
>  	pte = pte_offset_kernel(pmd, addr);
>  	if (pte_none(*pte))
>  		return 0;

Whilst this patch looks fine to me, I wonder whether walking the page tables
is really necessary for this function? The only user is fs/proc/kcore.c,
which basically wants to know if a lowmem address is actually backed by
physical memory. Our current implementation of kern_addr_valid will return
true even for MMIO mappings, whilst I think we could actually just do
something like:


	if ((((long)addr) >> VA_BITS) != -1UL)
		return 0;

	return pfn_valid(__pa(addr) >> PAGE_SHIFT);


Am I missing something here?

Will
