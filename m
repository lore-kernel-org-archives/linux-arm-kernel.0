From: antonios.motakis@huawei.com (Antonios Motakis)
Date: Tue, 22 Sep 2015 16:01:05 +0200
Subject: [PATCH 2/2] KVM/arm: enable armv7 fp/simd lazy switch
In-Reply-To: <1442538317-13618-3-git-send-email-m.smarduch@samsung.com>
References: <1442538317-13618-1-git-send-email-m.smarduch@samsung.com>
 <1442538317-13618-3-git-send-email-m.smarduch@samsung.com>
Message-ID: <56015F21.60200@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 18-Sep-15 03:05, Mario Smarduch wrote:
> Adds code to enable fp/simd lazy switch. On each entry check if fp/simd
> registers have been switched to guest, if no set the trap flag. On trap 
> switch fp/simd registers and set vfp_lazy to true and disable trapping. 
> When the vcpu is about to be put, then context switch fp/simd registers
> save guest and restore host and reset the vfp_lazy state to enable trapping 
> again.
> 

This description confused me a bit, since KVM on ARMv7 already exhibits
lazy switching behavior for VFP. Should the description highlight the
intended improvement in behavior?

If I understand correctly, instead of restoring the host state on every
exit, you postpone it until the task actually gets rescheduled, right?

> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
> ---
>  arch/arm/kvm/arm.c        | 17 +++++++++++++++++
>  arch/arm/kvm/interrupts.S | 40 +++++++++++++++++++++++++++++-----------
>  2 files changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index ce404a5..0acbb69 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -105,6 +105,20 @@ void kvm_arch_check_processor_compat(void *rtn)
>  	*(int *)rtn = 0;
>  }
>  
> +/**
> + * kvm_switch_fp_regs() - switch guest/host VFP/SIMD registers
> + * @vcpu:      pointer to vcpu structure.
> + *
> + */
> +static void kvm_switch_fp_regs(struct kvm_vcpu *vcpu)
> +{
> +#ifdef CONFIG_ARM
> +	if (vcpu->arch.vfp_lazy == 1) {
> +		kvm_call_hyp(__kvm_restore_host_vfp_state, vcpu);
> +		vcpu->arch.vfp_lazy = 0;
> +	}
> +#endif
> +}
>  
>  /**
>   * kvm_arch_init_vm - initializes a VM data structure
> @@ -295,6 +309,9 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>  
>  void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  {
> +	/* Check if Guest accessed VFP registers */
> +	kvm_switch_fp_regs(vcpu);
> +
>  	/*
>  	 * The arch-generic KVM code expects the cpu field of a vcpu to be -1
>  	 * if the vcpu is no longer assigned to a cpu.  This is used for the
> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
> index 900ef6d..a47acc1 100644
> --- a/arch/arm/kvm/interrupts.S
> +++ b/arch/arm/kvm/interrupts.S
> @@ -96,6 +96,24 @@ ENTRY(__kvm_flush_vm_context)
>  	bx	lr
>  ENDPROC(__kvm_flush_vm_context)
>  
> +/**
> + * void __kvm_restore_host_vfp_state(struct vcpu *vcpu) - Executes a lazy
> + *	fp/simd switch, saves the guest, restores host.
> + *
> + */
> +ENTRY(__kvm_restore_host_vfp_state)
> +	push    {r3-r7}
> +
> +	add     r7, r0, #VCPU_VFP_GUEST
> +	store_vfp_state r7
> +
> +	add     r7, r0, #VCPU_VFP_HOST
> +	ldr     r7, [r7]
> +	restore_vfp_state r7
> +
> +	pop     {r3-r7}
> +	bx      lr
> +ENDPROC(__kvm_restore_host_vfp_state)
>  
>  /********************************************************************
>   *  Hypervisor world-switch code
> @@ -131,7 +149,14 @@ ENTRY(__kvm_vcpu_run)
>  
>  	@ Trap coprocessor CRx accesses
>  	set_hstr vmentry
> +
> +	ldr     r1, [vcpu, #VCPU_VFP_LAZY]
> +	cmp     r1, #1
> +	beq     skip_guest_vfp_trap
> +
>  	set_hcptr vmentry, (HCPTR_TTA | HCPTR_TCP(10) | HCPTR_TCP(11))
> +skip_guest_vfp_trap:

I believe that HCPTR_TTA is not part of the floating point extensions.

> +
>  	set_hdcr vmentry
>  
>  	@ Write configured ID register into MIDR alias
> @@ -170,22 +195,12 @@ __kvm_vcpu_return:
>  	@ Don't trap coprocessor accesses for host kernel
>  	set_hstr vmexit
>  	set_hdcr vmexit
> -	set_hcptr vmexit, (HCPTR_TTA | HCPTR_TCP(10) | HCPTR_TCP(11)), after_vfp_restore
> +	set_hcptr vmexit, (HCPTR_TTA | HCPTR_TCP(10) | HCPTR_TCP(11))

If you don't use the functionality of the macro to branch on change,
then maybe the functionality should also be removed from the macro.

>  
>  #ifdef CONFIG_VFPv3
> -	@ Switch VFP/NEON hardware state to the host's
> -	add	r7, vcpu, #VCPU_VFP_GUEST
> -	store_vfp_state r7
> -	add	r7, vcpu, #VCPU_VFP_HOST
> -	ldr	r7, [r7]
> -	restore_vfp_state r7
> -
> -after_vfp_restore:
>  	@ Restore FPEXC_EN which we clobbered on entry
>  	pop	{r2}
>  	VFPFMXR FPEXC, r2
> -#else
> -after_vfp_restore:
>  #endif
>  
>  	@ Reset Hyp-role
> @@ -485,6 +500,9 @@ switch_to_guest_vfp:
>  	@ NEON/VFP used.  Turn on VFP access.
>  	set_hcptr vmtrap, (HCPTR_TCP(10) | HCPTR_TCP(11))
>  
> +	mov     r1, #1
> +	str     r1, [vcpu, #VCPU_VFP_LAZY]
> +
>  	@ Switch VFP/NEON hardware state to the guest's
>  	add	r7, r0, #VCPU_VFP_HOST
>  	ldr	r7, [r7]
> 

-- 
Antonios Motakis
Virtualization Engineer
Huawei Technologies Duesseldorf GmbH
European Research Center
Riesstrasse 25, 80992 M?nchen
