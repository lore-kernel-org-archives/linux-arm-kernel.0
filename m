From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Jul 2018 14:58:10 +0100
Subject: [PATCH v2 3/7] arm64: topology: add support to remove cpu
 topology sibling masks
In-Reply-To: <1529327923-17911-4-git-send-email-sudeep.holla@arm.com>
References: <1529327923-17911-1-git-send-email-sudeep.holla@arm.com>
 <1529327923-17911-4-git-send-email-sudeep.holla@arm.com>
Message-ID: <20180704135809.GB4828@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 02:18:39PM +0100, Sudeep Holla wrote:
> This patch adds support to remove all the CPU topology information using
> clear_cpu_topology and also resetting the sibling information on other
> sibling CPUs. This will be used in cpu_disable so that all the topology
> sibling information is removed on CPU hotplug out.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/include/asm/topology.h |  1 +
>  arch/arm64/kernel/topology.c      | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> index df48212f767b..fb996f454305 100644
> --- a/arch/arm64/include/asm/topology.h
> +++ b/arch/arm64/include/asm/topology.h
> @@ -23,6 +23,7 @@ extern struct cpu_topology cpu_topology[NR_CPUS];
> 
>  void init_cpu_topology(void);
>  void store_cpu_topology(unsigned int cpuid);
> +void remove_cpu_topology(unsigned int cpuid);
>  const struct cpumask *cpu_coregroup_mask(int cpu);
> 
>  #ifdef CONFIG_NUMA
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 6ea3ec49d418..38b102013708 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -322,6 +322,21 @@ static void __init reset_cpu_topology(void)
>  		clear_cpu_topology(cpu, true);
>  }
> 
> +#define cpu_llc_shared_mask(cpu)	(&cpu_topology[cpu].llc_siblings)

Why doesn't this live in topology.h with the other topology masks?

> +void remove_cpu_topology(unsigned int cpu)
> +{
> +	int sibling;
> +
> +	for_each_cpu(sibling, topology_core_cpumask(cpu))
> +		cpumask_clear_cpu(cpu, topology_core_cpumask(sibling));
> +	for_each_cpu(sibling, topology_sibling_cpumask(cpu))
> +		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
> +	for_each_cpu(sibling, cpu_llc_shared_mask(cpu))
> +		cpumask_clear_cpu(cpu, cpu_llc_shared_mask(sibling));
> +
> +	clear_cpu_topology(cpu, false);

If there are only two callers of clear_cpu_topology, I'd be inclined to drop
the boolean parameter (which is always impossible to read) and just inline
the reset code in reset_cpu_topology.

Will
