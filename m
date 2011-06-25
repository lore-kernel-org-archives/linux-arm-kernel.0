From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 25 Jun 2011 14:21:12 +0100
Subject: IRQS off tracer - is it useful or not?
Message-ID: <20110625132112.GH23234@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've just been looking at the IRQS off tracer for the first time.  I'm
getting output such as:

  <idle>-0       0d.s3    0us!: _raw_spin_lock_irqsave <-_raw_spin_lock_irqsave
  <idle>-0       0dNs4 1709us+: _raw_spin_unlock_irqrestore <-_raw_spin_unlock_irqrestore
  <idle>-0       0dNs4 1770us : time_hardirqs_on <-_raw_spin_unlock_irqrestore
  <idle>-0       0dNs4 1770us : <stack trace>

from it, which doesn't seem to be very useful.  Figuring out that it
may be because the EABI unwinder doesn't work too well with my toolchain,
I decided to try going for the more reliable frame pointer stuff.  This
gives me:

kjournal-423     0d.s4    0us : trace_hardirqs_on <-_raw_spin_unlock_irq
kjournal-423     0d.s4    0us : time_hardirqs_on <-_raw_spin_unlock_irq
kjournal-423     0d.s3    0us!: trace_hardirqs_off <-_raw_spin_lock_irqsave
kjournal-423     0d.s4 1709us+: trace_hardirqs_on <-_raw_spin_unlock_irqrestore
kjournal-423     0d.s4 1770us : time_hardirqs_on <-_raw_spin_unlock_irqrestore
kjournal-423     0d.s4 1770us : <stack trace>
 => time_hardirqs_on
 => trace_hardirqs_on_caller
 => trace_hardirqs_on
 => _raw_spin_unlock_irqrestore
 => cfq_idle_slice_timer
 => run_timer_softirq
 => __do_softirq
 => irq_exit

which is no better.  It's telling me that {trace,time}_hardirqs_o{n,ff} is
involved is absurd - of course that function is involved, because that's
how these events are reported and that detail is just not interesting.
And yet again, we still don't get to find out where IRQs were disabled.

So, from what I can see, the irqsoff tracing support is next to useless,
and given that, anyone got a good reason why I should care about its
hooks?  If I should care about them, it really needs to be fixed so it
actually provides useful information.
