From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 4 Mar 2014 10:46:14 +0000
Subject: [PATCH v2] arm64: topology: Implement basic CPU topology support
In-Reply-To: <1393919477-27814-1-git-send-email-broonie@kernel.org>
References: <1393919477-27814-1-git-send-email-broonie@kernel.org>
Message-ID: <20140304104614.GA21431@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 07:51:17AM +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Add basic CPU topology support to arm64, based on the existing pre-v8
> code and some work done by Mark Hambleton.  This patch does not
> implement any topology discovery support since that should be based on
> information from firmware, it merely implements the scaffolding for
> integration of topology support in the architecture.
> 
> No locking of the topology data is done since it is only modified during
> CPU bringup with external serialisation from the SMP code.
> 
> The goal is to separate the architecture hookup for providing topology
> information from the DT parsing in order to ease review and avoid
> blocking the architecture code (which will be built on by other work)
> with the DT code review by providing something simple and basic.
> 
> Following patches will implement support for interpreting topology
> information from MPIDR and for parsing the DT topology bindings for ARM,
> similar patches will be needed for ACPI.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> Acked-by: Mark RUtland <mark.rutland@arm.com>
> ---
>  arch/arm64/Kconfig                | 24 ++++++++++
>  arch/arm64/include/asm/topology.h | 39 ++++++++++++++++
>  arch/arm64/kernel/Makefile        |  1 +
>  arch/arm64/kernel/smp.c           | 11 +++++
>  arch/arm64/kernel/topology.c      | 95 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 170 insertions(+)
>  create mode 100644 arch/arm64/include/asm/topology.h
>  create mode 100644 arch/arm64/kernel/topology.c
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 764d682..80e0eb1 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -165,6 +165,30 @@ config SMP
>  
>  	  If you don't know what to do here, say N.
>  
> +config CPU_TOPOLOGY
> +	bool "Support CPU topology definition"
> +	depends on SMP
> +	default y
> +	help
> +	  Support CPU topology definition, based on configuration
> +	  provided by the firmware.
> +
> +config SCHED_MC
> +	bool "Multi-core scheduler support"
> +	depends on CPU_TOPOLOGY
> +	help
> +	  Multi-core scheduler support improves the CPU scheduler's decision
> +	  making when dealing with multi-core CPU chips at a cost of slightly
> +	  increased overhead in some places. If unsure say N here.
> +
> +config SCHED_SMT
> +	bool "SMT scheduler support"
> +	depends on CPU_TOPOLOGY
> +	help
> +	  Improves the CPU scheduler's decision making when dealing with
> +	  MultiThreading at a cost of slightly increased overhead in some
> +	  places. If unsure say N here.
> +
>  config NR_CPUS
>  	int "Maximum number of CPUs (2-32)"
>  	range 2 32
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> new file mode 100644
> index 0000000..c8a47e8
> --- /dev/null
> +++ b/arch/arm64/include/asm/topology.h
> @@ -0,0 +1,39 @@
> +#ifndef __ASM_TOPOLOGY_H
> +#define __ASM_TOPOLOGY_H
> +
> +#ifdef CONFIG_CPU_TOPOLOGY
> +
> +#include <linux/cpumask.h>
> +
> +struct cpu_topology {
> +	int thread_id;
> +	int core_id;
> +	int cluster_id;
> +	cpumask_t thread_sibling;
> +	cpumask_t core_sibling;
> +};
> +
> +extern struct cpu_topology cpu_topology[NR_CPUS];
> +
> +#define topology_physical_package_id(cpu)	(cpu_topology[cpu].cluster_id)
> +#define topology_core_id(cpu)		(cpu_topology[cpu].core_id)
> +#define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
> +#define topology_thread_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
> +
> +#define mc_capable()	(cpu_topology[0].cluster_id != -1)
> +#define smt_capable()	(cpu_topology[0].thread_id != -1)
> +
> +void init_cpu_topology(void);
> +void store_cpu_topology(unsigned int cpuid);
> +const struct cpumask *cpu_coregroup_mask(int cpu);
> +
> +#else
> +
> +static inline void init_cpu_topology(void) { }
> +static inline void store_cpu_topology(unsigned int cpuid) { }
> +
> +#endif
> +
> +#include <asm-generic/topology.h>
> +
> +#endif /* _ASM_ARM_TOPOLOGY_H */
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index e52bcdc..da1dafb 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -21,6 +21,7 @@ arm64-obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
>  arm64-obj-$(CONFIG_ARM64_CPU_SUSPEND)	+= sleep.o suspend.o
>  arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
>  arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
> +arm64-obj-$(CONFIG_CPU_TOPOLOGY)	+= topology.o
>  
>  obj-y					+= $(arm64-obj-y) vdso/
>  obj-m					+= $(arm64-obj-m)
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 5070dc3..f0a141d 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -114,6 +114,11 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  	return ret;
>  }
>  
> +static void smp_store_cpu_info(unsigned int cpuid)
> +{
> +	store_cpu_topology(cpuid);
> +}
> +
>  /*
>   * This is the secondary CPU boot entry.  We're using this CPUs
>   * idle thread stack, but a set of temporary page tables.
> @@ -152,6 +157,8 @@ asmlinkage void secondary_start_kernel(void)
>  	 */
>  	notify_cpu_starting(cpu);
>  
> +	smp_store_cpu_info(cpu);
> +
>  	/*
>  	 * OK, now it's safe to let the boot CPU continue.  Wait for
>  	 * the CPU migration code to notice that the CPU is online
> @@ -391,6 +398,10 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  	int err;
>  	unsigned int cpu, ncores = num_possible_cpus();
>  
> +	init_cpu_topology();
> +
> +	smp_store_cpu_info(smp_processor_id());
> +
>  	/*
>  	 * are we trying to boot more cores than exist?
>  	 */
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> new file mode 100644
> index 0000000..3e06b0b
> --- /dev/null
> +++ b/arch/arm64/kernel/topology.c
> @@ -0,0 +1,95 @@
> +/*
> + * arch/arm64/kernel/topology.c
> + *
> + * Copyright (C) 2011,2013,2014 Linaro Limited.
> + *
> + * Based on the arm32 version written by Vincent Guittot in turn based on
> + * arch/sh/kernel/topology.c
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +
> +#include <linux/cpu.h>

Include above can go

> +#include <linux/cpumask.h>
> +#include <linux/init.h>
> +#include <linux/percpu.h>
> +#include <linux/node.h>
> +#include <linux/nodemask.h>
> +#include <linux/sched.h>

Ditto for the four includes above, I know you will have to add them later, but
removing them is not that complex, up to you guys.

Having said that:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> +
> +#include <asm/topology.h>
> +
> +/*
> + * cpu topology table
> + */
> +struct cpu_topology cpu_topology[NR_CPUS];
> +EXPORT_SYMBOL_GPL(cpu_topology);
> +
> +const struct cpumask *cpu_coregroup_mask(int cpu)
> +{
> +	return &cpu_topology[cpu].core_sibling;
> +}
> +
> +static void update_siblings_masks(unsigned int cpuid)
> +{
> +	struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
> +	int cpu;
> +
> +	if (cpuid_topo->cluster_id == -1) {
> +		/*
> +		 * DT does not contain topology information for this cpu
> +		 * reset it to default behaviour
> +		 */
> +		pr_debug("CPU%u: No topology information configured\n", cpuid);
> +		cpuid_topo->core_id = 0;
> +		cpumask_set_cpu(cpuid, &cpuid_topo->core_sibling);
> +		cpumask_set_cpu(cpuid, &cpuid_topo->thread_sibling);
> +		return;
> +	}
> +
> +	/* update core and thread sibling masks */
> +	for_each_possible_cpu(cpu) {
> +		cpu_topo = &cpu_topology[cpu];
> +
> +		if (cpuid_topo->cluster_id != cpu_topo->cluster_id)
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
> +}
> +
> +void store_cpu_topology(unsigned int cpuid)
> +{
> +	update_siblings_masks(cpuid);
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
> +		struct cpu_topology *cpu_topo = &cpu_topology[cpu];
> +
> +		cpu_topo->thread_id = -1;
> +		cpu_topo->core_id =  -1;
> +		cpu_topo->cluster_id = -1;
> +		cpumask_clear(&cpu_topo->core_sibling);
> +		cpumask_clear(&cpu_topo->thread_sibling);
> +	}
> +}
> -- 
> 1.9.0
> 
> 
