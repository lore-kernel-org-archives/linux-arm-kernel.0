From: cdall@linaro.org (Christoffer Dall)
Date: Wed, 22 Feb 2017 12:10:17 +0100
Subject: [RFC 06/55] KVM: arm64: Add EL2 execution context for nesting
In-Reply-To: <1483943091-1364-7-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
 <1483943091-1364-7-git-send-email-jintack@cs.columbia.edu>
Message-ID: <20170222111017.GB26976@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 01:24:02AM -0500, Jintack Lim wrote:
> With the nested virtualization support, the context of the guest
> includes EL2 register states. The host manages a set of virtual EL2
> registers.  In addition to that, the guest hypervisor supposed to run in
> EL2 is now deprivilaged and runs in EL1. So, the host also manages a set
> of shadow system registers to be able to run the guest hypervisor in
> EL1.
> 
> Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm64/include/asm/kvm_host.h | 54 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index c0c8b02..ed78d73 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -146,6 +146,42 @@ enum vcpu_sysreg {
>  	NR_SYS_REGS	/* Nothing after this line! */
>  };
>  
> +enum el2_regs {
> +	ELR_EL2,
> +	SPSR_EL2,
> +	SP_EL2,
> +	AMAIR_EL2,
> +	MAIR_EL2,
> +	TCR_EL2,
> +	TTBR0_EL2,
> +	VTCR_EL2,
> +	VTTBR_EL2,
> +	VMPIDR_EL2,
> +	VPIDR_EL2,      /* 10 */
> +	MDCR_EL2,
> +	CNTHCTL_EL2,
> +	CNTHP_CTL_EL2,
> +	CNTHP_CVAL_EL2,
> +	CNTHP_TVAL_EL2,
> +	CNTVOFF_EL2,
> +	ACTLR_EL2,
> +	AFSR0_EL2,
> +	AFSR1_EL2,
> +	CPTR_EL2,       /* 20 */
> +	ESR_EL2,
> +	FAR_EL2,
> +	HACR_EL2,
> +	HCR_EL2,
> +	HPFAR_EL2,
> +	HSTR_EL2,
> +	RMR_EL2,
> +	RVBAR_EL2,
> +	SCTLR_EL2,
> +	TPIDR_EL2,      /* 30 */
> +	VBAR_EL2,
> +	NR_EL2_REGS     /* Nothing after this line! */
> +};

Why do we have a separate enum and array for the EL2 regs and not simply
expand vcpu_sysreg ?

> +
>  /* 32bit mapping */
>  #define c0_MPIDR	(MPIDR_EL1 * 2)	/* MultiProcessor ID Register */
>  #define c0_CSSELR	(CSSELR_EL1 * 2)/* Cache Size Selection Register */
> @@ -193,6 +229,23 @@ struct kvm_cpu_context {
>  		u64 sys_regs[NR_SYS_REGS];
>  		u32 copro[NR_COPRO_REGS];
>  	};
> +
> +	u64 el2_regs[NR_EL2_REGS];         /* only used for nesting */
> +	u64 shadow_sys_regs[NR_SYS_REGS];  /* only used for virtual EL2 */
> +
> +	/*
> +	 * hw_* will be used when switching to a VM. They point to either
> +	 * the virtual EL2 or EL1/EL0 context depending on vcpu mode.

don't they either point to the shadow sys regs or the the normal EL1
sysregs?

> +	 */
> +
> +	/* pointing shadow_sys_regs or sys_regs */

that's what this comment seems to indicate, so there's some duplicity
here.

> +	u64 *hw_sys_regs;
> +
> +	/* copy of either gp_regs.sp_el1 or el2_regs[SP_EL2] */
> +	u64 hw_sp_el1;
> +
> +	/* pstate written to SPSR_EL2 */
> +	u64 hw_pstate;
>  };
>  
>  typedef struct kvm_cpu_context kvm_cpu_context_t;
> @@ -277,6 +330,7 @@ struct kvm_vcpu_arch {
>  
>  #define vcpu_gp_regs(v)		(&(v)->arch.ctxt.gp_regs)
>  #define vcpu_sys_reg(v,r)	((v)->arch.ctxt.sys_regs[(r)])
> +#define vcpu_el2_reg(v, r)	((v)->arch.ctxt.el2_regs[(r)])
>  /*
>   * CP14 and CP15 live in the same array, as they are backed by the
>   * same system registers.
> -- 
> 1.9.1
> 
> 
