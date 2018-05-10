From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 10 May 2018 18:11:35 +0100
Subject: [PATCH v3 1/8] arm/arm64: KVM: Formalise end of direct linear map
In-Reply-To: <20180510162347.3858-2-steve.capper@arm.com>
References: <20180510162347.3858-1-steve.capper@arm.com>
 <20180510162347.3858-2-steve.capper@arm.com>
Message-ID: <9272dd72-7bc9-daf9-2386-ceca04384c1c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+Christoffer]

Hi Steve,

On 10/05/18 17:23, Steve Capper wrote:
> We assume that the direct linear map ends at ~0 in the KVM HYP map
> intersection checking code. This assumption will become invalid later on
> for arm64 when the address space of the kernel is re-arranged.
> 
> This patch introduces a new constant PAGE_OFFSET_END for both arm and
> arm64 and defines it to be ~0UL
> 
> Signed-off-by: Steve Capper <steve.capper@arm.com>
> ---
>  arch/arm/include/asm/memory.h   | 1 +
>  arch/arm64/include/asm/memory.h | 1 +
>  virt/kvm/arm/mmu.c              | 4 ++--
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index ed8fd0d19a3e..45c211fd50da 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -24,6 +24,7 @@
>  
>  /* PAGE_OFFSET - the virtual address of the start of the kernel image */
>  #define PAGE_OFFSET		UL(CONFIG_PAGE_OFFSET)
> +#define PAGE_OFFSET_END		(~0UL)
>  
>  #ifdef CONFIG_MMU
>  
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 49d99214f43c..c5617cbbf1ff 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -61,6 +61,7 @@
>  	(UL(1) << VA_BITS) + 1)
>  #define PAGE_OFFSET		(UL(0xffffffffffffffff) - \
>  	(UL(1) << (VA_BITS - 1)) + 1)
> +#define PAGE_OFFSET_END		(~0UL)
>  #define KIMAGE_VADDR		(MODULES_END)
>  #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)
>  #define MODULES_VADDR		(VA_START + KASAN_SHADOW_SIZE)
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 7f6a944db23d..22af347d65f1 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1927,10 +1927,10 @@ int kvm_mmu_init(void)
>  	kvm_debug("IDMAP page: %lx\n", hyp_idmap_start);
>  	kvm_debug("HYP VA range: %lx:%lx\n",
>  		  kern_hyp_va(PAGE_OFFSET),
> -		  kern_hyp_va((unsigned long)high_memory - 1));
> +		  kern_hyp_va(PAGE_OFFSET_END));
>  
>  	if (hyp_idmap_start >= kern_hyp_va(PAGE_OFFSET) &&
> -	    hyp_idmap_start <  kern_hyp_va((unsigned long)high_memory - 1) &&
> +	    hyp_idmap_start <  kern_hyp_va(PAGE_OFFSET_END) &&

This doesn't feel right to me now that we have the HYP randomization
code merged. The way kern_hyp_va works now is only valid for addresses
between VA(memblock_start_of_DRAM()) and high_memory.

I fear that you could trigger the failing condition below as you
evaluate the idmap address against something that is now not a HYP VA.

>  	    hyp_idmap_start != (unsigned long)__hyp_idmap_text_start) {
>  		/*
>  		 * The idmap page is intersecting with the VA space,
> 

I'd appreciate if you could keep me cc'd on this series.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
