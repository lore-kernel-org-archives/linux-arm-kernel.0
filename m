From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Aug 2016 13:53:43 +0100
Subject: [PATCH 7/8] arm64: Refactor sysinstr exception handling
In-Reply-To: <1471525832-21209-8-git-send-email-suzuki.poulose@arm.com>
References: <1471525832-21209-1-git-send-email-suzuki.poulose@arm.com>
 <1471525832-21209-8-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160822125343.GE14680@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 02:10:31PM +0100, Suzuki K Poulose wrote:
> Right now we trap some of the user space data cache operations
> based on a few Errata (ARM 819472, 826319, 827319 and 824069).
> We need to trap userspace access to CTR_EL0, if we detect mismatched
> cache line size. Since both these traps share the EC, refactor
> the handler a little bit to make it a bit more reader friendly.
> 
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/esr.h | 48 +++++++++++++++++++++++++++++
>  arch/arm64/kernel/traps.c    | 73 ++++++++++++++++++++++++++++----------------
>  2 files changed, 95 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> index f772e15..2a8f6c3 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/arch/arm64/include/asm/esr.h
> @@ -109,6 +109,54 @@
>  	((ESR_ELx_EC_BRK64 << ESR_ELx_EC_SHIFT) | ESR_ELx_IL |	\
>  	 ((imm) & 0xffff))
>  
> +/* ISS field definitions for System instruction traps */

Can you add a similar comment for the ESR_ELx_* encodings that we already
have, please? Unfortunately, we've not namespaced things, so the
data/instruction abort encodings are described as e.g. ESR_ELx_ISV.

> +#define ESR_ELx_SYS64_ISS_RES0_SHIFT	22
> +#define ESR_ELx_SYS64_ISS_RES0_MASK	(UL(0x7) << ESR_ELx_SYS64_ISS_RES0_SHIFT)
> +#define ESR_ELx_SYS64_ISS_DIR_MASK	0x1
> +#define ESR_ELx_SYS64_ISS_DIR_READ	0x1
> +#define ESR_ELx_SYS64_ISS_DIR_WRITE	0x0
> +
> +#define ESR_ELx_SYS64_ISS_RT_SHIFT	5
> +#define ESR_ELx_SYS64_ISS_RT_MASK	(UL(0x1f) << ESR_ELx_SYS64_ISS_RT_SHIFT)
> +#define ESR_ELx_SYS64_ISS_CRm_SHIFT	1
> +#define ESR_ELx_SYS64_ISS_CRm_MASK	(UL(0xf) << ESR_ELx_SYS64_ISS_CRm_SHIFT)
> +#define ESR_ELx_SYS64_ISS_CRn_SHIFT	10
> +#define ESR_ELx_SYS64_ISS_CRn_MASK	(UL(0xf) << ESR_ELx_SYS64_ISS_CRn_SHIFT)
> +#define ESR_ELx_SYS64_ISS_Op1_SHIFT	14
> +#define ESR_ELx_SYS64_ISS_Op1_MASK	(UL(0x7) << ESR_ELx_SYS64_ISS_Op1_SHIFT)
> +#define ESR_ELx_SYS64_ISS_Op2_SHIFT	17
> +#define ESR_ELx_SYS64_ISS_Op2_MASK	(UL(0x7) << ESR_ELx_SYS64_ISS_Op2_SHIFT)
> +#define ESR_ELx_SYS64_ISS_Op0_SHIFT	20
> +#define ESR_ELx_SYS64_ISS_Op0_MASK	(UL(0x3) << ESR_ELx_SYS64_ISS_Op0_SHIFT)

Inconsistent capitalisation in your macro naming (e.g. RT vs Op1). Maybe
just stick to uppercase for #defines?

> +#define ESR_ELx_SYS64_ISS_SYS_MASK	(ESR_ELx_SYS64_ISS_Op0_MASK | \
> +					 ESR_ELx_SYS64_ISS_Op1_MASK | \
> +					 ESR_ELx_SYS64_ISS_Op2_MASK | \
> +					 ESR_ELx_SYS64_ISS_CRn_MASK | \
> +					 ESR_ELx_SYS64_ISS_CRm_MASK)
> +#define ESR_ELx_SYS64_ISS_SYS_VAL(Op0, Op1, Op2, CRn, CRm) \
> +					(((Op0) << ESR_ELx_SYS64_ISS_Op0_SHIFT) | \
> +					 ((Op1) << ESR_ELx_SYS64_ISS_Op1_SHIFT) | \
> +					 ((Op2) << ESR_ELx_SYS64_ISS_Op2_SHIFT) | \
> +					 ((CRn) << ESR_ELx_SYS64_ISS_CRn_SHIFT) | \
> +					 ((CRm) << ESR_ELx_SYS64_ISS_CRm_SHIFT))
> +/*
> + * User space cache operations have the following sysreg encoding
> + * in System instructions.
> + * Op0=1, Op1=3, Op2=1, CRn=7, CRm={ 5, 10, 11, 14 }, WRITE (L=0)
> + */
> +#define ESR_ELx_SYS64_ISS_CRm_DC_CIVAC	14
> +#define ESR_ELx_SYS64_ISS_CRm_DC_CVAU	11
> +#define ESR_ELx_SYS64_ISS_CRm_DC_CVAC	10
> +#define ESR_ELx_SYS64_ISS_CRm_IC_IVAU	5
> +
> +#define ESR_ELx_SYS64_ISS_U_CACHE_OP_MASK	(ESR_ELx_SYS64_ISS_Op0_MASK | \
> +						 ESR_ELx_SYS64_ISS_Op1_MASK | \
> +						 ESR_ELx_SYS64_ISS_Op2_MASK | \
> +						 ESR_ELx_SYS64_ISS_CRn_MASK | \
> +						 ESR_ELx_SYS64_ISS_DIR_MASK)
> +#define ESR_ELx_SYS64_ISS_U_CACHE_OP_VAL \
> +				(ESR_ELx_SYS64_ISS_SYS_VAL(1, 3, 1, 7, 0) | \
> +				 ESR_ELx_SYS64_ISS_DIR_WRITE)

What is the _U_ for? Unified? User? If it's user, EL0 may be more
appropriate.

Will
