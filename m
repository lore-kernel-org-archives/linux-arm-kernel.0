From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Mon, 6 Oct 2014 23:22:04 +0530
Subject: [RFC PATCH 4/4] arm64:numa: adding numa support for arm64
 platforms.
In-Reply-To: <20141006112640.GF24686@leverpostej>
References: <1411635840-24038-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <1411635840-24038-5-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <20141003121343.GG26643@leverpostej>
 <CAFpQJXVJtn=PTYTd5icHhfYxsQnEzUP+w9kXXDJSs-M=eGNWVw@mail.gmail.com>
 <20141006112640.GF24686@leverpostej>
Message-ID: <CAFpQJXU4AW_WycWUWWaONvCiFgJU5KC_coCH8EU9kO=a0Rf9hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 6, 2014 at 4:56 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Oct 06, 2014 at 06:14:36AM +0100, Ganapatrao Kulkarni wrote:
>> Hi Mark,
>>
>> On Fri, Oct 3, 2014 at 5:43 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Thu, Sep 25, 2014 at 10:03:59AM +0100, Ganapatrao Kulkarni wrote:
>> >> Adding numa support for arm64 based platforms.
>> >> This version creates numa mapping by parsing the dt table.
>> >> cpu to node id mapping is derived from cluster_id as defined in cpu-map.
>> >> memory to node id mapping is derived from nid property of memory node.
>> >
>> > [...]
>> >
>> >> +/*
>> >> + * Too small node sizes may confuse the VM badly. Usually they
>> >> + * result from BIOS bugs. So dont recognize nodes as standalone
>> >> + * NUMA entities that have less than this amount of RAM listed:
>> >> + */
>> >> +#define NODE_MIN_SIZE (4*1024*1024)
>> >
>> > Why do these confuse the VM? what does BIOS have to do with arm64?
>> sneaked in from x86, will remove this.
>> >
>> >> +
>> >> +#define parent_node(node)      (node)
>> >
>> > Huh?
>> for thunder, no hierarchy at numa nodes. shall i put under ifdef or
>> separate header file?
>
> I was confused by a node being its own parent, but that seems to be the
> case elsewhere for parent_node() implementations. Please at least have a
> comment that we're assuming a flat hierarchy (for now).
sure, will add the required comments.
>
>> >
>> > [...]
>> >
>> >> @@ -168,6 +191,11 @@ void __init bootmem_init(void)
>> >>         min = PFN_UP(memblock_start_of_DRAM());
>> >>         max = PFN_DOWN(memblock_end_of_DRAM());
>> >>
>> >> +       high_memory = __va((max << PAGE_SHIFT) - 1) + 1;
>> >> +       max_pfn = max_low_pfn = max;
>> >> +
>> >> +       if (IS_ENABLED(CONFIG_NUMA))
>> >> +               arm64_numa_init();
>> >
>> > Is this function defined if !CONFIG_NUMA? Surely it must do nothing in
>> > that case anyway?
>> yes, if is not required, will remove it.
>> >
>> > [...]
>> >
>> >> +/*
>> >> + *  Set the cpu to node and mem mapping
>> >> + */
>> >> +void numa_store_cpu_info(cpu)
>> >> +{
>> >> +       cpu_to_node_map[cpu] = cpu_topology[cpu].cluster_id;
>> >> +       cpumask_set_cpu(cpu, node_to_cpumask_map[cpu_to_node_map[cpu]]);
>> >> +       set_numa_node(cpu_to_node_map[cpu]);
>> >> +       set_numa_mem(local_memory_node(cpu_to_node_map[cpu]));
>> >> +}
>> >
>> > I don't like this. I think we need to be more explicit in the DT w.r.t.
>> > the relationship between memory and the CPU hierarchy.
>> >
>> > I can imagine that we might end up with systems with multiple levels of
>> > NUMA hierarchy (using MPIDR_EL1.Aff{3,2}), and I'd rather that we were
>> > explcit as possible from the start w.r.t. the relationship between
>> > memory and groups of CPUs such that we don't end up with multiple ways
>> > of specifying said relationship, and horrible edge cases around implicit
>> > definitions (e.g. the nid to cluster mapping).
>> are you recomending to have explicit nid attribute to each cpu device node?
>
> I am recommending that we make the relationship explicit. If anything,
> using the cpu-map (with phandles) seems like a better approach.
yes, will add the mapping.
>
>> >> +/**
>> >> + * dummy_numa_init - Fallback dummy NUMA init
>> >> + *
>> >> + * Used if there's no underlying NUMA architecture, NUMA initialization
>> >> + * fails, or NUMA is disabled on the command line.
>> >> + *
>> >> + * Must online at least one node and add memory blocks that cover all
>> >> + * allowed memory.  This function must not fail.
>> >> + */
>> >> +static int __init dummy_numa_init(void)
>> >> +{
>> >> +       pr_info("%s\n",
>> >> +              numa_off ? "NUMA turned off" : "No NUMA configuration found");
>> >
>> > Why not print "NUMA turned off" in numa_setup?
>> enters this function only when, numa is turned off or the DT/ACPI
>> based numa init fails.
>
> Sure. Moving the "NUMA turned off" print into numa_setup would mean you
> could just print "Using dummy NUMA layout" or something to that effect
> here -- the function has no need to care about the value of numa_off.
agreed.
>
>> >
>> >> +       pr_info("Faking a node at [mem %#018Lx-%#018Lx]\n",
>> >> +              0LLU, PFN_PHYS(max_pfn) - 1);
>> >> +
>> >> +       node_set(0, numa_nodes_parsed);
>> >> +       numa_add_memblk(0, 0, PFN_PHYS(max_pfn));
>> >> +
>> >> +       return 0;
>> >> +}
>> >> +
>> >> +/**
>> >> + * early_init_dt_scan_numa_map - parse memory node and map nid to memory range.
>> >> + */
>> >> +int __init early_init_dt_scan_numa_map(unsigned long node, const char *uname,
>> >> +                                    int depth, void *data)
>> >> +{
>> >> +       const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
>> >> +       const __be32 *reg, *endp, *nid_prop;
>> >> +       int l, nid;
>> >> +
>> >> +       /* We are scanning "memory" nodes only */
>> >> +       if (type == NULL) {
>> >> +               /*
>> >> +                * The longtrail doesn't have a device_type on the
>> >> +                * /memory node, so look for the node called /memory at 0.
>> >> +                */
>> >> +               if (depth != 1 || strcmp(uname, "memory at 0") != 0)
>> >> +                       return 0;
>> >
>> > This has no place on arm64.
>> i am not sure that we can move to driver/of, at this moment this is
>> arm64 specific binding.
>
> I meant the longtrail workaround, hence my comments on that below.
oh! thanks, will remove this.
>
>> > We limited to longtrail workaround in the core memory parsing to PPC32
>> > only in commit b44aa25d20e2ef6b (of: Handle memory at 0 node on PPC32
>> > only). This code doesn't need it enabled ever.
>> >
>> > Are you booting using UEFI? This isn't going to work when the memory map
>> tried with bootwrapper, working on to boot from UEFI.
>> > comes from UEFI and we have no memory nodes in the DTB.
>> yes, there is issue with UEFI boot, since memory node is removed.
>> i request UEFI stub dev-team to suggest the possible ways to address this.
>
> I've Cc'd a few people who have worked on the stub and/or EFI memory map
> stuff. It would be worth keeping them on Cc so as to keep them informed.
thanks.
>
> I believe that the EFI stub is doing the right thing by ensuring that
> the EFI memory map is used, so this is just another configuration that
> your binding has to consider.
going through EFI stub, next is to boot numa kernel using UEFI, will
include UEFI boot support in v2 patch.
>
> Mark.
