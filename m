From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 16 Oct 2017 23:18:57 +0200
Subject: [RFC 4/7] arm64: irqflags: Use ICC sysregs to implement IRQ
 masking
In-Reply-To: <1507726862-11944-5-git-send-email-julien.thierry@arm.com>
References: <1507726862-11944-1-git-send-email-julien.thierry@arm.com>
 <1507726862-11944-5-git-send-email-julien.thierry@arm.com>
Message-ID: <20171016211857.GQ1845@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 02:00:59PM +0100, Julien Thierry wrote:
> From: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Currently irqflags is implemented using the PSR's I bit. It is possible
> to implement irqflags by using the co-processor interface to the GIC.
> Using the co-processor interface makes it feasible to simulate NMIs
> using GIC interrupt prioritization.
> 
> This patch changes the irqflags macros to modify, save and restore
> ICC_PMR_EL1. This has a substantial knock on effect for the rest of
> the kernel. There are four reasons for this:
> 
> 1. The state of the PMR becomes part of the interrupt context and must be
>    saved and restored during exceptions. It is saved on the stack as part
>    of the saved context when an interrupt/exception is taken.
> 
> 2. The hardware automatically masks the I bit (at boot, during traps, etc).
>    When the I bit is set by hardware we must add code to switch from I
>    bit masking and PMR masking:
>        - For IRQs, this is done after the interrupt has been acknowledged
>        	 avoiding the need to unmask.
>        - For other exceptions, this is done right after saving the context.
> 
> 3. Some instructions, such as wfi, require that the PMR not be used
>    for interrupt masking. Before calling these instructions we must
>    switch from PMR masking to I bit masking.
>    This is also the case when KVM runs a guest, if the CPU receives
>    an interrupt from the host, interrupts must not be masked in PMR
>    otherwise the GIC will not signal it to the CPU.
> 
> 4. We use the alternatives system to allow a single kernel to boot and
>    be switched to the alternative masking approach at runtime.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> [julien.thierry at arm.com: changes reflected in commit,
> 			 message, fixes, renaming]
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
---

I just gave a quick look to the KVM part here but didn't get into
whether this rather invasive change is warranted or not (it's definitely
entertaining though).

[...]


> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index e923b58..070e8a5 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -38,6 +38,10 @@
>  #include <kvm/arm_arch_timer.h>
>  #include <kvm/arm_pmu.h>
> 
> +#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
> +#include <asm/arch_gicv3.h>
> +#endif
> +
>  #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
> 
>  #define KVM_VCPU_MAX_FEATURES 4
> @@ -332,7 +336,30 @@ int kvm_unmap_hva_range(struct kvm *kvm,
>  void kvm_arm_resume_guest(struct kvm *kvm);
> 
>  u64 __kvm_call_hyp(void *hypfn, ...);
> +
> +#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
> +/*
> + * If we use PMR to disable interrupts, interrupts happening while the

I would describe this as 'masking' interrupts, as opposed to 'disabling'
interrupts, in general, and probably we can be more precise by
categorizing interrupts as 'normal' vs. 'priority (NMIs)' or something
like that.

> + * guest is executing will not be signaled to the host by the GIC  (and

signaled to the CPU.  (Whether this then causes an exception to EL2
depends on the HCR_EL2.IMO flag and what KVM does with that exception).

> + * any call to a waiting kvm_kick_many_cpus will likely cause a
> + * deadlock).

This kick thing is an unccessary specific example to bring out here, I
don't think it adds to the general understanding.

> + * We need to switch back to using PSR.I.
> + */
> +#define kvm_call_hyp(f, ...)						\
> +	({								\
> +		u64 res;						\
> +		unsigned long flags;					\
> +									\
> +		flags = arch_local_irq_save();				\
> +		gic_end_pmr_masking();					\
> +		res = __kvm_call_hyp(kvm_ksym_ref(f), ##__VA_ARGS__);	\
> +		gic_start_pmr_masking();				\
> +		arch_local_irq_restore(flags);				\
> +		res;							\

This is in the critical path, so ideally this could instead be done
inside the function, because the trap will set PSTATE.I already, so it
should be possible to reduce this to a set of save/clear/restore
operations after __kvm_call_hyp.

> +	})
> +#else
>  #define kvm_call_hyp(f, ...) __kvm_call_hyp(kvm_ksym_ref(f), ##__VA_ARGS__)
> +#endif
> 
>  void force_vm_exit(const cpumask_t *mask);
>  void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
> @@ -349,6 +376,9 @@ static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
>  				       unsigned long hyp_stack_ptr,
>  				       unsigned long vector_ptr)
>  {
> +#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
> +	unsigned long flags;
> +#endif
>  	/*
>  	 * Call initialization code, and switch to the full blown HYP code.
>  	 * If the cpucaps haven't been finalized yet, something has gone very
> @@ -356,7 +386,17 @@ static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
>  	 * cpus_have_const_cap() wrapper.
>  	 */
>  	BUG_ON(!static_branch_likely(&arm64_const_caps_ready));
> +#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
> +	flags = arch_local_irq_save();
> +	gic_end_pmr_masking();
> +#endif
> +
>  	__kvm_call_hyp((void *)pgd_ptr, hyp_stack_ptr, vector_ptr);
> +
> +#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
> +	gic_start_pmr_masking();
> +	arch_local_irq_restore(flags);
> +#endif

I don't think you need any of this, because I don't think you'd ever
need to handle interrupts while initializing hyp mode.

>  }
> 
Thanks,
-Christoffer
