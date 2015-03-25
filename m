From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Mar 2015 13:44:10 +0000
Subject: [PATCH v5 1/6] arm64: Add HAVE_REGS_AND_STACK_ACCESS_API feature
In-Reply-To: <1424214701-4899-2-git-send-email-dave.long@linaro.org>
References: <1424214701-4899-1-git-send-email-dave.long@linaro.org>
 <1424214701-4899-2-git-send-email-dave.long@linaro.org>
Message-ID: <20150325134410.GA26903@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 17, 2015 at 06:11:36PM -0500, David Long wrote:
> diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
> index 6913643..700d28b 100644
> --- a/arch/arm64/include/uapi/asm/ptrace.h
> +++ b/arch/arm64/include/uapi/asm/ptrace.h
> @@ -61,6 +61,42 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#define ARM_cpsr	pstate

There is no CPSR on AArch64, it's just called PSTATE. But more
importantly, what's the point of all these macros?

> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index d882b83..adc1f39 100644
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
> +#define REG_OFFSET_END {.name = NULL, .offset = 0}
> +
> +static const struct pt_regs_offset regoffset_table[] = {
> +	REG_OFFSET_NAME(x0),

If it is just for defining a name, just change the REG_OFFSET_NAME macro
to take a string argument and remove all the ARM_ macros.

I'm also not sure why we need the ARM_ prefix. Do you see them used
outside the arm64 context?

-- 
Catalin
