From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Tue, 6 Jan 2015 15:22:55 +0800
Subject: [RFC PATCH v3 4/4] arm64:numa: adding numa support for arm64
 platforms.
In-Reply-To: <1420011379-7116-5-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
References: <1420011379-7116-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <1420011379-7116-5-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
Message-ID: <54AB8D4F.4010901@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/12/31 15:36, Ganapatrao Kulkarni wrote:
> Adding numa support for arm64 based platforms.
> Adding dt node pasring for numa topology using property arm,associativity.
> 

Hi,

I applied this patch but started a guest with a dtb which doesn't include NUMA topology info.
That is I don't add property arm,associativity. The guest doesn't start and crashed.

Maybe we should consider the scenario that the dtb doesn't include any NUMA topology info.

Thanks,
Shannon

NUMA: arm,associativity-reference-points not found.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at arch/arm64/mm/numa.c:414 numa_init+0x6c/0x39c()
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 3.18.0-rc3+ #7
Call trace:
[<ffffffc000087f24>] dump_backtrace+0x0/0x124
[<ffffffc000088058>] show_stack+0x10/0x1c
[<ffffffc0004c2404>] dump_stack+0x74/0x94
[<ffffffc000097d98>] warn_slowpath_common+0x8c/0xb4
[<ffffffc000097e80>] warn_slowpath_null+0x14/0x20
[<ffffffc000664fa4>] numa_init+0x68/0x39c
[<ffffffc000665360>] arm64_numa_init+0x2c/0x3c
[<ffffffc000663f0c>] bootmem_init+0x4c/0xd0
[<ffffffc00066499c>] paging_init+0x12c/0x1b8
[<ffffffc0006617bc>] setup_arch+0x2b0/0x5b8
[<ffffffc00065f680>] start_kernel+0xa0/0x3a4
---[ end trace cb88537fdc8fa200 ]---
No NUMA configuration found
Faking a node at [mem 0x0000000000000000-0x000000005fffffff]
NUMA: Ignoring memory range 0x0 - 0x40000000
NUMA: Adding memblock 0 [0x40000000 - 0x60000000] on node 0
Initmem setup node 0 [mem 0x40000000-0x5fffffff]
  NODE_DATA [mem 0x5fffc000-0x5fffdfff]
Zone ranges:
  DMA      [mem 0x40000000-0x5fffffff]
  Normal   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x40000000-0x5fffffff]
Initmem setup node 0 [mem 0x40000000-0x5fffffff]

> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
> ---
>  arch/arm64/Kconfig              |  32 +++
>  arch/arm64/include/asm/mmzone.h |  32 +++
>  arch/arm64/include/asm/numa.h   |  45 ++++
>  arch/arm64/kernel/Makefile      |   1 +
>  arch/arm64/kernel/dt_numa.c     | 296 +++++++++++++++++++++++
>  arch/arm64/kernel/setup.c       |   8 +
>  arch/arm64/kernel/smp.c         |   2 +
>  arch/arm64/mm/Makefile          |   1 +
>  arch/arm64/mm/init.c            |  34 ++-
>  arch/arm64/mm/numa.c            | 520 ++++++++++++++++++++++++++++++++++++++++
>  10 files changed, 965 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm64/include/asm/mmzone.h
>  create mode 100644 arch/arm64/include/asm/numa.h
>  create mode 100644 arch/arm64/kernel/dt_numa.c
>  create mode 100644 arch/arm64/mm/numa.c
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 242419d..6d262b1 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -59,6 +59,7 @@ config ARM64
>  	select HAVE_PERF_USER_STACK_DUMP
>  	select HAVE_RCU_TABLE_FREE
>  	select HAVE_SYSCALL_TRACEPOINTS
> +	select HAVE_MEMBLOCK_NODE_MAP if NUMA
>  	select IRQ_DOMAIN
>  	select MODULES_USE_ELF_RELA
>  	select NO_BOOTMEM
> @@ -315,6 +316,37 @@ config HOTPLUG_CPU
>  	  Say Y here to experiment with turning CPUs off and on.  CPUs
>  	  can be controlled through /sys/devices/system/cpu.
>  
> +# Common NUMA Features
> +config NUMA
> +	bool "Numa Memory Allocation and Scheduler Support"
> +	depends on SMP
> +	---help---
> +	  Enable NUMA (Non Uniform Memory Access) support.
> +
> +	  The kernel will try to allocate memory used by a CPU on the
> +	  local memory controller of the CPU and add some more
> +	  NUMA awareness to the kernel.
> +
> +config ARM64_DT_NUMA
> +	def_bool n
> +	prompt "DT NUMA detection"
> +	---help---
> +	  Enable DT based numa.
> +
> +config NODES_SHIFT
> +	int "Maximum NUMA Nodes (as a power of 2)"
> +	range 1 10
> +	default "2"
> +	depends on NEED_MULTIPLE_NODES
> +	---help---
> +	  Specify the maximum number of NUMA Nodes available on the target
> +	  system.  Increases memory reserved to accommodate various tables.
> +
> +config USE_PERCPU_NUMA_NODE_ID
> +	def_bool y
> +	depends on NUMA
> +
> +
>  source kernel/Kconfig.preempt
>  
>  config HZ
> diff --git a/arch/arm64/include/asm/mmzone.h b/arch/arm64/include/asm/mmzone.h
> new file mode 100644
> index 0000000..d27ee66
> --- /dev/null
> +++ b/arch/arm64/include/asm/mmzone.h
> @@ -0,0 +1,32 @@
> +#ifndef __ASM_ARM64_MMZONE_H_
> +#define __ASM_ARM64_MMZONE_H_
> +
> +#ifdef CONFIG_NUMA
> +
> +#include <linux/mmdebug.h>
> +#include <asm/smp.h>
> +#include <linux/types.h>
> +#include <asm/numa.h>
> +
> +extern struct pglist_data *node_data[];
> +
> +#define NODE_DATA(nid)		(node_data[nid])
> +
> +
> +struct numa_memblk {
> +	u64			start;
> +	u64			end;
> +	int			nid;
> +};
> +
> +struct numa_meminfo {
> +	int			nr_blks;
> +	struct numa_memblk	blk[NR_NODE_MEMBLKS];
> +};
> +
> +void __init numa_remove_memblk_from(int idx, struct numa_meminfo *mi);
> +int __init numa_cleanup_meminfo(struct numa_meminfo *mi);
> +void __init numa_reset_distance(void);
> +
> +#endif /* CONFIG_NUMA */
> +#endif /* __ASM_ARM64_MMZONE_H_ */
> diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
> new file mode 100644
> index 0000000..7c9bebc
> --- /dev/null
> +++ b/arch/arm64/include/asm/numa.h
> @@ -0,0 +1,45 @@
> +#ifndef _ASM_ARM64_NUMA_H
> +#define _ASM_ARM64_NUMA_H
> +
> +#include <linux/nodemask.h>
> +#include <asm/topology.h>
> +
> +#ifdef CONFIG_NUMA
> +
> +#define NR_NODE_MEMBLKS		(MAX_NUMNODES * 2)
> +#define ZONE_ALIGN (1UL << (MAX_ORDER + PAGE_SHIFT))
> +
> +/* currently, arm64 implements flat NUMA topology */
> +#define parent_node(node)	(node)
> +
> +/* dummy definitions for pci functions */
> +#define pcibus_to_node(node)	0
> +#define cpumask_of_pcibus(bus)	0
> +
> +struct __node_cpu_hwid {
> +	u32 node_id;    /* logical node containing this CPU */
> +	u64 cpu_hwid;   /* MPIDR for this CPU */
> +};
> +
> +const struct cpumask *cpumask_of_node(int node);
> +/* Mappings between node number and cpus on that node. */
> +extern cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
> +
> +void __init arm64_numa_init(void);
> +int __init numa_add_memblk(u32 nodeid, u64 start, u64 end);
> +void numa_store_cpu_info(int cpu);
> +void numa_set_node(int cpu, int node);
> +void numa_clear_node(int cpu);
> +void numa_add_cpu(int cpu);
> +void numa_remove_cpu(int cpu);
> +void __init numa_set_distance(int from, int to, int distance);
> +#ifdef CONFIG_ARM64_DT_NUMA
> +int dt_get_cpu_node_id(int cpu);
> +int __init arm64_dt_numa_init(void);
> +#endif
> +#else	/* CONFIG_NUMA */
> +static inline void arm64_numa_init(void);
> +static inline void numa_store_cpu_info(int cpu)		{ }
> +static inline void arm64_numa_init(void)		{ }
> +#endif	/* CONFIG_NUMA */
> +#endif	/* _ASM_ARM64_NUMA_H */
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 5bd029b..39451df 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -31,6 +31,7 @@ arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
>  arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
>  arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
>  arm64-obj-$(CONFIG_PCI)			+= pci.o
> +arm64-obj-$(CONFIG_ARM64_DT_NUMA)	+= dt_numa.o
>  
>  obj-y					+= $(arm64-obj-y) vdso/
>  obj-m					+= $(arm64-obj-m)
> diff --git a/arch/arm64/kernel/dt_numa.c b/arch/arm64/kernel/dt_numa.c
> new file mode 100644
> index 0000000..1b64b25
> --- /dev/null
> +++ b/arch/arm64/kernel/dt_numa.c
> @@ -0,0 +1,296 @@
> +/*
> + * DT NUMA Parsing support, based on the powerpc implementation.
> + *
> + * Copyright (C) 2014 Cavium Inc.
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
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/string.h>
> +#include <linux/init.h>
> +#include <linux/bootmem.h>
> +#include <linux/memblock.h>
> +#include <linux/ctype.h>
> +#include <linux/module.h>
> +#include <linux/nodemask.h>
> +#include <linux/sched.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <asm/smp_plat.h>
> +
> +#define MAX_DISTANCE_REF_POINTS 4
> +static int min_common_depth;
> +static int distance_ref_points_depth;
> +static const __be32 *distance_ref_points;
> +static int distance_lookup_table[MAX_NUMNODES][MAX_DISTANCE_REF_POINTS];
> +static int of_node_to_nid_single(struct device_node *device);
> +static int default_nid;
> +extern nodemask_t numa_nodes_parsed __initdata;
> +
> +static void initialize_distance_lookup_table(int nid,
> +		const __be32 *associativity)
> +{
> +	int i;
> +
> +	for (i = 0; i < distance_ref_points_depth; i++) {
> +		const __be32 *entry;
> +
> +		entry = &associativity[be32_to_cpu(distance_ref_points[i])];
> +		distance_lookup_table[nid][i] = of_read_number(entry, 1);
> +	}
> +}
> +
> +/* must hold reference to node during call */
> +static const __be32 *of_get_associativity(struct device_node *dev)
> +{
> +	return of_get_property(dev, "arm,associativity", NULL);
> +}
> +
> +/* Returns nid in the range [0..MAX_NUMNODES-1], or -1 if no useful numa
> + * info is found.
> + */
> +static int associativity_to_nid(const __be32 *associativity)
> +{
> +	int nid = -1;
> +
> +	if (min_common_depth == -1)
> +		goto out;
> +
> +	if (of_read_number(associativity, 1) >= min_common_depth)
> +		nid = of_read_number(&associativity[min_common_depth], 1);
> +
> +	/* set 0xffff as invalid node */
> +	if (nid == 0xffff || nid >= MAX_NUMNODES)
> +		nid = -1;
> +
> +	initialize_distance_lookup_table(nid, associativity);
> +
> +out:
> +	return nid;
> +}
> +
> +/* Returns the nid associated with the given device tree node,
> + * or -1 if not found.
> + */
> +static int of_node_to_nid_single(struct device_node *device)
> +{
> +	int nid = -1;
> +	const __be32 *tmp;
> +
> +	tmp = of_get_associativity(device);
> +	if (tmp)
> +		nid = associativity_to_nid(tmp);
> +	return nid;
> +}
> +
> +/* Walk the device tree upwards, looking for an associativity id */
> +int of_node_to_nid(struct device_node *device)
> +{
> +	struct device_node *tmp;
> +	int nid = -1;
> +
> +	of_node_get(device);
> +	while (device) {
> +		nid = of_node_to_nid_single(device);
> +		if (nid != -1)
> +			break;
> +
> +		tmp = device;
> +		device = of_get_parent(tmp);
> +		of_node_put(tmp);
> +	}
> +	of_node_put(device);
> +
> +	return nid;
> +}
> +EXPORT_SYMBOL_GPL(of_node_to_nid);
> +
> +static int __init find_min_common_depth(unsigned long node)
> +{
> +	int depth;
> +	const __be32 *numa_prop;
> +	int nr_address_cells;
> +
> +	/*
> +	 * This property is a set of 32-bit integers, each representing
> +	 * an index into the arm,associativity nodes.
> +	 *
> +	 * With form 1 affinity the first integer is the most significant
> +	 * NUMA boundary and the following are progressively less significant
> +	 * boundaries. There can be more than one level of NUMA.
> +	 */
> +
> +	distance_ref_points = of_get_flat_dt_prop(node,
> +			"arm,associativity-reference-points",
> +			&distance_ref_points_depth);
> +	numa_prop = distance_ref_points;
> +
> +	if (numa_prop) {
> +		nr_address_cells = dt_mem_next_cell(
> +				OF_ROOT_NODE_ADDR_CELLS_DEFAULT, &numa_prop);
> +		nr_address_cells = dt_mem_next_cell(
> +				OF_ROOT_NODE_ADDR_CELLS_DEFAULT, &numa_prop);
> +	}
> +	if (!distance_ref_points) {
> +		pr_err("NUMA: arm,associativity-reference-points not found.\n");
> +		goto err;
> +	}
> +
> +	distance_ref_points_depth /= sizeof(__be32);
> +
> +	if (distance_ref_points_depth < 2) {
> +		pr_err(KERN_WARNING "NUMA: short arm,associativity-reference-points\n");
> +		goto err;
> +	}
> +
> +	depth = of_read_number(distance_ref_points, 1);
> +
> +	/*
> +	 * Warn and cap if the hardware supports more than
> +	 * MAX_DISTANCE_REF_POINTS domains.
> +	 */
> +	if (distance_ref_points_depth > MAX_DISTANCE_REF_POINTS) {
> +		pr_debug(KERN_WARNING "NUMA: distance array capped at %d entries\n", MAX_DISTANCE_REF_POINTS);
> +		distance_ref_points_depth = MAX_DISTANCE_REF_POINTS;
> +	}
> +
> +	return depth;
> +
> +err:
> +	return -1;
> +}
> +
> +int dt_get_cpu_node_id(int cpu)
> +{
> +	struct device_node *dn = NULL;
> +
> +	while ((dn = of_find_node_by_type(dn, "cpu"))) {
> +		const u32 *cell;
> +		u64 hwid;
> +
> +		/*
> +		 * A cpu node with missing "reg" property is
> +		 * considered invalid to build a cpu_logical_map
> +		 * entry.
> +		 */
> +		cell = of_get_property(dn, "reg", NULL);
> +		if (!cell) {
> +			pr_err("%s: missing reg property\n", dn->full_name);
> +			return default_nid;
> +		}
> +		hwid = of_read_number(cell, of_n_addr_cells(dn));
> +
> +		if (cpu_logical_map(cpu) == hwid)
> +		return of_node_to_nid_single(dn);
> +	}
> +	return NUMA_NO_NODE;
> +}
> +EXPORT_SYMBOL(dt_get_cpu_node_id);
> +
> +static int __init parse_memory_node(unsigned long node)
> +{
> +	const __be32 *reg, *endp, *associativity;
> +	int length;
> +	int nid = -1;
> +
> +	associativity = of_get_flat_dt_prop(node, "arm,associativity", &length);
> +
> +	if (associativity)
> +		nid = associativity_to_nid(associativity);
> +
> +	reg = of_get_flat_dt_prop(node, "reg", &length);
> +	endp = reg + (length / sizeof(__be32));
> +
> +	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
> +		u64 base, size;
> +		struct memblock_region *mblk;
> +
> +		base = dt_mem_next_cell(dt_root_addr_cells, &reg);
> +		size = dt_mem_next_cell(dt_root_size_cells, &reg);
> +		pr_debug("NUMA-DT:  base = %llx , node = %u\n",
> +				base, nid);
> +		for_each_memblock(memory, mblk) {
> +			if (mblk->base == base) {
> +				numa_add_memblk(nid, mblk->base,mblk->size);
> +				node_set(nid, numa_nodes_parsed);
> +				break;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * early_init_dt_scan_numa_map - parse memory node and map nid to memory range.
> + */
> +int __init early_init_dt_scan_numa_map(unsigned long node, const char *uname,
> +				     int depth, void *data)
> +{
> +	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
> +
> +	/* We are scanning "numa-map" nodes only */
> +	if (depth == 0) {
> +		min_common_depth = find_min_common_depth(node);
> +		if (min_common_depth < 0)
> +			return min_common_depth;
> +		pr_debug("NUMA associativity depth for CPU/Memory: %d\n", min_common_depth);
> +		return 0;
> +	}
> +
> +	if (type) {
> +		if (strcmp(type, "memory") == 0)
> +			parse_memory_node(node);
> +	}
> +	return 0;
> +}
> +
> +int dt_get_node_distance(int a, int b)
> +{
> +	int i;
> +	int distance = LOCAL_DISTANCE;
> +
> +	for (i = 0; i < distance_ref_points_depth; i++) {
> +		if (distance_lookup_table[a][i] == distance_lookup_table[b][i])
> +			break;
> +
> +		/* Double the distance for each NUMA level */
> +		distance *= 2;
> +	}
> +	return distance;
> +}
> +
> +/* DT node mapping is done already early_init_dt_scan_memory */
> +int __init arm64_dt_numa_init(void)
> +{
> +	int i;
> +	u32 nodea, nodeb, distance, node_count = 0;
> +
> +	of_scan_flat_dt(early_init_dt_scan_numa_map, NULL);
> +
> +	for_each_node_mask(i, numa_nodes_parsed)
> +		node_count = i;
> +	node_count++;
> +
> +	for (nodea =  0; nodea < node_count; nodea++) {
> +		for (nodeb = 0; nodeb < node_count; nodeb++) {
> +			distance = dt_get_node_distance(nodea, nodeb);
> +			numa_set_distance(nodea, nodeb, distance);
> +		}
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL(arm64_dt_numa_init);
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 2437196..80b4a9e 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -425,6 +425,9 @@ static int __init topology_init(void)
>  {
>  	int i;
>  
> +	for_each_online_node(i)
> +		register_one_node(i);
> +
>  	for_each_possible_cpu(i) {
>  		struct cpu *cpu = &per_cpu(cpu_data.cpu, i);
>  		cpu->hotpluggable = 1;
> @@ -461,7 +464,12 @@ static int c_show(struct seq_file *m, void *v)
>  		 * "processor".  Give glibc what it expects.
>  		 */
>  #ifdef CONFIG_SMP
> +	if (IS_ENABLED(CONFIG_NUMA)) {
> +		seq_printf(m, "processor\t: %d", i);
> +		seq_printf(m, " [nid: %d]\n", cpu_to_node(i));
> +	} else {
>  		seq_printf(m, "processor\t: %d\n", i);
> +	}
>  #endif
>  	}
>  
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index b06d1d9..1d1e86f 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -50,6 +50,7 @@
>  #include <asm/sections.h>
>  #include <asm/tlbflush.h>
>  #include <asm/ptrace.h>
> +#include <asm/numa.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/ipi.h>
> @@ -123,6 +124,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  static void smp_store_cpu_info(unsigned int cpuid)
>  {
>  	store_cpu_topology(cpuid);
> +	numa_store_cpu_info(cpuid);
>  }
>  
>  /*
> diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
> index c56179e..c86e6de 100644
> --- a/arch/arm64/mm/Makefile
> +++ b/arch/arm64/mm/Makefile
> @@ -3,3 +3,4 @@ obj-y				:= dma-mapping.o extable.o fault.o init.o \
>  				   ioremap.o mmap.o pgd.o mmu.o \
>  				   context.o proc.o pageattr.o
>  obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
> +obj-$(CONFIG_NUMA)		+= numa.o
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 494297c..6fd6802 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -39,6 +39,7 @@
>  #include <asm/setup.h>
>  #include <asm/sizes.h>
>  #include <asm/tlb.h>
> +#include <asm/numa.h>
>  
>  #include "mm.h"
>  
> @@ -73,6 +74,20 @@ static phys_addr_t max_zone_dma_phys(void)
>  	return min(offset + (1ULL << 32), memblock_end_of_DRAM());
>  }
>  
> +#ifdef CONFIG_NUMA
> +static void __init zone_sizes_init(unsigned long min, unsigned long max)
> +{
> +	unsigned long max_zone_pfns[MAX_NR_ZONES];
> +
> +	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
> +	if (IS_ENABLED(CONFIG_ZONE_DMA))
> +		max_zone_pfns[ZONE_DMA] = PFN_DOWN(max_zone_dma_phys());
> +	max_zone_pfns[ZONE_NORMAL] = max;
> +
> +	free_area_init_nodes(max_zone_pfns);
> +}
> +
> +#else
>  static void __init zone_sizes_init(unsigned long min, unsigned long max)
>  {
>  	struct memblock_region *reg;
> @@ -111,6 +126,7 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>  
>  	free_area_init_node(0, zone_size, min, zhole_size);
>  }
> +#endif /* CONFIG_NUMA */
>  
>  #ifdef CONFIG_HAVE_ARCH_PFN_VALID
>  int pfn_valid(unsigned long pfn)
> @@ -128,10 +144,15 @@ static void arm64_memory_present(void)
>  static void arm64_memory_present(void)
>  {
>  	struct memblock_region *reg;
> +	int nid = 0;
>  
> -	for_each_memblock(memory, reg)
> -		memory_present(0, memblock_region_memory_base_pfn(reg),
> -			       memblock_region_memory_end_pfn(reg));
> +	for_each_memblock(memory, reg) {
> +#ifdef CONFIG_NUMA
> +		nid = reg->nid;
> +#endif
> +		memory_present(nid, memblock_region_memory_base_pfn(reg),
> +				memblock_region_memory_end_pfn(reg));
> +	}
>  }
>  #endif
>  
> @@ -167,6 +188,10 @@ void __init bootmem_init(void)
>  	min = PFN_UP(memblock_start_of_DRAM());
>  	max = PFN_DOWN(memblock_end_of_DRAM());
>  
> +	high_memory = __va((max << PAGE_SHIFT) - 1) + 1;
> +	max_pfn = max_low_pfn = max;
> +
> +	arm64_numa_init();
>  	/*
>  	 * Sparsemem tries to allocate bootmem in memory_present(), so must be
>  	 * done after the fixed reservations.
> @@ -175,9 +200,6 @@ void __init bootmem_init(void)
>  
>  	sparse_init();
>  	zone_sizes_init(min, max);
> -
> -	high_memory = __va((max << PAGE_SHIFT) - 1) + 1;
> -	max_pfn = max_low_pfn = max;
>  }
>  
>  #ifndef CONFIG_SPARSEMEM_VMEMMAP
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> new file mode 100644
> index 0000000..e146a2d
> --- /dev/null
> +++ b/arch/arm64/mm/numa.c
> @@ -0,0 +1,520 @@
> +/*
> + * NUMA support, based on the x86 implementation.
> + *
> + * Copyright (C) 2014 Cavium Inc.
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
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/string.h>
> +#include <linux/init.h>
> +#include <linux/bootmem.h>
> +#include <linux/memblock.h>
> +#include <linux/mmzone.h>
> +#include <linux/ctype.h>
> +#include <linux/module.h>
> +#include <linux/nodemask.h>
> +#include <linux/sched.h>
> +#include <linux/topology.h>
> +#include <linux/of.h>
> +#include <asm/smp_plat.h>
> +
> +int __initdata numa_off;
> +nodemask_t numa_nodes_parsed __initdata;
> +static int numa_distance_cnt;
> +static u8 *numa_distance;
> +
> +struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
> +EXPORT_SYMBOL(node_data);
> +
> +static struct __node_cpu_hwid node_cpu_hwid[NR_CPUS];
> +static struct numa_meminfo numa_meminfo;
> +
> +static __init int numa_setup(char *opt)
> +{
> +	if (!opt)
> +		return -EINVAL;
> +	if (!strncmp(opt, "off", 3)) {
> +		pr_info("%s\n", "NUMA turned off");
> +		numa_off = 1;
> +	}
> +	return 0;
> +}
> +early_param("numa", numa_setup);
> +
> +cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
> +EXPORT_SYMBOL(node_to_cpumask_map);
> +
> +/*
> + * Returns a pointer to the bitmask of CPUs on Node 'node'.
> + */
> +const struct cpumask *cpumask_of_node(int node)
> +{
> +	if (node >= nr_node_ids) {
> +		pr_warn("cpumask_of_node(%d): node > nr_node_ids(%d)\n",
> +			node, nr_node_ids);
> +		dump_stack();
> +		return cpu_none_mask;
> +	}
> +	if (node_to_cpumask_map[node] == NULL) {
> +		pr_warn("cpumask_of_node(%d): no node_to_cpumask_map!\n",
> +			node);
> +		dump_stack();
> +		return cpu_online_mask;
> +	}
> +	return node_to_cpumask_map[node];
> +}
> +EXPORT_SYMBOL(cpumask_of_node);
> +
> +int cpu_to_node_map[NR_CPUS];
> +EXPORT_SYMBOL(cpu_to_node_map);
> +
> +void numa_clear_node(int cpu)
> +{
> +	cpu_to_node_map[cpu] = NUMA_NO_NODE;
> +}
> +
> +/*
> + * Allocate node_to_cpumask_map based on number of available nodes
> + * Requires node_possible_map to be valid.
> + *
> + * Note: cpumask_of_node() is not valid until after this is done.
> + * (Use CONFIG_DEBUG_PER_CPU_MAPS to check this.)
> + */
> +void __init setup_node_to_cpumask_map(void)
> +{
> +	unsigned int node;
> +
> +	/* setup nr_node_ids if not done yet */
> +	if (nr_node_ids == MAX_NUMNODES)
> +		setup_nr_node_ids();
> +
> +	/* allocate the map */
> +	for (node = 0; node < nr_node_ids; node++)
> +		alloc_bootmem_cpumask_var(&node_to_cpumask_map[node]);
> +
> +	/* cpumask_of_node() will now work */
> +	pr_debug("Node to cpumask map for %d nodes\n", nr_node_ids);
> +}
> +
> +/*
> + *  Set the cpu to node and mem mapping
> + */
> +void numa_store_cpu_info(int cpu)
> +{
> +#ifdef CONFIG_ARM64_DT_NUMA
> +	node_cpu_hwid[cpu].node_id  =  dt_get_cpu_node_id(cpu);
> +#endif
> +	/* mapping of MPIDR/hwid, node and logical cpu id */
> +	cpu_to_node_map[cpu] = node_cpu_hwid[cpu].node_id;
> +	node_cpu_hwid[cpu].cpu_hwid = cpu_logical_map(cpu);
> +	cpumask_set_cpu(cpu, node_to_cpumask_map[cpu_to_node_map[cpu]]);
> +	set_numa_node(cpu_to_node_map[cpu]);
> +	set_numa_mem(local_memory_node(cpu_to_node_map[cpu]));
> +}
> +
> +/**
> + * numa_add_memblk_to - Add one numa_memblk to a numa_meminfo
> + */
> +
> +static int __init numa_add_memblk_to(int nid, u64 start, u64 end,
> +				     struct numa_meminfo *mi)
> +{
> +	/* ignore zero length blks */
> +	if (start == end)
> +		return 0;
> +
> +	/* whine about and ignore invalid blks */
> +	if (start > end || nid < 0 || nid >= MAX_NUMNODES) {
> +		pr_warn("NUMA: Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
> +				nid, start, end - 1);
> +		return 0;
> +	}
> +
> +	if (mi->nr_blks >= NR_NODE_MEMBLKS) {
> +		pr_err("NUMA: too many memblk ranges\n");
> +		return -EINVAL;
> +	}
> +
> +	pr_info("NUMA: Adding memblock %d [0x%llx - 0x%llx] on node %d\n",
> +			mi->nr_blks, start, end, nid);
> +	mi->blk[mi->nr_blks].start = start;
> +	mi->blk[mi->nr_blks].end = end;
> +	mi->blk[mi->nr_blks].nid = nid;
> +	mi->nr_blks++;
> +	return 0;
> +}
> +
> +/**
> + * numa_add_memblk - Add one numa_memblk to numa_meminfo
> + * @nid: NUMA node ID of the new memblk
> + * @start: Start address of the new memblk
> + * @end: End address of the new memblk
> + *
> + * Add a new memblk to the default numa_meminfo.
> + *
> + * RETURNS:
> + * 0 on success, -errno on failure.
> + */
> +#define MAX_PHYS_ADDR	((phys_addr_t)~0)
> +
> +int __init numa_add_memblk(u32 nid, u64 base, u64 size)
> +{
> +	const u64 phys_offset = __pa(PAGE_OFFSET);
> +
> +	base &= PAGE_MASK;
> +	size &= PAGE_MASK;
> +
> +	if (base > MAX_PHYS_ADDR) {
> +		pr_warn("NUMA: Ignoring memory block 0x%llx - 0x%llx\n",
> +				base, base + size);
> +		return -ENOMEM;
> +	}
> +
> +	if (base + size > MAX_PHYS_ADDR) {
> +		pr_info("NUMA: Ignoring memory range 0x%lx - 0x%llx\n",
> +				ULONG_MAX, base + size);
> +		size = MAX_PHYS_ADDR - base;
> +	}
> +
> +	if (base + size < phys_offset) {
> +		pr_warn("NUMA: Ignoring memory block 0x%llx - 0x%llx\n",
> +			   base, base + size);
> +		return -ENOMEM;
> +	}
> +	if (base < phys_offset) {
> +		pr_info("NUMA: Ignoring memory range 0x%llx - 0x%llx\n",
> +			   base, phys_offset);
> +		size -= phys_offset - base;
> +		base = phys_offset;
> +	}
> +
> +	return numa_add_memblk_to(nid, base, base+size, &numa_meminfo);
> +}
> +EXPORT_SYMBOL(numa_add_memblk);
> +
> +/* Initialize NODE_DATA for a node on the local memory */
> +static void __init setup_node_data(int nid, u64 start, u64 end)
> +{
> +	const size_t nd_size = roundup(sizeof(pg_data_t), PAGE_SIZE);
> +	u64 nd_pa;
> +	void *nd;
> +	int tnid;
> +
> +	start = roundup(start, ZONE_ALIGN);
> +
> +	pr_info("Initmem setup node %d [mem %#010Lx-%#010Lx]\n",
> +	       nid, start, end - 1);
> +
> +	/*
> +	 * Allocate node data.  Try node-local memory and then any node.
> +	 */
> +	nd_pa = memblock_alloc_nid(nd_size, SMP_CACHE_BYTES, nid);
> +	if (!nd_pa) {
> +		nd_pa = __memblock_alloc_base(nd_size, SMP_CACHE_BYTES,
> +					      MEMBLOCK_ALLOC_ACCESSIBLE);
> +		if (!nd_pa) {
> +			pr_err("Cannot find %zu bytes in node %d\n",
> +			       nd_size, nid);
> +			return;
> +		}
> +	}
> +	nd = __va(nd_pa);
> +
> +	/* report and initialize */
> +	pr_info("  NODE_DATA [mem %#010Lx-%#010Lx]\n",
> +	       nd_pa, nd_pa + nd_size - 1);
> +	tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
> +	if (tnid != nid)
> +		pr_info("    NODE_DATA(%d) on node %d\n", nid, tnid);
> +
> +	node_data[nid] = nd;
> +	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
> +	NODE_DATA(nid)->node_id = nid;
> +	NODE_DATA(nid)->node_start_pfn = start >> PAGE_SHIFT;
> +	NODE_DATA(nid)->node_spanned_pages = (end - start) >> PAGE_SHIFT;
> +
> +	node_set_online(nid);
> +}
> +
> +/*
> + * Set nodes, which have memory in @mi, in *@nodemask.
> + */
> +static void __init numa_nodemask_from_meminfo(nodemask_t *nodemask,
> +					      const struct numa_meminfo *mi)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(mi->blk); i++)
> +		if (mi->blk[i].start != mi->blk[i].end &&
> +		    mi->blk[i].nid != NUMA_NO_NODE)
> +			node_set(mi->blk[i].nid, *nodemask);
> +}
> +
> +/*
> + * Sanity check to catch more bad NUMA configurations (they are amazingly
> + * common).  Make sure the nodes cover all memory.
> + */
> +static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
> +{
> +	u64 numaram, totalram;
> +	int i;
> +
> +	numaram = 0;
> +	for (i = 0; i < mi->nr_blks; i++) {
> +		u64 s = mi->blk[i].start >> PAGE_SHIFT;
> +		u64 e = mi->blk[i].end >> PAGE_SHIFT;
> +
> +		numaram += e - s;
> +		numaram -= __absent_pages_in_range(mi->blk[i].nid, s, e);
> +		if ((s64)numaram < 0)
> +			numaram = 0;
> +	}
> +
> +	totalram = max_pfn - absent_pages_in_range(0, max_pfn);
> +
> +	/* We seem to lose 3 pages somewhere. Allow 1M of slack. */
> +	if ((s64)(totalram - numaram) >= (1 << (20 - PAGE_SHIFT))) {
> +		pr_err("NUMA: nodes only cover %lluMB of your %lluMB Total RAM. Not used.\n",
> +		       (numaram << PAGE_SHIFT) >> 20,
> +		       (totalram << PAGE_SHIFT) >> 20);
> +		return false;
> +	}
> +	return true;
> +}
> +
> +/**
> + * numa_reset_distance - Reset NUMA distance table
> + *
> + * The current table is freed.  The next numa_set_distance() call will
> + * create a new one.
> + */
> +void __init numa_reset_distance(void)
> +{
> +	size_t size = numa_distance_cnt * numa_distance_cnt *
> +		sizeof(numa_distance[0]);
> +
> +	/* numa_distance could be 1LU marking allocation failure, test cnt */
> +	if (numa_distance_cnt)
> +		memblock_free(__pa(numa_distance), size);
> +	numa_distance_cnt = 0;
> +	numa_distance = NULL;	/* enable table creation */
> +}
> +
> +static int __init numa_alloc_distance(void)
> +{
> +	nodemask_t nodes_parsed;
> +	size_t size;
> +	int i, j, cnt = 0;
> +	u64 phys;
> +
> +	/* size the new table and allocate it */
> +	nodes_parsed = numa_nodes_parsed;
> +	numa_nodemask_from_meminfo(&nodes_parsed, &numa_meminfo);
> +
> +	for_each_node_mask(i, nodes_parsed)
> +		cnt = i;
> +	cnt++;
> +	size = cnt * cnt * sizeof(numa_distance[0]);
> +
> +	phys = memblock_find_in_range(0, PFN_PHYS(max_pfn),
> +				      size, PAGE_SIZE);
> +	if (!phys) {
> +		pr_warning("NUMA: Warning: can't allocate distance table!\n");
> +		/* don't retry until explicitly reset */
> +		numa_distance = (void *)1LU;
> +		return -ENOMEM;
> +	}
> +	memblock_reserve(phys, size);
> +
> +	numa_distance = __va(phys);
> +	numa_distance_cnt = cnt;
> +
> +	/* fill with the default distances */
> +	for (i = 0; i < cnt; i++)
> +		for (j = 0; j < cnt; j++)
> +			numa_distance[i * cnt + j] = i == j ?
> +				LOCAL_DISTANCE : REMOTE_DISTANCE;
> +	pr_debug("NUMA: Initialized distance table, cnt=%d\n", cnt);
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
> +	if (!numa_distance && numa_alloc_distance() < 0)
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
> +
> +static int __init numa_register_memblks(struct numa_meminfo *mi)
> +{
> +	unsigned long uninitialized_var(pfn_align);
> +	int i, nid;
> +
> +	/* Account for nodes with cpus and no memory */
> +	node_possible_map = numa_nodes_parsed;
> +	numa_nodemask_from_meminfo(&node_possible_map, mi);
> +	if (WARN_ON(nodes_empty(node_possible_map)))
> +		return -EINVAL;
> +
> +	for (i = 0; i < mi->nr_blks; i++) {
> +		struct numa_memblk *mb = &mi->blk[i];
> +
> +		memblock_set_node(mb->start, mb->end - mb->start,
> +				  &memblock.memory, mb->nid);
> +	}
> +
> +	/*
> +	 * If sections array is gonna be used for pfn -> nid mapping, check
> +	 * whether its granularity is fine enough.
> +	 */
> +#ifdef NODE_NOT_IN_PAGE_FLAGS
> +	pfn_align = node_map_pfn_alignment();
> +	if (pfn_align && pfn_align < PAGES_PER_SECTION) {
> +		pr_warn("Node alignment %lluMB < min %lluMB, rejecting NUMA config\n",
> +		       PFN_PHYS(pfn_align) >> 20,
> +		       PFN_PHYS(PAGES_PER_SECTION) >> 20);
> +		return -EINVAL;
> +	}
> +#endif
> +	if (!numa_meminfo_cover_memory(mi))
> +		return -EINVAL;
> +
> +	/* Finally register nodes. */
> +	for_each_node_mask(nid, node_possible_map) {
> +		u64 start = PFN_PHYS(max_pfn);
> +		u64 end = 0;
> +
> +		for (i = 0; i < mi->nr_blks; i++) {
> +			if (nid != mi->blk[i].nid)
> +				continue;
> +			start = min(mi->blk[i].start, start);
> +			end = max(mi->blk[i].end, end);
> +		}
> +
> +		if (start < end)
> +			setup_node_data(nid, start, end);
> +	}
> +
> +	/* Dump memblock with node info and return. */
> +	memblock_dump_all();
> +	return 0;
> +}
> +
> +static int __init numa_init(int (*init_func)(void))
> +{
> +	int ret, i;
> +
> +	nodes_clear(node_possible_map);
> +	nodes_clear(node_online_map);
> +
> +	ret = init_func();
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = numa_register_memblks(&numa_meminfo);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; i < nr_cpu_ids; i++)
> +		numa_clear_node(i);
> +
> +	setup_node_to_cpumask_map();
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
> + */
> +static int __init dummy_numa_init(void)
> +{
> +	pr_info("%s\n", "No NUMA configuration found");
> +	pr_info("Faking a node at [mem %#018Lx-%#018Lx]\n",
> +	       0LLU, PFN_PHYS(max_pfn) - 1);
> +	node_set(0, numa_nodes_parsed);
> +	numa_add_memblk(0, 0, PFN_PHYS(max_pfn));
> +
> +	return 0;
> +}
> +
> +/**
> + * arm64_numa_init - Initialize NUMA
> + *
> + * Try each configured NUMA initialization method until one succeeds.  The
> + * last fallback is dummy single node config encomapssing whole memory and
> + * never fails.
> + */
> +void __init arm64_numa_init(void)
> +{
> +	if (!numa_off) {
> +#ifdef CONFIG_ARM64_DT_NUMA
> +		if (!numa_init(arm64_dt_numa_init))
> +			return;
> +#endif
> +	}
> +
> +	numa_init(dummy_numa_init);
> +}
> 


-- 
Shannon
