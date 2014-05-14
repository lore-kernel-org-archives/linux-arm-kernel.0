From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 14 May 2014 17:47:28 +0100
Subject: [PATCH v5 1/4] add ARMv7 HYP API to flush VM TLBs without address
 param
In-Reply-To: <1399509616-4632-2-git-send-email-m.smarduch@samsung.com>
References: <1399509616-4632-1-git-send-email-m.smarduch@samsung.com>
 <1399509616-4632-2-git-send-email-m.smarduch@samsung.com>
Message-ID: <CAMJs5B_2N0FchTKFA_DtfCboJ0uRWCVtwzSJUPcezH78A7kC6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 07, 2014 at 05:40:13PM -0700, Mario Smarduch wrote:
> Patch adds HYP interface for global VM TLB invalidation without address
> parameter.
>
> - Added ARM version of kvm_flush_remote_tlbs()
>
>
> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
> ---
>  arch/arm/include/asm/kvm_asm.h  |    1 +
>  arch/arm/include/asm/kvm_host.h |    2 ++
>  arch/arm/kvm/interrupts.S       |    5 +++++
>  arch/arm/kvm/mmu.c              |   10 ++++++++++
>  4 files changed, 18 insertions(+)
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
> index 193ceaf..ac3bb65 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -231,4 +231,6 @@ int kvm_perf_teardown(void);
>  u64 kvm_arm_timer_get_reg(struct kvm_vcpu *, u64 regid);
>  int kvm_arm_timer_set_reg(struct kvm_vcpu *, u64 regid, u64 value);
>
> +void kvm_tlb_flush_vmid(struct kvm *kvm);
> +
>  #endif /* __ARM_KVM_HOST_H__ */
> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
> index 0d68d40..8620280 100644
> --- a/arch/arm/kvm/interrupts.S
> +++ b/arch/arm/kvm/interrupts.S
> @@ -45,8 +45,12 @@ __kvm_hyp_code_start:
>   *
>   * As v7 does not support flushing per IPA, just nuke the whole TLB
>   * instead, ignoring the ipa value.
> + *
> + * void __kvm_tlb_flush_vm(struct kvm *kvm) - alias on ARMv7 for global VM TLB
> + * flush with no address parameters.
>   */
>  ENTRY(__kvm_tlb_flush_vmid_ipa)
> +ENTRY(__kvm_tlb_flush_vmid)
>   push {r2, r3}
>
>   dsb ishst
> @@ -65,6 +69,7 @@ ENTRY(__kvm_tlb_flush_vmid_ipa)
>   pop {r2, r3}
>   bx lr
>  ENDPROC(__kvm_tlb_flush_vmid_ipa)
> +ENDPROC(__kvm_tlb_flush_vmid)

yikes, can you please make this a separate function that calls the other
one?

>
>  /********************************************************************
>   * Flush TLBs and instruction caches of all CPUs inside the inner-shareable
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 80bb1e6..95c172a 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -56,6 +56,16 @@ static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
>   kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, kvm, ipa);
>  }
>
> +/* Function reuses __kvm_tlb_flush_vmid_ipa() HYP interface without additional
> + * address argument to flush entire VM TLBs.
> + */

This is not proper kernel commenting formatting, please see
Documentation/CodingStyle.

For new exported functions in the KVM/ARM code, please add kdocs style
documentation to the functions.

> +void kvm_flush_remote_tlbs(struct kvm *kvm)

This doesn't build?:

arch/arm/kvm/mmu.o: In function `kvm_flush_remote_tlbs':
mmu.c:(.text+0xc7c): multiple definition of `kvm_flush_remote_tlbs'

> +{
> + if (kvm)
> + kvm_call_hyp(__kvm_tlb_flush_vmid, kvm);
> +}
> +
> +
>  static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
>    int min, int max)
>  {
> --
> 1.7.9.5
>
