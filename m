From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 24 Apr 2014 15:39:20 +0100
Subject: [PATCH 1/4] arm64: topology: Initialise default topology state
 immediately
In-Reply-To: <1398198078-7473-1-git-send-email-broonie@kernel.org>
References: <1398198078-7473-1-git-send-email-broonie@kernel.org>
Message-ID: <20140424143920.GA8191@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 09:21:15PM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> As a legacy of the way 32 bit ARM did things the topology code uses a null
> topology map by default and then overwrites it by mapping cores with no
> information to a cluster by themselves later. In order to make it simpler
> to reset things as part of recovering from parse failures in firmware
> information directly set this configuration on init. A core will always be
> its own sibling so there should be no risk of confusion with firmware
> provided information.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  arch/arm64/kernel/topology.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 3e06b0be4ec8..ff662b23af5f 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -43,9 +43,6 @@ static void update_siblings_masks(unsigned int cpuid)
>  		 * reset it to default behaviour
>  		 */
>  		pr_debug("CPU%u: No topology information configured\n", cpuid);
> -		cpuid_topo->core_id = 0;
> -		cpumask_set_cpu(cpuid, &cpuid_topo->core_sibling);
> -		cpumask_set_cpu(cpuid, &cpuid_topo->thread_sibling);
>  		return;
>  	}
>  
> @@ -87,9 +84,12 @@ void __init init_cpu_topology(void)
>  		struct cpu_topology *cpu_topo = &cpu_topology[cpu];
>  
>  		cpu_topo->thread_id = -1;
> -		cpu_topo->core_id =  -1;
> +		cpu_topo->core_id = 0;
>  		cpu_topo->cluster_id = -1;
> +
>  		cpumask_clear(&cpu_topo->core_sibling);
> +		cpumask_set_cpu(cpu, &cpu_topo->core_sibling);
>  		cpumask_clear(&cpu_topo->thread_sibling);
> +		cpumask_set_cpu(cpu, &cpu_topo->thread_sibling);
>  	}
>  }

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
