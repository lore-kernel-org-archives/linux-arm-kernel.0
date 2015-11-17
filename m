From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Nov 2015 15:25:58 +0000
Subject: [RFC PATCH] arm64: use non-global mappings for UEFI runtime
 regions
In-Reply-To: <1447750411-6424-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1447750411-6424-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151117152558.GK12586@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 09:53:31AM +0100, Ard Biesheuvel wrote:
> As pointed out by Russell King in response to the proposed ARM version
> of this code, the sequence to switch between the UEFI runtime mapping
> and current's actual userland mapping (and vice versa) is potentially
> unsafe, since it leaves a time window between the switch to the new
> page tables and the TLB flush where speculative accesses may hit on
> stale global TLB entries.

Wow, annoying that we missed that.

> So instead, use non-global mappings, and perform the switch via the
> ordinary ASID-aware context switch routines.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

>From digging into the way the ASID allocator works, I believe this is
correct. FWIW:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

For backporting, I'm not sure that this is necessarily safe prior to
Will's rework of the ASID allocator. I think we can IPI in this context,
and it looks like the cpu_set_reserved_ttbr0() in flush_context() would
save us from the problem described above, but I may have missed
something.

Will, are you aware of anything that could bite us here?

Mark.

> ---
>  arch/arm64/include/asm/mmu_context.h |  2 +-
>  arch/arm64/kernel/efi.c              | 14 +++++---------
>  2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index c0e87898ba96..24165784b803 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -101,7 +101,7 @@ static inline void cpu_set_default_tcr_t0sz(void)
>  #define destroy_context(mm)		do { } while(0)
>  void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
>  
> -#define init_new_context(tsk,mm)	({ atomic64_set(&mm->context.id, 0); 0; })
> +#define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.id, 0); 0; })
>  
>  /*
>   * This is called when "tsk" is about to enter lazy TLB mode.
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index de46b50f4cdf..fc5508e0df57 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -224,6 +224,8 @@ static bool __init efi_virtmap_init(void)
>  {
>  	efi_memory_desc_t *md;
>  
> +	init_new_context(NULL, &efi_mm);
> +
>  	for_each_efi_memory_desc(&memmap, md) {
>  		u64 paddr, npages, size;
>  		pgprot_t prot;
> @@ -254,7 +256,8 @@ static bool __init efi_virtmap_init(void)
>  		else
>  			prot = PAGE_KERNEL;
>  
> -		create_pgd_mapping(&efi_mm, paddr, md->virt_addr, size, prot);
> +		create_pgd_mapping(&efi_mm, paddr, md->virt_addr, size,
> +				   __pgprot(pgprot_val(prot) | PTE_NG));
>  	}
>  	return true;
>  }
> @@ -329,14 +332,7 @@ core_initcall(arm64_dmi_init);
>  
>  static void efi_set_pgd(struct mm_struct *mm)
>  {
> -	if (mm == &init_mm)
> -		cpu_set_reserved_ttbr0();
> -	else
> -		cpu_switch_mm(mm->pgd, mm);
> -
> -	local_flush_tlb_all();
> -	if (icache_is_aivivt())
> -		__local_flush_icache_all();
> +	switch_mm(NULL, mm, NULL);
>  }
>  
>  void efi_virtmap_load(void)
> -- 
> 1.9.1
> 
