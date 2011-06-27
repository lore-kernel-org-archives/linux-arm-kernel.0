From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 27 Jun 2011 09:26:11 -0700
Subject: IRQS off tracer - is it useful or not?
In-Reply-To: <20110625132112.GH23234@n2100.arm.linux.org.uk>
References: <20110625132112.GH23234@n2100.arm.linux.org.uk>
Message-ID: <4E08AF23.2060901@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/25/2011 6:21 AM, Russell King - ARM Linux wrote:
> I've just been looking at the IRQS off tracer for the first time.  I'm
> getting output such as:
>
>   <idle>-0       0d.s3    0us!: _raw_spin_lock_irqsave <-_raw_spin_lock_irqsave
>   <idle>-0       0dNs4 1709us+: _raw_spin_unlock_irqrestore <-_raw_spin_unlock_irqrestore
>   <idle>-0       0dNs4 1770us : time_hardirqs_on <-_raw_spin_unlock_irqrestore
>   <idle>-0       0dNs4 1770us : <stack trace>
>
> from it, which doesn't seem to be very useful.  Figuring out that it
> may be because the EABI unwinder doesn't work too well with my toolchain,
> I decided to try going for the more reliable frame pointer stuff.  This
> gives me:
>
> kjournal-423     0d.s4    0us : trace_hardirqs_on <-_raw_spin_unlock_irq
> kjournal-423     0d.s4    0us : time_hardirqs_on <-_raw_spin_unlock_irq
> kjournal-423     0d.s3    0us!: trace_hardirqs_off <-_raw_spin_lock_irqsave
> kjournal-423     0d.s4 1709us+: trace_hardirqs_on <-_raw_spin_unlock_irqrestore
> kjournal-423     0d.s4 1770us : time_hardirqs_on <-_raw_spin_unlock_irqrestore
> kjournal-423     0d.s4 1770us : <stack trace>
>  => time_hardirqs_on
>  => trace_hardirqs_on_caller
>  => trace_hardirqs_on
>  => _raw_spin_unlock_irqrestore
>  => cfq_idle_slice_timer
>  => run_timer_softirq
>  => __do_softirq
>  => irq_exit
>
> which is no better.  It's telling me that {trace,time}_hardirqs_o{n,ff} is
> involved is absurd - of course that function is involved, because that's
> how these events are reported and that detail is just not interesting.
> And yet again, we still don't get to find out where IRQs were disabled.

Is ftrace enabled (/proc/sys/kernel/ftrace_enabled)? If it is you should
a least see the functions that were called while irqs were off.

There should also be a

 => started at: func_irq_off
 => ended at:  func_irq_on

near the top of the latency trace although it may not be entirely useful
unless spinlocks are inlined. Perhaps we should start inlining spinlocks?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
