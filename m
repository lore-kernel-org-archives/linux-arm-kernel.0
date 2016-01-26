From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 26 Jan 2016 12:52:38 -0600
Subject: [PATCH v9 1/6] arm64, numa: adding numa support for arm64
 platforms.
In-Reply-To: <1453134965-6125-2-git-send-email-gkulkarni@caviumnetworks.com>
References: <1453134965-6125-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1453134965-6125-2-git-send-email-gkulkarni@caviumnetworks.com>
Message-ID: <20160126185238.GB17600@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2016 at 10:06:00PM +0530, Ganapatrao Kulkarni wrote:
> Adding numa support for arm64 based platforms.
> This patch adds by default the dummy numa node and
> maps all memory and cpus to node 0.
> using this patch, numa can be simulated on single node arm64 platforms.

> diff --git a/arch/arm64/include/asm/mmzone.h b/arch/arm64/include/asm/mmzone.h
> new file mode 100644
> index 0000000..2cd804d
> --- /dev/null
> +++ b/arch/arm64/include/asm/mmzone.h
> @@ -0,0 +1,18 @@
> +#ifndef __ASM_MMZONE_H
> +#define __ASM_MMZONE_H
> +
> +#ifdef CONFIG_NUMA
> +
> +#include <linux/mmdebug.h>
> +#include <linux/types.h>
> +
> +#include <asm/smp.h>
> +#include <asm/numa.h>

Are all these #includes really necessary?  s390 looks very similar and
doesn't need the #includes.

> +extern struct pglist_data *node_data[];
> +
> +#define NODE_DATA(nid)		(node_data[(nid)])
> +
> +#endif /* CONFIG_NUMA */
> +
> +#endif /* __ASM_MMZONE_H */

> diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
> new file mode 100644
> index 0000000..f28f15b0
> --- /dev/null
> +++ b/arch/arm64/include/asm/numa.h
> @@ -0,0 +1,40 @@
> +#ifndef __ASM_NUMA_H
> +#define __ASM_NUMA_H
> +
> +#include <linux/nodemask.h>
> +#include <asm/topology.h>
> +
> +#ifdef CONFIG_NUMA
> +
> +/* currently, arm64 implements flat NUMA topology */
> +#define parent_node(node)	(node)
> +
> +extern int __node_distance(int from, int to);

Below you add some extern function declarations without the "extern"
keyword.  I don't know what the convention is for arm64 (I omit the
"extern" for PCI), but it seems like you should at least be
consistent.

> +#define node_distance(a, b) __node_distance(a, b)
> +
> +extern int cpu_to_node_map[NR_CPUS];
> +extern nodemask_t numa_nodes_parsed __initdata;
> +
> +/* Mappings between node number and cpus on that node. */
> +extern cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
> +extern void numa_clear_node(unsigned int cpu);
> +#ifdef CONFIG_DEBUG_PER_CPU_MAPS
> +extern const struct cpumask *cpumask_of_node(int node);
> +#else
> +/* Returns a pointer to the cpumask of CPUs on Node 'node'. */
> +static inline const struct cpumask *cpumask_of_node(int node)
> +{
> +	return node_to_cpumask_map[node];
> +}
> +#endif
> +
> +void __init arm64_numa_init(void);
> +int __init numa_add_memblk(int nodeid, u64 start, u64 end);
> +void __init numa_set_distance(int from, int to, int distance);
> +void __init numa_reset_distance(void);
> +void numa_store_cpu_info(unsigned int cpu);
