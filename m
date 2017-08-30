From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 30 Aug 2017 20:53:19 +0200
Subject: [PATCH 3/3] arm64: kvm: Fix single step for guest skipped
 instructions
In-Reply-To: <1504083688-48334-4-git-send-email-julien.thierry@arm.com>
References: <1504083688-48334-1-git-send-email-julien.thierry@arm.com>
 <1504083688-48334-4-git-send-email-julien.thierry@arm.com>
Message-ID: <CAMJs5B9u_s_wOoR7tyOV7t67aWmmgA6KavEWhDuDN98+z5rACg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

[cc'ing Alex Benn?e here who wrote the debug code for arm64]

On Wed, Aug 30, 2017 at 11:01 AM, Julien Thierry <julien.thierry@arm.com> wrote:
> Software Step exception is missing after trapping instruction from the guest.
>
> We need to set the PSR.SS to 0 for the guest vcpu before resuming guest
> execution.
>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
>
> ---
>  arch/arm64/include/asm/kvm_asm.h     |  2 ++
>  arch/arm64/include/asm/kvm_emulate.h |  2 ++
>  arch/arm64/kvm/debug.c               | 12 +++++++++++-
>  arch/arm64/kvm/hyp/switch.c          | 12 ++++++++++++
>  4 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 26a64d0..398bbaa 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -32,6 +32,8 @@
>
>  #define KVM_ARM64_DEBUG_DIRTY_SHIFT    0
>  #define KVM_ARM64_DEBUG_DIRTY          (1 << KVM_ARM64_DEBUG_DIRTY_SHIFT)
> +#define KVM_ARM64_DEBUG_INST_SKIP_SHIFT        1
> +#define KVM_ARM64_DEBUG_INST_SKIP      (1 << KVM_ARM64_DEBUG_INST_SKIP_SHIFT)
>
>  #define kvm_ksym_ref(sym)                                              \
>         ({                                                              \
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index fe39e68..d401c64 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -95,6 +95,8 @@ static inline void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr)
>                 kvm_skip_instr32(vcpu, is_wide_instr);
>         else
>                 *vcpu_pc(vcpu) += 4;
> +       /* Let debug engine know we skipped an instruction */
> +       vcpu->arch.debug_flags |= KVM_ARM64_DEBUG_INST_SKIP;

Why do we need to defer this action until later?

Can't we simply do clear DBG_SPSR_SS here?

I think even if the guest kernel is single-stepping guest userspace,
you're still safe because you'll take another debug exception from
having 'executed' (read: emulated) this instruction in the hypervisor.

>  }
>
>  static inline void vcpu_set_thumb(struct kvm_vcpu *vcpu)
> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> index dbadfaf..4806e6b 100644
> --- a/arch/arm64/kvm/debug.c
> +++ b/arch/arm64/kvm/debug.c
> @@ -151,12 +151,22 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
>                  * debugging the system.
>                  */
>                 if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP) {
> -                       *vcpu_cpsr(vcpu) |=  DBG_SPSR_SS;
> +                       /*
> +                        * If we skipped an instruction while single stepping,
> +                        * spsr.ss needs to be 0 in order to trigger SS
> +                        * exception on return.
> +                        */
> +                       if (!(vcpu->arch.debug_flags & KVM_ARM64_DEBUG_INST_SKIP))
> +                               *vcpu_cpsr(vcpu) |=  DBG_SPSR_SS;
> +                       else
> +                               *vcpu_cpsr(vcpu) &=  ~DBG_SPSR_SS;

Then you wouldn't need this.

>                         vcpu_sys_reg(vcpu, MDSCR_EL1) |= DBG_MDSCR_SS;
>                 } else {
>                         vcpu_sys_reg(vcpu, MDSCR_EL1) &= ~DBG_MDSCR_SS;
>                 }
>
> +               vcpu->arch.debug_flags &= ~KVM_ARM64_DEBUG_INST_SKIP;
> +
>                 trace_kvm_arm_set_dreg32("SPSR_EL2", *vcpu_cpsr(vcpu));
>
>                 /*
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index 945e79c..6030acd 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -22,6 +22,7 @@
>  #include <asm/kvm_emulate.h>
>  #include <asm/kvm_hyp.h>
>  #include <asm/fpsimd.h>
> +#include <asm/debug-monitors.h>
>
>  static bool __hyp_text __fpsimd_enabled_nvhe(void)
>  {
> @@ -276,6 +277,10 @@ static void __hyp_text __skip_instr(struct kvm_vcpu *vcpu)
>         }
>
>         write_sysreg_el2(*vcpu_pc(vcpu), elr);
> +
> +       *vcpu_cpsr(vcpu) = read_sysreg_el2(spsr);
> +       *vcpu_cpsr(vcpu) &= ~DBG_SPSR_SS;
> +       write_sysreg_el2(*vcpu_cpsr(vcpu), spsr);

I don't think you really need to use *vcpu_cpsr(vcpu) here, I think
you can just use a temporary variable, which may make the flow a bit
easier to read actually.

>  }
>
>  int __hyp_text __kvm_vcpu_run(struct kvm_vcpu *vcpu)
> @@ -343,6 +348,13 @@ int __hyp_text __kvm_vcpu_run(struct kvm_vcpu *vcpu)
>                         if (ret == -1) {
>                                 /* Promote an illegal access to an SError */
>                                 __skip_instr(vcpu);
> +
> +                               /*
> +                                * We're not jumping back, let debug setup know
> +                                * we skipped an instruction.
> +                                */
> +                               vcpu->arch.debug_flags |= KVM_ARM64_DEBUG_INST_SKIP;

I agree with Marc, I don't think you need this, because you have
modified the hardware spsr_el2, which you're going to read back in
__sysreg_save_guest_state().

>                                 exit_code = ARM_EXCEPTION_EL1_SERROR;
>                         }
>
> --
> 1.9.1

Thanks,
-Christoffer
