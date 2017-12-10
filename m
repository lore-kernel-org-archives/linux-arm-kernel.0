From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Sun, 10 Dec 2017 13:39:30 -0800
Subject: WARNING: suspicious RCU usage
In-Reply-To: <20171210193438.GP10595@n2100.armlinux.org.uk>
References: <20171210113930.zimywmxzsutwzzmz@linux-u7w5.ap.freescale.net>
 <20171210120012.GM10595@n2100.armlinux.org.uk>
 <20171210190727.GJ7829@linux.vnet.ibm.com>
 <20171210193438.GP10595@n2100.armlinux.org.uk>
Message-ID: <20171210213930.GL7829@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 10, 2017 at 07:34:39PM +0000, Russell King - ARM Linux wrote:
> On Sun, Dec 10, 2017 at 11:07:27AM -0800, Paul E. McKenney wrote:
> > On Sun, Dec 10, 2017 at 12:00:12PM +0000, Russell King - ARM Linux wrote:
> > > +Paul
> > > 
> > > Annoyingly, it looks like calling "complete()" from a dying CPU is
> > > triggering the RCU usage warning.  From what I remember, this is an
> > > old problem, and we still have no better solution for this other than
> > > to persist with the warning.
> > 
> > I thought that this issue was resolved with tglx's use of IPIs from
> > the outgoing CPU.  Or is this due to an additional complete() from the
> > ARM code?  If so, could it also use tglx's IPI trick?
> 
> I don't think it was tglx's IPI trick, I've had code sitting in my tree
> for a while for it, but it has its own set of problems which are not
> resolvable:
> 
> 1. it needs more IPIs than we have available on all platforms

OK, I will ask the stupid question...  Is it possible to multiplex
the IPIs, for example, by using smp_call_function_single()?

> 2. there's some optional locking in the GIC driver that cause problems
>    for the cpu dying path.

On this, I must plead ignorance.

> The concensus last time around was that the IPI solution is a non-
> starter, so the seven year proven-reliable solution (disregarding the
> RCU warning) persists because I don't think anyone came up with a
> better solution.

Seven years already?  Sigh, I don't have the heart to check because
I wouldn't want to find out that it has actually been longer.  ;-)

							Thanx, Paul

> > > I suspect the following lockdep warning is triggered by the RCU code
> > > bringing the console semaphore into the mix of locks.
> > 
> > It does indeed look to me that it is quite possible that resolving
> > the complete() issue would prevent the lockdep splat from appearing,
> > which might in turn prevent acquisition of the console semaphore.
> 
> Yea, if only it was simple to resolve that.
> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up
> 
