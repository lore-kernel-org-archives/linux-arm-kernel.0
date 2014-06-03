From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 3 Jun 2014 18:31:03 +0100
Subject: [PATCH] arm64: topology: add MPIDR-based detection
In-Reply-To: <1401644249-23792-1-git-send-email-broonie@kernel.org>
References: <1401644249-23792-1-git-send-email-broonie@kernel.org>
Message-ID: <20140603173103.GA18004@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Sun, Jun 01, 2014 at 06:37:29PM +0100, Mark Brown wrote:
> From: Zi Shen Lim <zlim@broadcom.com>
> 
> Create cpu topology based on MPIDR. When hardware sets MPIDR to sane
> values, this method will always work. Therefore it should also work well
> as the fallback method. [1]
> 
> When we have multiple processing elements in the system, we create
> the cpu topology by mapping each affinity level (from lowest to highest)
> to threads (if they exist), cores, and clusters.
> 
> We combine data from all higher affinity levels into cluster_id
> so we don't lose any information from MPIDR. [2]

I refactored the patch (UP code path) and deliberately removed the
code that packs affinity levels into the cluster id. I do not
like packing the affinity levels and on second thoughts packing the
unused affinity levels into cluster_id is as correct as packing
the unused affinity levels into core_id (ie it is arbitrary), so I do
not think we should do it, that's the reason why we defined DT bindings
to add a proper topology semantics and we should use them when the MPIDR
values deviate from the "recommendations".

Patch attached, my ack included, should be ready to go, unless you
object to that.

Lorenzo

> [1] http://www.spinics.net/lists/arm-kernel/msg317445.html
> [2] https://lkml.org/lkml/2014/4/23/703
> 
> Signed-off-by: Zi Shen Lim <zlim@broadcom.com>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  arch/arm64/include/asm/cputype.h |  2 ++
>  arch/arm64/kernel/topology.c     | 51 +++++++++++++++++++++++++++++-----------
>  2 files changed, 39 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 27f54a7cc81b..ed48a3a7836a 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -18,6 +18,8 @@
>  
>  #define INVALID_HWID		ULONG_MAX
>  
> +#define MPIDR_UP_BITMASK	(0x1 << 30)
> +#define MPIDR_MT_BITMASK	(0x1 << 24)
>  #define MPIDR_HWID_BITMASK	0xff00ffffff
>  
>  #define MPIDR_LEVEL_BITS_SHIFT	3
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 43514f905916..9a0160068503 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -20,6 +20,7 @@
>  #include <linux/of.h>
>  #include <linux/sched.h>
>  
> +#include <asm/cputype.h>
>  #include <asm/topology.h>
>  
>  static int __init get_cpu_for_node(struct device_node *node)
> @@ -188,13 +189,9 @@ static int __init parse_dt_topology(void)
>  	 * Check that all cores are in the topology; the SMP code will
>  	 * only mark cores described in the DT as possible.
>  	 */
> -	for_each_possible_cpu(cpu) {
> -		if (cpu_topology[cpu].cluster_id == -1) {
> -			pr_err("CPU%d: No topology information specified\n",
> -			       cpu);
> +	for_each_possible_cpu(cpu)
> +		if (cpu_topology[cpu].cluster_id == -1)
>  			ret = -EINVAL;
> -		}
> -	}
>  
>  out_map:
>  	of_node_put(map);
> @@ -219,14 +216,6 @@ static void update_siblings_masks(unsigned int cpuid)
>  	struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
>  	int cpu;
>  
> -	if (cpuid_topo->cluster_id == -1) {
> -		/*
> -		 * DT does not contain topology information for this cpu.
> -		 */
> -		pr_debug("CPU%u: No topology information configured\n", cpuid);
> -		return;
> -	}
> -
>  	/* update core and thread sibling masks */
>  	for_each_possible_cpu(cpu) {
>  		cpu_topo = &cpu_topology[cpu];
> @@ -249,6 +238,40 @@ static void update_siblings_masks(unsigned int cpuid)
>  
>  void store_cpu_topology(unsigned int cpuid)
>  {
> +	struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
> +	u64 mpidr;
> +
> +	if (cpuid_topo->cluster_id != -1)
> +		goto topology_populated;
> +
> +	mpidr = read_cpuid_mpidr();
> +
> +	/* Create cpu topology mapping based on MPIDR. */
> +	if (mpidr & MPIDR_UP_BITMASK) {
> +		/* Uniprocessor system */
> +		cpuid_topo->thread_id  = -1;
> +		cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +		cpuid_topo->cluster_id = 0;
> +	} else if (mpidr & MPIDR_MT_BITMASK) {
> +		/* Multiprocessor system : Multi-threads per core */
> +		cpuid_topo->thread_id  = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +		cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +		cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 2) |
> +					 MPIDR_AFFINITY_LEVEL(mpidr, 3) << 8;
> +	} else {
> +		/* Multiprocessor system : Single-thread per core */
> +		cpuid_topo->thread_id  = -1;
> +		cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +		cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 1) |
> +					 MPIDR_AFFINITY_LEVEL(mpidr, 2) << 8 |
> +					 MPIDR_AFFINITY_LEVEL(mpidr, 3) << 16;
> +	}
> +
> +	pr_debug("CPU%u: cluster %d core %d thread %d mpidr %llx\n",
> +		 cpuid, cpuid_topo->cluster_id, cpuid_topo->core_id,
> +		 cpuid_topo->thread_id, mpidr);
> +
> +topology_populated:
>  	update_siblings_masks(cpuid);
>  }
>  
> -- 
> 2.0.0.rc4
> 
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-arm64-topology-add-MPIDR-based-detection.patch
Type: text/x-diff
Size: 3828 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140603/d5e1520c/attachment-0001.bin>
