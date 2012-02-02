From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 2 Feb 2012 13:31:28 -0500 (EST)
Subject: [PATCH RFC idle 2/3] arm: Avoid invoking RCU when CPU is idle
In-Reply-To: <20120202174337.GS2518@linux.vnet.ibm.com>
References: <20120202004253.GA10946@linux.vnet.ibm.com>
 <1328143404-11038-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <1328143404-11038-2-git-send-email-paulmck@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202012234050.2759@xanadu.home>
 <20120202044439.GD2435@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202021159560.2759@xanadu.home>
 <20120202174337.GS2518@linux.vnet.ibm.com>
Message-ID: <alpine.LFD.2.02.1202021257340.2759@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Feb 2012, Paul E. McKenney wrote:

> On Thu, Feb 02, 2012 at 12:13:00PM -0500, Nicolas Pitre wrote:
> > I would have to know more about what the rcu_idle_*() calls imply before 
> > suggesting an alternative.
> 
> After a call to rcu_idle_enter(), RCU ignores the CPU completely until the
> next call to rcu_idle_exit().  This means that in the interval between
> rcu_idle_enter() and rcu_idle_exit(), you can say rcu_read_lock() all
> you want, but your data structures will get absolutely no RCU protection.
> This will result in random memory corruption, and for all I know might
> already be resultin in random memory corruption.  So a fix is required.
> 
> So why does RCU need to ignore idle CPUs?  Because otherwise, RCU needs
> to periodically wake them up to check their status.  Waking them up
> periodically defeats CONFIG_NO_HZ's attempts to conserve power.  Avoiding
> waking them up and avoiding ignoring them extended RCU grace periods,
> eventually OOMing the systems.
> 
> Why this new imposition?  It is not new.  It has always been illegal to
> use RCU in the idle loop from the beginning.  But people happily ignored
> that restriction, partly because it is not always immediately obvious
> what is using RCU.  Event tracing does, but unless you know that...

Not having the slightest idea about the tracing context, I'd simply 
suggest flaming the people who ignored the restriction harder.  Or turn 
that into a BUG() to get their attention.

> So we added diagnostics to check for illegal uses of RCU in the idle
> loop, and also separated rcu_idle_enter() and rcu_idle_exit() from
> tick_nohz_stop_sched_tick(), so that things like idle notifiers can work.
> The diagnostics promptly located all sorts of problems, including these.

Good.

> The two options I see are:
> 
> 1.	Rip tracing out of the inner idle loops and everything that
> 	they invoke.

What I suggested above.  But as I said I know sh*t about that tracing 
implementation so that's an easy suggestion for me to make.

> 2.	Push rcu_idle_enter() and rcu_idle_exit() further down into
> 	the idle loops.  As you say, -all- of them.
> 
> My patch set was an attempt at #2, but clearly a very poorly conceived
> attempt.  But I had to start somewhere.

I'm pretty opposed to #2 in any case.  Spreading knowledge about generic 
kernel infrastructure requirements across 53 or so different ARM 
subarchitectures is what has put ARM in trouble in the past, as core 
kernel folks called it a maintenance hell.  Just imagine that you do put 
your rcu_idle_enter() call in those subarchs, and a year from now you 
need to modify its semantics.  At that point you would have to audit all 
those 53 subarchs which might have evolved their idle support in the 
mean time, and the new ones that might have appeared with buggy usage of 
rcu_idle_enter() just because they copied it from somewhere else without 
thinking it through.

Now we're working very hard to kill that trend and move things in the 
other direction so to keep only minimal and very platform specific 
knowledge in the subarch code.  If rcu were to push its requirements 
down there again instead of keeping things abstracted in one place 
higher the stack then that would be a big step backward.

> Other ideas?

Have a special tracing API just for the idle code that queues its events 
in a per-CPU buffer (there should not be that many events to trace in 
the idle code) and have rcu_idle_exit() flush that buffer back in the 
actual tracing infrastructure.  Maybe rcu_idle_enter() could set things 
in a way so the regular tracing API could still be used regardless.  
This has the advantage of keeping the knowledge about rcu restrictions 
in a central place that can be much more easily maintained.


Nicolas
