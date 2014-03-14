From: will.deacon@arm.com (Will Deacon)
Date: Fri, 14 Mar 2014 10:07:35 +0000
Subject: [PATCH v6 4/7] arm64: Add ftrace support
In-Reply-To: <53228959.3040000@linaro.org>
References: <1393564724-3966-1-git-send-email-takahiro.akashi@linaro.org>
 <1394705630-12384-1-git-send-email-takahiro.akashi@linaro.org>
 <1394705630-12384-5-git-send-email-takahiro.akashi@linaro.org>
 <20140313170834.GE25472@mudshark.cambridge.arm.com>
 <53228959.3040000@linaro.org>
Message-ID: <20140314100735.GC13541@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 04:45:13AM +0000, AKASHI Takahiro wrote:
> On 03/14/2014 02:08 AM, Will Deacon wrote:
> > On Thu, Mar 13, 2014 at 10:13:47AM +0000, AKASHI Takahiro wrote:
> >> This patch implements arm64 specific part to support function tracers,
> >> such as function (CONFIG_FUNCTION_TRACER), function_graph
> >> (CONFIG_FUNCTION_GRAPH_TRACER) and function profiler
> >> (CONFIG_FUNCTION_PROFILER).
> >>
> >> With 'function' tracer, all the functions in the kernel are traced with
> >> timestamps in ${sysfs}/tracing/trace. If function_graph tracer is
> >> specified, call graph is generated.
> >>
> >> The kernel must be compiled with -pg option so that _mcount() is inserted
> >> at the beginning of functions. This function is called on every function's
> >> entry as long as tracing is enabled.
> >> In addition, function_graph tracer also needs to be able to probe function's
> >> exit. ftrace_graph_caller() & return_to_handler do this by faking link
> >> register's value to intercept function's return path.
> >>
> >> More details on architecture specific requirements are described in
> >> Documentation/trace/ftrace-design.txt.
> >
> > [...]
> 
> You seem not to like this statement :-)

Huh? I was just using '[...]' to signify that I'd removed a lot of context
(since the code all looked fine there). Otherwise, review emails can get
really long.

> >> +       str     x0, [sp, #-16]!
> >> +       mov     x0, x29                 //     parent's fp
> >> +       bl      ftrace_return_to_handler// addr = ftrace_return_to_hander(fp);
> >> +       mov     x30, x0                 // restore the original return address
> >> +       ldr     x0, [sp], #16
> >> +       ret
> >
> > and an ENDPROC here.
> 
> Fix it.
> But please note that this (return_to_handler) is not a real function.
> Declaring it as ENDPROC is not very useful.

Then use END(...). The opening macro was the main point, since that avoid
the need for an explicit .globl.

Will
