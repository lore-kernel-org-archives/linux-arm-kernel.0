From: will.deacon@arm.com (Will Deacon)
Date: Fri, 23 Nov 2012 16:30:26 +0000
Subject: [PATCH v4 4/5] ARM: KVM: arch_timers: Add timer world switch
In-Reply-To: <20121110154625.3274.39369.stgit@chazy-air>
References: <20121110154554.3274.77777.stgit@chazy-air>
 <20121110154625.3274.39369.stgit@chazy-air>
Message-ID: <20121123163026.GL32200@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2012 at 03:46:25PM +0000, Christoffer Dall wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> Do the necessary save/restore dance for the timers in the world
> switch code. In the process, allow the guest to read the physical
> counter, which is useful for its own clock_event_device.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
> ---
>  arch/arm/kernel/asm-offsets.c  |    8 ++++++++
>  arch/arm/kvm/arm.c             |    3 +++
>  arch/arm/kvm/interrupts_head.S |   41 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+)
> 
> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
> index 39b6221..50df318 100644
> --- a/arch/arm/kernel/asm-offsets.c
> +++ b/arch/arm/kernel/asm-offsets.c
> @@ -177,6 +177,14 @@ int main(void)
>    DEFINE(VGIC_CPU_APR,		offsetof(struct vgic_cpu, vgic_apr));
>    DEFINE(VGIC_CPU_LR,		offsetof(struct vgic_cpu, vgic_lr));
>    DEFINE(VGIC_CPU_NR_LR,	offsetof(struct vgic_cpu, nr_lr));
> +#ifdef CONFIG_KVM_ARM_TIMER
> +  DEFINE(VCPU_TIMER_CNTV_CTL,	offsetof(struct kvm_vcpu, arch.timer_cpu.cntv_ctl));
> +  DEFINE(VCPU_TIMER_CNTV_CVALH,	offsetof(struct kvm_vcpu, arch.timer_cpu.cntv_cval32.high));
> +  DEFINE(VCPU_TIMER_CNTV_CVALL,	offsetof(struct kvm_vcpu, arch.timer_cpu.cntv_cval32.low));
> +  DEFINE(KVM_TIMER_CNTVOFF_H,	offsetof(struct kvm, arch.timer.cntvoff32.high));
> +  DEFINE(KVM_TIMER_CNTVOFF_L,	offsetof(struct kvm, arch.timer.cntvoff32.low));
> +  DEFINE(KVM_TIMER_ENABLED,	offsetof(struct kvm, arch.timer.enabled));
> +#endif
>    DEFINE(KVM_VGIC_VCTRL,	offsetof(struct kvm, arch.vgic.vctrl_base));
>  #endif
>    DEFINE(KVM_VTTBR,		offsetof(struct kvm, arch.vttbr));
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 1716f12..8cdef69 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -661,6 +661,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  		update_vttbr(vcpu->kvm);
>  
>  		kvm_vgic_sync_to_cpu(vcpu);
> +		kvm_timer_sync_to_cpu(vcpu);
>  
>  		local_irq_disable();
>  
> @@ -674,6 +675,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  
>  		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm)) {
>  			local_irq_enable();
> +			kvm_timer_sync_from_cpu(vcpu);
>  			kvm_vgic_sync_from_cpu(vcpu);
>  			continue;
>  		}
> @@ -713,6 +715,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  		 * Back from guest
>  		 *************************************************************/
>  
> +		kvm_timer_sync_from_cpu(vcpu);
>  		kvm_vgic_sync_from_cpu(vcpu);
>  
>  		ret = handle_exit(vcpu, run, ret);
> diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
> index 0003aab..ece84d1 100644
> --- a/arch/arm/kvm/interrupts_head.S
> +++ b/arch/arm/kvm/interrupts_head.S
> @@ -422,6 +422,25 @@
>  #define CNTHCTL_PL1PCEN		(1 << 1)
>  
>  .macro save_timer_state	vcpup
> +#ifdef CONFIG_KVM_ARM_TIMER
> +	ldr	r4, [\vcpup, #VCPU_KVM]
> +	ldr	r2, [r4, #KVM_TIMER_ENABLED]
> +	cmp	r2, #0
> +	beq	1f
> +
> +	mrc	p15, 0, r2, c14, c3, 1	@ CNTV_CTL
> +	and	r2, #3

Why do you need this and (you do the masking on the restore path)?

> +	str	r2, [\vcpup, #VCPU_TIMER_CNTV_CTL]
> +	bic	r2, #1			@ Clear ENABLE
> +	mcr	p15, 0, r2, c14, c3, 1	@ CNTV_CTL
> +	isb
> +
> +	mrrc	p15, 3, r2, r3, c14	@ CNTV_CVAL
> +	str	r3, [\vcpup, #VCPU_TIMER_CNTV_CVALH]
> +	str	r2, [\vcpup, #VCPU_TIMER_CNTV_CVALL]
> +
> +1:
> +#endif
>  	@ Allow physical timer/counter access for the host
>  	mrc	p15, 4, r2, c14, c1, 0	@ CNTHCTL
>  	orr	r2, r2, #(CNTHCTL_PL1PCEN | CNTHCTL_PL1PCTEN)
> @@ -435,6 +454,28 @@
>  	orr	r2, r2, #CNTHCTL_PL1PCTEN
>  	bic	r2, r2, #CNTHCTL_PL1PCEN
>  	mcr	p15, 4, r2, c14, c1, 0	@ CNTHCTL
> +
> +#ifdef CONFIG_KVM_ARM_TIMER
> +	ldr	r4, [\vcpup, #VCPU_KVM]
> +	ldr	r2, [r4, #KVM_TIMER_ENABLED]
> +	cmp	r2, #0
> +	beq	1f
> +
> +	ldr	r3, [r4, #KVM_TIMER_CNTVOFF_H]
> +	ldr	r2, [r4, #KVM_TIMER_CNTVOFF_L]
> +	mcrr	p15, 4, r2, r3, c14	@ CNTVOFF
> +	isb
> +
> +	ldr	r3, [\vcpup, #VCPU_TIMER_CNTV_CVALH]
> +	ldr	r2, [\vcpup, #VCPU_TIMER_CNTV_CVALL]
> +	mcrr	p15, 3, r2, r3, c14	@ CNTV_CVAL
> +
> +	ldr	r2, [\vcpup, #VCPU_TIMER_CNTV_CTL]
> +	and	r2, #3

Please use the long form syntax for these instructions (and r2, r2, #3) as
toolchains have historically been picky about accepting these when not
targetting Thumb and it also makes it consistent with the rest of arch/arm/.

> +	mcr	p15, 0, r2, c14, c3, 1	@ CNTV_CTL
> +	isb
> +1:
> +#endif

It's pretty horrible to take a macro argument (vcpup) and then open-code all
the other register numbers without moving the argument somewhere nice. Are
callers just expected to understand that you clobber {r2,r3,r4} and avoid
them? If so, why not just use the PCS so that people don't have to learn a
new convention?

Will
