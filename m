From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Feb 2014 16:03:21 +0100
Subject: [PATCH v3 1/6] arm64: Add ftrace support
In-Reply-To: <1391768336-5642-2-git-send-email-takahiro.akashi@linaro.org>
References: <1382598488-13511-1-git-send-email-takahiro.akashi@linaro.org>
 <1391768336-5642-1-git-send-email-takahiro.akashi@linaro.org>
 <1391768336-5642-2-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <201402101603.21791.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 February 2014, AKASHI Takahiro wrote:
> @@ -0,0 +1,23 @@

> +
> +#ifdef CONFIG_FUNCTION_TRACER
> +#define MCOUNT_ADDR		((unsigned long)_mcount)
> +#define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
> +
> +#ifndef __ASSEMBLY__
> +extern void _mcount(unsigned long);
> +#endif /* __ASSEMBLY__ */
> +#endif /* CONFIG_FUNCTION_TRACER */

We generally like to have as few #ifdef as possible, and I think the
#ifdef CONFIG_FUNCTION_TRACER here is not needed.

> +#endif /* __ASM_FTRACE_H */
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 2d4554b..ca921fb 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -5,6 +5,11 @@
>  CPPFLAGS_vmlinux.lds	:= -DTEXT_OFFSET=$(TEXT_OFFSET)
>  AFLAGS_head.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
>  
> +ifdef CONFIG_FUNCTION_TRACER
> +CFLAGS_REMOVE_ftrace.o = -pg
> +CFLAGS_REMOVE_insn.o = -pg
> +endif

Same here. It never hurts to have the CFLAGS_REMOVE_* statements here, since
you will not want to build these files for profiling.

> diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
> index 338b568..7f0512f 100644
> --- a/arch/arm64/kernel/arm64ksyms.c
> +++ b/arch/arm64/kernel/arm64ksyms.c
> @@ -56,3 +56,7 @@ EXPORT_SYMBOL(clear_bit);
>  EXPORT_SYMBOL(test_and_clear_bit);
>  EXPORT_SYMBOL(change_bit);
>  EXPORT_SYMBOL(test_and_change_bit);
> +
> +#ifdef CONFIG_FUNCTION_TRACER
> +EXPORT_SYMBOL(_mcount);
> +#endif

This one is clearly needed of course.

> +/*
> + * Gcc with -pg will put the following code in the beginning of each function:
> + *      mov x0, x30
> + *      bl _mcount
> + *	[function's body ...]
> + * "bl _mcount" may be replaced to "bl ftrace_caller" or NOP if dynamic
> + * ftrace is enabled.

Unrelated to your patch, I have run into problems with this on arm32, maybe
someone on Cc to this mail has an idea what to do about it:

If I build a large "randconfig" kernel or "allyesconfig", the kernel image
size exceeds 32MB, which means I can no longer link callers with a 26
bit signed immediate argument like the "bl _mcount" here. For any other
function calls, "gcc -mlong-calls" can be used to work around this, but
this particular instance is created by inserting assembly statements
into the output without considering the long-call options. Is there
a way to get the kernel to link anyway?

> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER

Here, again, you an remove the #ifdef by making the entire file built
only for CONFIG_FUNCTION_GRAPH_TRACER.

	Arnd
