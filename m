From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Jun 2011 17:54:23 +0100
Subject: IRQS off tracer - is it useful or not?
In-Reply-To: <4E08AF23.2060901@codeaurora.org>
References: <20110625132112.GH23234@n2100.arm.linux.org.uk>
	<4E08AF23.2060901@codeaurora.org>
Message-ID: <20110627165423.GA6222@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2011 at 09:26:11AM -0700, Stephen Boyd wrote:
> On 6/25/2011 6:21 AM, Russell King - ARM Linux wrote:
> > I've just been looking at the IRQS off tracer for the first time.  I'm
> > getting output such as:
> >
> >   <idle>-0       0d.s3    0us!: _raw_spin_lock_irqsave <-_raw_spin_lock_irqsave
> >   <idle>-0       0dNs4 1709us+: _raw_spin_unlock_irqrestore <-_raw_spin_unlock_irqrestore
> >   <idle>-0       0dNs4 1770us : time_hardirqs_on <-_raw_spin_unlock_irqrestore
> >   <idle>-0       0dNs4 1770us : <stack trace>
> >
> > from it, which doesn't seem to be very useful.  Figuring out that it
> > may be because the EABI unwinder doesn't work too well with my toolchain,
> > I decided to try going for the more reliable frame pointer stuff.  This
> > gives me:
> >
> > kjournal-423     0d.s4    0us : trace_hardirqs_on <-_raw_spin_unlock_irq
> > kjournal-423     0d.s4    0us : time_hardirqs_on <-_raw_spin_unlock_irq
> > kjournal-423     0d.s3    0us!: trace_hardirqs_off <-_raw_spin_lock_irqsave
> > kjournal-423     0d.s4 1709us+: trace_hardirqs_on <-_raw_spin_unlock_irqrestore
> > kjournal-423     0d.s4 1770us : time_hardirqs_on <-_raw_spin_unlock_irqrestore
> > kjournal-423     0d.s4 1770us : <stack trace>
> >  => time_hardirqs_on
> >  => trace_hardirqs_on_caller
> >  => trace_hardirqs_on
> >  => _raw_spin_unlock_irqrestore
> >  => cfq_idle_slice_timer
> >  => run_timer_softirq
> >  => __do_softirq
> >  => irq_exit
> >
> > which is no better.  It's telling me that {trace,time}_hardirqs_o{n,ff} is
> > involved is absurd - of course that function is involved, because that's
> > how these events are reported and that detail is just not interesting.
> > And yet again, we still don't get to find out where IRQs were disabled.
> 
> Is ftrace enabled (/proc/sys/kernel/ftrace_enabled)? If it is you should
> a least see the functions that were called while irqs were off.
> 
> There should also be a
> 
>  => started at: func_irq_off
>  => ended at:  func_irq_on
> 
> near the top of the latency trace although it may not be entirely useful
> unless spinlocks are inlined. Perhaps we should start inlining spinlocks?

I tried enabling ftrace too, and while that improved things, it also
made the latency results unbelievable.

1. ftrace didn't log entry into every function in paths - some were
skipped despite there being an mcount call.
2. (and this is the more serious) the overhead of ftrace is _far_ too
large to draw any meaningful conclusions from the results.

Are IRQs really disabled for 3ms on OMAP - does it really take 120us
to get into an interrupt handler through all the NO_HZ stuff - does it
really take 250us to do a few writes to the DMA controller?

If I'm wanting to find out how long IRQs are disabled and where that
happens, I'd feel a lot more confident about writing my own IRQ latency
tracing for this rather than trying to use this stuff.

So what I'm trying to get to the bottom of: should I care about the
IRQS off hooks in the entry assembly code given that the existing IRQs
off tracing seems to be useless for performing that task.  My own
personal experience is saying a very big no to that.
