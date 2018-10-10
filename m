From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Oct 2018 11:18:40 +0100
Subject: [PATCH] Doc: lockdep: add information about performance impact
In-Reply-To: <20181009155818.GD9259@arm.com>
References: <CGME20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056@eucas1p2.samsung.com>
 <20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056~b_ujkjRd31303013030eucas1p2C@eucas1p2.samsung.com>
 <20181009154359.GB5728@hirez.programming.kicks-ass.net>
 <20181009155818.GD9259@arm.com>
Message-ID: <20181010101840.GM30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2018 at 04:58:18PM +0100, Will Deacon wrote:
> On Tue, Oct 09, 2018 at 05:43:59PM +0200, Peter Zijlstra wrote:
> > On Tue, Oct 09, 2018 at 05:39:27PM +0200, Lukasz Luba wrote:
> > > This patch add some warning related to performance drop.
> > > It should be mentioned that this is not for free
> > > and the platfrom resources (cache, bus interconnect, etc.)
> > > will be used more frequently.
> > 
> > To me this reads a bit like: water is wet.
> > 
> > Is this really needed?
> 
> I don't think so -- this is a debug option under "kernel hacking". Surely
> the perf hit comes with the territory.

Indeed it does - since adding debug code means additional instructions,
more cache pressure and, therefore, slower execution.

I've already said to people... turn on all debug options for development,
and when you move to performance evaluation and optimisation for the
production version, evaluate and turn off debug options.

Unfortunately, turning off PROVE_LOCKING in the defconfigs is going
to have a negative impact on the automated build/boot testing that
systems like kernelci.org do for us - these are primarily based
around the defconfigs, which means we're going to end up building
with PROVE_LOCKING disabled.  This means kernelci.org will be less
likely to catch locking issues.

Forcing PROVE_LOCKING on also doesn't make sense - there may be (rare)
bugs, eg race conditions, uncovered by having that disabled.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
