From: will.deacon@arm.com (Will Deacon)
Date: Fri, 16 Apr 2010 14:54:28 +0100
Subject: [Kgdb-bugreport] [PATCH] ARM: change definition of cpu_relax()
	for ARM11MPCore
In-Reply-To: <20100415173609.GA29752@mvista.com>
References: <1271093038-31773-1-git-send-email-will.deacon@arm.com>
	<20100412173247.GA3048@n2100.arm.linux.org.uk>
	<20100415173609.GA29752@mvista.com>
Message-ID: <1271426068.18220.1.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi George,

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
> instead of atomic_set" [3].  

Yes, I encountered the issue in the KGDB testsuite. However, the patch [3]
in mainline doesn't resolve the issue as pointed out here:

http://lkml.org/lkml/2010/4/8/214

> If so, isn't the original ARM11 MPCore KGDB
> cpu_relax() issue just a red herring?  Shouldn't any polling loops
> which depend on specific (hardware) write/read order implement appropriate
> barriers rather than rely on cpu_relax() to guarantee order?  If
> perhaps there are indeed other cases where cpu_relax() is being used
> incorrectly, then maybe those should be fixed instead?  Just curious...

As pointed out by Jamie Lokier, this isn't about ordering, it's about
ensuring that stores eventually make it to memory.

According to Linus:

`Linux does expect that if some other CPU modifies a memory location, 
then we _will_ see that modification eventually. If the CPU needs help to 
do so, then cpu_relax() needs to do that.'

Since the ARM11MPCore doesn't make this guarantee in hardware, then we
have to fix it up in software. We can either fix up every polling loop in
the Kernel individually or [as suggested above] modify cpu_relax() to
do the work for us. Note that we only need to modify cpu_relax() for this
particular core; other ARM SMP variants behave more sanely.

Thanks,

Will
