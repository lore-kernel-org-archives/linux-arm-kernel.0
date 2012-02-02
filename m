From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 2 Feb 2012 12:13:00 -0500 (EST)
Subject: [PATCH RFC idle 2/3] arm: Avoid invoking RCU when CPU is idle
In-Reply-To: <20120202044439.GD2435@linux.vnet.ibm.com>
References: <20120202004253.GA10946@linux.vnet.ibm.com>
 <1328143404-11038-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <1328143404-11038-2-git-send-email-paulmck@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202012234050.2759@xanadu.home>
 <20120202044439.GD2435@linux.vnet.ibm.com>
Message-ID: <alpine.LFD.2.02.1202021159560.2759@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 1 Feb 2012, Paul E. McKenney wrote:

> On Wed, Feb 01, 2012 at 10:49:22PM -0500, Nicolas Pitre wrote:
> > On Wed, 1 Feb 2012, Paul E. McKenney wrote:
> > 
> > > From: "Paul E. McKenney" <paul.mckenney@linaro.org>
> > > 
> > > The idle loop is a quiscent state for RCU, which means that RCU ignores
> > > CPUs that have told RCU that they are idle via rcu_idle_enter().
> > > There are nevertheless quite a few places where idle CPUs use RCU, most
> > > commonly indirectly via tracing.  This patch fixes these problems for ARM.
> > > 
> > > Many of these bugs have been in the kernel for quite some time, but
> > > Frederic's recent change now gives warnings.
> > > 
> > > This patch takes the straightforward approach of pushing the
> > > rcu_idle_enter()/rcu_idle_exit() pair further down into the core of the
> > > idle loop.
> > 
> > NAK.
> > 
> > 1) This is going to conflict with a patch series I've pushed to RMK 
> >    already.  You can see its result in linux-next.
> > 
> > 2) The purpose of (1) is to do precisely the very opposite i.e. move as 
> >    much common knowledge as possible up the idle call paths and leave 
> >    the platform specific quirks as bare as possible, if any.
> > 
> > So I'd much prefer if this change was constrained to be inside 
> > cpu_idle(), or at least in its close vicinity.
> 
> OK.  Then the tracing in the inner idle loop needs to go.  Other
> restructuring might be required as well. 

Let me expand a bit more on the "if any" in my #2 above.  Most ARM 
sub-architectures don't have any special idle drivers and they simply 
rely on the default cpu_do_idle call.  What this proposed patch is doing 
is to move the rcu_idle_enter()/rcu_idle_exit() pair down into the few 
subarchs with an existing cpu-idle callback.  This means in practice 
that rcu_idle_enter()/rcu_idle_exit() wouldn't be called at all anymore 
on most ARM targets.  Is that appropriate?

> The long and short of it is that you absolutely cannot use RCU between 
> the time you invoke rcu_idle_enter() and the time you invoke 
> rcu_idle_exit().  The ARM idle code currently does just that and 
> therefore must change.
> 
> Whatever change you choose that causes the code to meet that constraint
> is met is fine by me.
> 
> But that constraint absolutely must be met.

I would have to know more about what the rcu_idle_*() calls imply before 
suggesting an alternative.


Nicolas
