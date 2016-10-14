From: drjones@redhat.com (Andrew Jones)
Date: Fri, 14 Oct 2016 10:05:24 +0200
Subject: aarch64 ACPI boot regressed by commit 7ba5f605f3a0 ("arm64/numa:
 remove the limitation that cpu0 must bind to node0")
In-Reply-To: <4a64cd93-5ead-aad6-1057-f42224d65b43@redhat.com>
References: <4a64cd93-5ead-aad6-1057-f42224d65b43@redhat.com>
Message-ID: <20161014080524.4hm2b4p373r7rhel@hawk.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2016 at 12:50:29AM +0200, Laszlo Ersek wrote:
> (4) Analysis (well, a lame attempt at that, because I have zero
> familiarity with this code). Let me quote the patch:
> 
> > commit 7ba5f605f3a0d9495aad539eeb8346d726dfc183
> > Author: Zhen Lei <thunder.leizhen@huawei.com>
> > Date:   Thu Sep 1 14:55:04 2016 +0800
> >
> >     arm64/numa: remove the limitation that cpu0 must bind to node0
> >
> >     1. Remove the old binding code.
> >     2. Read the nid of cpu0 from dts.
> >     3. Fallback the nid of cpu0 to 0 when numa=off is set in bootargs.
> >
> >     Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >     Signed-off-by: Will Deacon <will.deacon@arm.com>
> >
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index c3c08368a685..8b048e6ec34a 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -624,6 +624,7 @@ static void __init of_parse_and_init_cpus(void)
> >  			}
> >
> >  			bootcpu_valid = true;
> > +			early_map_cpu_to_node(0, of_node_to_nid(dn));
> >
> >  			/*
> >  			 * cpu_logical_map has already been
> > diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> > index 0a15f010b64a..778a985c8a70 100644
> > --- a/arch/arm64/mm/numa.c
> > +++ b/arch/arm64/mm/numa.c
> > @@ -116,16 +116,24 @@ static void __init setup_node_to_cpumask_map(void)
> >   */
> >  void numa_store_cpu_info(unsigned int cpu)
> >  {
> > -	map_cpu_to_node(cpu, numa_off ? 0 : cpu_to_node_map[cpu]);
> > +	map_cpu_to_node(cpu, cpu_to_node_map[cpu]);
> >  }
> >
> >  void __init early_map_cpu_to_node(unsigned int cpu, int nid)
> >  {
> >  	/* fallback to node 0 */
> > -	if (nid < 0 || nid >= MAX_NUMNODES)
> > +	if (nid < 0 || nid >= MAX_NUMNODES || numa_off)
> >  		nid = 0;

The ACPI equivalent code must be missing (at least) the above, because,
even with DT, mach-virt won't have cpu to node mappings unless numa
is configured on the command line. Can you try adding something like

    -m 512 -smp 4 \
    -numa node,mem=256M,cpus=0-1,nodeid=0 \
    -numa node,mem=256M,cpus=2-3,nodeid=1

to your QEMU command line? Then when you boot with ACPI you'll get a
SRAT. If that works, then we're just missing the "no SRAT, nid = 0"
code (that should have been added with this patch)

Thanks,
drew
