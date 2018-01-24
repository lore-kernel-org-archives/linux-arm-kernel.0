From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 24 Jan 2018 10:58:22 +0000
Subject: [PATCH] arm64: turn off xgene branch prediction while in kernel
 space
In-Reply-To: <1516760007-14670-1-git-send-email-kdinh@apm.com>
References: <1516760007-14670-1-git-send-email-kdinh@apm.com>
Message-ID: <aacf7d03-faa7-c17d-b763-c80b293106ea@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Khuong,

On 24/01/18 02:13, Khuong Dinh wrote:
> Aliasing attacks against CPU branch predictors can allow an attacker to
> redirect speculative control flow on some CPUs and potentially divulge
> information from one context to another.
> 
> This patch only supports for XGene processors.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> Signed-off-by: Khuong Dinh <kdinh@apm.com>
> ---
>  arch/arm64/include/asm/cpucaps.h |    3 ++-
>  arch/arm64/include/asm/fixmap.h  |    4 ++++
>  arch/arm64/kernel/cpu_errata.c   |   18 ++++++++++++++++++
>  arch/arm64/kernel/entry.S        |   28 ++++++++++++++++++++++++++++
>  arch/arm64/kernel/smp.c          |   34 ++++++++++++++++++++++++++++++++++
>  5 files changed, 86 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index bb26382..dc9ada1 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -45,7 +45,8 @@
>  #define ARM64_HARDEN_BRANCH_PREDICTOR		24
>  #define ARM64_HARDEN_BP_POST_GUEST_EXIT		25
>  #define ARM64_HAS_RAS_EXTN			26
> +#define ARM64_XGENE_HARDEN_BRANCH_PREDICTOR	27
>  

Why isn't this using the infrastructure that is already in place?

> -#define ARM64_NCAPS				27
> +#define ARM64_NCAPS				28
>  
>  #endif /* __ASM_CPUCAPS_H */
> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
> index ec1e6d6..d5400ca 100644
> --- a/arch/arm64/include/asm/fixmap.h
> +++ b/arch/arm64/include/asm/fixmap.h
> @@ -63,6 +63,10 @@ enum fixed_addresses {
>  	FIX_ENTRY_TRAMP_TEXT,
>  #define TRAMP_VALIAS		(__fix_to_virt(FIX_ENTRY_TRAMP_TEXT))
>  #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
> +
> +#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
> +	FIX_BOOT_CPU_BP_CTLREG,
> +#endif /* CONFIG_HARDEN_BRANCH_PREDICTOR */
>  	__end_of_permanent_fixed_addresses,
>  
>  	/*
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index ed68818..1554014 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -53,6 +53,18 @@
>  		(arm64_ftr_reg_ctrel0.sys_val & arm64_ftr_reg_ctrel0.strict_mask);
>  }
>  
> +#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
> +static bool is_xgene_cpu(const struct arm64_cpu_capabilities *entry, int scope)
> +{
> +	unsigned int midr = read_cpuid_id();
> +	unsigned int variant = MIDR_VARIANT(midr);
> +
> +	WARN_ON(scope != SCOPE_LOCAL_CPU);
> +	return MIDR_IMPLEMENTOR(midr) == ARM_CPU_IMP_APM && (variant <= 3) &&
> +					is_hyp_mode_available();
> +}

So what happens in a guest? No BP invalidation whatsoever? I don't think
that's acceptable.

> +#endif
> +
>  static int cpu_enable_trap_ctr_access(void *__unused)
>  {
>  	/* Clear SCTLR_EL1.UCT */
> @@ -369,6 +381,12 @@ static int qcom_enable_link_stack_sanitization(void *data)
>  		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
>  		.enable = enable_psci_bp_hardening,
>  	},
> +	{
> +		.desc = "ARM64 XGENE branch predictors control",
> +		.capability = ARM64_XGENE_HARDEN_BRANCH_PREDICTOR,
> +		.def_scope = SCOPE_LOCAL_CPU,
> +		.matches = is_xgene_cpu,
> +	},
>  #endif
>  	{
>  	}
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index b34e717..8c7d98e 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -62,6 +62,32 @@
>  #endif
>  	.endm
>  
> +	.macro bp_disable, tmp1, tmp2
> +#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
> +	alternative_if ARM64_XGENE_HARDEN_BRANCH_PREDICTOR
> +	adr_l	x\tmp1, bp_ctlreg
> +	mrs	x\tmp2, tpidr_el1
> +	ldr	x\tmp1, [x\tmp1, x\tmp2]
> +	ldr	w\tmp2, [x\tmp1]
> +	orr	w\tmp2, w\tmp2, #(1 << 25)
> +	str	w\tmp2, [x\tmp1]
> +	alternative_else_nop_endif
> +#endif
> +	.endm
> +
> +	.macro bp_enable, tmp1, tmp2
> +#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
> +	alternative_if ARM64_XGENE_HARDEN_BRANCH_PREDICTOR
> +	adr_l	x\tmp1, bp_ctlreg
> +	mrs	x\tmp2, tpidr_el1
> +	ldr	x\tmp1, [x\tmp1, x\tmp2]
> +	ldr	w\tmp2, [x\tmp1]
> +	and	w\tmp2, w\tmp2, #~(1 << 25)
> +	str	w\tmp2, [x\tmp1]
> +	alternative_else_nop_endif
> +#endif
> +	.endm
> +
>  /*
>   * Bad Abort numbers
>   *-----------------
> @@ -158,6 +184,7 @@ alternative_else_nop_endif
>  	stp	x28, x29, [sp, #16 * 14]
>  
>  	.if	\el == 0
> +	bp_disable 20, 21
>  	mrs	x21, sp_el0
>  	ldr_this_cpu	tsk, __entry_task, x20	// Ensure MDSCR_EL1.SS is clear,
>  	ldr	x19, [tsk, #TSK_TI_FLAGS]	// since we can unmask debug
> @@ -307,6 +334,7 @@ alternative_else_nop_endif
>  
>  	msr	elr_el1, x21			// set up the return data
>  	msr	spsr_el1, x22
> +	bp_enable 21, 22
>  	ldp	x0, x1, [sp, #16 * 0]
>  	ldp	x2, x3, [sp, #16 * 1]
>  	ldp	x4, x5, [sp, #16 * 2]

This is not what we do on other cores. Why is XGene any different?

> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 3b8ad7b..69646be 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -85,6 +85,38 @@ enum ipi_msg_type {
>  	IPI_WAKEUP
>  };
>  
> +#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
> +DEFINE_PER_CPU_READ_MOSTLY(void __iomem *, bp_ctlreg);
> +
> +static void map_bp_ctlreg(void)
> +{
> +	if (cpus_have_const_cap(ARM64_XGENE_HARDEN_BRANCH_PREDICTOR)) {
> +		u64 mpidr = read_cpuid_mpidr();
> +		unsigned int idx;
> +		void __iomem *p;
> +		phys_addr_t pa;
> +
> +		idx =  (MPIDR_AFFINITY_LEVEL(mpidr, 1) << 1) +
> +			MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +		pa = 0x7c0c0000ULL | (0x100000ULL * idx);
> +		if (smp_processor_id())
> +			p = ioremap(pa, PAGE_SIZE);
> +		else {
> +			/* boot processor uses fixmap */
> +			set_fixmap_io(FIX_BOOT_CPU_BP_CTLREG, pa);
> +			p = (void __iomem *)__fix_to_virt(
> +						FIX_BOOT_CPU_BP_CTLREG);
> +		}
> +		__this_cpu_write(bp_ctlreg, p);
> +
> +		pr_debug("%s: cpu%d idx=%d pa=0x%llx %p", __func__,
> +			 smp_processor_id(), idx, pa, p);
> +	}
> +}
> +#else
> +static inline void map_bp_ctlreg(void) {}
> +#endif
> +
>  #ifdef CONFIG_ARM64_VHE
>  
>  /* Whether the boot CPU is running in HYP mode or not*/
> @@ -224,6 +256,7 @@ asmlinkage void secondary_start_kernel(void)
>  
>  	cpu = task_cpu(current);
>  	set_my_cpu_offset(per_cpu_offset(cpu));
> +	map_bp_ctlreg();
>  
>  	/*
>  	 * All kernel threads share the same mm context; grab a
> @@ -454,6 +487,7 @@ void __init smp_prepare_boot_cpu(void)
>  	 * cpuinfo_store_boot_cpu() above.
>  	 */
>  	update_cpu_errata_workarounds();
> +	map_bp_ctlreg();
>  }
>  
>  static u64 __init of_get_cpu_mpidr(struct device_node *dn)
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
