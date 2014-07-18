From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 18 Jul 2014 16:55:42 -0400 (EDT)
Subject: [PATCH 2/4] ARM: add IPI tracepoints
In-Reply-To: <20140718160418.54d11f6a@gandalf.local.home>
References: <1405660735-13408-1-git-send-email-nicolas.pitre@linaro.org>
 <1405660735-13408-3-git-send-email-nicolas.pitre@linaro.org>
 <20140718160418.54d11f6a@gandalf.local.home>
Message-ID: <alpine.LFD.2.11.1407181652080.3647@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Jul 2014, Steven Rostedt wrote:

> On Fri, 18 Jul 2014 01:18:53 -0400
> Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> 
>   
> > -#ifdef CONFIG_IRQ_WORK
> > -void arch_irq_work_raise(void)
> > -{
> > -	if (is_smp())
> > -		smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
> > -}
> > +static const char *ipi_types[NR_IPI]
> > +#ifdef CONFIG_TRACING
> > +__tracepoint_string
> >  #endif
> 
> Oh, this is ugly. I should probably add a define when !CONFIG_TRACING
> is set. Something like:
> 
> #ifdef CONFIG_TRACING
> ...
> #else
> # define __tracepoint_string
> #endif
> 
> Such that users of __tracepoint_string don't need to add ugly ifdefs in
> the code.
> 
> If you want to add that to ftrace_event.h to this series, I'll ack it.

Here's the patch I have at the head of the series now, with the above
ugliness changed to an unconditional __tracepoint_string attribute.

From: Nicolas Pitre <nicolas.pitre@linaro.org>
Date: Fri, 18 Jul 2014 16:34:39 -0400
Subject: [PATCH] trace: don't refer __tracepoint_string to an undefined linker section

When CONFIG_TRACING is not set, the linker script doesn't specify any
__tracepoint_str section.  Let those __tracepoint_string marked strings
live in the default rodata section in that case.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/include/linux/ftrace_event.h b/include/linux/ftrace_event.h
index cff3106ffe..d6346607e4 100644
--- a/include/linux/ftrace_event.h
+++ b/include/linux/ftrace_event.h
@@ -606,7 +606,11 @@ do {									\
 		static const char *___tp_str __tracepoint_string = str; \
 		___tp_str;						\
 	})
+#ifdef CONFIG_TRACING
 #define __tracepoint_string	__attribute__((section("__tracepoint_str")))
+#else
+#define __tracepoint_string
+#endif
 
 #ifdef CONFIG_PERF_EVENTS
 struct perf_event;
