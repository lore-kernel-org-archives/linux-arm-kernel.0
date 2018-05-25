From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 25 May 2018 11:50:10 +0100
Subject: [PATCHv2] ARM64: KVM: use lm_alias() for kvm_ksym_ref()
In-Reply-To: <20180510111347.32253-1-mark.rutland@arm.com>
References: <20180510111347.32253-1-mark.rutland@arm.com>
Message-ID: <20180525105010.qswcppfkybznmzka@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2018 at 12:13:47PM +0100, Mark Rutland wrote:
> For historical reasons, we open-code lm_alias() in kvm_ksym_ref().
> 
> Let's use lm_alias() to avoid duplication and make things clearer.
> 
> As we have to pull this from <linux/mm.h> (which is not safe for
> inclusion in assembly), we may as well move the kvm_ksym_ref()
> definition into the existing !__ASSEMBLY__ block.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: kvmarm at lists.cs.columbia.edu
> ---
>  arch/arm64/include/asm/kvm_asm.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Marc, Christoffer, are you happy to pick this up?

Mark.

> Since v1 [1]:
> * Rebase to v4.17-rc4
> * Fix typo in commit message
> 
> Mark.
> 
> [1] https://lkml.kernel.org/r/20180406151909.57197-1-mark.rutland at arm.com
> 
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index f6648a3e4152..a9ceeec5a76f 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -33,16 +33,19 @@
>  #define KVM_ARM64_DEBUG_DIRTY_SHIFT	0
>  #define KVM_ARM64_DEBUG_DIRTY		(1 << KVM_ARM64_DEBUG_DIRTY_SHIFT)
>  
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/mm.h>
> +
>  /* Translate a kernel address of @sym into its equivalent linear mapping */
>  #define kvm_ksym_ref(sym)						\
>  	({								\
>  		void *val = &sym;					\
>  		if (!is_kernel_in_hyp_mode())				\
> -			val = phys_to_virt((u64)&sym - kimage_voffset);	\
> +			val = lm_alias(&sym);				\
>  		val;							\
>  	 })
>  
> -#ifndef __ASSEMBLY__
>  struct kvm;
>  struct kvm_vcpu;
>  
> -- 
> 2.11.0
> 
