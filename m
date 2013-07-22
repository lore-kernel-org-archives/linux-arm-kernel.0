From: gleb@redhat.com (Gleb Natapov)
Date: Mon, 22 Jul 2013 10:36:39 +0300
Subject: [PATCH 4/4] arm64: KVM: remove __kvm_hyp_code_{start,end} from
 hyp.S
In-Reply-To: <1374242035-13199-5-git-send-email-marc.zyngier@arm.com>
References: <1374242035-13199-1-git-send-email-marc.zyngier@arm.com>
 <1374242035-13199-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130722073639.GK20379@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 19, 2013 at 02:53:55PM +0100, Marc Zyngier wrote:
> We already have __hyp_text_{start,end} to express the boundaries
> of the HYP text section, and __kvm_hyp_code_{start,end} are getting
> in the way of a more modular world switch code.
> 
> Just turn __kvm_hyp_code_{start,end} into #defines mapping the
> linker-emited symbols.
> 
Same here, why 3.11?

> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h | 6 ++++--
>  arch/arm64/include/asm/virt.h    | 4 ++++
>  arch/arm64/kvm/hyp.S             | 6 ------
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index b25763b..dddb345 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -18,6 +18,8 @@
>  #ifndef __ARM_KVM_ASM_H__
>  #define __ARM_KVM_ASM_H__
>  
> +#include <asm/virt.h>
> +
>  /*
>   * 0 is reserved as an invalid value.
>   * Order *must* be kept in sync with the hyp switch code.
> @@ -95,8 +97,8 @@ extern char __kvm_hyp_init_end[];
>  
>  extern char __kvm_hyp_vector[];
>  
> -extern char __kvm_hyp_code_start[];
> -extern char __kvm_hyp_code_end[];
> +#define	__kvm_hyp_code_start	__hyp_text_start
> +#define	__kvm_hyp_code_end	__hyp_text_end
>  
>  extern void __kvm_flush_vm_context(void);
>  extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
> diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
> index 4398272..59d67f3 100644
> --- a/arch/arm64/include/asm/virt.h
> +++ b/arch/arm64/include/asm/virt.h
> @@ -49,6 +49,10 @@ static inline bool is_hyp_mode_mismatched(void)
>  	return __boot_cpu_mode[0] != __boot_cpu_mode[1];
>  }
>  
> +/* The section containing the hypervisor text */
> +extern char __hyp_text_start[];
> +extern char __hyp_text_end[];
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* ! __ASM__VIRT_H */
> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> index e1ccfcc..19ccf48 100644
> --- a/arch/arm64/kvm/hyp.S
> +++ b/arch/arm64/kvm/hyp.S
> @@ -36,9 +36,6 @@
>  	.pushsection	.hyp.text, "ax"
>  	.align	PAGE_SHIFT
>  
> -__kvm_hyp_code_start:
> -	.globl __kvm_hyp_code_start
> -
>  .macro save_common_regs
>  	// x2: base address for cpu context
>  	// x3: tmp register
> @@ -837,7 +834,4 @@ ENTRY(__kvm_hyp_vector)
>  	ventry	el1_error_invalid		// Error 32-bit EL1
>  ENDPROC(__kvm_hyp_vector)
>  
> -__kvm_hyp_code_end:
> -	.globl	__kvm_hyp_code_end
> -
>  	.popsection
> -- 
> 1.8.2.3
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
			Gleb.
