From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 18 Jul 2014 22:55:12 -0400 (EDT)
Subject: [PATCH 2/4] ARM: add IPI tracepoints
In-Reply-To: <20140718172221.6dbe83e4@gandalf.local.home>
References: <1405660735-13408-1-git-send-email-nicolas.pitre@linaro.org>
 <1405660735-13408-3-git-send-email-nicolas.pitre@linaro.org>
 <20140718160418.54d11f6a@gandalf.local.home>
 <alpine.LFD.2.11.1407181652080.3647@knanqh.ubzr>
 <20140718172221.6dbe83e4@gandalf.local.home>
Message-ID: <alpine.LFD.2.11.1407182249020.3647@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Jul 2014, Steven Rostedt wrote:

> On Fri, 18 Jul 2014 16:55:42 -0400 (EDT)
> Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> 
> > 
> > Here's the patch I have at the head of the series now, with the above
> > ugliness changed to an unconditional __tracepoint_string attribute.
> > 
> 
> I was thinking of something like this. Feel free to add this to your
> series.

OK.  Same end result, but much clearer.  Thanks.

Any comments / ACKs on the other patches?  I'd like to see 1/4 to 3/4 
(and your patch) merged upstream during the next window.  4/4 is up for 
debate.

> -- Steve
> 
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
> @@ -574,6 +574,7 @@ do {									\
>  		__trace_printk(ip, fmt, ##args);			\
>  } while (0)
>  
> +#ifdef CONFIG_TRACING
>  /**
>   * tracepoint_string - register constant persistent string to trace system
>   * @str - a constant persistent string that will be referenced in tracepoints
> @@ -607,6 +608,15 @@ do {									\
>  		___tp_str;						\
>  	})
>  #define __tracepoint_string	__attribute__((section("__tracepoint_str")))
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
