From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 21 Jan 2013 12:35:58 +0000
Subject: [v3 3/9] ARM: tegra: Use DT /cpu node to detect number of CPU core
In-Reply-To: <1358237598-32413-4-git-send-email-hdoyu@nvidia.com>
References: <1358237598-32413-1-git-send-email-hdoyu@nvidia.com>
 <1358237598-32413-4-git-send-email-hdoyu@nvidia.com>
Message-ID: <20130121123558.GA27211@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 08:13:12AM +0000, Hiroshi Doyu wrote:
> SCU based detection only works with Cortex-A9 MP and it doesn't
> support ones with multiple clusters. The only way to detect number of
> CPU core correctly is with DT /cpu node.
> 
> Tegra SoCs decided to use DT detection as the only way and to not use
> SCU based detection at all. Even if DT /cpu node based detection
> fails, it continues with a single core

Please add missing punctuation, reword the commit log to make it clearer.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> ---
> Based on the discussion:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/140608.html
> 
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> ---
>  arch/arm/mach-tegra/platsmp.c |   15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
> index 6867030..689ee4b 100644
> --- a/arch/arm/mach-tegra/platsmp.c
> +++ b/arch/arm/mach-tegra/platsmp.c
> @@ -177,23 +177,8 @@ done:
>  	return status;
>  }
>  
> -/*
> - * Initialise the CPU possible map early - this describes the CPUs
> - * which may be present or become present in the system.
> - */
>  static void __init tegra_smp_init_cpus(void)
>  {
> -	unsigned int i, ncores = scu_get_core_count(scu_base);
> -
> -	if (ncores > nr_cpu_ids) {
> -		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
> -			ncores, nr_cpu_ids);
> -		ncores = nr_cpu_ids;
> -	}
> -
> -	for (i = 0; i < ncores; i++)
> -		set_cpu_possible(i, true);
> -
>  	set_smp_cross_call(gic_raise_softirq);
>  }
>  

As discussed,

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
