From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Mar 2016 11:04:08 +0000
Subject: [PATCH v11 1/9] arm64: Add HAVE_REGS_AND_STACK_ACCESS_API feature
In-Reply-To: <1457501543-24197-2-git-send-email-dave.long@linaro.org>
References: <1457501543-24197-1-git-send-email-dave.long@linaro.org>
 <1457501543-24197-2-git-send-email-dave.long@linaro.org>
Message-ID: <56E7EC28.7010101@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

On 09/03/16 05:32, David Long wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> Add HAVE_REGS_AND_STACK_ACCESS_API feature for arm64.
> 
> Signed-off-by: David A. Long <dave.long@linaro.org>
> ---
>  arch/arm64/Kconfig              |   1 +
>  arch/arm64/include/asm/ptrace.h |  31 +++++++++++
>  arch/arm64/kernel/ptrace.c      | 117 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 149 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 8cc6228..4211b0d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -78,6 +78,7 @@ config ARM64
>  	select HAVE_PERF_EVENTS
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
> +	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_RCU_TABLE_FREE
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select IOMMU_DMA if IOMMU_SUPPORT
> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index e9e5467..7bd6445 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -118,6 +118,8 @@ struct pt_regs {
>  	u64 syscallno;
>  };
>  
> +#define MAX_REG_OFFSET offsetof(struct user_pt_regs, pstate)

So here you're using user_pt_regs...

> +
>  #define arch_has_single_step()	(1)
>  
>  #ifdef CONFIG_COMPAT
> @@ -146,6 +148,35 @@ struct pt_regs {
>  #define user_stack_pointer(regs) \
>  	(!compat_user_mode(regs) ? (regs)->sp : (regs)->compat_sp)
>  
> +extern int regs_query_register_offset(const char *name);
> +extern const char *regs_query_register_name(unsigned int offset);
> +extern bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr);
> +extern unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
> +					       unsigned int n);
> +
> +/**
> + * regs_get_register() - get register value from its offset
> + * @regs:	   pt_regs from which register value is gotten
> + * @offset:    offset number of the register.
> + *
> + * regs_get_register returns the value of a register whose offset from @regs.
> + * The @offset is the offset of the register in struct pt_regs.

Is that the offset in pt_regs? Or should it be in the actual regs array
instead? So far, this is the same thing, but that feels pretty fragile.

> + * If @offset is bigger than MAX_REG_OFFSET, this returns 0.
> + */
> +static inline u64 regs_get_register(struct pt_regs *regs,
> +					      unsigned int offset)

... and here this is pt_regs. I know that the structures are quite
similar, but some uniformity wouldn't hurt. Given that this series is
mostly concerned with kernel space, it should probably the latter rather
than the former.

> +{
> +	if (unlikely(offset > MAX_REG_OFFSET))
> +		return 0;
> +	return *(u64 *)((u64)regs + offset);

Now that's a bit disgusting... You are assuming way too much about the
layout of pt_regs (imagine someone insert a new field right before the
union?). How about:

	u64 *reg_array = regs->regs;
	return reg_array[offset >> 3];

instead? I know the semantic is not the same, but I'd really like to see
something a bit more robust.

> +}
> +
> +/* Valid only for Kernel mode traps. */
> +static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
> +{
> +	return regs->sp;
> +}
> +
>  static inline unsigned long regs_return_value(struct pt_regs *regs)
>  {
>  	return regs->regs[0];
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index ff7f132..efebf0f 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -48,6 +48,123 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/syscalls.h>
>  
> +struct pt_regs_offset {
> +	const char *name;
> +	int offset;
> +};
> +
> +#define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
> +#define REG_OFFSET_END {.name = NULL, .offset = 0}
> +#define	GPR_OFFSET_NAME(r)	\
> +	{.name = "x" #r, .offset = offsetof(struct pt_regs, regs[r])}
> +
> +static const struct pt_regs_offset regoffset_table[] = {
> +	GPR_OFFSET_NAME(0),
> +	GPR_OFFSET_NAME(1),
> +	GPR_OFFSET_NAME(2),
> +	GPR_OFFSET_NAME(3),
> +	GPR_OFFSET_NAME(4),
> +	GPR_OFFSET_NAME(5),
> +	GPR_OFFSET_NAME(6),
> +	GPR_OFFSET_NAME(7),
> +	GPR_OFFSET_NAME(8),
> +	GPR_OFFSET_NAME(9),
> +	GPR_OFFSET_NAME(10),
> +	GPR_OFFSET_NAME(11),
> +	GPR_OFFSET_NAME(12),
> +	GPR_OFFSET_NAME(13),
> +	GPR_OFFSET_NAME(14),
> +	GPR_OFFSET_NAME(15),
> +	GPR_OFFSET_NAME(16),
> +	GPR_OFFSET_NAME(17),
> +	GPR_OFFSET_NAME(18),
> +	GPR_OFFSET_NAME(19),
> +	GPR_OFFSET_NAME(20),
> +	GPR_OFFSET_NAME(21),
> +	GPR_OFFSET_NAME(22),
> +	GPR_OFFSET_NAME(23),
> +	GPR_OFFSET_NAME(24),
> +	GPR_OFFSET_NAME(25),
> +	GPR_OFFSET_NAME(26),
> +	GPR_OFFSET_NAME(27),
> +	GPR_OFFSET_NAME(28),
> +	GPR_OFFSET_NAME(29),
> +	GPR_OFFSET_NAME(30),
> +	{.name = "lr", .offset = offsetof(struct pt_regs, regs[30])},
> +	REG_OFFSET_NAME(sp),
> +	REG_OFFSET_NAME(pc),
> +	REG_OFFSET_NAME(pstate),
> +	REG_OFFSET_END,
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
> +
>  /*
>   * TODO: does not yet catch signals sent when the child dies.
>   * in exit.c or in signal.c.
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
