From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Dec 2015 17:11:32 +0000
Subject: [PATCH v7 1/4] arm64, numa: adding numa support for arm64
 platforms.
In-Reply-To: <1447780843-9223-2-git-send-email-gkulkarni@caviumnetworks.com>
References: <1447780843-9223-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1447780843-9223-2-git-send-email-gkulkarni@caviumnetworks.com>
Message-ID: <20151217171131.GC24108@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This all looks pretty reasonable, but I'd like to see an Ack from a
devicetree maintainer on the binding before I merge anything (and I see
that there are outstanding comments from Rutland on that).

On Tue, Nov 17, 2015 at 10:50:40PM +0530, Ganapatrao Kulkarni wrote:
> Adding numa support for arm64 based platforms.
> This patch adds by default the dummy numa node and
> maps all memory and cpus to node 0.
> using this patch, numa can be simulated on single node arm64 platforms.
> 
> Reviewed-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> ---
>  arch/arm64/Kconfig              |  25 +++
>  arch/arm64/include/asm/mmzone.h |  17 ++
>  arch/arm64/include/asm/numa.h   |  47 +++++
>  arch/arm64/kernel/setup.c       |   4 +
>  arch/arm64/kernel/smp.c         |   2 +
>  arch/arm64/mm/Makefile          |   1 +
>  arch/arm64/mm/init.c            |  30 +++-
>  arch/arm64/mm/numa.c            | 384 ++++++++++++++++++++++++++++++++++++++++
>  8 files changed, 506 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm64/include/asm/mmzone.h
>  create mode 100644 arch/arm64/include/asm/numa.h
>  create mode 100644 arch/arm64/mm/numa.c
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 9ac16a4..7d8fb42 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -71,6 +71,7 @@ config ARM64
>  	select HAVE_GENERIC_DMA_COHERENT
>  	select HAVE_HW_BREAKPOINT if PERF_EVENTS
>  	select HAVE_MEMBLOCK
> +	select HAVE_MEMBLOCK_NODE_MAP if NUMA
>  	select HAVE_PATA_PLATFORM
>  	select HAVE_PERF_EVENTS
>  	select HAVE_PERF_REGS
> @@ -482,6 +483,30 @@ config HOTPLUG_CPU
>  	  Say Y here to experiment with turning CPUs off and on.  CPUs
>  	  can be controlled through /sys/devices/system/cpu.
>  
> +# Common NUMA Features
> +config NUMA
> +	bool "Numa Memory Allocation and Scheduler Support"
> +	depends on SMP
> +	help
> +	  Enable NUMA (Non Uniform Memory Access) support.
> +
> +	  The kernel will try to allocate memory used by a CPU on the
> +	  local memory controller of the CPU and add some more
> +	  NUMA awareness to the kernel.

I appreciate that this is copied from x86, but what exactly do you mean
by "memory controller" here?

> diff --git a/arch/arm64/include/asm/mmzone.h b/arch/arm64/include/asm/mmzone.h
> new file mode 100644
> index 0000000..6ddd468
> --- /dev/null
> +++ b/arch/arm64/include/asm/mmzone.h
> @@ -0,0 +1,17 @@
> +#ifndef __ASM_ARM64_MMZONE_H_
> +#define __ASM_ARM64_MMZONE_H_

Please try to follow the standard naming for header guards under arm64
(yes, it's not perfect, but we've made some effort for consistency).

> +
> +#ifdef CONFIG_NUMA
> +
> +#include <linux/mmdebug.h>
> +#include <linux/types.h>
> +
> +#include <asm/smp.h>
> +#include <asm/numa.h>
> +
> +extern struct pglist_data *node_data[];
> +
> +#define NODE_DATA(nid)		(node_data[(nid)])

This is the same as m32r, metag, parisc, powerpc, s390, sh, sparc, tile
and x86. Can we make this the default in the core code instead and then
replace this header file with asm-generic or something?

> +
> +#endif /* CONFIG_NUMA */
> +#endif /* __ASM_ARM64_MMZONE_H_ */
> diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
> new file mode 100644
> index 0000000..c00f3a4
> --- /dev/null
> +++ b/arch/arm64/include/asm/numa.h
> @@ -0,0 +1,47 @@
> +#ifndef _ASM_NUMA_H
> +#define _ASM_NUMA_H

Same comment on the guards.

> +#include <linux/nodemask.h>
> +#include <asm/topology.h>
> +
> +#ifdef CONFIG_NUMA
> +
> +#define NR_NODE_MEMBLKS		(MAX_NUMNODES * 2)

This is only used by the ACPI code afaict, so maybe include it when you
add that?

> +#define ZONE_ALIGN (1UL << (MAX_ORDER + PAGE_SHIFT))

Where is this used?

> +
> +/* currently, arm64 implements flat NUMA topology */
> +#define parent_node(node)	(node)
> +
> +extern int __node_distance(int from, int to);
> +#define node_distance(a, b) __node_distance(a, b)
> +
> +/* dummy definitions for pci functions */
> +#define pcibus_to_node(node)	0
> +#define cpumask_of_pcibus(bus)	0

There's a bunch of these dummy definitions already available in
asm-generic/topology.h. Can we use those instead of rolling our own
please?

> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 17bf39a..8dc9c5d 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -37,6 +37,7 @@
>  
>  #include <asm/fixmap.h>
>  #include <asm/memory.h>
> +#include <asm/numa.h>
>  #include <asm/sections.h>
>  #include <asm/setup.h>
>  #include <asm/sizes.h>
> @@ -77,6 +78,19 @@ static phys_addr_t max_zone_dma_phys(void)
>  	return min(offset + (1ULL << 32), memblock_end_of_DRAM());
>  }
>  
> +#ifdef CONFIG_NUMA
> +static void __init zone_sizes_init(unsigned long min, unsigned long max)
> +{
> +	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
> +
> +	if (IS_ENABLED(CONFIG_ZONE_DMA))
> +		max_zone_pfns[ZONE_DMA] = PFN_DOWN(max_zone_dma_phys());
> +	max_zone_pfns[ZONE_NORMAL] = max;
> +
> +	free_area_init_nodes(max_zone_pfns);
> +}

This is certainly more readable then the non-numa zone_sizes_init. Is
there a reason we can't always select HAVE_MEMBLOCK_NODE_MAP and avoid
having to handle the zone holds explicitly?

Also, I couldn't find any calls to memblock_add_node, which seem to be
expected. What am I missing?

> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> new file mode 100644
> index 0000000..e3afbf8
> --- /dev/null
> +++ b/arch/arm64/mm/numa.c
> @@ -0,0 +1,384 @@
> +/*
> + * NUMA support, based on the x86 implementation.
> + *
> + * Copyright (C) 2015 Cavium Inc.
> + * Author: Ganapatrao Kulkarni <gkulkarni@cavium.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/bootmem.h>
> +#include <linux/ctype.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/memblock.h>
> +#include <linux/module.h>
> +#include <linux/mmzone.h>
> +#include <linux/nodemask.h>
> +#include <linux/sched.h>
> +#include <linux/string.h>
> +#include <linux/topology.h>
> +
> +#include <asm/smp_plat.h>
> +
> +struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
> +EXPORT_SYMBOL(node_data);
> +nodemask_t numa_nodes_parsed __initdata;
> +int cpu_to_node_map[NR_CPUS] = { [0 ... NR_CPUS-1] = NUMA_NO_NODE };
> +
> +static int numa_off;
> +static int numa_distance_cnt;
> +static u8 *numa_distance;
> +
> +static __init int numa_parse_early_param(char *opt)
> +{
> +	if (!opt)
> +		return -EINVAL;
> +	if (!strncmp(opt, "off", 3)) {
> +		pr_info("%s\n", "NUMA turned off");
> +		numa_off = 1;

There's a patch kicking around to add this to strtobool:

  https://lkml.org/lkml/2015/12/9/802

but I can't see it in next :(

> +	}
> +	return 0;
> +}
> +early_param("numa", numa_parse_early_param);
> +
> +cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
> +EXPORT_SYMBOL(node_to_cpumask_map);
> +
> +#ifdef CONFIG_DEBUG_PER_CPU_MAPS
> +/*
> + * Returns a pointer to the bitmask of CPUs on Node 'node'.
> + */
> +const struct cpumask *cpumask_of_node(int node)
> +{
> +
> +	if (WARN_ON(node >= nr_node_ids))
> +		return cpu_none_mask;
> +
> +	if (WARN_ON(node_to_cpumask_map[node] == NULL))
> +		return cpu_online_mask;
> +
> +	return node_to_cpumask_map[node];
> +}
> +EXPORT_SYMBOL(cpumask_of_node);
> +#endif
> +
> +static void map_cpu_to_node(unsigned int cpu, int nid)
> +{
> +	set_cpu_numa_node(cpu, nid);
> +	if (nid >= 0)
> +		cpumask_set_cpu(cpu, node_to_cpumask_map[nid]);
> +}
> +
> +static void unmap_cpu_to_node(unsigned int cpu)
> +{
> +	int nid = cpu_to_node(cpu);
> +
> +	if (nid >= 0)
> +		cpumask_clear_cpu(cpu, node_to_cpumask_map[nid]);
> +	set_cpu_numa_node(cpu, NUMA_NO_NODE);
> +}
> +
> +void numa_clear_node(unsigned int cpu)
> +{
> +	unmap_cpu_to_node(cpu);
> +}
> +
> +/*
> + * Allocate node_to_cpumask_map based on number of available nodes
> + * Requires node_possible_map to be valid.
> + *
> + * Note: cpumask_of_node() is not valid until after this is done.
> + * (Use CONFIG_DEBUG_PER_CPU_MAPS to check this.)
> + */
> +static void __init setup_node_to_cpumask_map(void)
> +{
> +	unsigned int cpu;
> +	int node;
> +
> +	/* setup nr_node_ids if not done yet */
> +	if (nr_node_ids == MAX_NUMNODES)
> +		setup_nr_node_ids();
> +
> +	/* allocate and clear the mapping */
> +	for (node = 0; node < nr_node_ids; node++) {
> +		alloc_bootmem_cpumask_var(&node_to_cpumask_map[node]);
> +		cpumask_clear(node_to_cpumask_map[node]);
> +	}
> +
> +	for_each_possible_cpu(cpu)
> +		set_cpu_numa_node(cpu, NUMA_NO_NODE);
> +
> +	/* cpumask_of_node() will now work */
> +	pr_debug("Node to cpumask map for %d nodes\n", nr_node_ids);
> +}
> +
> +/*
> + *  Set the cpu to node and mem mapping
> + */
> +void numa_store_cpu_info(unsigned int cpu)
> +{
> +	map_cpu_to_node(cpu, numa_off ? 0 : cpu_to_node_map[cpu]);
> +}
> +
> +/**
> + * numa_add_memblk - Set node id to memblk
> + * @nid: NUMA node ID of the new memblk
> + * @start: Start address of the new memblk
> + * @size:  Size of the new memblk
> + *
> + * RETURNS:
> + * 0 on success, -errno on failure.
> + */
> +int __init numa_add_memblk(int nid, u64 start, u64 size)
> +{
> +	int ret;
> +
> +	ret = memblock_set_node(start, size, &memblock.memory, nid);
> +	if (ret < 0) {
> +		pr_err("NUMA: memblock [0x%llx - 0x%llx] failed to add on node %d\n",
> +			start, (start + size - 1), nid);
> +		return ret;
> +	}
> +
> +	node_set(nid, numa_nodes_parsed);
> +	pr_info("NUMA: Adding memblock [0x%llx - 0x%llx] on node %d\n",
> +			start, (start + size - 1), nid);
> +	return ret;
> +}
> +EXPORT_SYMBOL(numa_add_memblk);
> +
> +/* Initialize NODE_DATA for a node on the local memory */
> +static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
> +{
> +	const size_t nd_size = roundup(sizeof(pg_data_t), SMP_CACHE_BYTES);
> +	u64 nd_pa;
> +	void *nd;
> +	int tnid;
> +
> +	pr_info("Initmem setup node %d [mem %#010Lx-%#010Lx]\n",
> +			nid, start_pfn << PAGE_SHIFT,
> +			(end_pfn << PAGE_SHIFT) - 1);
> +
> +	nd_pa = memblock_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
> +	nd = __va(nd_pa);
> +
> +	/* report and initialize */
> +	pr_info("  NODE_DATA [mem %#010Lx-%#010Lx]\n",
> +		nd_pa, nd_pa + nd_size - 1);
> +	tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
> +	if (tnid != nid)
> +		pr_info("    NODE_DATA(%d) on node %d\n", nid, tnid);
> +
> +	node_data[nid] = nd;
> +	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
> +	NODE_DATA(nid)->node_id = nid;
> +	NODE_DATA(nid)->node_start_pfn = start_pfn;
> +	NODE_DATA(nid)->node_spanned_pages = end_pfn - start_pfn;
> +}
> +
> +/**
> + * numa_reset_distance - Reset NUMA distance table
> + *
> + * The current table is freed.
> + * The next numa_set_distance() call will create a new one.
> + */
> +void __init numa_reset_distance(void)
> +{
> +	size_t size;
> +
> +	if (!numa_distance)
> +		return;
> +
> +	size = numa_distance_cnt * numa_distance_cnt *
> +		sizeof(numa_distance[0]);
> +
> +	memblock_free(__pa(numa_distance), size);
> +	numa_distance_cnt = 0;
> +	numa_distance = NULL;
> +}
> +
> +static int __init numa_alloc_distance(void)
> +{
> +	size_t size;
> +	u64 phys;
> +	int i, j;
> +
> +	size = nr_node_ids * nr_node_ids * sizeof(numa_distance[0]);
> +	phys = memblock_find_in_range(0, PFN_PHYS(max_pfn),
> +				      size, PAGE_SIZE);
> +	if (WARN_ON(!phys))
> +		return -ENOMEM;
> +
> +	memblock_reserve(phys, size);
> +
> +	numa_distance = __va(phys);
> +	numa_distance_cnt = nr_node_ids;
> +
> +	/* fill with the default distances */
> +	for (i = 0; i < numa_distance_cnt; i++)
> +		for (j = 0; j < numa_distance_cnt; j++)
> +			numa_distance[i * numa_distance_cnt + j] = i == j ?
> +				LOCAL_DISTANCE : REMOTE_DISTANCE;
> +
> +	pr_debug("NUMA: Initialized distance table, cnt=%d\n",
> +			numa_distance_cnt);
> +
> +	return 0;
> +}
> +
> +/**
> + * numa_set_distance - Set NUMA distance from one NUMA to another
> + * @from: the 'from' node to set distance
> + * @to: the 'to'  node to set distance
> + * @distance: NUMA distance
> + *
> + * Set the distance from node @from to @to to @distance.  If distance table
> + * doesn't exist, one which is large enough to accommodate all the currently
> + * known nodes will be created.
> + *
> + * If such table cannot be allocated, a warning is printed and further
> + * calls are ignored until the distance table is reset with
> + * numa_reset_distance().
> + *
> + * If @from or @to is higher than the highest known node or lower than zero
> + * at the time of table creation or @distance doesn't make sense, the call
> + * is ignored.
> + * This is to allow simplification of specific NUMA config implementations.
> + */
> +void __init numa_set_distance(int from, int to, int distance)
> +{
> +	if (!numa_distance)
> +		return;
> +
> +	if (from >= numa_distance_cnt || to >= numa_distance_cnt ||
> +			from < 0 || to < 0) {
> +		pr_warn_once("NUMA: Warning: node ids are out of bound, from=%d to=%d distance=%d\n",
> +			    from, to, distance);
> +		return;
> +	}
> +
> +	if ((u8)distance != distance ||
> +	    (from == to && distance != LOCAL_DISTANCE)) {
> +		pr_warn_once("NUMA: Warning: invalid distance parameter, from=%d to=%d distance=%d\n",
> +			     from, to, distance);
> +		return;
> +	}
> +
> +	numa_distance[from * numa_distance_cnt + to] = distance;
> +}
> +EXPORT_SYMBOL(numa_set_distance);
> +
> +int __node_distance(int from, int to)
> +{
> +	if (from >= numa_distance_cnt || to >= numa_distance_cnt)
> +		return from == to ? LOCAL_DISTANCE : REMOTE_DISTANCE;
> +	return numa_distance[from * numa_distance_cnt + to];
> +}
> +EXPORT_SYMBOL(__node_distance);

Much of this is simply a direct copy/paste from x86. Why can't it be
moved to common code? I don't see anything arch-specific here.

> +static int __init numa_register_nodes(void)
> +{
> +	int nid;
> +	struct memblock_region *mblk;
> +
> +	/* Check that valid nid is set to memblks */
> +	for_each_memblock(memory, mblk)
> +		if (mblk->nid == NUMA_NO_NODE || mblk->nid >= MAX_NUMNODES)
> +			return -EINVAL;
> +
> +	/* Finally register nodes. */
> +	for_each_node_mask(nid, numa_nodes_parsed) {
> +		unsigned long start_pfn, end_pfn;
> +
> +		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
> +		setup_node_data(nid, start_pfn, end_pfn);
> +		node_set_online(nid);
> +	}
> +
> +	/* Setup online nodes to actual nodes*/
> +	node_possible_map = numa_nodes_parsed;
> +
> +	/* Dump memblock with node info and return. */
> +	memblock_dump_all();

We already call this from arm64_memblock_init. If that's now too early
to be of any use, we should move it to after bootmem_init, but we should
probably avoid calling it twice.

> +	return 0;
> +}
> +
> +static int __init numa_init(int (*init_func)(void))
> +{
> +	int ret;
> +
> +	nodes_clear(numa_nodes_parsed);
> +	nodes_clear(node_possible_map);
> +	nodes_clear(node_online_map);
> +	numa_reset_distance();
> +
> +	ret = init_func();
> +	if (ret < 0)
> +		return ret;
> +
> +	if (nodes_empty(numa_nodes_parsed))
> +		return -EINVAL;
> +
> +	ret = numa_register_nodes();
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = numa_alloc_distance();
> +	if (ret < 0)
> +		return ret;
> +
> +	setup_node_to_cpumask_map();
> +
> +	/* init boot processor */
> +	cpu_to_node_map[0] = 0;
> +	map_cpu_to_node(0, 0);
> +
> +	return 0;
> +}
> +
> +/**
> + * dummy_numa_init - Fallback dummy NUMA init
> + *
> + * Used if there's no underlying NUMA architecture, NUMA initialization
> + * fails, or NUMA is disabled on the command line.
> + *
> + * Must online at least one node and add memory blocks that cover all
> + * allowed memory.  This function must not fail.

Why can't it fail? It looks like the return value is ignored by numa_init.

Will
