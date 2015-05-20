From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 20 May 2015 14:39:45 +0100
Subject: [PATCH v6 1/6] arm64: Add HAVE_REGS_AND_STACK_ACCESS_API feature
In-Reply-To: <1429561187-3661-2-git-send-email-dave.long@linaro.org>
References: <1429561187-3661-1-git-send-email-dave.long@linaro.org>
 <1429561187-3661-2-git-send-email-dave.long@linaro.org>
Message-ID: <20150520133944.GA29424@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 20, 2015 at 04:19:42PM -0400, David Long wrote:
> diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
> index 6913643..58c0223 100644
> --- a/arch/arm64/include/uapi/asm/ptrace.h
> +++ b/arch/arm64/include/uapi/asm/ptrace.h
> @@ -61,6 +61,42 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#define ARM_pstate	pstate
> +#define ARM_pc		pc
> +#define ARM_sp		sp
> +#define ARM_lr		regs[30]
> +#define ARM_fp		regs[29]
> +#define ARM_x28		regs[28]
> +#define ARM_x27		regs[27]
> +#define ARM_x26		regs[26]
> +#define ARM_x25		regs[25]
> +#define ARM_x24		regs[24]
> +#define ARM_x23		regs[23]
> +#define ARM_x22		regs[22]
> +#define ARM_x21		regs[21]
> +#define ARM_x20		regs[20]
> +#define ARM_x19		regs[19]
> +#define ARM_x18		regs[18]
> +#define ARM_ip1		regs[17]
> +#define ARM_ip0		regs[16]
> +#define ARM_x15		regs[15]
> +#define ARM_x14		regs[14]
> +#define ARM_x13		regs[13]
> +#define ARM_x12		regs[12]
> +#define ARM_x11		regs[11]
> +#define ARM_x10		regs[10]
> +#define ARM_x9		regs[9]
> +#define ARM_x8		regs[8]
> +#define ARM_x7		regs[7]
> +#define ARM_x6		regs[6]
> +#define ARM_x5		regs[5]
> +#define ARM_x4		regs[4]
> +#define ARM_x3		regs[3]
> +#define ARM_x2		regs[2]
> +#define ARM_x1		regs[1]
> +#define ARM_x0		regs[0]
> +#define ARM_ORIG_x0	orig_x0

I replied some time ago on this part. I don't see the point these
macros.

> +
>  /*
>   * User structures for general purpose, floating point and debug registers.
>   */
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index d882b83..a889f79 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -48,6 +48,122 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/syscalls.h>
>  
> +struct pt_regs_offset {
> +	const char *name;
> +	int offset;
> +};
> +
> +#define REG_OFFSET_NAME(r) \
> +	{.name = #r, .offset = offsetof(struct pt_regs, ARM_##r)}

Can you not just use "offsetof(struct pt_regs, r)" here? That would be
the same as x86, powerpc.

> +#define REG_OFFSET_END {.name = NULL, .offset = 0}
> +
> +static const struct pt_regs_offset regoffset_table[] = {
> +	REG_OFFSET_NAME(x0),
> +	REG_OFFSET_NAME(x1),
> +	REG_OFFSET_NAME(x2),
> +	REG_OFFSET_NAME(x3),
> +	REG_OFFSET_NAME(x4),
> +	REG_OFFSET_NAME(x5),
> +	REG_OFFSET_NAME(x6),
> +	REG_OFFSET_NAME(x7),
> +	REG_OFFSET_NAME(x8),
> +	REG_OFFSET_NAME(x9),
> +	REG_OFFSET_NAME(x10),
> +	REG_OFFSET_NAME(x11),
> +	REG_OFFSET_NAME(x12),
> +	REG_OFFSET_NAME(x13),
> +	REG_OFFSET_NAME(x14),
> +	REG_OFFSET_NAME(x15),
> +	REG_OFFSET_NAME(ip0),
> +	REG_OFFSET_NAME(ip1),
> +	REG_OFFSET_NAME(x18),
> +	REG_OFFSET_NAME(x19),
> +	REG_OFFSET_NAME(x20),
> +	REG_OFFSET_NAME(x21),
> +	REG_OFFSET_NAME(x22),
> +	REG_OFFSET_NAME(x23),
> +	REG_OFFSET_NAME(x24),
> +	REG_OFFSET_NAME(x25),
> +	REG_OFFSET_NAME(x26),
> +	REG_OFFSET_NAME(x27),
> +	REG_OFFSET_NAME(x28),
> +	REG_OFFSET_NAME(fp),
> +	REG_OFFSET_NAME(lr),
> +	REG_OFFSET_NAME(sp),
> +	REG_OFFSET_NAME(pc),

and stick to x16, x17, x29, x30 instead of the ip0 etc.

> +	REG_OFFSET_NAME(pstate),
> +	REG_OFFSET_NAME(ORIG_x0),
> +	REG_OFFSET_END,

Do we need orig_x0 of MAX_REG_OFFSET doesn't include it?

> +};
> +
> +/**
> + * regs_query_register_offset() - query register offset from its name
> + * @name:	the name of a register
> + *
> + * regs_query_register_offset() returns the offset of a register in struct
> + * pt_regs from its name. If the name is invalid, this returns -EINVAL;
> + */
> +int regs_query_register_offset(const char *name)
> +{
> +	const struct pt_regs_offset *roff;
> +
> +	for (roff = regoffset_table; roff->name != NULL; roff++)
> +		if (!strcmp(roff->name, name))
> +			return roff->offset;
> +	return -EINVAL;
> +}
> +
> +/**
> + * regs_query_register_name() - query register name from its offset
> + * @offset:	the offset of a register in struct pt_regs.
> + *
> + * regs_query_register_name() returns the name of a register from its
> + * offset in struct pt_regs. If the @offset is invalid, this returns NULL;
> + */
> +const char *regs_query_register_name(unsigned int offset)
> +{
> +	const struct pt_regs_offset *roff;
> +
> +	for (roff = regoffset_table; roff->name != NULL; roff++)
> +		if (roff->offset == offset)
> +			return roff->name;
> +	return NULL;
> +}

BTW, these functions together with the pt_regs_offset structure look the
same on the other architectures. Can we move them to some common header
to avoid duplication (e.g. linux/ptrace.h)?

> +
> +/**
> + * regs_within_kernel_stack() - check the address in the stack
> + * @regs:      pt_regs which contains kernel stack pointer.
> + * @addr:      address which is checked.
> + *
> + * regs_within_kernel_stack() checks @addr is within the kernel stack page(s).
> + * If @addr is within the kernel stack, it returns true. If not, returns false.
> + */
> +bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr)
> +{
> +	return ((addr & ~(THREAD_SIZE - 1))  ==
> +		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1)));
> +}
> +
> +/**
> + * regs_get_kernel_stack_nth() - get Nth entry of the stack
> + * @regs:	pt_regs which contains kernel stack pointer.
> + * @n:		stack entry number.
> + *
> + * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack which
> + * is specified by @regs. If the @n th entry is NOT in the kernel stack,
> + * this returns 0.
> + */
> +unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n)
> +{
> +	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
> +
> +	addr += n;
> +	if (regs_within_kernel_stack(regs, (unsigned long)addr))
> +		return *addr;
> +	else
> +		return 0;
> +}

Same here.

-- 
Catalin
