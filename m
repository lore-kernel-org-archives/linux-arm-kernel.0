From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 26 Feb 2014 17:50:04 +0000
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20140226154858.GC10246@arm.com>
References: <1393302345-18253-1-git-send-email-broonie@kernel.org>
 <1393302345-18253-2-git-send-email-broonie@kernel.org>
 <20140225165411.GA3883@red-moon>
 <20140226005052.GA31120@sirena.org.uk>
 <20140226123208.GB22839@e102568-lin.cambridge.arm.com>
 <20140226144610.GA2394@sirena.org.uk>
 <20140226154858.GC10246@arm.com>
Message-ID: <20140226175004.GC22839@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 03:48:58PM +0000, Catalin Marinas wrote:
> On Wed, Feb 26, 2014 at 02:46:10PM +0000, Mark Brown wrote:
> > On Wed, Feb 26, 2014 at 12:32:08PM +0000, Lorenzo Pieralisi wrote:
> > > On Wed, Feb 26, 2014 at 12:50:52AM +0000, Mark Brown wrote:
> > > > Having said that like I keep saying it seems most sensible to fall back
> > > > to MPIDR if we don't have any better idea; it's guaranteed to be
> > > > available, may well be correct and helps systems that did a good job
> > > > with their hardware.
> > 
> > > You have a point. Unless someone feels strongly against this, I would
> > > suggest falling back to MPIDR_EL1 if there is missing or wrong information in
> > > DT.
> > 
> > Catalin seemed very concerned about any use at all of MPIDR, that's why
> > the code was removed originally.  Catalin?
> 
> My concern is that the MPIDR is just considered a unique ID. The ARMv8
> relaxes the requirement so that it no longer needs to start at 0 and
> increase monotonically. I checked with the architecture guys here and
> they still expect the affinity hierarchy to be described by MPIDR but we
> can have holes in the range for certain levels (i.e. an affinity level
> may not start at 0 and may not even increase monotonically for
> subsequent CPUs).
> 
> So we can either add a tolerant MPIDR parsing or we simply assume that
> the topology is _flat_ when DT doesn't provide the information.

I think that as far as the topology structures are concerned we can fall
back to MPIDR_EL1 in case cpu-map is missing or incomplete, since even
if the affinity levels contain holes or are not sequential that should
be fine (but see below). After all we have cpu-map to correct things for
this same reason and that will take precedence over the MPIDR_EL1 anyway.

Macros below are required for the scheduler to work. The ids are arch
dependent (so generic code cannot rely on them being sequential or
follow any rule) and if we fall back to MPIDR_EL1 they will get initialized.

#define topology_physical_package_id(cpu)	(cpu_topology[cpu].socket_id)
#define topology_core_id(cpu)		(cpu_topology[cpu].core_id)
#define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
#define topology_thread_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)

#define mc_capable()	(cpu_topology[0].socket_id != -1)
#define smt_capable()	(cpu_topology[0].thread_id != -1)

What would be wrong, is leaving the core_sibling and thread_sibling
masks empty and this CAN happen even on current arm32 code if the
cluster id field (ie MPIDR[15:8] for the sake of this discussion) is
different for different CPUs, and that's a bug that fortunately was
never hit (it is a totally valid MPIDR layout, a bit weird though).

On an arm32 4 cpus system with MPIDR layout {0x100, 0x200, 0x300, 0x400}
(which is allowed) the kernel would panic (since the thread_sibling and
core_sibling masks would end up empty).

So I agree with Catalin, either we allow a fall-back to MPIDR_EL1, with relaxed
parsing rules (but let's not forget what I wrote above), or we keep the
current set but with following changes:

- if s topology node for a cpu (or some cpus) is missing or wrong, the whole
  topology structure should be reverted to default (as in
  include/linux/topology.h Documentation/cputopology.txt). This solves Mark's
  concern about having some cpus with missing topology information.
  NB: My patch does not do that, it resets topology only for the misconfigured
  cpu.

That's the best we can do. I think that an MPIDR_EL1 fall back mechanism
should be put in place, as a separate patch or squashed to patch 1.

I would prefer the latter, but if you want to get the infrastructure in
first I think that's acceptable.

Apologies for all requested changes.

Thanks,
Lorenzo
