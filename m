From: jamie@shareable.org (Jamie Lokier)
Date: Thu, 15 Apr 2010 22:03:22 +0100
Subject: [Kgdb-bugreport] [PATCH] ARM: change definition of cpu_relax()
	for ARM11MPCore
In-Reply-To: <20100415173609.GA29752@mvista.com>
References: <1271093038-31773-1-git-send-email-will.deacon@arm.com>
	<20100412173247.GA3048@n2100.arm.linux.org.uk>
	<20100415173609.GA29752@mvista.com>
Message-ID: <20100415210322.GB26494@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

George G. Davis wrote:
> Hi,
> 
> On Mon, Apr 12, 2010 at 06:32:47PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Apr 12, 2010 at 06:23:58PM +0100, Will Deacon wrote:
> > > This patch changes the definition of cpu_relax() to smp_mb() for ARMv6 cores,
> > > forcing the write buffer to drain while inside a polling loop on an SMP system.
> > > If the Kernel is not compiled for SMP support, this will expand to a barrier()
> > > as before.
> 
> If I've followed these threads [1][2] correctly, this ARM11 MPCore issue
> was discovered while running the "KGDB: internal test suite" (KGDB_TESTS)
> and that problem is resolved via "kgdb: use atomic_inc and atomic_dec
> instead of atomic_set" [3].  If so, isn't the original ARM11 MPCore KGDB
> cpu_relax() issue just a red herring?  Shouldn't any polling loops
> which depend on specific (hardware) write/read order implement appropriate
> barriers rather than rely on cpu_relax() to guarantee order?

Note that the need to force the write buffer to drain is _not_ an
ordering issue.  It's a buffer draining issue. :-)

I'm not sure if Linux smp_wmb() guarantees to ensure prior writes will
be visible to other CPUs in a short time, or if it only guarantees
write order.

-- Jamie
