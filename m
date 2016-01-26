From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 Jan 2016 11:14:39 +0000
Subject: [RFC][PATCH 2/4] arm64: Add option to force mapping with
 PAGE_SIZE pages
In-Reply-To: <1453740735-17898-3-git-send-email-labbott@fedoraproject.org>
References: <1453740735-17898-1-git-send-email-labbott@fedoraproject.org>
 <1453740735-17898-3-git-send-email-labbott@fedoraproject.org>
Message-ID: <20160126111438.GA5059@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 25, 2016 at 08:52:13AM -0800, Laura Abbott wrote:
> Under some circumstances (e.g. debugging) it may be useful to have all
> kernel memory mapped using PAGE_SIZE pages. Add an option for this.
> 
> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
> ---
>  arch/arm64/Kconfig  | 11 +++++++++++
>  arch/arm64/mm/mmu.c | 10 +++++++---
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index ffa3c54..faf7eac 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -504,6 +504,17 @@ config HOTPLUG_CPU
>  	  Say Y here to experiment with turning CPUs off and on.  CPUs
>  	  can be controlled through /sys/devices/system/cpu.
>  
> +config FORCE_PAGES
> +	bool "Force all memory mappings to be PAGE_SIZE"
> +	help
> +	  For performance reasons, kernel memory may be mapped with
> +	  page table entries larger than the expected PAGE_SIZE. This results
> +	  in better TLB performance but prevents adjustment of page table
> +	  attributes at runtime. Say Y here to have all kernel memory mapped
> +	  with PAGE_SIZE entries.
> +
> +	  If unsure, say N.
> +

I think we can make this a boot-time option, given that we're simply
flipping a boolean that only directly affects a small amount of boot
code. I doubt there would be a noticeable overhead, and it makes it more
likely that we can use this to debug production kernels.

Is there a usecase other than DEBUG_PAGEALLOC that you have in mind? If
not, we could just hang this off of debug_pagealloc_enabled(), as we
parse the early params before we create the usual page tables.

Thanks,
Mark.

>  source kernel/Kconfig.preempt
>  source kernel/Kconfig.hz
>  
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 2d6e7cf..450d38a 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -181,7 +181,8 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
>  	do {
>  		next = pmd_addr_end(addr, end);
>  		/* try section mapping first */
> -		if (((addr | next | phys) & ~SECTION_MASK) == 0) {
> +		if (((addr | next | phys) & ~SECTION_MASK) == 0 &&
> +		      (!IS_ENABLED(CONFIG_FORCE_PAGES) || !pgtable_alloc)) {
>  			pmd_t old_pmd =*pmd;
>  			set_pmd(pmd, __pmd(phys |
>  					   pgprot_val(mk_sect_prot(prot))));
> @@ -208,8 +209,11 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
>  }
>  
>  static inline bool use_1G_block(unsigned long addr, unsigned long next,
> -			unsigned long phys)
> +			unsigned long phys, phys_addr_t (*pgtable_alloc)(void))
>  {
> +	if (pgtable_alloc && IS_ENABLED(CONFIG_FORCE_PAGES))
> +		return false;
> +
>  	if (PAGE_SHIFT != 12)
>  		return false;
>  
> @@ -241,7 +245,7 @@ static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
>  		/*
>  		 * For 4K granule only, attempt to put down a 1GB block
>  		 */
> -		if (use_1G_block(addr, next, phys)) {
> +		if (use_1G_block(addr, next, phys, pgtable_alloc)) {
>  			pud_t old_pud = *pud;
>  			set_pud(pud, __pud(phys |
>  					   pgprot_val(mk_sect_prot(prot))));
> -- 
> 2.5.0
> 
