From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 14 May 2018 11:04:02 +0100
Subject: [PATCH 03/18] arm64: introduce sysreg_clear_set()
In-Reply-To: <20180514094640.27569-4-mark.rutland@arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-4-mark.rutland@arm.com>
Message-ID: <20180514100402.GY7753@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 10:46:25AM +0100, Mark Rutland wrote:
> Currently we have a couple of helpers to manipulate bits in particular
> sysregs:
> 
>  * config_sctlr_el1(u32 clear, u32 set)
> 
>  * change_cpacr(u64 val, u64 mask)
> 
> The parameters of these differ in naming convention, order, and size,
> which is unfortunate. They also differ slightly in behaviour, as
> change_cpacr() skips the sysreg write if the bits are unchanged, which
> is a useful optimization when sysreg writes are expensive.
> 
> Before we gain more yet another sysreg manipulation function, let's
> unify these with a common helper, providing a consistent order for
> clear/set operands, and the write skipping behaviour from
> change_cpacr(). Code will be migrated to the new helper in subsequent
> patches.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

Makes sense.  I felt I was (re)inventing an idiom with
change_cpacr() at the time, though it didn't quite seem worth
factoring out.  Now you plan to add a third similar manipulator,
this factoring makes sense.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  arch/arm64/include/asm/sysreg.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index bd1d1194a5e7..b52762769329 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -729,6 +729,17 @@ asm(
>  	asm volatile("msr_s " __stringify(r) ", %x0" : : "rZ" (__val));	\
>  } while (0)
>  
> +/*
> + * Modify bits in a sysreg. Bits in the clear mask are zeroed, then bits in the
> + * set mask are set. Other bits are left as-is.
> + */
> +#define sysreg_clear_set(sysreg, clear, set) do {			\
> +	u64 __scs_val = read_sysreg(sysreg);				\
> +	u64 __scs_new = (__scs_val & ~(u64)(clear)) | (set);		\
> +	if (__scs_new != __scs_val)					\
> +		write_sysreg(__scs_new, sysreg);			\
> +} while (0)
> +
>  static inline void config_sctlr_el1(u32 clear, u32 set)
>  {
>  	u32 val;
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
