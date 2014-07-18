From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 18 Jul 2014 16:04:18 -0400
Subject: [PATCH 2/4] ARM: add IPI tracepoints
In-Reply-To: <1405660735-13408-3-git-send-email-nicolas.pitre@linaro.org>
References: <1405660735-13408-1-git-send-email-nicolas.pitre@linaro.org>
 <1405660735-13408-3-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20140718160418.54d11f6a@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Jul 2014 01:18:53 -0400
Nicolas Pitre <nicolas.pitre@linaro.org> wrote:

  
> -#ifdef CONFIG_IRQ_WORK
> -void arch_irq_work_raise(void)
> -{
> -	if (is_smp())
> -		smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
> -}
> +static const char *ipi_types[NR_IPI]
> +#ifdef CONFIG_TRACING
> +__tracepoint_string
>  #endif

Oh, this is ugly. I should probably add a define when !CONFIG_TRACING
is set. Something like:

#ifdef CONFIG_TRACING
...
#else
# define __tracepoint_string
#endif

Such that users of __tracepoint_string don't need to add ugly ifdefs in
the code.

If you want to add that to ftrace_event.h to this series, I'll ack it.

-- Steve


> -
> -static const char *ipi_types[NR_IPI] = {
> += {
>  #define S(x,s)	[x] = s
>  	S(IPI_WAKEUP, "CPU wakeup interrupts"),
>  	S(IPI_TIMER, "Timer broadcast interrupts"),
> @@ -473,6 +457,12 @@ static const char *ipi_types[NR_IPI] = {
>  	S(IPI_COMPLETION, "completion interrupts"),
>  };
>  
