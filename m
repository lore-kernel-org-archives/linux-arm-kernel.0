From: will.deacon@arm.com (Will Deacon)
Date: Thu, 14 Jun 2018 17:44:06 +0100
Subject: [PATCHv2 02/19] arm64: move SCTLR_EL{1,2} assertions to
 <asm/sysreg.h>
In-Reply-To: <20180601112441.37810-3-mark.rutland@arm.com>
References: <20180601112441.37810-1-mark.rutland@arm.com>
 <20180601112441.37810-3-mark.rutland@arm.com>
Message-ID: <20180614164405.GE26471@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2018 at 12:24:24PM +0100, Mark Rutland wrote:
> Currently we assert that the SCTLR_EL{1,2}_{SET,CLEAR} bits are
> self-consistent with an assertion in config_sctlr_el1(). This is a bit
> unusual, since config_sctlr_el1() doesn't make use of these definitions,
> and is far away from the definitions themselves.
> 
> We can use the CPP #error directive to have equivalent assertions in
> <asm/sysreg.h>, next to the definitions of the set/clear bits, which is
> a bit clearer and simpler.
> 
> The preprocessor handles literals differently than regular C, e.g. ~0 is
> equivalent to ~(intmax_t)0 rather than ~(int)0. Therefore, instead of ~0
> we use 0xffffffff, which is unambiguous.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Dave Martin <dave.martin@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/sysreg.h | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 6171178075dc..bd1d1194a5e7 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -452,9 +452,9 @@
>  			 SCTLR_ELx_SA     | SCTLR_ELx_I    | SCTLR_ELx_WXN | \
>  			 ENDIAN_CLEAR_EL2 | SCTLR_EL2_RES0)
>  
> -/* Check all the bits are accounted for */
> -#define SCTLR_EL2_BUILD_BUG_ON_MISSING_BITS	BUILD_BUG_ON((SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != ~0)
> -
> +#if (SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != 0xffffffff
> +#error "Inconsistent SCTLR_EL2 set/clear bits"
> +#endif

Please can you extend this check to be 64-bit, since SCTLR is growing fields
up there and we'll want to check them too?

Thanks,

Will
