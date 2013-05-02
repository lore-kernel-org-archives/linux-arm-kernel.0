From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 May 2013 16:13:02 +0100
Subject: [PATCH v2 1/5] ARM: KVM: be more thorough when invalidating TLBs
In-Reply-To: <1367505542-2231-2-git-send-email-marc.zyngier@arm.com>
References: <1367505542-2231-1-git-send-email-marc.zyngier@arm.com>
 <1367505542-2231-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130502151302.GG20730@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 03:38:58PM +0100, Marc Zyngier wrote:
> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
> index f7793df..9e2d906c 100644
> --- a/arch/arm/kvm/interrupts.S
> +++ b/arch/arm/kvm/interrupts.S
...
> -static void clear_pte_entry(pte_t *pte)
> +static void clear_pte_entry(struct kvm *kvm, pte_t *pte, phys_addr_t addr)
>  {
>  	if (pte_present(*pte)) {
>  		kvm_set_pte(pte, __pte(0));
>  		put_page(virt_to_page(pte));
> +		kvm_tlb_flush_vmid_ipa(kvm, addr);
>  	}
>  }
...
>  static void unmap_stage2_range(struct kvm *kvm, phys_addr_t start, u64 size)
>  {
> -	unmap_range(kvm->arch.pgd, start, size);
> +	unmap_range(kvm, kvm->arch.pgd, start, size);
>  }
>  
>  /**
> @@ -413,6 +425,7 @@ void kvm_free_stage2_pgd(struct kvm *kvm)
>  		return;
>  
>  	unmap_stage2_range(kvm, 0, KVM_PHYS_SIZE);
> +	kvm_tlb_flush_vmid_ipa(kvm, 0);	/* Invalidate TLB ALL */

Do you still need this here if you invalidated each individual pte in
clear_pte_entry()? I think you can remove it from clear_pte_entry() and
just leave it here (more efficient probably) since you wouldn't free the
actual pages pointed at by the pte before unmapping.

>  	free_pages((unsigned long)kvm->arch.pgd, S2_PGD_ORDER);
>  	kvm->arch.pgd = NULL;
>  }
> @@ -675,7 +688,6 @@ static void handle_hva_to_gpa(struct kvm *kvm,
>  static void kvm_unmap_hva_handler(struct kvm *kvm, gpa_t gpa, void *data)
>  {
>  	unmap_stage2_range(kvm, gpa, PAGE_SIZE);
> -	kvm_tlb_flush_vmid_ipa(kvm, gpa);

Here you removed it relying on clear_pte_entry(), I think you could keep
it (see above).

-- 
Catalin
