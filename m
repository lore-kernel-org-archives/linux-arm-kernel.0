From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 10 Feb 2014 16:22:31 +0000
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <1392037324-5069-1-git-send-email-broonie@kernel.org>
References: <1392037324-5069-1-git-send-email-broonie@kernel.org>
Message-ID: <20140210162230.GK25305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 01:02:01PM +0000, Mark Brown wrote:
> +static void update_siblings_masks(unsigned int cpuid)
> +{
> +	struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
> +	int cpu;
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
> +	smp_wmb();

I now noticed there are a couple of smp_wmb() calls in this patch. What
are they for?

-- 
Catalin
