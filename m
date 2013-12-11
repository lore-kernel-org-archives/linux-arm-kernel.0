From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Dec 2013 14:12:24 +0000
Subject: [PATCH 4/6] arm64: topology: Implement basic CPU topology support
In-Reply-To: <1386767606-6391-4-git-send-email-broonie@kernel.org>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <1386767606-6391-4-git-send-email-broonie@kernel.org>
Message-ID: <20131211141224.GG26730@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 01:13:24PM +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Add basic CPU topology support to arm64, based on the existing pre-v8
> code and some work done by Mark Hambleton.  This patch does not
> implement the ARM CPU topology bindings, it implements equivalent
> support to the existing the equivalent pre-v8 capability using the
> mandatory MPIDR information in the CPU binding in device tree and
> assuming that a simple SMP or multi-cluster topology is in use.
> 
> The primary goal is to separate the architecture hookup for providing
> topology information from the DT parsing in order to ease review and
> avoid blocking the architecture code (which will be built on by other
> work) with the DT code review by providing something something simple
> and basic.  Having this support should also make the kernel cope better
> with incomplete DTs.
> 
> Further patches will provide support for overriding this using the
> topology bindings, providing richer support for a wider range of systems.

[Adding Lorenzo]

I seem to remember Lorenzo having patches already for this, along with
bindings, Documentation etc. so it would be good to know how these two
series are supposed to interact.

Will

> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  arch/arm64/Kconfig                |   8 +++
>  arch/arm64/include/asm/cpu.h      |   1 -
>  arch/arm64/include/asm/cputype.h  |   9 +++
>  arch/arm64/include/asm/smp_plat.h |   1 +
>  arch/arm64/include/asm/topology.h |  42 +++++++++++
>  arch/arm64/kernel/Makefile        |   1 +
>  arch/arm64/kernel/setup.c         |   9 +--
>  arch/arm64/kernel/smp.c           |  19 ++++-
>  arch/arm64/kernel/topology.c      | 143 ++++++++++++++++++++++++++++++++++++++
>  9 files changed, 227 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm64/include/asm/topology.h
>  create mode 100644 arch/arm64/kernel/topology.c
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 88c8b6c1341a..7b4dab852937 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -154,6 +154,14 @@ config SMP
>  
>  	  If you don't know what to do here, say N.
>  
> +config ARM_CPU_TOPOLOGY
> +	bool "Support CPU topology definition"
> +	depends on SMP
> +	default y
> +	help
> +	  Support CPU topology definition, based on configuration
> +	  provided by the firmware.
> +
>  config NR_CPUS
>  	int "Maximum number of CPUs (2-32)"
>  	range 2 32
> diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
> index d67ff011d361..8a26b690110c 100644
> --- a/arch/arm64/include/asm/cpu.h
> +++ b/arch/arm64/include/asm/cpu.h
> @@ -10,7 +10,6 @@
>  
>  #include <linux/percpu.h>
>  #include <linux/cpu.h>
> -#include <linux/topology.h>
>  
>  struct cpuinfo_arm {
>  	struct cpu	cpu;
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 5fe138e0b828..bd504739cbfd 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -29,6 +29,15 @@
>  #define INVALID_HWID		ULONG_MAX
>  
>  #define MPIDR_HWID_BITMASK	0xff00ffffff
> +#define MPIDR_SMP_BITMASK (0x3 << 30)
> +#define MPIDR_SMP_VALUE (0x2 << 30)
> +#define MPIDR_MT_BITMASK (0x1 << 24)
> +#define MPIDR_LEVEL_BITS 8
> +#define MPIDR_LEVEL_MASK ((1 << MPIDR_LEVEL_BITS) - 1)
> +
> +#define MPIDR_AFFINITY_LEVEL(mpidr, level) \
> +	((mpidr >> (MPIDR_LEVEL_BITS * level)) & MPIDR_LEVEL_MASK)
> +
>  
>  #define read_cpuid(reg) ({						\
>  	u64 __val;							\
> diff --git a/arch/arm64/include/asm/smp_plat.h b/arch/arm64/include/asm/smp_plat.h
> index ed43a0d2b1b2..4ad4ecc93bcf 100644
> --- a/arch/arm64/include/asm/smp_plat.h
> +++ b/arch/arm64/include/asm/smp_plat.h
> @@ -19,6 +19,7 @@
>  #ifndef __ASM_SMP_PLAT_H
>  #define __ASM_SMP_PLAT_H
>  
> +#include <linux/cpumask.h>
>  #include <asm/types.h>
>  
>  /*
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> new file mode 100644
> index 000000000000..611edefaeaf1
> --- /dev/null
> +++ b/arch/arm64/include/asm/topology.h
> @@ -0,0 +1,42 @@
> +#ifndef _ASM_ARM_TOPOLOGY_H
> +#define _ASM_ARM_TOPOLOGY_H
> +
> +#ifdef CONFIG_ARM_CPU_TOPOLOGY
> +
> +#include <linux/cpumask.h>
> +
> +struct cputopo_arm {
> +	int thread_id;
> +	int core_id;
> +	int socket_id;
> +	cpumask_t thread_sibling;
> +	cpumask_t core_sibling;
> +};
> +
> +extern struct cputopo_arm cpu_topology[NR_CPUS];
> +
> +#define topology_physical_package_id(cpu)	(cpu_topology[cpu].socket_id)
> +#define topology_core_id(cpu)		(cpu_topology[cpu].core_id)
> +#define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
> +#define topology_thread_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
> +
> +#define mc_capable()	(cpu_topology[0].socket_id != -1)
> +#define smt_capable()	(cpu_topology[0].thread_id != -1)
> +
> +void init_cpu_topology(void);
> +void store_cpu_topology(unsigned int cpuid);
> +const struct cpumask *cpu_coregroup_mask(int cpu);
> +int cluster_to_logical_mask(unsigned int socket_id, cpumask_t *cluster_mask);
> +
> +#else
> +
> +static inline void init_cpu_topology(void) { }
> +static inline void store_cpu_topology(unsigned int cpuid) { }
> +static inline int cluster_to_logical_mask(unsigned int socket_id,
> +	cpumask_t *cluster_mask) { return -EINVAL; }
> +
> +#endif
> +
> +#include <asm-generic/topology.h>
> +
> +#endif /* _ASM_ARM_TOPOLOGY_H */
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 5ba2fd43a75b..2d145e38ad49 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -18,6 +18,7 @@ arm64-obj-$(CONFIG_SMP)			+= smp.o smp_spin_table.o
>  arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
>  arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)+= hw_breakpoint.o
>  arm64-obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
> +arm64-obj-$(CONFIG_ARM_CPU_TOPOLOGY)  += topology.o
>  
>  obj-y					+= $(arm64-obj-y) vdso/
>  obj-m					+= $(arm64-obj-m)
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 0bc5e4cbc017..dbe4a9ba90cb 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -54,6 +54,7 @@
>  #include <asm/traps.h>
>  #include <asm/memblock.h>
>  #include <asm/psci.h>
> +#include <asm/cpu.h>
>  
>  unsigned int processor_id;
>  EXPORT_SYMBOL(processor_id);
> @@ -250,16 +251,16 @@ static int __init arm64_device_init(void)
>  }
>  arch_initcall(arm64_device_init);
>  
> -static DEFINE_PER_CPU(struct cpu, cpu_data);
> +DEFINE_PER_CPU(struct cpuinfo_arm, cpu_data);
>  
>  static int __init topology_init(void)
>  {
>  	int i;
>  
>  	for_each_possible_cpu(i) {
> -		struct cpu *cpu = &per_cpu(cpu_data, i);
> -		cpu->hotpluggable = 1;
> -		register_cpu(cpu, i);
> +		struct cpuinfo_arm *cpu = &per_cpu(cpu_data, i);
> +		cpu->cpu.hotpluggable = 1;
> +		register_cpu(&cpu->cpu, i);
>  	}
>  
>  	return 0;
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index a5aeefab03c3..f29c7ffad84a 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -35,7 +35,6 @@
>  #include <linux/clockchips.h>
>  #include <linux/completion.h>
>  #include <linux/of.h>
> -
>  #include <asm/atomic.h>
>  #include <asm/cacheflush.h>
>  #include <asm/cputype.h>
> @@ -48,6 +47,7 @@
>  #include <asm/sections.h>
>  #include <asm/tlbflush.h>
>  #include <asm/ptrace.h>
> +#include <asm/cpu.h>
>  
>  /*
>   * as from 2.5, kernels no longer have an init_tasks structure
> @@ -113,6 +113,16 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  	return ret;
>  }
>  
> +static void __cpuinit smp_store_cpu_info(unsigned int cpuid)
> +{
> +	struct cpuinfo_arm *cpu_info = &per_cpu(cpu_data, cpuid);
> +
> +	cpu_info->loops_per_jiffy = loops_per_jiffy;
> +	cpu_info->cpuid = read_cpuid_id();
> +
> +	store_cpu_topology(cpuid);
> +}
> +
>  /*
>   * This is the secondary CPU boot entry.  We're using this CPUs
>   * idle thread stack, but a set of temporary page tables.
> @@ -150,6 +160,8 @@ asmlinkage void secondary_start_kernel(void)
>  	 */
>  	notify_cpu_starting(cpu);
>  
> +	smp_store_cpu_info(cpu);
> +
>  	/*
>  	 * OK, now it's safe to let the boot CPU continue.  Wait for
>  	 * the CPU migration code to notice that the CPU is online
> @@ -387,6 +399,11 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  	int err;
>  	unsigned int cpu, ncores = num_possible_cpus();
>  
> +	init_cpu_topology();
> +
> +	smp_store_cpu_info(smp_processor_id());
> +
> +
>  	/*
>  	 * are we trying to boot more cores than exist?
>  	 */
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> new file mode 100644
> index 000000000000..e0b40f48b448
> --- /dev/null
> +++ b/arch/arm64/kernel/topology.c
> @@ -0,0 +1,143 @@
> +/*
> + * arch/arm64/kernel/topology.c
> + *
> + * Copyright (C) 2011,2013 Linaro Limited.
> + * Written by: Vincent Guittot
> + *
> + * based on arch/sh/kernel/topology.c
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/export.h>
> +#include <linux/init.h>
> +#include <linux/percpu.h>
> +#include <linux/node.h>
> +#include <linux/nodemask.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +
> +#include <asm/cputype.h>
> +#include <asm/smp_plat.h>
> +#include <asm/topology.h>
> +
> +/*
> + * cpu topology table
> + */
> +struct cputopo_arm cpu_topology[NR_CPUS];
> +EXPORT_SYMBOL_GPL(cpu_topology);
> +
> +const struct cpumask *cpu_coregroup_mask(int cpu)
> +{
> +	return &cpu_topology[cpu].core_sibling;
> +}
> +
> +static void update_siblings_masks(unsigned int cpuid)
> +{
> +	struct cputopo_arm *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
> +	int cpu;
> +
> +	/* update core and thread sibling masks */
> +	for_each_possible_cpu(cpu) {
> +		cpu_topo = &cpu_topology[cpu];
> +
> +		if (cpuid_topo->socket_id != cpu_topo->socket_id)
> +			continue;
> +
> +		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
> +		if (cpu != cpuid)
> +			cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);
> +
> +		if (cpuid_topo->core_id != cpu_topo->core_id)
> +			continue;
> +
> +		cpumask_set_cpu(cpuid, &cpu_topo->thread_sibling);
> +		if (cpu != cpuid)
> +			cpumask_set_cpu(cpu, &cpuid_topo->thread_sibling);
> +	}
> +	smp_wmb();
> +}
> +
> +/*
> + * store_cpu_topology is called at boot when only one cpu is running
> + * and with the mutex cpu_hotplug.lock locked, when several cpus have booted,
> + * which prevents simultaneous write access to cpu_topology array
> + */
> +void store_cpu_topology(unsigned int cpuid)
> +{
> +	struct cputopo_arm *cpuid_topo = &cpu_topology[cpuid];
> +	u64 mpidr;
> +
> +	/* If the cpu topology has been already set, just return */
> +	if (cpuid_topo->core_id != -1)
> +		return;
> +
> +	mpidr = cpu_logical_map(cpuid);
> +
> +	/*
> +	 * Create cpu topology mapping, assume the cores are largely
> +	 * independent since the DT bindings do not include the flags
> +	 * for MT.
> +	 */
> +	cpuid_topo->core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +	cpuid_topo->socket_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +
> +	update_siblings_masks(cpuid);
> +
> +	pr_info("CPU%u: cpu %d, socket %d mapped using MPIDR %llx\n",
> +		cpuid, cpu_topology[cpuid].core_id,
> +		cpu_topology[cpuid].socket_id, mpidr);
> +}
> +
> +
> +/*
> + * cluster_to_logical_mask - return cpu logical mask of CPUs in a cluster
> + * @socket_id:		cluster HW identifier
> + * @cluster_mask:	the cpumask location to be initialized, modified by the
> + *			function only if return value == 0
> + *
> + * Return:
> + *
> + * 0 on success
> + * -EINVAL if cluster_mask is NULL or there is no record matching socket_id
> + */
> +int cluster_to_logical_mask(unsigned int socket_id, cpumask_t *cluster_mask)
> +{
> +	int cpu;
> +
> +	if (!cluster_mask)
> +		return -EINVAL;
> +
> +	for_each_online_cpu(cpu)
> +		if (socket_id == topology_physical_package_id(cpu)) {
> +			cpumask_copy(cluster_mask, topology_core_cpumask(cpu));
> +			return 0;
> +		}
> +
> +	return -EINVAL;
> +}
> +
> +/*
> + * init_cpu_topology is called at boot when only one cpu is running
> + * which prevent simultaneous write access to cpu_topology array
> + */
> +void __init init_cpu_topology(void)
> +{
> +	unsigned int cpu;
> +
> +	/* init core mask and power*/
> +	for_each_possible_cpu(cpu) {
> +		struct cputopo_arm *cpu_topo = &(cpu_topology[cpu]);
> +
> +		cpu_topo->thread_id = -1;
> +		cpu_topo->core_id =  -1;
> +		cpu_topo->socket_id = -1;
> +		cpumask_clear(&cpu_topo->core_sibling);
> +		cpumask_clear(&cpu_topo->thread_sibling);
> +	}
> +	smp_wmb();
> +}
> -- 
> 1.8.5.1
> 
> 
