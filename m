From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Fri, 09 Nov 2018 16:58:00 +0000
Subject: [PATCH 2/2] kvm/arm: consistently advance singlestep when
 emulating instructions
In-Reply-To: <20181109150711.45864-3-mark.rutland@arm.com>
References: <20181109150711.45864-1-mark.rutland@arm.com>
 <20181109150711.45864-3-mark.rutland@arm.com>
Message-ID: <87d0re5gtj.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Mark Rutland <mark.rutland@arm.com> writes:

> When we emulate a guest instruction, we don't advance the hardware
> singlestep state machine, and thus the guest will receive a software
> step exception after a next instruction which is not emulated by the
> host.
>
> We bodge around this in an ad-hoc fashion. Sometimes we explicitly check
> whether userspace requested a single step, and fake a debug exception
> from within the kernel. Other times, we advance the HW singlestep state
> rely on the HW to generate the exception for us. Thus, the observed step
> behaviour differs for host and guest.
>
> Let's make this simpler and consistent by always advancing the HW
> singlestep state machine when we skip an instruction. Thus we can rely
> on the hardware to generate the singlestep exception for us, and never
> need to explicitly check for an active-pending step, nor do we need to
> fake a debug exception from the guest.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Alex Benn?e <alex.bennee@linaro.org>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
Tested-by: Alex Benn?e <alex.bennee@linaro.org>

For reference I'm leaving this kernel boot soaking overnight. In theory
there may be a branch to self but we shall see:

  https://gist.github.com/stsquad/ddfb00787cb133b4b658756cb6c47f63

> ---
>  arch/arm/include/asm/kvm_host.h          |  5 ----
>  arch/arm64/include/asm/kvm_emulate.h     | 35 ++++++++++++++++++++------
>  arch/arm64/include/asm/kvm_host.h        |  1 -
>  arch/arm64/kvm/debug.c                   | 21 ----------------
>  arch/arm64/kvm/handle_exit.c             | 14 +----------
>  arch/arm64/kvm/hyp/switch.c              | 43 +++-----------------------------
>  arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c | 12 ++++++---
>  virt/kvm/arm/arm.c                       |  2 --
>  virt/kvm/arm/hyp/vgic-v3-sr.c            |  6 ++++-
>  9 files changed, 46 insertions(+), 93 deletions(-)
>
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 5ca5d9af0c26..c5634c6ffcea 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -296,11 +296,6 @@ static inline void kvm_arm_init_debug(void) {}
>  static inline void kvm_arm_setup_debug(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arm_clear_debug(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu) {}
> -static inline bool kvm_arm_handle_step_debug(struct kvm_vcpu *vcpu,
> -					     struct kvm_run *run)
> -{
> -	return false;
> -}
>
>  int kvm_arm_vcpu_arch_set_attr(struct kvm_vcpu *vcpu,
>  			       struct kvm_device_attr *attr);
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 21247870def7..506386a3edde 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -24,6 +24,7 @@
>
>  #include <linux/kvm_host.h>
>
> +#include <asm/debug-monitors.h>
>  #include <asm/esr.h>
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_hyp.h>
> @@ -147,14 +148,6 @@ static inline bool kvm_condition_valid(const struct kvm_vcpu *vcpu)
>  	return true;
>  }
>
> -static inline void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr)
> -{
> -	if (vcpu_mode_is_32bit(vcpu))
> -		kvm_skip_instr32(vcpu, is_wide_instr);
> -	else
> -		*vcpu_pc(vcpu) += 4;
> -}
> -
>  static inline void vcpu_set_thumb(struct kvm_vcpu *vcpu)
>  {
>  	*vcpu_cpsr(vcpu) |= PSR_AA32_T_BIT;
> @@ -424,4 +417,30 @@ static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
>  	return data;		/* Leave LE untouched */
>  }
>
> +static inline void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr)
> +{
> +	if (vcpu_mode_is_32bit(vcpu))
> +		kvm_skip_instr32(vcpu, is_wide_instr);
> +	else
> +		*vcpu_pc(vcpu) += 4;
> +
> +	/* advance the singlestep state machine */
> +	*vcpu_cpsr(vcpu) &= ~DBG_SPSR_SS;
> +}
> +
> +/*
> + * Skip an instruction which has been emulated at hyp while most guest sysregs
> + * are live.
> + */
> +static inline void __hyp_text __kvm_skip_instr(struct kvm_vcpu *vcpu)
> +{
> +	*vcpu_pc(vcpu) = read_sysreg_el2(elr);
> +	vcpu->arch.ctxt.gp_regs.regs.pstate = read_sysreg_el2(spsr);
> +
> +	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
> +
> +	write_sysreg_el2(vcpu->arch.ctxt.gp_regs.regs.pstate, spsr);
> +	write_sysreg_el2(*vcpu_pc(vcpu), elr);
> +}
> +
>  #endif /* __ARM64_KVM_EMULATE_H__ */
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 52fbc823ff8c..7a5035f9c5c3 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -445,7 +445,6 @@ void kvm_arm_init_debug(void);
>  void kvm_arm_setup_debug(struct kvm_vcpu *vcpu);
>  void kvm_arm_clear_debug(struct kvm_vcpu *vcpu);
>  void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu);
> -bool kvm_arm_handle_step_debug(struct kvm_vcpu *vcpu, struct kvm_run *run);
>  int kvm_arm_vcpu_arch_set_attr(struct kvm_vcpu *vcpu,
>  			       struct kvm_device_attr *attr);
>  int kvm_arm_vcpu_arch_get_attr(struct kvm_vcpu *vcpu,
> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> index 00d422336a45..f39801e4136c 100644
> --- a/arch/arm64/kvm/debug.c
> +++ b/arch/arm64/kvm/debug.c
> @@ -236,24 +236,3 @@ void kvm_arm_clear_debug(struct kvm_vcpu *vcpu)
>  		}
>  	}
>  }
> -
> -
> -/*
> - * After successfully emulating an instruction, we might want to
> - * return to user space with a KVM_EXIT_DEBUG. We can only do this
> - * once the emulation is complete, though, so for userspace emulations
> - * we have to wait until we have re-entered KVM before calling this
> - * helper.
> - *
> - * Return true (and set exit_reason) to return to userspace or false
> - * if no further action is required.
> - */
> -bool kvm_arm_handle_step_debug(struct kvm_vcpu *vcpu, struct kvm_run *run)
> -{
> -	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP) {
> -		run->exit_reason = KVM_EXIT_DEBUG;
> -		run->debug.arch.hsr = ESR_ELx_EC_SOFTSTP_LOW << ESR_ELx_EC_SHIFT;
> -		return true;
> -	}
> -	return false;
> -}
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index 35a81bebd02b..b0643f9c4873 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -229,13 +229,6 @@ static int handle_trap_exceptions(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  		handled = exit_handler(vcpu, run);
>  	}
>
> -	/*
> -	 * kvm_arm_handle_step_debug() sets the exit_reason on the kvm_run
> -	 * structure if we need to return to userspace.
> -	 */
> -	if (handled > 0 && kvm_arm_handle_step_debug(vcpu, run))
> -		handled = 0;
> -
>  	return handled;
>  }
>
> @@ -269,12 +262,7 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  	case ARM_EXCEPTION_IRQ:
>  		return 1;
>  	case ARM_EXCEPTION_EL1_SERROR:
> -		/* We may still need to return for single-step */
> -		if (!(*vcpu_cpsr(vcpu) & DBG_SPSR_SS)
> -			&& kvm_arm_handle_step_debug(vcpu, run))
> -			return 0;
> -		else
> -			return 1;
> +		return 1;
>  	case ARM_EXCEPTION_TRAP:
>  		return handle_trap_exceptions(vcpu, run);
>  	case ARM_EXCEPTION_HYP_GONE:
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index 7cc175c88a37..4282f05771c1 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -305,33 +305,6 @@ static bool __hyp_text __populate_fault_info(struct kvm_vcpu *vcpu)
>  	return true;
>  }
>
> -/* Skip an instruction which has been emulated. Returns true if
> - * execution can continue or false if we need to exit hyp mode because
> - * single-step was in effect.
> - */
> -static bool __hyp_text __skip_instr(struct kvm_vcpu *vcpu)
> -{
> -	*vcpu_pc(vcpu) = read_sysreg_el2(elr);
> -
> -	if (vcpu_mode_is_32bit(vcpu)) {
> -		vcpu->arch.ctxt.gp_regs.regs.pstate = read_sysreg_el2(spsr);
> -		kvm_skip_instr32(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
> -		write_sysreg_el2(vcpu->arch.ctxt.gp_regs.regs.pstate, spsr);
> -	} else {
> -		*vcpu_pc(vcpu) += 4;
> -	}
> -
> -	write_sysreg_el2(*vcpu_pc(vcpu), elr);
> -
> -	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP) {
> -		vcpu->arch.fault.esr_el2 =
> -			(ESR_ELx_EC_SOFTSTP_LOW << ESR_ELx_EC_SHIFT) | 0x22;
> -		return false;
> -	} else {
> -		return true;
> -	}
> -}
> -
>  static bool __hyp_text __hyp_switch_fpsimd(struct kvm_vcpu *vcpu)
>  {
>  	struct user_fpsimd_state *host_fpsimd = vcpu->arch.host_fpsimd_state;
> @@ -420,20 +393,12 @@ static bool __hyp_text fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
>  		if (valid) {
>  			int ret = __vgic_v2_perform_cpuif_access(vcpu);
>
> -			if (ret ==  1 && __skip_instr(vcpu))
> +			if (ret == 1)
>  				return true;
>
> -			if (ret == -1) {
> -				/* Promote an illegal access to an
> -				 * SError. If we would be returning
> -				 * due to single-step clear the SS
> -				 * bit so handle_exit knows what to
> -				 * do after dealing with the error.
> -				 */
> -				if (!__skip_instr(vcpu))
> -					*vcpu_cpsr(vcpu) &= ~DBG_SPSR_SS;
> +			/* Promote an illegal access to an SError.*/
> +			if (ret == -1)
>  				*exit_code = ARM_EXCEPTION_EL1_SERROR;
> -			}
>
>  			goto exit;
>  		}
> @@ -444,7 +409,7 @@ static bool __hyp_text fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
>  	     kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_CP15_32)) {
>  		int ret = __vgic_v3_perform_cpuif_access(vcpu);
>
> -		if (ret == 1 && __skip_instr(vcpu))
> +		if (ret == 1)
>  			return true;
>  	}
>
> diff --git a/arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c b/arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c
> index 215c7c0eb3b0..9cbdd034a563 100644
> --- a/arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c
> +++ b/arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c
> @@ -41,7 +41,7 @@ static bool __hyp_text __is_be(struct kvm_vcpu *vcpu)
>   * Returns:
>   *  1: GICV access successfully performed
>   *  0: Not a GICV access
> - * -1: Illegal GICV access
> + * -1: Illegal GICV access successfully performed
>   */
>  int __hyp_text __vgic_v2_perform_cpuif_access(struct kvm_vcpu *vcpu)
>  {
> @@ -61,12 +61,16 @@ int __hyp_text __vgic_v2_perform_cpuif_access(struct kvm_vcpu *vcpu)
>  		return 0;
>
>  	/* Reject anything but a 32bit access */
> -	if (kvm_vcpu_dabt_get_as(vcpu) != sizeof(u32))
> +	if (kvm_vcpu_dabt_get_as(vcpu) != sizeof(u32)) {
> +		__kvm_skip_instr(vcpu);
>  		return -1;
> +	}
>
>  	/* Not aligned? Don't bother */
> -	if (fault_ipa & 3)
> +	if (fault_ipa & 3) {
> +		__kvm_skip_instr(vcpu);
>  		return -1;
> +	}
>
>  	rd = kvm_vcpu_dabt_get_rd(vcpu);
>  	addr  = hyp_symbol_addr(kvm_vgic_global_state)->vcpu_hyp_va;
> @@ -88,5 +92,7 @@ int __hyp_text __vgic_v2_perform_cpuif_access(struct kvm_vcpu *vcpu)
>  		vcpu_set_reg(vcpu, rd, data);
>  	}
>
> +	__kvm_skip_instr(vcpu);
> +
>  	return 1;
>  }
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 23774970c9df..4adcee5fc126 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -674,8 +674,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  		ret = kvm_handle_mmio_return(vcpu, vcpu->run);
>  		if (ret)
>  			return ret;
> -		if (kvm_arm_handle_step_debug(vcpu, vcpu->run))
> -			return 0;
>  	}
>
>  	if (run->immediate_exit)
> diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
> index 616e5a433ab0..9652c453480f 100644
> --- a/virt/kvm/arm/hyp/vgic-v3-sr.c
> +++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
> @@ -1012,8 +1012,10 @@ int __hyp_text __vgic_v3_perform_cpuif_access(struct kvm_vcpu *vcpu)
>
>  	esr = kvm_vcpu_get_hsr(vcpu);
>  	if (vcpu_mode_is_32bit(vcpu)) {
> -		if (!kvm_condition_valid(vcpu))
> +		if (!kvm_condition_valid(vcpu)) {
> +			__kvm_skip_instr(vcpu);
>  			return 1;
> +		}
>
>  		sysreg = esr_cp15_to_sysreg(esr);
>  	} else {
> @@ -1123,6 +1125,8 @@ int __hyp_text __vgic_v3_perform_cpuif_access(struct kvm_vcpu *vcpu)
>  	rt = kvm_vcpu_sys_get_rt(vcpu);
>  	fn(vcpu, vmcr, rt);
>
> +	__kvm_skip_instr(vcpu);
> +
>  	return 1;
>  }


--
Alex Benn?e
