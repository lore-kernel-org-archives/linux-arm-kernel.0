From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 03 Dec 2015 11:45:49 +0300
Subject: [PATCH v2] ARM/arm64: KVM: correct PTE uncachedness check
In-Reply-To: <1449131122-29186-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1449131122-29186-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <008901d12da7$033469d0$099d3d70$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Tested-by: Pavel Fedin <p.fedin@samsung.com>

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia


> -----Original Message-----
> From: Ard Biesheuvel [mailto:ard.biesheuvel at linaro.org]
> Sent: Thursday, December 03, 2015 11:25 AM
> To: linux-arm-kernel at lists.infradead.org; kvmarm at lists.cs.columbia.edu;
> christoffer.dall at linaro.org; p.fedin at samsung.com
> Cc: Ard Biesheuvel
> Subject: [PATCH v2] ARM/arm64: KVM: correct PTE uncachedness check
> 
> Commit e6fab5442345 ("ARM/arm64: KVM: test properly for a PTE's
> uncachedness") modified the logic to test whether a HYP or stage-2
> mapping needs flushing, from [incorrectly] interpreting the page table
> attributes to [incorrectly] checking whether the PFN that backs the
> mapping is covered by host system RAM. The PFN number is part of the
> output of the translation, not the input, so we have to use pte_pfn()
> on the contents of the PTE, not __phys_to_pfn() on the HYP virtual
> address or stage-2 intermediate physical address.
> 
> Fixes: e6fab5442345 ("ARM/arm64: KVM: test properly for a PTE's uncachedness")
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/kvm/mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 7dace909d5cf..61d96a645ff3 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -218,7 +218,7 @@ static void unmap_ptes(struct kvm *kvm, pmd_t *pmd,
>  			kvm_tlb_flush_vmid_ipa(kvm, addr);
> 
>  			/* No need to invalidate the cache for device mappings */
> -			if (!kvm_is_device_pfn(__phys_to_pfn(addr)))
> +			if (!kvm_is_device_pfn(pte_pfn(old_pte)))
>  				kvm_flush_dcache_pte(old_pte);
> 
>  			put_page(virt_to_page(pte));
> @@ -310,7 +310,7 @@ static void stage2_flush_ptes(struct kvm *kvm, pmd_t *pmd,
> 
>  	pte = pte_offset_kernel(pmd, addr);
>  	do {
> -		if (!pte_none(*pte) && !kvm_is_device_pfn(__phys_to_pfn(addr)))
> +		if (!pte_none(*pte) && !kvm_is_device_pfn(pte_pfn(*pte)))
>  			kvm_flush_dcache_pte(*pte);
>  	} while (pte++, addr += PAGE_SIZE, addr != end);
>  }
> --
> 1.9.1
