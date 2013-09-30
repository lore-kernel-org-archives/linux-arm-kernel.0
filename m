From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 30 Sep 2013 12:51:33 -0400 (EDT)
Subject: [RFC PATCH 1/3] ARM: mcpm: Factor out logical-to-physical CPU
 translation
In-Reply-To: <1380553607-3271-2-git-send-email-Dave.Martin@arm.com>
References: <1380553607-3271-1-git-send-email-Dave.Martin@arm.com>
 <1380553607-3271-2-git-send-email-Dave.Martin@arm.com>
Message-ID: <alpine.LFD.2.03.1309301250450.6331@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Sep 2013, Dave Martin wrote:

> This patch factors the logical-to-physical CPU translation out of
> mcpm_boot_secondary(), so that it can be reused elsewhere.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
>  arch/arm/common/mcpm_platsmp.c |   17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/common/mcpm_platsmp.c b/arch/arm/common/mcpm_platsmp.c
> index 1bc34c7..c0c3cd7 100644
> --- a/arch/arm/common/mcpm_platsmp.c
> +++ b/arch/arm/common/mcpm_platsmp.c
> @@ -19,14 +19,23 @@
>  #include <asm/smp.h>
>  #include <asm/smp_plat.h>
>  
> +static void cpu_to_pcpu(unsigned int cpu,
> +			unsigned int *pcpu, unsigned int *pcluster)
> +{
> +	unsigned int mpidr;
> +
> +	mpidr = cpu_logical_map(cpu);
> +	*pcpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +	*pcluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +}
> +
>  static int mcpm_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
> -	unsigned int mpidr, pcpu, pcluster, ret;
> +	unsigned int pcpu, pcluster, ret;
>  	extern void secondary_startup(void);
>  
> -	mpidr = cpu_logical_map(cpu);
> -	pcpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> -	pcluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +	cpu_to_pcpu(cpu, &pcpu, &pcluster);
> +
>  	pr_debug("%s: logical CPU %d is physical CPU %d cluster %d\n",
>  		 __func__, cpu, pcpu, pcluster);
>  
> -- 
> 1.7.9.5
> 
