From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 8 Jun 2014 14:05:02 +0200
Subject: [PATCH v7 1/4] arm: add ARMv7 HYP API to flush VM TLBs without
 address param
In-Reply-To: <1401837567-5527-2-git-send-email-m.smarduch@samsung.com>
References: <1401837567-5527-1-git-send-email-m.smarduch@samsung.com>
 <1401837567-5527-2-git-send-email-m.smarduch@samsung.com>
Message-ID: <20140608120502.GE3279@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 04:19:24PM -0700, Mario Smarduch wrote:
> Patch adds HYP interface for global VM TLB invalidation without address
> parameter. Added ARM version of kvm_flush_remote_tlbs(), made the generic
> implementation a weak symbol.
> 
> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
> ---
>  arch/arm/include/asm/kvm_asm.h |    1 +
>  arch/arm/kvm/interrupts.S      |   11 +++++++++++
>  arch/arm/kvm/mmu.c             |   14 ++++++++++++++
>  virt/kvm/kvm_main.c            |    2 +-
>  4 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
> index 53b3c4a..21bc519 100644
> --- a/arch/arm/include/asm/kvm_asm.h
> +++ b/arch/arm/include/asm/kvm_asm.h
> @@ -78,6 +78,7 @@ extern char __kvm_hyp_code_end[];
>  
>  extern void __kvm_flush_vm_context(void);
>  extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
> +extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
>  
>  extern int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
>  #endif
> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
> index 0d68d40..bddc66b 100644
> --- a/arch/arm/kvm/interrupts.S
> +++ b/arch/arm/kvm/interrupts.S
> @@ -66,6 +66,17 @@ ENTRY(__kvm_tlb_flush_vmid_ipa)
>  	bx	lr
>  ENDPROC(__kvm_tlb_flush_vmid_ipa)
>  
> +/**
> + * void __kvm_tlb_flush_vmid(struct kvm *kvm) - Flush per-VMID TLBs
> + *
> + * Reuses __kvm_tlb_flush_vmid_ipa() for ARMv7, without passing address
> + * parameter
> + */
> +
> +ENTRY(__kvm_tlb_flush_vmid)
> +	b	__kvm_tlb_flush_vmid_ipa
> +ENDPROC(__kvm_tlb_flush_vmid)
> +
>  /********************************************************************
>   * Flush TLBs and instruction caches of all CPUs inside the inner-shareable
>   * domain, for all VMIDs
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 2ac9588..ef29540 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -56,6 +56,20 @@ static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
>  		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, kvm, ipa);
>  }
>  
> +/**
> + * kvm_flush_remote_tlbs() - flush all VM TLB entries
> + * @kvm:       pointer to kvm structure.
> + *
> + * Interface to HYP function to flush all VM TLB entries without address
> + * parameter. In HYP mode reuses __kvm_tlb_flush_vmid_ipa() function used by
> + * kvm_tlb_flush_vmid_ipa().
> + */
> +void kvm_flush_remote_tlbs(struct kvm *kvm)
> +{
> +	if (kvm)
> +		kvm_call_hyp(__kvm_tlb_flush_vmid, kvm);
> +}
> +
>  static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
>  				  int min, int max)
>  {
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index fa70c6e..ba25765 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -184,7 +184,7 @@ static bool make_all_cpus_request(struct kvm *kvm, unsigned int req)
>  	return called;
>  }
>  
> -void kvm_flush_remote_tlbs(struct kvm *kvm)
> +void __weak kvm_flush_remote_tlbs(struct kvm *kvm)
>  {
>  	long dirty_count = kvm->tlbs_dirty;
>  
> -- 
> 1.7.9.5
> 

This doesn't build or link on aarch64 :(

-Christoffer
