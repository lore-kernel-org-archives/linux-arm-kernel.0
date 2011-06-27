From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Mon, 27 Jun 2011 22:17:01 +0200
Subject: IRQS off tracer - is it useful or not?
In-Reply-To: <20110627165423.GA6222@n2100.arm.linux.org.uk>
References: <20110625132112.GH23234@n2100.arm.linux.org.uk>	<4E08AF23.2060901@codeaurora.org>
	<20110627165423.GA6222@n2100.arm.linux.org.uk>
Message-ID: <4E08E53D.4050209@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2011 06:54 PM, Russell King - ARM Linux wrote:
> On Mon, Jun 27, 2011 at 09:26:11AM -0700, Stephen Boyd wrote:
>> On 6/25/2011 6:21 AM, Russell King - ARM Linux wrote:
>>> I've just been looking at the IRQS off tracer for the first time.  I'm
>>> getting output such as:
>>>
>>>   <idle>-0       0d.s3    0us!: _raw_spin_lock_irqsave <-_raw_spin_lock_irqsave
>>>   <idle>-0       0dNs4 1709us+: _raw_spin_unlock_irqrestore <-_raw_spin_unlock_irqrestore
>>>   <idle>-0       0dNs4 1770us : time_hardirqs_on <-_raw_spin_unlock_irqrestore
>>>   <idle>-0       0dNs4 1770us : <stack trace>
>>>
>>> from it, which doesn't seem to be very useful.  Figuring out that it
>>> may be because the EABI unwinder doesn't work too well with my toolchain,
>>> I decided to try going for the more reliable frame pointer stuff.  This
>>> gives me:
>>>
>>> kjournal-423     0d.s4    0us : trace_hardirqs_on <-_raw_spin_unlock_irq
>>> kjournal-423     0d.s4    0us : time_hardirqs_on <-_raw_spin_unlock_irq
>>> kjournal-423     0d.s3    0us!: trace_hardirqs_off <-_raw_spin_lock_irqsave
>>> kjournal-423     0d.s4 1709us+: trace_hardirqs_on <-_raw_spin_unlock_irqrestore
>>> kjournal-423     0d.s4 1770us : time_hardirqs_on <-_raw_spin_unlock_irqrestore
>>> kjournal-423     0d.s4 1770us : <stack trace>
>>>  => time_hardirqs_on
>>>  => trace_hardirqs_on_caller
>>>  => trace_hardirqs_on
>>>  => _raw_spin_unlock_irqrestore
>>>  => cfq_idle_slice_timer
>>>  => run_timer_softirq
>>>  => __do_softirq
>>>  => irq_exit
>>>
>>> which is no better.  It's telling me that {trace,time}_hardirqs_o{n,ff} is
>>> involved is absurd - of course that function is involved, because that's
>>> how these events are reported and that detail is just not interesting.
>>> And yet again, we still don't get to find out where IRQs were disabled.
>>
>> Is ftrace enabled (/proc/sys/kernel/ftrace_enabled)? If it is you should
>> a least see the functions that were called while irqs were off.
>>
>> There should also be a
>>
>>  => started at: func_irq_off
>>  => ended at:  func_irq_on
>>
>> near the top of the latency trace although it may not be entirely useful
>> unless spinlocks are inlined. Perhaps we should start inlining spinlocks?
> 
> I tried enabling ftrace too, and while that improved things, it also
> made the latency results unbelievable.
> 
> 1. ftrace didn't log entry into every function in paths - some were
> skipped despite there being an mcount call.
> 2. (and this is the more serious) the overhead of ftrace is _far_ too
> large to draw any meaningful conclusions from the results.
> 
> Are IRQs really disabled for 3ms on OMAP - does it really take 120us
> to get into an interrupt handler through all the NO_HZ stuff - does it
> really take 250us to do a few writes to the DMA controller?

Hi Russell,

Maybe this post is off-topic, but I worked on reducing latencies on
omap3 with xenomai. Most paths are common with Linux, maybe this could
be of interest for this list. The reasons for big latencies with xenomai
on omap3 were:
- the gpio masking/acking function calls nesting, this can be reduced by
inlining some functions, especially when not compiling for multiple
omaps (but my guess is that if you want the lowest latency, you are not
going to compile for all the omaps anyway);
- the gpio demuxing, which is one big irqs off section, this can be
reduced by re-enabling irqs in the middle of it;
- the gptimer 0/1 programming latency, this can be reduced by using
other gptimer, and configuring the timer used as clockevent to be "non
posted".

On omap4, the reasons for high latencies (on 2.6.37, sorry, may be
outdated) are:
- gic mask/ack handlers which take a spinlock then call writel, which
ends up with a call to outer_clean, which takes another spinlock. Solved
by usin a writel_relaxed, and remove the spinlock for mask and ack, and
also implement the mask_ack callback to avoid a function call by
address, which ends up calling two other functions by address, which
take two spinlocks, etc...
- the l2 cache flushes in general, protected by a spinlock, currently
unsolved.
- the gptimer again, but here, we have another clocksource, the cortex
a9 global timer (but maybe not usable with CONFIG_PM?).
- the twd had a lot of early shots because the frequency calibration was
too imprecise (503.6 MHz instead of 504MHz on the board I have), this is
solved by the patches relying on clock frequency instead.

Regards.


-- 
                                                                Gilles.
