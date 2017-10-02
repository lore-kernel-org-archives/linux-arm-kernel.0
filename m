From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 2 Oct 2017 10:55:27 +0100
Subject: [PATCH v5 4/7] arm64: sysreg: Move SPE registers and PSB into
 common header files
In-Reply-To: <1506607791-8621-5-git-send-email-will.deacon@arm.com>
References: <1506607791-8621-1-git-send-email-will.deacon@arm.com>
 <1506607791-8621-5-git-send-email-will.deacon@arm.com>
Message-ID: <20171002095527.GB20737@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 03:09:48PM +0100, Will Deacon wrote:
> SPE is part of the v8.2 architecture, so move its system register and
> field definitions into sysreg.h and the new PSB barrier into barrier.h
> 
> Finally, move KVM over to using the generic definitions so that it
> doesn't have to open-code its own versions.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Thanks for splitting this out.

FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/barrier.h |  2 +
>  arch/arm64/include/asm/sysreg.h  | 93 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm64/kvm/hyp/debug-sr.c    | 24 +++--------
>  3 files changed, 102 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index 0fe7e43b7fbc..77651c49ef44 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -31,6 +31,8 @@
>  #define dmb(opt)	asm volatile("dmb " #opt : : : "memory")
>  #define dsb(opt)	asm volatile("dsb " #opt : : : "memory")
>  
> +#define psb_csync()	asm volatile("hint #17" : : : "memory")
> +
>  #define mb()		dsb(sy)
>  #define rmb()		dsb(ld)
>  #define wmb()		dsb(st)
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index f707fed5886f..94b7a0d42aad 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -172,6 +172,99 @@
>  #define SYS_FAR_EL1			sys_reg(3, 0, 6, 0, 0)
>  #define SYS_PAR_EL1			sys_reg(3, 0, 7, 4, 0)
>  
> +/*** Statistical Profiling Extension ***/
> +/* ID registers */
> +#define SYS_PMSIDR_EL1			sys_reg(3, 0, 9, 9, 7)
> +#define SYS_PMSIDR_EL1_FE_SHIFT		0
> +#define SYS_PMSIDR_EL1_FT_SHIFT		1
> +#define SYS_PMSIDR_EL1_FL_SHIFT		2
> +#define SYS_PMSIDR_EL1_ARCHINST_SHIFT	3
> +#define SYS_PMSIDR_EL1_LDS_SHIFT	4
> +#define SYS_PMSIDR_EL1_ERND_SHIFT	5
> +#define SYS_PMSIDR_EL1_INTERVAL_SHIFT	8
> +#define SYS_PMSIDR_EL1_INTERVAL_MASK	0xfUL
> +#define SYS_PMSIDR_EL1_MAXSIZE_SHIFT	12
> +#define SYS_PMSIDR_EL1_MAXSIZE_MASK	0xfUL
> +#define SYS_PMSIDR_EL1_COUNTSIZE_SHIFT	16
> +#define SYS_PMSIDR_EL1_COUNTSIZE_MASK	0xfUL
> +
> +#define SYS_PMBIDR_EL1			sys_reg(3, 0, 9, 10, 7)
> +#define SYS_PMBIDR_EL1_ALIGN_SHIFT	0
> +#define SYS_PMBIDR_EL1_ALIGN_MASK	0xfU
> +#define SYS_PMBIDR_EL1_P_SHIFT		4
> +#define SYS_PMBIDR_EL1_F_SHIFT		5
> +
> +/* Sampling controls */
> +#define SYS_PMSCR_EL1			sys_reg(3, 0, 9, 9, 0)
> +#define SYS_PMSCR_EL1_E0SPE_SHIFT	0
> +#define SYS_PMSCR_EL1_E1SPE_SHIFT	1
> +#define SYS_PMSCR_EL1_CX_SHIFT		3
> +#define SYS_PMSCR_EL1_PA_SHIFT		4
> +#define SYS_PMSCR_EL1_TS_SHIFT		5
> +#define SYS_PMSCR_EL1_PCT_SHIFT		6
> +
> +#define SYS_PMSCR_EL2			sys_reg(3, 4, 9, 9, 0)
> +#define SYS_PMSCR_EL2_E0HSPE_SHIFT	0
> +#define SYS_PMSCR_EL2_E2SPE_SHIFT	1
> +#define SYS_PMSCR_EL2_CX_SHIFT		3
> +#define SYS_PMSCR_EL2_PA_SHIFT		4
> +#define SYS_PMSCR_EL2_TS_SHIFT		5
> +#define SYS_PMSCR_EL2_PCT_SHIFT		6
> +
> +#define SYS_PMSICR_EL1			sys_reg(3, 0, 9, 9, 2)
> +
> +#define SYS_PMSIRR_EL1			sys_reg(3, 0, 9, 9, 3)
> +#define SYS_PMSIRR_EL1_RND_SHIFT	0
> +#define SYS_PMSIRR_EL1_INTERVAL_SHIFT	8
> +#define SYS_PMSIRR_EL1_INTERVAL_MASK	0xffffffUL
> +
> +/* Filtering controls */
> +#define SYS_PMSFCR_EL1			sys_reg(3, 0, 9, 9, 4)
> +#define SYS_PMSFCR_EL1_FE_SHIFT		0
> +#define SYS_PMSFCR_EL1_FT_SHIFT		1
> +#define SYS_PMSFCR_EL1_FL_SHIFT		2
> +#define SYS_PMSFCR_EL1_B_SHIFT		16
> +#define SYS_PMSFCR_EL1_LD_SHIFT		17
> +#define SYS_PMSFCR_EL1_ST_SHIFT		18
> +
> +#define SYS_PMSEVFR_EL1			sys_reg(3, 0, 9, 9, 5)
> +#define SYS_PMSEVFR_EL1_RES0		0x0000ffff00ff0f55UL
> +
> +#define SYS_PMSLATFR_EL1		sys_reg(3, 0, 9, 9, 6)
> +#define SYS_PMSLATFR_EL1_MINLAT_SHIFT	0
> +
> +/* Buffer controls */
> +#define SYS_PMBLIMITR_EL1		sys_reg(3, 0, 9, 10, 0)
> +#define SYS_PMBLIMITR_EL1_E_SHIFT	0
> +#define SYS_PMBLIMITR_EL1_FM_SHIFT	1
> +#define SYS_PMBLIMITR_EL1_FM_MASK	0x3UL
> +#define SYS_PMBLIMITR_EL1_FM_STOP_IRQ	(0 << SYS_PMBLIMITR_EL1_FM_SHIFT)
> +
> +#define SYS_PMBPTR_EL1			sys_reg(3, 0, 9, 10, 1)
> +
> +/* Buffer error reporting */
> +#define SYS_PMBSR_EL1			sys_reg(3, 0, 9, 10, 3)
> +#define SYS_PMBSR_EL1_COLL_SHIFT	16
> +#define SYS_PMBSR_EL1_S_SHIFT		17
> +#define SYS_PMBSR_EL1_EA_SHIFT		18
> +#define SYS_PMBSR_EL1_DL_SHIFT		19
> +#define SYS_PMBSR_EL1_EC_SHIFT		26
> +#define SYS_PMBSR_EL1_EC_MASK		0x3fUL
> +
> +#define SYS_PMBSR_EL1_EC_BUF		(0x0UL << SYS_PMBSR_EL1_EC_SHIFT)
> +#define SYS_PMBSR_EL1_EC_FAULT_S1	(0x24UL << SYS_PMBSR_EL1_EC_SHIFT)
> +#define SYS_PMBSR_EL1_EC_FAULT_S2	(0x25UL << SYS_PMBSR_EL1_EC_SHIFT)
> +
> +#define SYS_PMBSR_EL1_FAULT_FSC_SHIFT	0
> +#define SYS_PMBSR_EL1_FAULT_FSC_MASK	0x3fUL
> +
> +#define SYS_PMBSR_EL1_BUF_BSC_SHIFT	0
> +#define SYS_PMBSR_EL1_BUF_BSC_MASK	0x3fUL
> +
> +#define SYS_PMBSR_EL1_BUF_BSC_FULL	(0x1UL << SYS_PMBSR_EL1_BUF_BSC_SHIFT)
> +
> +/*** End of Statistical Profiling Extension ***/
> +
>  #define SYS_PMINTENSET_EL1		sys_reg(3, 0, 9, 14, 1)
>  #define SYS_PMINTENCLR_EL1		sys_reg(3, 0, 9, 14, 2)
>  
> diff --git a/arch/arm64/kvm/hyp/debug-sr.c b/arch/arm64/kvm/hyp/debug-sr.c
> index f5154ed3da6c..321c9c05dd9e 100644
> --- a/arch/arm64/kvm/hyp/debug-sr.c
> +++ b/arch/arm64/kvm/hyp/debug-sr.c
> @@ -65,16 +65,6 @@
>  	default:	write_debug(ptr[0], reg, 0);			\
>  	}
>  
> -#define PMSCR_EL1		sys_reg(3, 0, 9, 9, 0)
> -
> -#define PMBLIMITR_EL1		sys_reg(3, 0, 9, 10, 0)
> -#define PMBLIMITR_EL1_E		BIT(0)
> -
> -#define PMBIDR_EL1		sys_reg(3, 0, 9, 10, 7)
> -#define PMBIDR_EL1_P		BIT(4)
> -
> -#define psb_csync()		asm volatile("hint #17")
> -
>  static void __hyp_text __debug_save_spe_vhe(u64 *pmscr_el1)
>  {
>  	/* The vcpu can run. but it can't hide. */
> @@ -90,18 +80,18 @@ static void __hyp_text __debug_save_spe_nvhe(u64 *pmscr_el1)
>  		return;
>  
>  	/* Yes; is it owned by EL3? */
> -	reg = read_sysreg_s(PMBIDR_EL1);
> -	if (reg & PMBIDR_EL1_P)
> +	reg = read_sysreg_s(SYS_PMBIDR_EL1);
> +	if (reg & BIT(SYS_PMBIDR_EL1_P_SHIFT))
>  		return;
>  
>  	/* No; is the host actually using the thing? */
> -	reg = read_sysreg_s(PMBLIMITR_EL1);
> -	if (!(reg & PMBLIMITR_EL1_E))
> +	reg = read_sysreg_s(SYS_PMBLIMITR_EL1);
> +	if (!(reg & BIT(SYS_PMBLIMITR_EL1_E_SHIFT)))
>  		return;
>  
>  	/* Yes; save the control register and disable data generation */
> -	*pmscr_el1 = read_sysreg_s(PMSCR_EL1);
> -	write_sysreg_s(0, PMSCR_EL1);
> +	*pmscr_el1 = read_sysreg_s(SYS_PMSCR_EL1);
> +	write_sysreg_s(0, SYS_PMSCR_EL1);
>  	isb();
>  
>  	/* Now drain all buffered data to memory */
> @@ -122,7 +112,7 @@ static void __hyp_text __debug_restore_spe(u64 pmscr_el1)
>  	isb();
>  
>  	/* Re-enable data generation */
> -	write_sysreg_s(pmscr_el1, PMSCR_EL1);
> +	write_sysreg_s(pmscr_el1, SYS_PMSCR_EL1);
>  }
>  
>  void __hyp_text __debug_save_state(struct kvm_vcpu *vcpu,
> -- 
> 2.1.4
> 
