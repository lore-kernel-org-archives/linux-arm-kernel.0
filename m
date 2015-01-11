From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 11 Jan 2015 19:27:16 +0100
Subject: [PATCH 5/7] arm64: kvm: move to ESR_ELx macros
In-Reply-To: <1420632260-8798-6-git-send-email-mark.rutland@arm.com>
References: <1420632260-8798-1-git-send-email-mark.rutland@arm.com>
 <1420632260-8798-6-git-send-email-mark.rutland@arm.com>
Message-ID: <20150111182716.GL21444@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 12:04:18PM +0000, Mark Rutland wrote:
> Now that we have common ESR_ELx macros, make use of them in the arm64
> KVM code. The addition of <asm/esr.h> to the include path highlighted
> badly ordered (i.e. not alphabetical) include lists; these are changed
> to alphabetical order.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/kvm_emulate.h | 28 +++++++++++++++-------------
>  arch/arm64/kvm/emulate.c             |  5 +++--
>  arch/arm64/kvm/handle_exit.c         | 32 +++++++++++++++++---------------
>  arch/arm64/kvm/hyp.S                 | 17 +++++++++--------
>  arch/arm64/kvm/inject_fault.c        | 14 +++++++-------
>  arch/arm64/kvm/sys_regs.c            | 23 +++++++++++++----------
>  6 files changed, 64 insertions(+), 55 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 8127e45..6a9fa89 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -23,8 +23,10 @@
>  #define __ARM64_KVM_EMULATE_H__
>  
>  #include <linux/kvm_host.h>
> -#include <asm/kvm_asm.h>
> +
> +#include <asm/esr.h>
>  #include <asm/kvm_arm.h>
> +#include <asm/kvm_asm.h>
>  #include <asm/kvm_mmio.h>
>  #include <asm/ptrace.h>
>  
> @@ -128,63 +130,63 @@ static inline phys_addr_t kvm_vcpu_get_fault_ipa(const struct kvm_vcpu *vcpu)
>  
>  static inline bool kvm_vcpu_dabt_isvalid(const struct kvm_vcpu *vcpu)
>  {
> -	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_EL2_ISV);
> +	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_ISV);
>  }
>  
>  static inline bool kvm_vcpu_dabt_iswrite(const struct kvm_vcpu *vcpu)
>  {
> -	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_EL2_WNR);
> +	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_WNR);
>  }
>  
>  static inline bool kvm_vcpu_dabt_issext(const struct kvm_vcpu *vcpu)
>  {
> -	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_EL2_SSE);
> +	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_SSE);
>  }
>  
>  static inline int kvm_vcpu_dabt_get_rd(const struct kvm_vcpu *vcpu)
>  {
> -	return (kvm_vcpu_get_hsr(vcpu) & ESR_EL2_SRT_MASK) >> ESR_EL2_SRT_SHIFT;
> +	return (kvm_vcpu_get_hsr(vcpu) & ESR_ELx_SRT_MASK) >> ESR_ELx_SRT_SHIFT;
>  }
>  
>  static inline bool kvm_vcpu_dabt_isextabt(const struct kvm_vcpu *vcpu)
>  {
> -	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_EL2_EA);
> +	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_EA);
>  }
>  
>  static inline bool kvm_vcpu_dabt_iss1tw(const struct kvm_vcpu *vcpu)
>  {
> -	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_EL2_S1PTW);
> +	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_S1PTW);
>  }
>  
>  static inline int kvm_vcpu_dabt_get_as(const struct kvm_vcpu *vcpu)
>  {
> -	return 1 << ((kvm_vcpu_get_hsr(vcpu) & ESR_EL2_SAS) >> ESR_EL2_SAS_SHIFT);
> +	return 1 << !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_SAS);

huh?

>  }
>  
>  /* This one is not specific to Data Abort */
>  static inline bool kvm_vcpu_trap_il_is32bit(const struct kvm_vcpu *vcpu)
>  {
> -	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_EL2_IL);
> +	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_IL);
>  }
>  
>  static inline u8 kvm_vcpu_trap_get_class(const struct kvm_vcpu *vcpu)
>  {
> -	return kvm_vcpu_get_hsr(vcpu) >> ESR_EL2_EC_SHIFT;
> +	return kvm_vcpu_get_hsr(vcpu) >> ESR_ELx_EC_SHIFT;
>  }
>  
>  static inline bool kvm_vcpu_trap_is_iabt(const struct kvm_vcpu *vcpu)
>  {
> -	return kvm_vcpu_trap_get_class(vcpu) == ESR_EL2_EC_IABT;
> +	return kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_IABT_LOW;
>  }
>  
>  static inline u8 kvm_vcpu_trap_get_fault(const struct kvm_vcpu *vcpu)
>  {
> -	return kvm_vcpu_get_hsr(vcpu) & ESR_EL2_FSC;
> +	return kvm_vcpu_get_hsr(vcpu) & ESR_ELx_FSC;
>  }
>  
>  static inline u8 kvm_vcpu_trap_get_fault_type(const struct kvm_vcpu *vcpu)
>  {
> -	return kvm_vcpu_get_hsr(vcpu) & ESR_EL2_FSC_TYPE;
> +	return kvm_vcpu_get_hsr(vcpu) & ESR_ELx_FSC_TYPE;
>  }
>  
>  static inline unsigned long kvm_vcpu_get_mpidr(struct kvm_vcpu *vcpu)
> diff --git a/arch/arm64/kvm/emulate.c b/arch/arm64/kvm/emulate.c
> index 124418d..f87d8fb 100644
> --- a/arch/arm64/kvm/emulate.c
> +++ b/arch/arm64/kvm/emulate.c
> @@ -22,6 +22,7 @@
>   */
>  
>  #include <linux/kvm_host.h>
> +#include <asm/esr.h>
>  #include <asm/kvm_emulate.h>
>  
>  /*
> @@ -55,8 +56,8 @@ static int kvm_vcpu_get_condition(const struct kvm_vcpu *vcpu)
>  {
>  	u32 esr = kvm_vcpu_get_hsr(vcpu);
>  
> -	if (esr & ESR_EL2_CV)
> -		return (esr & ESR_EL2_COND) >> ESR_EL2_COND_SHIFT;
> +	if (esr & ESR_ELx_CV)
> +		return (esr & ESR_ELx_COND_MASK) >> ESR_ELx_COND_SHIFT;
>  
>  	return -1;
>  }
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index 34b8bd0..bcbc923 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -21,8 +21,10 @@
>  
>  #include <linux/kvm.h>
>  #include <linux/kvm_host.h>
> -#include <asm/kvm_emulate.h>
> +
> +#include <asm/esr.h>
>  #include <asm/kvm_coproc.h>
> +#include <asm/kvm_emulate.h>
>  #include <asm/kvm_mmu.h>
>  #include <asm/kvm_psci.h>
>  
> @@ -61,7 +63,7 @@ static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>   */
>  static int kvm_handle_wfx(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  {
> -	if (kvm_vcpu_get_hsr(vcpu) & ESR_EL2_EC_WFI_ISS_WFE)
> +	if (kvm_vcpu_get_hsr(vcpu) & ESR_ELx_WFx_ISS_WFE)
>  		kvm_vcpu_on_spin(vcpu);
>  	else
>  		kvm_vcpu_block(vcpu);
> @@ -72,19 +74,19 @@ static int kvm_handle_wfx(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  }
>  
>  static exit_handle_fn arm_exit_handlers[] = {
> -	[ESR_EL2_EC_WFI]	= kvm_handle_wfx,
> -	[ESR_EL2_EC_CP15_32]	= kvm_handle_cp15_32,
> -	[ESR_EL2_EC_CP15_64]	= kvm_handle_cp15_64,
> -	[ESR_EL2_EC_CP14_MR]	= kvm_handle_cp14_32,
> -	[ESR_EL2_EC_CP14_LS]	= kvm_handle_cp14_load_store,
> -	[ESR_EL2_EC_CP14_64]	= kvm_handle_cp14_64,
> -	[ESR_EL2_EC_HVC32]	= handle_hvc,
> -	[ESR_EL2_EC_SMC32]	= handle_smc,
> -	[ESR_EL2_EC_HVC64]	= handle_hvc,
> -	[ESR_EL2_EC_SMC64]	= handle_smc,
> -	[ESR_EL2_EC_SYS64]	= kvm_handle_sys_reg,
> -	[ESR_EL2_EC_IABT]	= kvm_handle_guest_abort,
> -	[ESR_EL2_EC_DABT]	= kvm_handle_guest_abort,
> +	[ESR_ELx_EC_WFx]	= kvm_handle_wfx,
> +	[ESR_ELx_EC_CP15_32]	= kvm_handle_cp15_32,
> +	[ESR_ELx_EC_CP15_64]	= kvm_handle_cp15_64,
> +	[ESR_ELx_EC_CP14_MR]	= kvm_handle_cp14_32,
> +	[ESR_ELx_EC_CP14_LS]	= kvm_handle_cp14_load_store,
> +	[ESR_ELx_EC_CP14_64]	= kvm_handle_cp14_64,
> +	[ESR_ELx_EC_HVC32]	= handle_hvc,
> +	[ESR_ELx_EC_SMC32]	= handle_smc,
> +	[ESR_ELx_EC_HVC64]	= handle_hvc,
> +	[ESR_ELx_EC_SMC64]	= handle_smc,
> +	[ESR_ELx_EC_SYS64]	= kvm_handle_sys_reg,
> +	[ESR_ELx_EC_IABT_LOW]	= kvm_handle_guest_abort,
> +	[ESR_ELx_EC_DABT_LOW]	= kvm_handle_guest_abort,
>  };
>  
>  static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> index fbe909f..c0d8202 100644
> --- a/arch/arm64/kvm/hyp.S
> +++ b/arch/arm64/kvm/hyp.S
> @@ -17,15 +17,16 @@
>  
>  #include <linux/linkage.h>
>  
> -#include <asm/assembler.h>
> -#include <asm/memory.h>
>  #include <asm/asm-offsets.h>
> +#include <asm/assembler.h>
>  #include <asm/debug-monitors.h>
> +#include <asm/esr.h>
>  #include <asm/fpsimdmacros.h>
>  #include <asm/kvm.h>
> -#include <asm/kvm_asm.h>
>  #include <asm/kvm_arm.h>
> +#include <asm/kvm_asm.h>
>  #include <asm/kvm_mmu.h>
> +#include <asm/memory.h>
>  
>  #define CPU_GP_REG_OFFSET(x)	(CPU_GP_REGS + x)
>  #define CPU_XREG_OFFSET(x)	CPU_GP_REG_OFFSET(CPU_USER_PT_REGS + 8*x)
> @@ -1140,9 +1141,9 @@ el1_sync:					// Guest trapped into EL2
>  	push	x2, x3
>  
>  	mrs	x1, esr_el2
> -	lsr	x2, x1, #ESR_EL2_EC_SHIFT
> +	lsr	x2, x1, #ESR_ELx_EC_SHIFT
>  
> -	cmp	x2, #ESR_EL2_EC_HVC64
> +	cmp	x2, #ESR_ELx_EC_HVC64
>  	b.ne	el1_trap
>  
>  	mrs	x3, vttbr_el2			// If vttbr is valid, the 64bit guest
> @@ -1177,13 +1178,13 @@ el1_trap:
>  	 * x1: ESR
>  	 * x2: ESR_EC
>  	 */
> -	cmp	x2, #ESR_EL2_EC_DABT
> -	mov	x0, #ESR_EL2_EC_IABT
> +	cmp	x2, #ESR_ELx_EC_DABT_LOW
> +	mov	x0, #ESR_ELx_EC_IABT_LOW
>  	ccmp	x2, x0, #4, ne
>  	b.ne	1f		// Not an abort we care about
>  
>  	/* This is an abort. Check for permission fault */
> -	and	x2, x1, #ESR_EL2_FSC_TYPE
> +	and	x2, x1, #ESR_ELx_FSC_TYPE
>  	cmp	x2, #FSC_PERM
>  	b.ne	1f		// Not a permission fault
>  
> diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
> index 81a02a8..f02530e 100644
> --- a/arch/arm64/kvm/inject_fault.c
> +++ b/arch/arm64/kvm/inject_fault.c
> @@ -118,27 +118,27 @@ static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr
>  	 * instruction set. Report an external synchronous abort.
>  	 */
>  	if (kvm_vcpu_trap_il_is32bit(vcpu))
> -		esr |= ESR_EL1_IL;
> +		esr |= ESR_ELx_IL;
>  
>  	/*
>  	 * Here, the guest runs in AArch64 mode when in EL1. If we get
>  	 * an AArch32 fault, it means we managed to trap an EL0 fault.
>  	 */
>  	if (is_aarch32 || (cpsr & PSR_MODE_MASK) == PSR_MODE_EL0t)
> -		esr |= (ESR_EL1_EC_IABT_EL0 << ESR_EL1_EC_SHIFT);
> +		esr |= (ESR_ELx_EC_IABT_LOW << ESR_ELx_EC_SHIFT);
>  	else
> -		esr |= (ESR_EL1_EC_IABT_EL1 << ESR_EL1_EC_SHIFT);
> +		esr |= (ESR_ELx_EC_IABT_CUR << ESR_ELx_EC_SHIFT);
>  
>  	if (!is_iabt)
> -		esr |= ESR_EL1_EC_DABT_EL0;
> +		esr |= ESR_ELx_EC_DABT_LOW;
>  
> -	vcpu_sys_reg(vcpu, ESR_EL1) = esr | ESR_EL2_EC_xABT_xFSR_EXTABT;
> +	vcpu_sys_reg(vcpu, ESR_EL1) = esr | ESR_ELx_FSC_EXTABT;
>  }
>  
>  static void inject_undef64(struct kvm_vcpu *vcpu)
>  {
>  	unsigned long cpsr = *vcpu_cpsr(vcpu);
> -	u32 esr = (ESR_EL1_EC_UNKNOWN << ESR_EL1_EC_SHIFT);
> +	u32 esr = (ESR_ELx_EC_UNKNOWN << ESR_ELx_EC_SHIFT);
>  
>  	*vcpu_spsr(vcpu) = cpsr;
>  	*vcpu_elr_el1(vcpu) = *vcpu_pc(vcpu);
> @@ -151,7 +151,7 @@ static void inject_undef64(struct kvm_vcpu *vcpu)
>  	 * set.
>  	 */
>  	if (kvm_vcpu_trap_il_is32bit(vcpu))
> -		esr |= ESR_EL1_IL;
> +		esr |= ESR_ELx_IL;
>  
>  	vcpu_sys_reg(vcpu, ESR_EL1) = esr;
>  }
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 3d7c2df..6b859d7 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -20,17 +20,20 @@
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> -#include <linux/mm.h>
>  #include <linux/kvm_host.h>
> +#include <linux/mm.h>
>  #include <linux/uaccess.h>
> -#include <asm/kvm_arm.h>
> -#include <asm/kvm_host.h>
> -#include <asm/kvm_emulate.h>
> -#include <asm/kvm_coproc.h>
> -#include <asm/kvm_mmu.h>
> +
>  #include <asm/cacheflush.h>
>  #include <asm/cputype.h>
>  #include <asm/debug-monitors.h>
> +#include <asm/esr.h>
> +#include <asm/kvm_arm.h>
> +#include <asm/kvm_coproc.h>
> +#include <asm/kvm_emulate.h>
> +#include <asm/kvm_host.h>
> +#include <asm/kvm_mmu.h>
> +
>  #include <trace/events/kvm.h>
>  
>  #include "sys_regs.h"
> @@ -815,12 +818,12 @@ static void unhandled_cp_access(struct kvm_vcpu *vcpu,
>  	int cp;
>  
>  	switch(hsr_ec) {
> -	case ESR_EL2_EC_CP15_32:
> -	case ESR_EL2_EC_CP15_64:
> +	case ESR_ELx_EC_CP15_32:
> +	case ESR_ELx_EC_CP15_64:
>  		cp = 15;
>  		break;
> -	case ESR_EL2_EC_CP14_MR:
> -	case ESR_EL2_EC_CP14_64:
> +	case ESR_ELx_EC_CP14_MR:
> +	case ESR_ELx_EC_CP14_64:
>  		cp = 14;
>  		break;
>  	default:
> -- 
> 1.9.1
> 

Otherwise looks good.

Thanks,
-Christoffer
