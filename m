From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 22 Sep 2016 10:29:40 -0400
Subject: [PATCH] clocksource/drivers/ti-32k: Prevent ftrace recursion
In-Reply-To: <alpine.DEB.2.20.1609221555590.5599@nanos>
References: <20160922075621.3725-1-jszhang@marvell.com>
 <alpine.DEB.2.20.1609221555590.5599@nanos>
Message-ID: <20160922102940.6ddfeb0e@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Sep 2016 15:58:03 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 22 Sep 2016, Jisheng Zhang wrote:
> 
> > Currently ti-32k can be used as a scheduler clock. We properly marked
> > omap_32k_read_sched_clock() as notrace but we then call another
> > function ti_32k_read_cycles() that _wasn't_ notrace.
> > 
> > Having a traceable function in the sched_clock() path leads to a
> > recursion within ftrace and a kernel crash.  
> 
> Kernel crash? Doesn't ftrace core prevent recursion?
>

There is recursion protection, but there are some holes, as well as
calls where ftrace can't protect itself.

What triggered the bug? Just simple enabling of function tracing? And
what arch? I would like to close these holes. Although, I should add
some kind of flag to notify the user (or at least for me) that recursion
is happening, because that can really be a performance hit on tracing.

-- Steve
