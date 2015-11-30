From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 30 Nov 2015 21:00:24 +0100
Subject: [PATCH v2 01/21] arm64: Add macros to read/write system registers
In-Reply-To: <1448650215-15218-2-git-send-email-marc.zyngier@arm.com>
References: <1448650215-15218-1-git-send-email-marc.zyngier@arm.com>
 <1448650215-15218-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20151130200024.GH11704@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2015 at 06:49:55PM +0000, Marc Zyngier wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> Rather than crafting custom macros for reading/writing each system
> register provide generics accessors, read_sysreg and write_sysreg, for
> this purpose.
> 
> Unlike read_cpuid, calls to read_exception_reg are never expected
> to be optimized away or replaced with synthetic values.

how does this comment about read_exception_reg relate to this patch?

> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/sysreg.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index d48ab5b..c9c283a 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -20,6 +20,8 @@
>  #ifndef __ASM_SYSREG_H
>  #define __ASM_SYSREG_H
>  
> +#include <linux/stringify.h>
> +
>  #include <asm/opcodes.h>
>  
>  /*
> @@ -208,6 +210,8 @@
>  
>  #else
>  
> +#include <linux/types.h>
> +
>  asm(
>  "	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n"
>  "	.equ	__reg_num_x\\num, \\num\n"
> @@ -232,6 +236,19 @@ static inline void config_sctlr_el1(u32 clear, u32 set)
>  	val |= set;
>  	asm volatile("msr sctlr_el1, %0" : : "r" (val));
>  }
> +
> +#define read_sysreg(r) ({					\
> +	u64 __val;						\
> +	asm volatile("mrs %0, " __stringify(r) : "=r" (__val));	\
> +	__val;							\
> +})
> +
> +#define write_sysreg(v, r) do {					\
> +	u64 __val = (u64)v;					\
> +	asm volatile("msr " __stringify(r) ", %0"		\
> +		     : : "r" (__val));				\
> +} while (0)
> +
>  #endif
>  
>  #endif	/* __ASM_SYSREG_H */
> -- 
> 2.1.4
> 
