From: broonie@kernel.org (Mark Brown)
Date: Mon, 16 Dec 2013 12:29:48 +0000
Subject: [PATCH 4/6] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20131216105734.GA8931@e102568-lin.cambridge.arm.com>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <1386767606-6391-4-git-send-email-broonie@kernel.org>
 <20131216105734.GA8931@e102568-lin.cambridge.arm.com>
Message-ID: <20131216122948.GF3185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 10:57:34AM +0000, Lorenzo Pieralisi wrote:
> On Wed, Dec 11, 2013 at 01:13:24PM +0000, Mark Brown wrote:

Replying again since I didn't notice half the content here - please
delete unneeded context from your mails, it makes it much easier to 
find the content you've added.

> > +const struct cpumask *cpu_coregroup_mask(int cpu);
> > +int cluster_to_logical_mask(unsigned int socket_id, cpumask_t *cluster_mask);

> I think the function signature above needs changing when we move to DT
> topology bindings, put it differently the look up won't be based on a
> socket id anymore, I need some time to think about it.

Well, we need to consider the possibility of ACPI or whatever as well.

> > +       cpu_info->loops_per_jiffy = loops_per_jiffy;
> > +       cpu_info->cpuid = read_cpuid_id();

> > +       store_cpu_topology(cpuid);

> All bits of info are in the DT, topology can be built by primary CPU, no need
> to call store_cpu_topology() on each CPU, that was only needed because on
> arm32 the topology code relies on each CPU reading its own MPIDR.

This is also gone in the current versions of the series.

> > +       /*
> > +        * Create cpu topology mapping, assume the cores are largely
> > +        * independent since the DT bindings do not include the flags
> > +        * for MT.
> > +        */
> > +       cpuid_topo->core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> > +       cpuid_topo->socket_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);

> This is what we are trying to prevent.  The way levels are mapped to
> core and cluster id is just a recommendation. Better to follow DT bindings,
> they are stricter and provide us with all the required bits of information.

Again, this is gone from the current version.  Like I said to Catalin it
does feel like this is making more work for systems that have done the
right thing with their MPIDRs which doesn't seem ideal (and note that
all the DTs that you guys are publishing for your models lack any
topology information at present).

> > +       for_each_online_cpu(cpu)
> > +               if (socket_id == topology_physical_package_id(cpu)) {
> > +                       cpumask_copy(cluster_mask, topology_core_cpumask(cpu));
> > +                       return 0;
> > +               }
> > +
> > +       return -EINVAL;
> > +}

> As mentioned, I think this function will have to change. Masks can be
> built using phandles to topology nodes. I know this is how cluster masks
> are currently built in arm32 kernels, but this does not mean that's the
> correct approach, given the laxity of the MPIDR specification.

So, this can actually be removed completely since there aren't any
references to this function any more that said the socket_id assignment
is still there...

This isn't being done using MPDIR, it's being done based on using the
lowest level of cluster however we found it.  What we're doing is that
while parsing the topology information source we use it to pick a
physical package identifier and then later on we use that identifier as
a handle.  The socket ID isn't really taken from a field in the MPDIR,
it's the result of doing the mapping you mention.

I definitely don't think we should be using phandles directly unless we
want to have a separate implementation for ACPI (or whatever else might
come up) which would mean less encapsulation of the topology code.
Having the parsing code assign socket IDs doesn't seem like a
particularly bad way of doing things, we need IDs for the generic
topology API functions to use anyway.

> > +       for_each_possible_cpu(cpu) {
> > +               struct cputopo_arm *cpu_topo = &(cpu_topology[cpu]);
> > +
> > +               cpu_topo->thread_id = -1;
> > +               cpu_topo->core_id =  -1;
> > +               cpu_topo->socket_id = -1;
> > +               cpumask_clear(&cpu_topo->core_sibling);
> > +               cpumask_clear(&cpu_topo->thread_sibling);
> > +       }

> This is probably the place where the topology should be parsed and built
> in one go, from DT, I did that and then needed to rewrite the code since
> topology bindings changed before getting merged.

Right, and that's where it happens for the DT parsing code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131216/aaec2a2a/attachment-0001.sig>
