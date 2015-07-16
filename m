From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 15 Jul 2015 21:38:18 -0400
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <55A703F3.8050203@linaro.org>
References: <1436765375-7119-1-git-send-email-takahiro.akashi@linaro.org>
 <1436765375-7119-3-git-send-email-takahiro.akashi@linaro.org>
 <DAAB1BC4-B36E-436D-8EAD-548641E58490@gmail.com>
 <20150714093154.4d73e551@gandalf.local.home>
 <55A5A75A.1060401@linaro.org>
 <20150714225105.6c1e4f15@gandalf.local.home>
 <55A646EE.6030402@linaro.org>
 <20150715105536.42949ea9@gandalf.local.home>
 <20150715121337.3b31aa84@gandalf.local.home>
 <55A6FA82.9000901@linaro.org> <55A703F3.8050203@linaro.org>
Message-ID: <20150715213818.55c5b3d8@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Jul 2015 10:08:03 +0900
AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:

> On 07/16/2015 09:27 AM, AKASHI Takahiro wrote:
> > On 07/16/2015 01:13 AM, Steven Rostedt wrote:
> >> On Wed, 15 Jul 2015 10:55:36 -0400
> >> Steven Rostedt <rostedt@goodmis.org> wrote:
> >>
> >>
> >>> I'll take a look at it and try to clean up the code.
> >>
> >> Does the  following patch make sense for you?
> >
> > Looks nice. The patch greatly simplifies changes on arm64 side.
> 
> As follows:
> 
> - Takahiro AKASHI
> 

How should we go forward with this. Want me to make my change to my
tree, and pull this patch in with it? I can set up for a 4.3 release.

Then if I can get an Acked-by from one of the arm64 maintainers, I can
have this go through my tree?

-- Steve


> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index c5534fa..868d6f1 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -15,6 +15,7 @@
> 
>   #define MCOUNT_ADDR		((unsigned long)_mcount)
>   #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
> +#define FTRACE_STACK_FRAME_OFFSET 4 /* sync it up with stacktrace.c */
> 
>   #ifndef __ASSEMBLY__
>   #include <linux/compat.h>
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 1da6029..2c1bf7d 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -260,6 +260,13 @@ static inline void ftrace_kill(void) { }
>   #endif /* CONFIG_FUNCTION_TRACER */
> 
>   #ifdef CONFIG_STACK_TRACER
> +/*
> + * the offset value to add to return address from save_stack_trace()
> + */
> +#ifndef FTRACE_STACK_FRAME_OFFSET
> +#define FTRACE_STACK_FRAME_OFFSET 0
> +#endif
> +
>   extern int stack_tracer_enabled;
>   int
>   stack_trace_sysctl(struct ctl_table *table, int write,
> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> index 9384647..c5b9748 100644
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -105,7 +105,7 @@ check_stack(unsigned long ip, unsigned long *stack)
> 
>   	/* Skip over the overhead of the stack tracer itself */
>   	for (i = 0; i < max_stack_trace.nr_entries; i++) {
> -		if (stack_dump_trace[i] == ip)
> +		if ((stack_dump_trace[i] + FTRACE_STACK_FRAME_OFFSET) == ip)
>   			break;
>   	}
> 
> @@ -131,7 +131,8 @@ check_stack(unsigned long ip, unsigned long *stack)
>   		p = start;
> 
>   		for (; p < top && i < max_stack_trace.nr_entries; p++) {
> -			if (*p == stack_dump_trace[i]) {
> +			if (*p == (stack_dump_trace[i]
> +					+ FTRACE_STACK_FRAME_OFFSET)) {
>   				stack_dump_trace[x] = stack_dump_trace[i++];
>   				this_size = stack_dump_index[x++] =
>   					(top - p) * sizeof(unsigned long);
