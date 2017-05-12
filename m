From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 May 2017 18:07:22 +0100
Subject: [PATCHv3] arm64/cpufeature: don't use mutex in bringup path
In-Reply-To: <1494584120-15208-1-git-send-email-mark.rutland@arm.com>
References: <1494584120-15208-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20170512170722.GJ26181@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 11:15:20AM +0100, Mark Rutland wrote:
> Currently, cpus_set_cap() calls static_branch_enable_cpuslocked(), which
> must take the jump_label mutex.
> 
> We call cpus_set_cap() in the secondary bringup path, from the idle
> thread where interrupts are disabled. Taking a mutex in this path "is a
> NONO" regardless of whether it's contended, and something we must avoid.
> Additionally, the secondary CPU doesn't hold the percpu rwsem (as this
> is held by the primary CPU), so this triggers a lockdep splat.
> 
> This patch fixes both issues. The poking of static keys is deferred
> until enable_cpu_capabilities(), which runs in a suitable context on the
> boot CPU. To account for the static keys being set later,
> cpus_have_const_cap() is updated to use another static key to check
> whether the const cap keys have been initialised, falling back to the
> caps bitmap until this is the case.
> 
> This means that users of cpus_have_const_cap() gain should only gain a
> single additional NOP in the fast path once the const caps are
> initialised, but should always see the current cap value.
> 
> The hyp code should never dereference the caps array, since the caps are
> initialized before we run the module initcall to initialise hyp. A check
> is added to the hyp init code to docuemnt this requirement.
> 
> This rework means that we can remove the *_cpuslocked() helpers added in
> commit d54bb72551b999dd ("arm64/cpufeature: Use
> static_branch_enable_cpuslocked()").
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyniger <marc.zyngier@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Sebastian Sewior <bigeasy@linutronix.de>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h | 13 ++++++++++---
>  arch/arm64/include/asm/kvm_host.h   |  8 ++++++--
>  arch/arm64/kernel/cpu_errata.c      |  9 +--------
>  arch/arm64/kernel/cpufeature.c      | 25 ++++++++++++++++++++++---
>  4 files changed, 39 insertions(+), 16 deletions(-)
> 
> Catalin, Will, assuming you're happy with the patch, it will need to go via the
> tip tree.

Fine by me, although there's a typo in the comment (see below).

> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 5e19165..51d3d3c 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -24,6 +24,7 @@
>  
>  #include <linux/types.h>
>  #include <linux/kvm_types.h>
> +#include <asm/cpufeature.h>
>  #include <asm/kvm.h>
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_mmio.h>
> @@ -355,9 +356,12 @@ static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
>  				       unsigned long vector_ptr)
>  {
>  	/*
> -	 * Call initialization code, and switch to the full blown
> -	 * HYP code.
> +	 * Call initialization code, and switch to the full blown HYP code.
> +	 * If the cpucaps haven't been finialized yet, something has gone very
> +	 * wrong, and hyp will crash and burn when it uses any
> +	 * cpus_have_const_cap() wrapper.

Typo: finialized

>  	 */
> +	BUG_ON(!static_branch_likely(&arm64_const_caps_ready));
>  	__kvm_call_hyp((void *)pgd_ptr, hyp_stack_ptr, vector_ptr);
>  }
>  
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 57d60fa..2ed2a76 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -190,16 +190,9 @@ void verify_local_cpu_errata_workarounds(void)
>  		}
>  }
>  
> -void update_cpu_errata_workarounds_cpuslocked(void)
> -{
> -	update_cpu_capabilities(arm64_errata, "enabling workaround for");
> -}
> -
>  void update_cpu_errata_workarounds(void)
>  {
> -	get_online_cpus();
> -	update_cpu_errata_workarounds_cpuslocked();
> -	put_online_cpus();
> +	update_cpu_capabilities(arm64_errata, "enabling workaround for");
>  }
>  
>  void __init enable_errata_workarounds(void)
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 803afae..4a89f59 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -986,8 +986,16 @@ void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
>   */
>  void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
>  {
> -	for (; caps->matches; caps++)
> -		if (caps->enable && cpus_have_cap(caps->capability))
> +	for (; caps->matches; caps++) {
> +		unsigned int num = caps->capability;
> +
> +		if (!cpus_have_cap(num))
> +			continue;
> +
> +		/* Ensure cpus_have_const_cap(num) works */
> +		static_branch_enable(&cpu_hwcap_keys[num]);
> +
> +		if (caps->enable) {
>  			/*
>  			 * Use stop_machine() as it schedules the work allowing
>  			 * us to modify PSTATE, instead of on_each_cpu() which
> @@ -995,6 +1003,8 @@ void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
>  			 * we return.
>  			 */
>  			stop_machine(caps->enable, NULL, cpu_online_mask);
> +		}
> +	}
>  }
>  
>  /*
> @@ -1086,7 +1096,7 @@ void check_local_cpu_capabilities(void)
>  	 * advertised capabilities.
>  	 */
>  	if (!sys_caps_initialised)
> -		update_cpu_errata_workarounds_cpuslocked();
> +		update_cpu_errata_workarounds();
>  	else
>  		verify_local_cpu_capabilities();
>  }
> @@ -1099,6 +1109,14 @@ static void __init setup_feature_capabilities(void)
>  	enable_cpu_capabilities(arm64_features);
>  }
>  
> +DEFINE_STATIC_KEY_FALSE(arm64_const_caps_ready);
> +EXPORT_SYMBOL(arm64_const_caps_ready);
> +
> +static void __init mark_const_caps_ready(void)
> +{
> +	static_branch_enable(&arm64_const_caps_ready);
> +}
> +
>  /*
>   * Check if the current CPU has a given feature capability.
>   * Should be called from non-preemptible context.
> @@ -1134,6 +1152,7 @@ void __init setup_cpu_features(void)
>  	/* Set the CPU feature capabilies */
>  	setup_feature_capabilities();
>  	enable_errata_workarounds();
> +	mark_const_caps_ready();

Does this make you the eponymous developer of the CPU capability framework?

Will
