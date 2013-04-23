From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Tue, 23 Apr 2013 16:00:24 -0700
Subject: [PATCH v3 20/32] arm64: KVM: Plug the arch timer
In-Reply-To: <1365437854-30214-21-git-send-email-marc.zyngier@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-21-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130423230024.GH20569@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 05:17:22PM +0100, Marc Zyngier wrote:
> Add support for the in-kernel timer emulation. The include file
> is a complete duplicate of the 32bit one - something to fix
> at one point.

again, I'd really like to see this fixed before we merge the code...

> 
> Reviewed-by: Christopher Covington <cov@codeaurora.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/kvm/arch_timer.c               |  1 +
>  arch/arm64/include/asm/kvm_arch_timer.h | 58 +++++++++++++++++++++++++++++++++
>  arch/arm64/kvm/hyp.S                    | 56 +++++++++++++++++++++++++++++++
>  3 files changed, 115 insertions(+)
>  create mode 100644 arch/arm64/include/asm/kvm_arch_timer.h
> 
> diff --git a/arch/arm/kvm/arch_timer.c b/arch/arm/kvm/arch_timer.c
> index c55b608..49a7516 100644
> --- a/arch/arm/kvm/arch_timer.c
> +++ b/arch/arm/kvm/arch_timer.c
> @@ -195,6 +195,7 @@ static struct notifier_block kvm_timer_cpu_nb = {
>  
>  static const struct of_device_id arch_timer_of_match[] = {
>  	{ .compatible	= "arm,armv7-timer",	},
> +	{ .compatible	= "arm,armv8-timer",	},
>  	{},
>  };
>  
> diff --git a/arch/arm64/include/asm/kvm_arch_timer.h b/arch/arm64/include/asm/kvm_arch_timer.h
> new file mode 100644
> index 0000000..eb02273
> --- /dev/null
> +++ b/arch/arm64/include/asm/kvm_arch_timer.h
> @@ -0,0 +1,58 @@
> +/*
> + * Copyright (C) 2012 ARM Ltd.
> + * Author: Marc Zyngier <marc.zyngier@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef __ARM64_KVM_ARCH_TIMER_H
> +#define __ARM64_KVM_ARCH_TIMER_H
> +
> +#include <linux/clocksource.h>
> +#include <linux/hrtimer.h>
> +#include <linux/workqueue.h>
> +
> +struct arch_timer_kvm {
> +	/* Is the timer enabled */
> +	bool			enabled;
> +
> +	/* Virtual offset, restored only */
> +	cycle_t			cntvoff;
> +};
> +
> +struct arch_timer_cpu {
> +	/* Background timer used when the guest is not running */
> +	struct hrtimer			timer;
> +
> +	/* Work queued with the above timer expires */
> +	struct work_struct		expired;
> +
> +	/* Background timer active */
> +	bool				armed;
> +
> +	/* Timer IRQ */
> +	const struct kvm_irq_level	*irq;
> +
> +	/* Registers: control register, timer value */
> +	u32				cntv_ctl;	/* Saved/restored */
> +	cycle_t				cntv_cval;	/* Saved/restored */
> +};
> +
> +int kvm_timer_hyp_init(void);
> +int kvm_timer_init(struct kvm *kvm);
> +void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu);
> +void kvm_timer_flush_hwstate(struct kvm_vcpu *vcpu);
> +void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu);
> +void kvm_timer_vcpu_terminate(struct kvm_vcpu *vcpu);
> +
> +#endif
> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> index cc3192e..25da0b5 100644
> --- a/arch/arm64/kvm/hyp.S
> +++ b/arch/arm64/kvm/hyp.S
> @@ -390,6 +390,60 @@ __kvm_hyp_code_start:
>  2:
>  .endm
>  
> +.macro save_timer_state
> +	// x0: vcpu pointer
> +	ldr	x2, [x0, #VCPU_KVM]
> +	kern_hyp_va x2
> +	ldr	w3, [x2, #KVM_TIMER_ENABLED]
> +	cbz	w3, 1f
> +
> +	mrs	x3, cntv_ctl_el0
> +	and	x3, x3, #3
> +	str	w3, [x0, #VCPU_TIMER_CNTV_CTL]
> +	bic	x3, x3, #1		// Clear Enable
> +	msr	cntv_ctl_el0, x3
> +
> +	isb
> +
> +	mrs	x3, cntv_cval_el0
> +	str	x3, [x0, #VCPU_TIMER_CNTV_CVAL]
> +
> +1:
> +	// Allow physical timer/counter access for the host
> +	mrs	x2, cnthctl_el2
> +	orr	x2, x2, #3
> +	msr	cnthctl_el2, x2
> +
> +	// Clear cntvoff for the host
> +	msr	cntvoff_el2, xzr
> +.endm
> +
> +.macro restore_timer_state
> +	// x0: vcpu pointer
> +	// Disallow physical timer access for the guest
> +	// Physical counter access is allowed
> +	mrs	x2, cnthctl_el2
> +	orr	x2, x2, #1
> +	bic	x2, x2, #2
> +	msr	cnthctl_el2, x2
> +
> +	ldr	x2, [x0, #VCPU_KVM]
> +	kern_hyp_va x2
> +	ldr	w3, [x2, #KVM_TIMER_ENABLED]
> +	cbz	w3, 1f
> +
> +	ldr	x3, [x2, #KVM_TIMER_CNTVOFF]
> +	msr	cntvoff_el2, x3
> +	ldr	x2, [x0, #VCPU_TIMER_CNTV_CVAL]
> +	msr	cntv_cval_el0, x2
> +	isb
> +
> +	ldr	w2, [x0, #VCPU_TIMER_CNTV_CTL]
> +	and	x2, x2, #3
> +	msr	cntv_ctl_el0, x2
> +1:
> +.endm
> +
>  __save_sysregs:
>  	save_sysregs
>  	ret
> @@ -433,6 +487,7 @@ ENTRY(__kvm_vcpu_run)
>  	activate_vm
>  
>  	restore_vgic_state
> +	restore_timer_state
>  
>  	// Guest context
>  	add	x2, x0, #VCPU_CONTEXT
> @@ -456,6 +511,7 @@ __kvm_vcpu_return:
>  	bl __save_fpsimd
>  	bl __save_sysregs
>  
> +	save_timer_state
>  	save_vgic_state
>  
>  	deactivate_traps
> -- 
> 1.8.1.4
> 
> 
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm
