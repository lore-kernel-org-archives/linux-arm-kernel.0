From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Sep 2014 18:40:49 +0100
Subject: [PATCH FYI 3/4] ARM: add basic support for on-demand backtrace
 of other CPUs
In-Reply-To: <5409C925.8020409@linaro.org>
References: <20140905094056.GD30401@n2100.arm.linux.org.uk>
 <E1XPq1S-0000RP-FR@rmk-PC.arm.linux.org.uk> <5409C925.8020409@linaro.org>
Message-ID: <20140905174049.GJ30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 05, 2014 at 03:31:01PM +0100, Daniel Thompson wrote:
> On 05/09/14 10:41, Russell King wrote:
> > diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> > index 9388a3d479e1..94959f977b82 100644
> > --- a/arch/arm/kernel/smp.c
> > +++ b/arch/arm/kernel/smp.c
> > @@ -72,8 +72,12 @@ enum ipi_msg_type {
> >  	IPI_CPU_STOP,
> >  	IPI_IRQ_WORK,
> >  	IPI_COMPLETION,
> > +	IPI_CPU_BACKTRACE,
> 
> I'd prefer this to use a more generic name to allow the IPI to be used
> for debug/profiling purposes.

However, for profiling purposes, you want the profiling code to have
as smaller impact as possible, so you wouldn't want to call lots of
unnecessary functions based on:

> The backtrace_mask bitmap already makes it safe to call
> ipi_cpu_backtrace() without any additional demux.

The reason is quite simple - if you spend longer in the profiling code,
you perturb the timings of the code being profiled more, which can
change the profiled code's behaviour.  Take a look at things like the
network receive softirq (or any softirq) where there's a limited amount
of work which is done on the tail-end of a normal interrupt, before
bouncing it across to ksoftirqd.

Let's say you're chasing a performance problem with networking, trying
to work out what's going on, but running perf causes the performance
problem to vanish, because the timings have changed soo much that the
softirq stays scheduled on ksoftirqd.  What do you do then?

We should always aim for profiling and debugging to hasve as low
overhead as is possible.

> >  };
> >  
> > +/* For reliability, we're prepared to waste bits here. */
> > +static DECLARE_BITMAP(backtrace_mask, NR_CPUS) __read_mostly;
> > +
> 
> Both checkpatch and the comments in linux/thread.h imply using
> CONFIG_NR_CPUS is better here.

This comes from x86 code.  I don't wish to introduce an additional delta
between x86 and ARM, especially as we should look towards moving the x86
version out of arch/x86 into a generic location.

> How about some indication showing degree of platform support currently
> available?
> 
> printk(KERN_WARNING "%s backtrace for cpu %d\n",
>        in_nmi() ? "FIQ" : "Non-FIQ", cpu);

We could do that.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
