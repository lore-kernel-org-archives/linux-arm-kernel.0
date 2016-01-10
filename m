From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 10 Jan 2016 17:32:04 +0100
Subject: [PATCH v6 1/6] arm/arm64: KVM: Introduce armv7 fp/simd vcpu
 fields and helpers
In-Reply-To: <1451166900-3711-2-git-send-email-m.smarduch@samsung.com>
References: <1451166900-3711-1-git-send-email-m.smarduch@samsung.com>
 <1451166900-3711-2-git-send-email-m.smarduch@samsung.com>
Message-ID: <20160110163204.GD30867@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mario,

I spotted one more potential issue...

On Sat, Dec 26, 2015 at 01:54:55PM -0800, Mario Smarduch wrote:
> Add helper functions to enable access to fp/smid on guest entry and save host
> fpexc on vcpu put, check if fp/simd registers are dirty and add new vcpu
> fields.
> 
> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
> ---
>  arch/arm/include/asm/kvm_emulate.h   | 42 ++++++++++++++++++++++++++++++++++++
>  arch/arm/include/asm/kvm_host.h      |  6 ++++++
>  arch/arm64/include/asm/kvm_emulate.h |  8 +++++++
>  3 files changed, 56 insertions(+)
> 
> diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
> index 3095df0..d4d9da1 100644
> --- a/arch/arm/include/asm/kvm_emulate.h
> +++ b/arch/arm/include/asm/kvm_emulate.h
> @@ -24,6 +24,8 @@
>  #include <asm/kvm_mmio.h>
>  #include <asm/kvm_arm.h>
>  #include <asm/cputype.h>
> +#include <asm/vfp.h>
> +#include "../vfp/vfpinstr.h"
>  
>  unsigned long *vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num);
>  unsigned long *vcpu_spsr(struct kvm_vcpu *vcpu);
> @@ -255,4 +257,44 @@ static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
>  	}
>  }
>  
> +#ifdef CONFIG_VFPv3
> +/* Called from vcpu_load - save fpexc and enable guest access to fp/simd unit */
> +static inline void vcpu_trap_vfp_enable(struct kvm_vcpu *vcpu)
> +{
> +	u32 fpexc;
> +
> +	/* Save host fpexc, and enable guest access to fp unit */
> +	fpexc = fmrx(FPEXC);
> +	vcpu->arch.host_fpexc = fpexc;
> +	fpexc |= FPEXC_EN;
> +	fmxr(FPEXC, fpexc);
> +
> +	/* Configure HCPTR to trap on tracing and fp/simd access */
> +	vcpu->arch.hcptr = HCPTR_TTA | HCPTR_TCP(10)  | HCPTR_TCP(11);
> +}
> +
> +/* Called from vcpu_put - restore host fpexc */
> +static inline void vcpu_restore_host_fpexc(struct kvm_vcpu *vcpu)
> +{
> +	fmxr(FPEXC, vcpu->arch.host_fpexc);
> +}
> +
> +/* If trap bits are reset then fp/simd registers are dirty */
> +static inline bool vcpu_vfp_isdirty(struct kvm_vcpu *vcpu)
> +{
> +	return !(vcpu->arch.hcptr & (HCPTR_TCP(10) | HCPTR_TCP(11)));
> +}
> +#else
> +static inline void vcpu_trap_vfp_enable(struct kvm_vcpu *vcpu)
> +{
> +	vcpu->arch.hcptr = HCPTR_TTA;

Is it correct not to trap VFP registers when the host kernel does not
have CONFIG_VFPv3?  I think this is a change in functionality compared
to the current kernels is it not?

Thanks,
-Christoffer
