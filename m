From: Dave.Martin@arm.com (Dave P Martin)
Date: Wed, 19 Jun 2013 11:08:16 +0100
Subject: [PATCH 1/2] ARM: vexpress/TC2: basic PM support
In-Reply-To: <alpine.LFD.2.03.1306181528050.18597@syhkavp.arg>
References: <1370587152-4630-1-git-send-email-nicolas.pitre@linaro.org>
 <1370587152-4630-2-git-send-email-nicolas.pitre@linaro.org>
 <20130613203218.GA22310@quad.lixom.net>
 <alpine.LFD.2.03.1306131817310.18597@syhkavp.arg>
 <20130618172434.GI3289@localhost.localdomain>
 <alpine.LFD.2.03.1306181528050.18597@syhkavp.arg>
Message-ID: <20130619100816.GC2874@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 03:50:33PM -0400, Nicolas Pitre wrote:
> On Tue, 18 Jun 2013, Dave P Martin wrote:
> 
> > On Thu, Jun 13, 2013 at 06:31:32PM -0400, Nicolas Pitre wrote:
> > > On Thu, 13 Jun 2013, Olof Johansson wrote:
> > 
> > [...]
> > 
> > > /* Keep per-cpu usage count to cope with unordered up/down requests */
> > > static int tc2_pm_use_count[TC2_MAX_CPUS_PER_CLUSTER][TC2_CLUSTERS];
> > > 
> > > #define tc2_cluster_unused(cluster) \
> > >         (!tc2_pm_use_count[0][cluster] && \
> > >          !tc2_pm_use_count[1][cluster] && \
> > >          !tc2_pm_use_count[2][cluster])
> > > 
> > > > > +	if (!tc2_pm_use_count[0][cluster] &&
> > > > > +	    !tc2_pm_use_count[1][cluster] &&
> > > > > +	    !tc2_pm_use_count[2][cluster])
> > > > 
> > > > I see this construct used three times open-coded like this in the file. Adding
> > > > a smaller helper with a descriptive name would be a good idea.
> > > 
> > > Good observation.  Being too close to this code makes those issues 
> > > invisible.  Hence the tc2_cluster_unused() above.
> > > 
> > > > Same goes for other direct accesses to the array -- maybe a tiny helper to
> > > > set/get state? It might end up overabstracted that way though.
> > > 
> > > I would think so.
> > 
> > True, but it's worth noting that most mcpm backends (certainly any
> > native backends) will end up duplicating this pattern.  We already
> > have it for the fast model and for TC2.
> 
> We do not in the PSCI backend though.
> 
> > In this code, the use counts are doing basically the same thing as
> > the low-level mcpm coordination, but to coordinate things that can
> > happen while all affected CPUs' MMUs are on -- this we can use
> > proper spinlocks and be nice and efficient.  But there are still
> > parallels between the operations on the use counts array and the
> > low-level __mcpm_ state machine helpers.
> 
> Sort of.  The use counts are needed to determine who is becoming the 
> last man.  That's the sole purpose of it.  And then only the last man is 
> allowed to invoke MCPM state machine helpers changing the cluster state.
> 
> > There are some interesting wrinkles here, such as the fact that
> > tc2_pm_powered_up() chooses a first man to perform some post-MMU
> > actions using regular spinlocking and the use counts... but this
> > isn't necessarily the same CPU selected as first man by the
> > low-level pre-MMU synchronisation.  And that's not a bug, because
> > we want the winner at each stage to dash across the finish line:
> > waiting for the runners-up just incurs latency.
> 
> Exact.

(So, when you say the counts are only used to choose the last man, I
don't think it's quite that simple:

in connection with the spinlock, they also do first-man/last-man
coordination, and powerdown preemption at the CPU and cluster levels...
so it really does shadow the low-level state machine.  But that's just
my interpretation, and whether it's a good interpretation will depend on
whether it fits future backends ... which we don't fully know yet.)

> > Much about this feels like it's solving a common but non-trivial
> > problem, so there could be an argument for having more framework, or
> > otherwise documenting it a bit more.
> 
> Well... right now I think it is hard to abstract things properly as we 
> have very few backends.  I would like to see more of them first.

Agreed: that seems a reasonable stance.

This won't turn into a free-for-all unless we allow it to.

> For something that can be done next, it is probably about moving that 
> use count handling up the stack and out of backends.  I don't think we 
> should create more helpers for backends to use and play more ping pong 
> between the core and backends. The core MCPM layer could well take care 
> of that last man determination directly with no abstraction at all and 
> simply pass a last_man flag to simpler backends.  Initially the last man 
> was determined directly from some hardware state but the handling of 
> unordered up/down requests needed more than just a binary state.

Agreed.  Since all the mcpm methods start with code like this to determine
what to do and obtain some sort of lock, there's no reason why that can't
disappear into the framework.

A helper might be needed to do the unlock for the powerdown path, though
this might be combined with the existing helper methods to some extent.


This needs a bit of careful thought though, and I think if we wait for
one or two more backends to emerge, then that thought would be better
informed.

Cheers
---Dave
