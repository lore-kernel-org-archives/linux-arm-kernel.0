From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 11 Aug 2014 21:12:49 +0200
Subject: [PATCH v9 1/4] arm: add ARMv7 HYP API to flush VM TLBs, change
 generic TLB flush to support arch flush
In-Reply-To: <1406249768-25315-2-git-send-email-m.smarduch@samsung.com>
References: <1406249768-25315-1-git-send-email-m.smarduch@samsung.com>
 <1406249768-25315-2-git-send-email-m.smarduch@samsung.com>
Message-ID: <20140811191249.GF10550@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 05:56:05PM -0700, Mario Smarduch wrote:
> Patch adds HYP interface for global VM TLB invalidation without address
> parameter. Generic VM TLB flush calls ARMv7 arch defined TLB flush function.
> 
> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
> ---
>  arch/arm/include/asm/kvm_asm.h  |    1 +
>  arch/arm/include/asm/kvm_host.h |    1 +
>  arch/arm/kvm/Kconfig            |    1 +
>  arch/arm/kvm/interrupts.S       |   12 ++++++++++++
>  arch/arm/kvm/mmu.c              |   17 +++++++++++++++++
>  virt/kvm/Kconfig                |    3 +++
>  virt/kvm/kvm_main.c             |    4 ++++
>  7 files changed, 39 insertions(+)
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
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 193ceaf..042206f 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -230,5 +230,6 @@ int kvm_perf_teardown(void);
>  
>  u64 kvm_arm_timer_get_reg(struct kvm_vcpu *, u64 regid);
>  int kvm_arm_timer_set_reg(struct kvm_vcpu *, u64 regid, u64 value);
> +void kvm_arch_flush_remote_tlbs(struct kvm *);
>  
>  #endif /* __ARM_KVM_HOST_H__ */
> diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
> index 466bd29..44d3b6f 100644
> --- a/arch/arm/kvm/Kconfig
> +++ b/arch/arm/kvm/Kconfig
> @@ -22,6 +22,7 @@ config KVM
>  	select ANON_INODES
>  	select HAVE_KVM_CPU_RELAX_INTERCEPT
>  	select KVM_MMIO
> +	select HAVE_KVM_ARCH_TLB_FLUSH_ALL
>  	select KVM_ARM_HOST
>  	depends on ARM_VIRT_EXT && ARM_LPAE
>  	---help---
> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
> index 0d68d40..1258d46 100644
> --- a/arch/arm/kvm/interrupts.S
> +++ b/arch/arm/kvm/interrupts.S
> @@ -66,6 +66,18 @@ ENTRY(__kvm_tlb_flush_vmid_ipa)
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
> +
>  /********************************************************************
>   * Flush TLBs and instruction caches of all CPUs inside the inner-shareable
>   * domain, for all VMIDs
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 2ac9588..35254c6 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -56,6 +56,23 @@ static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
>  		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, kvm, ipa);
>  }
>  
> +#ifdef CONFIG_ARM

I assume this is here because of arm vs. arm64, use static inlines in
the header files to differentiate instead.

> +/**
> + * kvm_arch_flush_remote_tlbs() - flush all VM TLB entries
> + * @kvm:       pointer to kvm structure.
> + *
> + * Interface to HYP function to flush all VM TLB entries without address
> + * parameter. In HYP mode reuses __kvm_tlb_flush_vmid_ipa() function used by
> + * kvm_tlb_flush_vmid_ipa().

remove the last sentence from here, it's repetitive.

> + */
> +void kvm_arch_flush_remote_tlbs(struct kvm *kvm)
> +{
> +	if (kvm)
> +		kvm_call_hyp(__kvm_tlb_flush_vmid, kvm);
> +}
> +
> +#endif
> +
>  static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
>  				  int min, int max)
>  {
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 13f2d19..f1efaa5 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -34,3 +34,6 @@ config HAVE_KVM_CPU_RELAX_INTERCEPT
>  
>  config KVM_VFIO
>         bool
> +
> +config HAVE_KVM_ARCH_TLB_FLUSH_ALL
> +       bool
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index fa70c6e..258f3d9 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -186,12 +186,16 @@ static bool make_all_cpus_request(struct kvm *kvm, unsigned int req)
>  
>  void kvm_flush_remote_tlbs(struct kvm *kvm)
>  {
> +#ifdef CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL
> +	kvm_arch_flush_remote_tlbs(kvm);
> +#else
>  	long dirty_count = kvm->tlbs_dirty;
>  
>  	smp_mb();
>  	if (make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH))
>  		++kvm->stat.remote_tlb_flush;
>  	cmpxchg(&kvm->tlbs_dirty, dirty_count, 0);
> +#endif

I would split this into two patches, one trivial one for the KVM generic
solution, and one to add the arm-specific part.

That will make your commit text and title much nicer to read too.

Thanks,
-Christoffer
