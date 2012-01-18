From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jan 2012 18:04:53 +0000
Subject: [RFC PATCH 0/5] ARM: introducing DT topology
In-Reply-To: <20120118175028.GD9691@e102568-lin.cambridge.arm.com>
References: <1326897408-11204-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20120118162423.GK1068@n2100.arm.linux.org.uk>
 <20120118175028.GD9691@e102568-lin.cambridge.arm.com>
Message-ID: <20120118180453.GN1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 05:50:28PM +0000, Lorenzo Pieralisi wrote:
> I agree with you Russell, that's 100% valid on a single cluster. But on
> a multi-cluster (eg dual-cluster) the MPIDR might be wired like this:
> 
> MPIDR[15:8] - cluster id
> MPIDR[7:0] - core id
> 
> no hyperthreading
> 
> * CLUSTER 0 *
>                        MPIDR[23:16]   MPIDR[15:8]    MPIDR[7:0]
> HWCPU0: MPIDR=0x0          0x0            0x0           0x0
> HWCPU1: MPIDR=0x1          0x0            0x0           0x1 
> 
> * CLUSTER 1 *
> 
> HWCPU2: MPIDR=0x100        0x0            0x1           0x0               
> HWCPU3: MPIDR=0x101        0x0            0x1           0x1  
> 
> MPIDR is not a sequential index anymore, that's what I am going on about. 

And that's no problem to the boot code.  Assuming cluster 0 CPU 0 is the
boot CPU, then:

cpu_logical_map() would need to be initialized as {0x000, 0x001, 0x100,
0x101}.

> And yes, code like cpu_resume, that relies on MPIDR[7:0] to be unique
> needs patching, since that just takes into account the first affinity
> level, which can have same values for different CPUs in the system if
> they belong to different clusters.

That's going to be very painful to deal with, because of the restricted
environment we have there.  I guess we need to build some kind of
reverse table in memory somewhere which contains MPIDR mask+MPIDR value+
CPU array index.  Not nice at all.

> > > This hypothesis is not valid when the concept of cluster is introduced since
> > > the MPIDR cannot be represented as a single index and interrupt controller
> > > CPU interfaces might be wired with a numbering scheme following per-SoC
> > > design parameters which cannot be extrapolated easily through generic functions
> > > by the primary CPU.
> > 
> > So what you're saying is that the GIC CPU index may not be the CPU number
> > given by MPIDR?
> 
> Yes, that's correct. Taking the same example as above:
> 
> MPIDR[15:8] - cluster id
> MPIDR[7:0] - core id
> 
> no hyperthreading
> 
> * CLUSTER 0 *
>                          MPIDR[15:8]    MPIDR[7:0]  GIC-CPU-ID
> 		       
> HWCPU0: MPIDR=0x0            0x0           0x0          0x0
> HWCPU1: MPIDR=0x1            0x0           0x1          0x1 
> 
> * CLUSTER 1 *
> 
> HWCPU2: MPIDR=0x100          0x1           0x0          0x2     
> HWCPU3: MPIDR=0x101          0x1           0x1          0x3
> 
> There is just one GIC distributor shared across all clusters.

Right, so what we need is a kernel logical CPU id to GIC id mapping,
which you have in your patch.  You call it cpuif_logical_map() but
as it's specific to GIC, I wonder if it would be better called
gic_logical_map().

> > > Furthermore, relying on the MPIDR to be wired according to real topology
> > > levels might turn out to be an unreliable solution, hence a SW
> > > representation is needed to override possibly incorrect MPIDR register
> > > values.
> > 
> > This sounds like you're saying that the contents of MPIDR might be buggy
> > sometime in the future?  Do we actually know of any situations where the
> > information in there is currently wrong (outside of the development lab)?
> > If not, it's not something we should cater for until it's actually happened,
> > and then the pain should be felt by those silly enough to allow the chip
> > to go out the door.
> 
> I share your view Russell. Having said that: MPIDR is IMPLEMENTATION DEFINED.

I'll assume you mean that it's left to the implementation to set MPIDR
appropriately, and you're expecting implementations to make mistakes
with it.

Tell me: would you tolerate people making mistakes when they implement
an ARM CPU which results in the ISA almost being followed except some
op-codes having bits switched?

If not, then why would you tolerate wrong MPIDR values?  That's precisely
the same kind of bug.  And if we go adding work-arounds now, before
there's a problem, there will be no incentive for people to fix the
hardware bugs during their initial implementation testing.
