From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 6 May 2015 11:51:03 +0100
Subject: Memory size unaligned to section boundary
In-Reply-To: <20150506101104.GD2067@n2100.arm.linux.org.uk>
References: <a865bd68d706f8c4c9e82a374ff6adc4@agner.ch>
 <20150506101104.GD2067@n2100.arm.linux.org.uk>
Message-ID: <20150506105102.GB5382@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 11:11:05AM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 23, 2015 at 03:19:45PM +0200, Stefan Agner wrote:
> > I dug a bit more into that, and it unveiled that when creating the
> > mapping for the non-kernel_x part (if (kernel_x_end < end) in
> > map_lowmem), the unaligned section at the end leads to the freeze. In
> > alloc_init_pmd, if the memory end is section unaligned, alloc_init_pte
> > gets called which allocates a PTE outside of the initialized region (in
> > early_alloc_aligned). The system freezes at the call of memset in
> > early_alloc_aligned function.
[...]
> Right, and the question is why does that happen - and the answer is
> this:
> 
>         /*
>          * Round the memblock limit down to a section size.  This
>          * helps to ensure that we will allocate memory from the
>          * last full section, which should be mapped.
>          */
>         if (memblock_limit)
>                 memblock_limit = round_down(memblock_limit, SECTION_SIZE);
> 
> That should round down by 2x SECTION_SIZE to ensure that we don't start
> allocating the L2 page table in a section which isn't mapped.  Please
> try this patch:
> 
>  arch/arm/mm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 4e6ef896c619..387becac5c86 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1142,7 +1142,7 @@ void __init sanity_check_meminfo(void)
>  	 * last full section, which should be mapped.
>  	 */
>  	if (memblock_limit)
> -		memblock_limit = round_down(memblock_limit, SECTION_SIZE);
> +		memblock_limit = round_down(memblock_limit, 2 * SECTION_SIZE);

Why not PMD_SIZE? We don't need 4MB round down with LPAE.

-- 
Catalin
