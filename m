From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Sat, 22 Sep 2012 16:11:22 -0700
Subject: rcu self-detected stall messages on OMAP3, 4 boards
In-Reply-To: <alpine.DEB.2.00.1209222223080.22590@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209202244470.32589@utopia.booyaka.com>
 <20120920232114.GO2449@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209211803290.8839@utopia.booyaka.com>
 <20120921185827.GC2454@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209211900520.8839@utopia.booyaka.com>
 <20120921195717.GD2454@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209221836070.10663@utopia.booyaka.com>
 <20120922201043.GE2934@linux.vnet.ibm.com>
 <20120922215923.GA13161@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209222223080.22590@utopia.booyaka.com>
Message-ID: <20120922231121.GH2934@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 22, 2012 at 10:25:59PM +0000, Paul Walmsley wrote:
> On Sat, 22 Sep 2012, Paul E. McKenney wrote:
> 
> > And here is a patch.  I am still having trouble reproducing the problem,
> > but figured that I should avoid serializing things.
> 
> Thanks, testing this now on v3.6-rc6.

Very cool, thank you!

>                                        One question though about the patch 
> description:
> 
> > All this begs the question of exactly how a callback-free grace period
> > gets started in the first place.  This can happen due to the fact that
> > CPUs do not necessarily agree on which grace period is in progress.
> > If a CPU still believes that the grace period that just completed is
> > still ongoing, it will believe that it has callbacks that need to wait
> > for another grace period, never mind the fact that the grace period
> > that they were waiting for just completed.  This CPU can therefore
> > erroneously decide to start a new grace period.
> 
> Doesn't this imply that this bug would only affect multi-CPU systems?  

Surprisingly not, at least when running TREE_RCU or TREE_PREEMPT_RCU.
In order to keep lock contention down to a dull roar on larger systems,
TREE_RCU keeps three sets of books: (1) the global state in the rcu_state
structure, (2) the combining-tree per-node state in the rcu_node
structure, and the per-CPU state in the rcu_data structure.  A CPU is
not officially aware of the end of a grace period until it is reflected
in its rcu_data structure.  This has the perhaps-surprising consequence
that the CPU that detected the end of the old grace period might start
a new one before becoming officially aware that the old one ended.

Why not have the CPU inform itself immediately upon noticing that the
old grace period ended?  Deadlock.  The rcu_node locks must be acquired
from leaf towards root, and the CPU is holding the root rcu_node lock
when it notices that the grace period has ended.

I have made this a bit less problematic in the bigrt branch, working
towards a goal of getting RCU into a state where automatic formal
validation might one day be possible.  And yes, I am starting to get some
formal-validation people interested in this lofty goal, see for example:
http://sites.google.com/site/popl13grace/paper.pdf.

> The recent tests here have been on Pandaboard, which is dual-CPU, but my 
> recollection is that I also observed the warnings on a single-core 
> Beagleboard.  Will re-test.

Anxiously awaiting the results.  This has been a strange one, even by
RCU's standards.

Plus I need to add a few Reported-by lines.  Next version...

							Thanx, Paul
