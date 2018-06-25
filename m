From: drjones@redhat.com (Andrew Jones)
Date: Mon, 25 Jun 2018 10:03:06 +0200
Subject: [PATCH RFC] arm64: acpi: reenumerate topology ids
In-Reply-To: <9c85002d-1f1f-02e1-9aa2-24a7256e5fb3@arm.com>
References: <20180622142228.19645-1-drjones@redhat.com>
 <9c85002d-1f1f-02e1-9aa2-24a7256e5fb3@arm.com>
Message-ID: <20180625080306.gtkyytest2pftgnh@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 11:20:24AM -0500, Jeremy Linton wrote:
> Hi,
> 
> On 06/22/2018 09:22 AM, Andrew Jones wrote:
> > When booting with devicetree, and the devicetree has the cpu-map
> > node, the topology IDs that are visible from sysfs are generated
> > with counters. ACPI, on the other hand, uses ACPI table pointer
> > offsets, which, while guaranteed to be unique, look a bit weird.
> > Instead, we can generate DT identical topology IDs for ACPI by
> > just using counters for the leaf nodes and by remapping the
> > non-leaf table pointer offsets to counters.
> 
> I think there was some discussion about renumbering the ID's at one point to
> make them more 'human readable', its a pretty reasonable idea..
> 
> 
> > 
> > Cc: Jeremy Linton <jeremy.linton@arm.com>
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >   arch/arm64/kernel/topology.c | 68 ++++++++++++++++++++++++++++--------
> >   1 file changed, 54 insertions(+), 14 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index f845a8617812..4c6aa9eec3d3 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -316,6 +316,10 @@ static void __init reset_cpu_topology(void)
> >   }
> >   #ifdef CONFIG_ACPI
> > +
> > +#define acpi_topology_mktag(id)	(-((id) + 1))
> > +#define acpi_topology_istag(id)	((id) < 0)
> > +
> >   /*
> >    * Propagate the topology information of the processor_topology_node tree to the
> >    * cpu_topology array.
> > @@ -323,27 +327,24 @@ static void __init reset_cpu_topology(void)
> >   static int __init parse_acpi_topology(void)
> >   {
> >   	bool is_threaded;
> > -	int cpu, topology_id;
> > +	int package_id = 0, core_id, thread_id;
> > +	int cpu, ret;
> >   	is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
> >   	for_each_possible_cpu(cpu) {
> >   		int i, cache_id;
> > -		topology_id = find_acpi_cpu_topology(cpu, 0);
> > -		if (topology_id < 0)
> > -			return topology_id;
> > +		ret = find_acpi_cpu_topology(cpu, 0);
> > +		if (ret < 0)
> > +			return ret;
> > -		if (is_threaded) {
> > -			cpu_topology[cpu].thread_id = topology_id;
> > -			topology_id = find_acpi_cpu_topology(cpu, 1);
> > -			cpu_topology[cpu].core_id   = topology_id;
> > -		} else {
> > -			cpu_topology[cpu].thread_id  = -1;
> > -			cpu_topology[cpu].core_id    = topology_id;
> > -		}
> > -		topology_id = find_acpi_cpu_topology_package(cpu);
> > -		cpu_topology[cpu].package_id = topology_id;
> > +		if (is_threaded)
> > +			ret = find_acpi_cpu_topology(cpu, 1);
> > +		cpu_topology[cpu].core_id = acpi_topology_mktag(ret);
> > +
> > +		ret = find_acpi_cpu_topology_package(cpu);
> > +		cpu_topology[cpu].package_id = acpi_topology_mktag(ret);
> >   		i = acpi_find_last_cache_level(cpu);
> > @@ -358,6 +359,45 @@ static int __init parse_acpi_topology(void)
> >   		}
> >   	}
> > +	for_each_possible_cpu(cpu) {
> > +		int tag, cpu2;
> > +
> > +		if (is_threaded) {
> > +			if (acpi_topology_istag(cpu_topology[cpu].core_id))
> > +				thread_id = 0;
> > +			cpu_topology[cpu].thread_id = thread_id;
> > +			++thread_id;
> > +		} else {
> > +			cpu_topology[cpu].thread_id = -1;
> > +		}
> 
> Doesn't this assume the threads are adjacent to each other? Also, if i'm
> understanding this correctly, the threads for the first core are 0..N, and
> again the threads for the second core are again 0..N? Don't we want to avoid
> resetting the thread id? Although thread ID IIRC isn't visible, because the
> core-id dictates the thread siblings.

To make the numbering consistent with DT's cpu-map the thread_id should
start at 0 for each core. Or, parse_core() should be changed if we'd
rather have topology-wide unique thread-ids. However, I think it makes
more sense to reset them per core, especially considering that if the
topology hasn't already been populated, the fallback in
store_cpu_topology() will simply use MPIDR Aff0, which means a maximum ID
of 255, and thus necessarily wrapping for machines with more than 255 PEs.

I think I understand the concern with the assumption of adjacent table
entries, which applies to core-ids too, when they're leaves. I'll send
a v1 removing that assumption.

Thanks,
drew

> 
> 
> > +
> > +		if (acpi_topology_istag(cpu_topology[cpu].core_id)) {
> > +			if (acpi_topology_istag(cpu_topology[cpu].package_id))
> > +				core_id = 0;
> > +			tag = cpu_topology[cpu].core_id;
> > +			cpu_topology[cpu].core_id = core_id;
> > +
> > +			if (is_threaded) {
> > +				for_each_possible_cpu(cpu2) {
> > +					if (cpu_topology[cpu2].core_id == tag)
> > +						cpu_topology[cpu2].core_id = core_id;
> > +				}
> > +			}
> > +			++core_id;
> > +		}
> > +
> > +		if (acpi_topology_istag(cpu_topology[cpu].package_id)) {
> > +			tag = cpu_topology[cpu].package_id;
> > +			cpu_topology[cpu].package_id = package_id;
> > +
> > +			for_each_possible_cpu(cpu2) {
> > +				if (cpu_topology[cpu2].package_id == tag)
> > +					cpu_topology[cpu2].package_id = package_id;
> > +			}
> > +			++package_id;
> > +		}
> > +	}
> > +
> >   	return 0;
> >   }
> > 
> 
