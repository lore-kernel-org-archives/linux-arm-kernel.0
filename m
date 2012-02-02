From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Thu, 2 Feb 2012 09:43:37 -0800
Subject: [PATCH RFC idle 2/3] arm: Avoid invoking RCU when CPU is idle
In-Reply-To: <alpine.LFD.2.02.1202021159560.2759@xanadu.home>
References: <20120202004253.GA10946@linux.vnet.ibm.com>
 <1328143404-11038-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <1328143404-11038-2-git-send-email-paulmck@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202012234050.2759@xanadu.home>
 <20120202044439.GD2435@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202021159560.2759@xanadu.home>
Message-ID: <20120202174337.GS2518@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 12:13:00PM -0500, Nicolas Pitre wrote:
> On Wed, 1 Feb 2012, Paul E. McKenney wrote:
> 
> > On Wed, Feb 01, 2012 at 10:49:22PM -0500, Nicolas Pitre wrote:
> > > On Wed, 1 Feb 2012, Paul E. McKenney wrote:
> > > 
> > > > From: "Paul E. McKenney" <paul.mckenney@linaro.org>
> > > > 
> > > > The idle loop is a quiscent state for RCU, which means that RCU ignores
> > > > CPUs that have told RCU that they are idle via rcu_idle_enter().
> > > > There are nevertheless quite a few places where idle CPUs use RCU, most
> > > > commonly indirectly via tracing.  This patch fixes these problems for ARM.
> > > > 
> > > > Many of these bugs have been in the kernel for quite some time, but
> > > > Frederic's recent change now gives warnings.
> > > > 
> > > > This patch takes the straightforward approach of pushing the
> > > > rcu_idle_enter()/rcu_idle_exit() pair further down into the core of the
> > > > idle loop.
> > > 
> > > NAK.
> > > 
> > > 1) This is going to conflict with a patch series I've pushed to RMK 
> > >    already.  You can see its result in linux-next.
> > > 
> > > 2) The purpose of (1) is to do precisely the very opposite i.e. move as 
> > >    much common knowledge as possible up the idle call paths and leave 
> > >    the platform specific quirks as bare as possible, if any.
> > > 
> > > So I'd much prefer if this change was constrained to be inside 
> > > cpu_idle(), or at least in its close vicinity.
> > 
> > OK.  Then the tracing in the inner idle loop needs to go.  Other
> > restructuring might be required as well. 
> 
> Let me expand a bit more on the "if any" in my #2 above.  Most ARM 
> sub-architectures don't have any special idle drivers and they simply 
> rely on the default cpu_do_idle call.  What this proposed patch is doing 
> is to move the rcu_idle_enter()/rcu_idle_exit() pair down into the few 
> subarchs with an existing cpu-idle callback.  This means in practice 
> that rcu_idle_enter()/rcu_idle_exit() wouldn't be called at all anymore 
> on most ARM targets.  Is that appropriate?

Now that you put it that way, it does seem to have severe disadvantages.
Good thing I tagged the patches as RFC.  ;-)

Annoying, that.  I was hoping to get this fixed on an arch-by-arch basis.
Looks like it might have to be a global change requiring global agreement. :-(

> > The long and short of it is that you absolutely cannot use RCU between 
> > the time you invoke rcu_idle_enter() and the time you invoke 
> > rcu_idle_exit().  The ARM idle code currently does just that and 
> > therefore must change.
> > 
> > Whatever change you choose that causes the code to meet that constraint
> > is met is fine by me.
> > 
> > But that constraint absolutely must be met.
> 
> I would have to know more about what the rcu_idle_*() calls imply before 
> suggesting an alternative.

After a call to rcu_idle_enter(), RCU ignores the CPU completely until the
next call to rcu_idle_exit().  This means that in the interval between
rcu_idle_enter() and rcu_idle_exit(), you can say rcu_read_lock() all
you want, but your data structures will get absolutely no RCU protection.
This will result in random memory corruption, and for all I know might
already be resultin in random memory corruption.  So a fix is required.

So why does RCU need to ignore idle CPUs?  Because otherwise, RCU needs
to periodically wake them up to check their status.  Waking them up
periodically defeats CONFIG_NO_HZ's attempts to conserve power.  Avoiding
waking them up and avoiding ignoring them extended RCU grace periods,
eventually OOMing the systems.

Why this new imposition?  It is not new.  It has always been illegal to
use RCU in the idle loop from the beginning.  But people happily ignored
that restriction, partly because it is not always immediately obvious
what is using RCU.  Event tracing does, but unless you know that...

So we added diagnostics to check for illegal uses of RCU in the idle
loop, and also separated rcu_idle_enter() and rcu_idle_exit() from
tick_nohz_stop_sched_tick(), so that things like idle notifiers can work.
The diagnostics promptly located all sorts of problems, including these.

The two options I see are:

1.	Rip tracing out of the inner idle loops and everything that
	they invoke.

2.	Push rcu_idle_enter() and rcu_idle_exit() further down into
	the idle loops.  As you say, -all- of them.

My patch set was an attempt at #2, but clearly a very poorly conceived
attempt.  But I had to start somewhere.

Other ideas?

							Thanx, Paul
