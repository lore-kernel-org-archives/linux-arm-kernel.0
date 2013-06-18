From: Dave.Martin@arm.com (Dave P Martin)
Date: Tue, 18 Jun 2013 18:24:34 +0100
Subject: [PATCH 1/2] ARM: vexpress/TC2: basic PM support
In-Reply-To: <alpine.LFD.2.03.1306131817310.18597@syhkavp.arg>
References: <1370587152-4630-1-git-send-email-nicolas.pitre@linaro.org>
 <1370587152-4630-2-git-send-email-nicolas.pitre@linaro.org>
 <20130613203218.GA22310@quad.lixom.net>
 <alpine.LFD.2.03.1306131817310.18597@syhkavp.arg>
Message-ID: <20130618172434.GI3289@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 06:31:32PM -0400, Nicolas Pitre wrote:
> On Thu, 13 Jun 2013, Olof Johansson wrote:

[...]

> /* Keep per-cpu usage count to cope with unordered up/down requests */
> static int tc2_pm_use_count[TC2_MAX_CPUS_PER_CLUSTER][TC2_CLUSTERS];
> 
> #define tc2_cluster_unused(cluster) \
>         (!tc2_pm_use_count[0][cluster] && \
>          !tc2_pm_use_count[1][cluster] && \
>          !tc2_pm_use_count[2][cluster])
> 
> > > +	if (!tc2_pm_use_count[0][cluster] &&
> > > +	    !tc2_pm_use_count[1][cluster] &&
> > > +	    !tc2_pm_use_count[2][cluster])
> > 
> > I see this construct used three times open-coded like this in the file. Adding
> > a smaller helper with a descriptive name would be a good idea.
> 
> Good observation.  Being too close to this code makes those issues 
> invisible.  Hence the tc2_cluster_unused() above.
> 
> > Same goes for other direct accesses to the array -- maybe a tiny helper to
> > set/get state? It might end up overabstracted that way though.
> 
> I would think so.

True, but it's worth noting that most mcpm backends (certainly any
native backends) will end up duplicating this pattern.  We already
have it for the fast model and for TC2.


In this code, the use counts are doing basically the same thing as
the low-level mcpm coordination, but to coordinate things that can
happen while all affected CPUs' MMUs are on -- this we can use
proper spinlocks and be nice and efficient.  But there are still
parallels between the operations on the use counts array and the
low-level __mcpm_ state machine helpers.

There are some interesting wrinkles here, such as the fact that
tc2_pm_powered_up() chooses a first man to perform some post-MMU
actions using regular spinlocking and the use counts... but this
isn't necessarily the same CPU selected as first man by the
low-level pre-MMU synchronisation.  And that's not a bug, because
we want the winner at each stage to dash across the finish line:
waiting for the runners-up just incurs latency.


Much about this feels like it's solving a common but non-trivial
problem, so there could be an argument for having more framework, or
otherwise documenting it a bit more.

We seem to have the following basic operations:

	lock_for_power_down(cpu, cluster) ->

		cluster and CPU need to be powered on, lock is held for both;
		CPU needs to be powered on, lock is held for it; or
		CPU is already on, so do nothing, lock is not held.

	lock_for_power_up(cpu, cluster) ->

		CPU and cluster need to be powered down (last man), lock is held for both; or
		CPU needs to be powered down, lock is held for it; or
		Someone is already turning the CPU on, so do nothing, lock is not held.

	lock_for_setup(cpu, cluster) ->

		cluster needs to be put into the powered-on state (post-MMU first man), lock is held for it.
		cluster is already in the powrered-on state, so do nothing, lock is not held.

	unlock()

		guess


These may not be great names, but hopefully you get the idea.

They correspond to the operations done in .power_up(), .power_down()
and .powered_up() respectively.

Cheers
---Dave
