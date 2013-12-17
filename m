From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 17 Dec 2013 17:06:25 +0000
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <1387212565-12668-1-git-send-email-broonie@kernel.org>
References: <1387212565-12668-1-git-send-email-broonie@kernel.org>
Message-ID: <20131217170625.GB9831@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Mon, Dec 16, 2013 at 04:49:22PM +0000, Mark Brown wrote:
> +void store_cpu_topology(unsigned int cpuid);

I still think this function is not needed at all and therefore should
not be exported.

I understand this patch is there to provide the infrastructure, it is
not clear to me why store_cpu_topology() should be part of it, even
if we had to parse affinity levels in the MPIDR bitfields.

[...]

> +static void __cpuinit smp_store_cpu_info(unsigned int cpuid)
> +{
> +	store_cpu_topology(cpuid);

As I mentioned this need not be done here. Parse the topology from DT,
(cpu_logical_map or cpu-map) in one go and get rid of store_cpu_topology().

>  /*
>   * This is the secondary CPU boot entry.  We're using this CPUs
>   * idle thread stack, but a set of temporary page tables.
> @@ -150,6 +155,8 @@ asmlinkage void secondary_start_kernel(void)
>  	 */
>  	notify_cpu_starting(cpu);
>  
> +	smp_store_cpu_info(cpu);
> +
>  	/*
>  	 * OK, now it's safe to let the boot CPU continue.  Wait for
>  	 * the CPU migration code to notice that the CPU is online
> @@ -388,6 +395,11 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
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
> index 000000000000..b078afa6958d
> --- /dev/null
> +++ b/arch/arm64/kernel/topology.c
> @@ -0,0 +1,95 @@
> +/*
> + * arch/arm64/kernel/topology.c
> + *
> + * Copyright (C) 2011,2013 Linaro Limited.
> + * Written by: Vincent Guittot

You should probably update the header, just a nitpick though.

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

I think that some of these includes are not needed, they were needed in
previous versions, but not in this patch as it stands.

Lorenzo
