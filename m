From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Wed, 2 May 2018 12:49:16 +0100
Subject: [PATCH v8 13/13] arm64: topology: divorce MC scheduling domain
 from core_siblings
In-Reply-To: <62677b95-faf5-4908-abc9-428ef39ea912@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-14-jeremy.linton@arm.com>
 <62677b95-faf5-4908-abc9-428ef39ea912@arm.com>
Message-ID: <20180502114916.GW4589@e105550-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2018 at 03:33:33PM +0100, Sudeep Holla wrote:
> 
> 
> On 26/04/18 00:31, Jeremy Linton wrote:
> > Now that we have an accurate view of the physical topology
> > we need to represent it correctly to the scheduler. Generally MC
> > should equal the LLC in the system, but there are a number of
> > special cases that need to be dealt with.
> > 
> > In the case of NUMA in socket, we need to assure that the sched
> > domain we build for the MC layer isn't larger than the DIE above it.
> > Similarly for LLC's that might exist in cross socket interconnect or
> > directory hardware we need to assure that MC is shrunk to the socket
> > or NUMA node.
> > 
> > This patch builds a sibling mask for the LLC, and then picks the
> > smallest of LLC, socket siblings, or NUMA node siblings, which
> > gives us the behavior described above. This is ever so slightly
> > different than the similar alternative where we look for a cache
> > layer less than or equal to the socket/NUMA siblings.
> > 
> > The logic to pick the MC layer affects all arm64 machines, but
> > only changes the behavior for DT/MPIDR systems if the NUMA domain
> > is smaller than the core siblings (generally set to the cluster).
> > Potentially this fixes a possible bug in DT systems, but really
> > it only affects ACPI systems where the core siblings is correctly
> > set to the socket siblings. Thus all currently available ACPI
> > systems should have MC equal to LLC, including the NUMA in socket
> > machines where the LLC is partitioned between the NUMA nodes.
> > 
> > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > ---
> >  arch/arm64/include/asm/topology.h |  2 ++
> >  arch/arm64/kernel/topology.c      | 32 +++++++++++++++++++++++++++++++-
> >  2 files changed, 33 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> > index 6b10459e6905..df48212f767b 100644
> > --- a/arch/arm64/include/asm/topology.h
> > +++ b/arch/arm64/include/asm/topology.h
> > @@ -8,8 +8,10 @@ struct cpu_topology {
> >  	int thread_id;
> >  	int core_id;
> >  	int package_id;
> > +	int llc_id;
> >  	cpumask_t thread_sibling;
> >  	cpumask_t core_sibling;
> > +	cpumask_t llc_siblings;
> >  };
> >  
> >  extern struct cpu_topology cpu_topology[NR_CPUS];
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index bd1aae438a31..20b4341dc527 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -13,6 +13,7 @@
> >  
> >  #include <linux/acpi.h>
> >  #include <linux/arch_topology.h>
> > +#include <linux/cacheinfo.h>
> >  #include <linux/cpu.h>
> >  #include <linux/cpumask.h>
> >  #include <linux/init.h>
> > @@ -214,7 +215,19 @@ EXPORT_SYMBOL_GPL(cpu_topology);
> >  
> >  const struct cpumask *cpu_coregroup_mask(int cpu)
> >  {
> > -	return &cpu_topology[cpu].core_sibling;
> > +	const cpumask_t *core_mask = cpumask_of_node(cpu_to_node(cpu));
> > +
> > +	/* Find the smaller of NUMA, core or LLC siblings */
> > +	if (cpumask_subset(&cpu_topology[cpu].core_sibling, core_mask)) {
> > +		/* not numa in package, lets use the package siblings */
> > +		core_mask = &cpu_topology[cpu].core_sibling;
> > +	}
> > +	if (cpu_topology[cpu].llc_id != -1) {
> > +		if (cpumask_subset(&cpu_topology[cpu].llc_siblings, core_mask))
> > +			core_mask = &cpu_topology[cpu].llc_siblings;
> > +	}
> > +
> > +	return core_mask;
> >  }
> >  
> >  static void update_siblings_masks(unsigned int cpuid)
> > @@ -226,6 +239,9 @@ static void update_siblings_masks(unsigned int cpuid)
> >  	for_each_possible_cpu(cpu) {
> >  		cpu_topo = &cpu_topology[cpu];
> >  
> > +		if (cpuid_topo->llc_id == cpu_topo->llc_id)
> > +			cpumask_set_cpu(cpu, &cpuid_topo->llc_siblings);
> > +
> 
> Would this not result in cpuid_topo->llc_siblings = cpu_possible_mask
> on DT systems where llc_id is not set/defaults to -1 and still pass the
> condition. Does it make sense to add additional -1 check ?

I don't think mask will be used by the current code if llc_id == -1 as
the user does the check. Is it better to have the mask empty than
default to cpu_possible_mask? If we require all users to implement a
check it shouldn't matter.
