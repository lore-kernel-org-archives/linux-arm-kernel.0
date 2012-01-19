From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 19 Jan 2012 10:52:30 +0000
Subject: [RFC PATCH 0/5] ARM: introducing DT topology
In-Reply-To: <20120118180453.GN1068@n2100.arm.linux.org.uk>
References: <1326897408-11204-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20120118162423.GK1068@n2100.arm.linux.org.uk>
 <20120118175028.GD9691@e102568-lin.cambridge.arm.com>
 <20120118180453.GN1068@n2100.arm.linux.org.uk>
Message-ID: <20120119105229.GB18830@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 06:04:53PM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 18, 2012 at 05:50:28PM +0000, Lorenzo Pieralisi wrote:
> > I agree with you Russell, that's 100% valid on a single cluster. But on
> > a multi-cluster (eg dual-cluster) the MPIDR might be wired like this:
> > 
> > MPIDR[15:8] - cluster id
> > MPIDR[7:0] - core id
> > 
> > no hyperthreading
> > 
> > * CLUSTER 0 *
> >                        MPIDR[23:16]   MPIDR[15:8]    MPIDR[7:0]
> > HWCPU0: MPIDR=0x0          0x0            0x0           0x0
> > HWCPU1: MPIDR=0x1          0x0            0x0           0x1 
> > 
> > * CLUSTER 1 *
> > 
> > HWCPU2: MPIDR=0x100        0x0            0x1           0x0               
> > HWCPU3: MPIDR=0x101        0x0            0x1           0x1  
> > 
> > MPIDR is not a sequential index anymore, that's what I am going on about. 
> 
> And that's no problem to the boot code.  Assuming cluster 0 CPU 0 is the
> boot CPU, then:
> 
> cpu_logical_map() would need to be initialized as {0x000, 0x001, 0x100,
> 0x101}.

Correct. Now the question is how to get those values in the array.
There are two ways:

a) the boot CPU generates them
b) the boot CPU parses them from DT

case a) For this to work, and to be able to boot on every CPU on every
        cluster we need to have a way to detect the number of clusters
	and the number of CPUs per cluster
case b) Just parse the tree and retrieve the "reg" property, patch 1 of
        this series

Now, as you know ways better than I do, to boot an SMP system (with a
GIC) we need a pair {mpidr, GIC CPU IF id} and the values must be linked
(ie they have to uniquely represent a CPU), you correctly stated that in
your reply.

Hence, as you said, we need to retrieve the GIC CPU IF related to a given
MPIDR. We cannot generate it, as the current code assumes.

Example (dual-cluster system, each cluster made up of two CPUS, no SMT)

* CLUSTER 0

HWCPU0: MPIDR=0x0 
HWCPU1: MPIDR=0x1 

* CLUSTER 1

HWCPU2: MPIDR=0x100 
HWCPU3: MPIDR=0x101

Even if we knew the number of cpus per cluster and the number of clusters 
at boot

MPIDR = 0x101 does NOT imply GIC CPU IF id=0x3

The following formula does not work all the time
(GIC CPU IF id = MPIDR[7:0] + nb_cpus_in_lower_cluster_indexes)

NB: nb_cpus_in_lower_cluster_indexes must be computed by the boot CPU.

ARM mandate that numbering, but it is not a strict requirement (GICs
deviating from that numbering will be the exception, not the rule, but
we have to cater for them).

Hence we need a way to link GIC CPU IF id to MPIDR and that's patch 4 or
we could do that by using static data, I see no other solution.

But if we accept we can use DT to create that link, we can also use DT
to init cpu_logical_map instead of generating its values (since the linkage in
DT is done by using "cpu" nodes).

I have no strong opinion on this, just would like us to agree on a clean and
proper way forward, so any comment more than welcome.

> > And yes, code like cpu_resume, that relies on MPIDR[7:0] to be unique
> > needs patching, since that just takes into account the first affinity
> > level, which can have same values for different CPUs in the system if
> > they belong to different clusters.
> 
> That's going to be very painful to deal with, because of the restricted
> environment we have there.  I guess we need to build some kind of
> reverse table in memory somewhere which contains MPIDR mask+MPIDR value+
> CPU array index.  Not nice at all.
> 

That's the first thing I thought when I noticed the MPIDR config for 
multi-clusters. 

> > > > This hypothesis is not valid when the concept of cluster is introduced since
> > > > the MPIDR cannot be represented as a single index and interrupt controller
> > > > CPU interfaces might be wired with a numbering scheme following per-SoC
> > > > design parameters which cannot be extrapolated easily through generic functions
> > > > by the primary CPU.
> > > 
> > > So what you're saying is that the GIC CPU index may not be the CPU number
> > > given by MPIDR?
> > 
> > Yes, that's correct. Taking the same example as above:
> > 
> > MPIDR[15:8] - cluster id
> > MPIDR[7:0] - core id
> > 
> > no hyperthreading
> > 
> > * CLUSTER 0 *
> >                          MPIDR[15:8]    MPIDR[7:0]  GIC-CPU-ID
> > 		       
> > HWCPU0: MPIDR=0x0            0x0           0x0          0x0
> > HWCPU1: MPIDR=0x1            0x0           0x1          0x1 
> > 
> > * CLUSTER 1 *
> > 
> > HWCPU2: MPIDR=0x100          0x1           0x0          0x2     
> > HWCPU3: MPIDR=0x101          0x1           0x1          0x3
> > 
> > There is just one GIC distributor shared across all clusters.
> 
> Right, so what we need is a kernel logical CPU id to GIC id mapping,
> which you have in your patch.  You call it cpuif_logical_map() but
> as it's specific to GIC, I wonder if it would be better called
> gic_logical_map().

That's agreed.

> > > > Furthermore, relying on the MPIDR to be wired according to real topology
> > > > levels might turn out to be an unreliable solution, hence a SW
> > > > representation is needed to override possibly incorrect MPIDR register
> > > > values.
> > > 
> > > This sounds like you're saying that the contents of MPIDR might be buggy
> > > sometime in the future?  Do we actually know of any situations where the
> > > information in there is currently wrong (outside of the development lab)?
> > > If not, it's not something we should cater for until it's actually happened,
> > > and then the pain should be felt by those silly enough to allow the chip
> > > to go out the door.
> > 
> > I share your view Russell. Having said that: MPIDR is IMPLEMENTATION DEFINED.
> 
> I'll assume you mean that it's left to the implementation to set MPIDR
> appropriately, and you're expecting implementations to make mistakes
> with it.
> 
> Tell me: would you tolerate people making mistakes when they implement
> an ARM CPU which results in the ISA almost being followed except some
> op-codes having bits switched?
> 
> If not, then why would you tolerate wrong MPIDR values?  That's precisely
> the same kind of bug.  And if we go adding work-arounds now, before
> there's a problem, there will be no incentive for people to fix the
> hardware bugs during their initial implementation testing.

I agree Russell, nothing to object, but you should concede that having
op-codes with bits switched is easier to detect :) (even though if we
decide to "generate" the cpu_logical_map with a bunch of code, the pen 
release code will easily go pop if MPIDR is botched).

PATCH 5 can also be used to count the number of CPUs per cluster and the 
number of clusters in the system if we cannot rely on a HW mechanisms to probe 
that.

I will keep it on my tree in case we deem it necessary.

Thank you very much,
Lorenzo
