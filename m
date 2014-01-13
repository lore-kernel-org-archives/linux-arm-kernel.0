From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 13 Jan 2014 16:10:59 +0000
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <1389554441-27335-2-git-send-email-broonie@kernel.org>
References: <1389554441-27335-1-git-send-email-broonie@kernel.org>
 <1389554441-27335-2-git-send-email-broonie@kernel.org>
Message-ID: <20140113161059.GA32720@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Vincent in CC, questions related to SCHED MC macros]

Minor comments below.

On Sun, Jan 12, 2014 at 07:20:38PM +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Add basic CPU topology support to arm64, based on the existing pre-v8
> code and some work done by Mark Hambleton.  This patch does not
> implement any topology discovery support since that should be based on
> information from firmware, it merely implements the scaffolding for
> integration of topology support in the architecture.
> 
> The goal is to separate the architecture hookup for providing topology
> information from the DT parsing in order to ease review and avoid
> blocking the architecture code (which will be built on by other work)
> with the DT code review by providing something something simple
> and basic.

"something something", one something is enough.

[...]

> new file mode 100644
> index 000000000000..6f5270c65a6c
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
> +	int socket_id;

Is there any reason why we can't rename socket_id to cluster_id ? It won't
change our lives but at least we kind of know what it means in ARM world.

> +	cpumask_t thread_sibling;
> +	cpumask_t core_sibling;
> +};
> +
> +extern struct cpu_topology cpu_topology[NR_CPUS];
> +
> +#define topology_physical_package_id(cpu)	(cpu_topology[cpu].socket_id)
> +#define topology_core_id(cpu)		(cpu_topology[cpu].core_id)
> +#define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
> +#define topology_thread_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
> +
> +#define mc_capable()	(cpu_topology[0].socket_id != -1)
> +#define smt_capable()	(cpu_topology[0].thread_id != -1)

Are the two macros above still required in the kernel ? I can't see any
usage at present.

Vincent, do you know why they were not removed in commit:

8e7fbcbc22c12414bcc9dfdd683637f58fb32759

I am certainly missing something.

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
> index 2d4554b13410..252b62181532 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -20,6 +20,7 @@ arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)+= hw_breakpoint.o
>  arm64-obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
>  arm64-obj-$(CONFIG_ARM64_CPU_SUSPEND)	+= sleep.o suspend.o
>  arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
> +arm64-obj-$(CONFIG_CPU_TOPOLOGY)	+= topology.o
>  
>  obj-y					+= $(arm64-obj-y) vdso/
>  obj-m					+= $(arm64-obj-m)
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 1b7617ab499b..40e20efc13e6 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -114,6 +114,11 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  	return ret;
>  }
>  
> +static void __cpuinit smp_store_cpu_info(unsigned int cpuid)
> +{
> +	store_cpu_topology(cpuid);
> +}

__cpuinit has been (is being) removed from the kernel and probably should
be removed from this definition too.

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
> @@ -391,6 +398,11 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  	int err;
>  	unsigned int cpu, ncores = num_possible_cpus();
>  
> +	init_cpu_topology();
> +
> +	smp_store_cpu_info(smp_processor_id());
> +
> +

Too many empty lines, one is enough.

>  	/*
>  	 * are we trying to boot more cores than exist?
>  	 */
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> new file mode 100644
> index 000000000000..980019fefeff
> --- /dev/null
> +++ b/arch/arm64/kernel/topology.c
> @@ -0,0 +1,91 @@
> +/*
> + * arch/arm64/kernel/topology.c
> + *
> + * Copyright (C) 2011,2013 Linaro Limited.
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
> +#include <linux/cpumask.h>
> +#include <linux/init.h>
> +#include <linux/percpu.h>
> +#include <linux/node.h>
> +#include <linux/nodemask.h>
> +#include <linux/sched.h>
> +
> +#include <asm/topology.h>

I have already commented on this. If this patchset is completely merged,
that is one thing, if it is not we are adding include files for nothing.
If you have time, and there should be given that the set missed the
merge window it would be nice to split the includes, I will not nitpick
any longer though, so it is up to you.

[...]

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
> +		struct cpu_topology *cpu_topo = &(cpu_topology[cpu]);

You do not need brackets, &cpu_topology[cpu] will do.

Lorenzo
