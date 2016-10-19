From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Oct 2016 15:04:14 +0100
Subject: [PATCH 1/2] arm64: swp emulation: bound LL/SC retries before
 rescheduling
In-Reply-To: <1476874784-16214-1-git-send-email-will.deacon@arm.com>
References: <1476874784-16214-1-git-send-email-will.deacon@arm.com>
Message-ID: <20161019140414.GB11036@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 11:59:43AM +0100, Will Deacon wrote:
> If a CPU does not implement a global monitor for certain memory types,
> then userspace can attempt a kernel DoS by issuing SWP instructions
> targetting the problematic memory (for example, a framebuffer mapped
> with non-cacheable attributes).
> 
> The SWP emulation code protects against these sorts of attacks by
> checking for pending signals and potentially rescheduling when the STXR
> instruction fails during the emulation. Whilst this is good for avoiding
> livelock, it harms emulation of legitimate SWP instructions on CPUs
> where forward progress is not guaranteed if there are memory accesses to
> the same reservation granule (up to 2k) between the failing STXR and
> the retry of the LDXR.
> 
> This patch solves the problem by retrying the STXR a bounded number of
> times (4) before breaking out of the LL/SC loop and looking for
> something else to do.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Assuming I've followed all the operand numbering correctly, this looks
correct to me per my reading of the requirements in the ARM ARM.

FWIW:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  arch/arm64/kernel/armv8_deprecated.c | 36 ++++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
> index 42ffdb54e162..b0988bb1bf64 100644
> --- a/arch/arm64/kernel/armv8_deprecated.c
> +++ b/arch/arm64/kernel/armv8_deprecated.c
> @@ -280,35 +280,43 @@ static void __init register_insn_emulation_sysctl(struct ctl_table *table)
>  /*
>   * Error-checking SWP macros implemented using ldxr{b}/stxr{b}
>   */
> -#define __user_swpX_asm(data, addr, res, temp, B)		\
> +
> +/* Arbitrary constant to ensure forward-progress of the LL/SC loop */
> +#define __SWP_LL_SC_LOOPS	4
> +
> +#define __user_swpX_asm(data, addr, res, temp, temp2, B)	\
>  	__asm__ __volatile__(					\
> +	"	mov		%w3, %w7\n"			\
>  	ALTERNATIVE("nop", SET_PSTATE_PAN(0), ARM64_HAS_PAN,	\
>  		    CONFIG_ARM64_PAN)				\
> -	"0:	ldxr"B"		%w2, [%3]\n"			\
> -	"1:	stxr"B"		%w0, %w1, [%3]\n"		\
> +	"0:	ldxr"B"		%w2, [%4]\n"			\
> +	"1:	stxr"B"		%w0, %w1, [%4]\n"		\
>  	"	cbz		%w0, 2f\n"			\
> -	"	mov		%w0, %w4\n"			\
> +	"	sub		%w3, %w3, #1\n"			\
> +	"	cbnz		%w3, 0b\n"			\
> +	"	mov		%w0, %w5\n"			\
>  	"	b		3f\n"				\
>  	"2:\n"							\
>  	"	mov		%w1, %w2\n"			\
>  	"3:\n"							\
>  	"	.pushsection	 .fixup,\"ax\"\n"		\
>  	"	.align		2\n"				\
> -	"4:	mov		%w0, %w5\n"			\
> +	"4:	mov		%w0, %w6\n"			\
>  	"	b		3b\n"				\
>  	"	.popsection"					\
>  	_ASM_EXTABLE(0b, 4b)					\
>  	_ASM_EXTABLE(1b, 4b)					\
>  	ALTERNATIVE("nop", SET_PSTATE_PAN(1), ARM64_HAS_PAN,	\
>  		CONFIG_ARM64_PAN)				\
> -	: "=&r" (res), "+r" (data), "=&r" (temp)		\
> -	: "r" (addr), "i" (-EAGAIN), "i" (-EFAULT)		\
> +	: "=&r" (res), "+r" (data), "=&r" (temp), "=&r" (temp2)	\
> +	: "r" (addr), "i" (-EAGAIN), "i" (-EFAULT),		\
> +	  "i" (__SWP_LL_SC_LOOPS)				\
>  	: "memory")
>  
> -#define __user_swp_asm(data, addr, res, temp) \
> -	__user_swpX_asm(data, addr, res, temp, "")
> -#define __user_swpb_asm(data, addr, res, temp) \
> -	__user_swpX_asm(data, addr, res, temp, "b")
> +#define __user_swp_asm(data, addr, res, temp, temp2) \
> +	__user_swpX_asm(data, addr, res, temp, temp2, "")
> +#define __user_swpb_asm(data, addr, res, temp, temp2) \
> +	__user_swpX_asm(data, addr, res, temp, temp2, "b")
>  
>  /*
>   * Bit 22 of the instruction encoding distinguishes between
> @@ -328,12 +336,12 @@ static int emulate_swpX(unsigned int address, unsigned int *data,
>  	}
>  
>  	while (1) {
> -		unsigned long temp;
> +		unsigned long temp, temp2;
>  
>  		if (type == TYPE_SWPB)
> -			__user_swpb_asm(*data, address, res, temp);
> +			__user_swpb_asm(*data, address, res, temp, temp2);
>  		else
> -			__user_swp_asm(*data, address, res, temp);
> +			__user_swp_asm(*data, address, res, temp, temp2);
>  
>  		if (likely(res != -EAGAIN) || signal_pending(current))
>  			break;
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
