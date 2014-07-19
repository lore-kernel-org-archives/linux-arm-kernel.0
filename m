From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 19 Jul 2014 21:10:37 +0200
Subject: [PATCH 2/4] ARM: add IPI tracepoints
In-Reply-To: <20140718172221.6dbe83e4@gandalf.local.home>
References: <1405660735-13408-1-git-send-email-nicolas.pitre@linaro.org>
 <1405660735-13408-3-git-send-email-nicolas.pitre@linaro.org>
 <20140718160418.54d11f6a@gandalf.local.home>
 <alpine.LFD.2.11.1407181652080.3647@knanqh.ubzr>
 <20140718172221.6dbe83e4@gandalf.local.home>
Message-ID: <CAKv+Gu_71vJFf3aUZso1X7m7fULUMhxj+MZVYq+LGNRLJvGyAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 July 2014 23:22, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 18 Jul 2014 16:55:42 -0400 (EDT)
> Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>
>>
>> Here's the patch I have at the head of the series now, with the above
>> ugliness changed to an unconditional __tracepoint_string attribute.
>>
>
> I was thinking of something like this. Feel free to add this to your
> series.
>
> -- Steve
>

Nico,

If this patch addresses the issue where 3 RCU related tracepoint
strings turn up /after/ _edata on !CONFIG_TRACING, there is already a
patch queued up here

http://marc.info/?l=linux-kernel&m=140518452623148&w=2

As far as In know, these were the only occurrences using a __used
modifier, which is why they weren't dropped by the compiler in the
!CONFIG_TRACING case.

Regards,
Ard.



> From: Steven Rostedt <rostedt@goodmis.org>
> Subject: [PATCH] tracing: Do not do anything special with tracepoint_string when tracing is disabled
>
> When CONFIG_TRACING is not enabled, there's no reason to save the trace
> strings either by the linker or as a static variable that can be
> referenced later. Simply pass back the string that is given to
> tracepoint_string().
>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
> diff --git a/include/linux/ftrace_event.h b/include/linux/ftrace_event.h
> index cff3106..b296363 100644
> --- a/include/linux/ftrace_event.h
> +++ b/include/linux/ftrace_event.h
> @@ -574,6 +574,7 @@ do {                                                                        \
>                 __trace_printk(ip, fmt, ##args);                        \
>  } while (0)
>
> +#ifdef CONFIG_TRACING
>  /**
>   * tracepoint_string - register constant persistent string to trace system
>   * @str - a constant persistent string that will be referenced in tracepoints
> @@ -607,6 +608,15 @@ do {                                                                       \
>                 ___tp_str;                                              \
>         })
>  #define __tracepoint_string    __attribute__((section("__tracepoint_str")))
> +#else
> +/*
> + * tracepoint_string() is used to save the string address for userspace
> + * tracing tools. When tracing isn't configured, there's no need to save
> + * anything.
> + */
> +# define tracepoint_string(str) str
> +# define __tracepoint_string
> +#endif
>
>  #ifdef CONFIG_PERF_EVENTS
>  struct perf_event;
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
