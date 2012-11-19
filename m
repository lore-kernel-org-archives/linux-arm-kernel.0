From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 19 Nov 2012 10:38:34 -0500 (EST)
Subject: [PATCH v4 2/7] ARM: kernel: update topology to use new MPIDR
 macros
In-Reply-To: <1353329106-24084-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1353329106-24084-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1353329106-24084-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <alpine.LFD.2.02.1211191037450.1182@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Nov 2012, Lorenzo Pieralisi wrote:

> This patch updates the topology initialization code to use the newly
> defined accessors to retrieve the MPIDR affinity levels.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/kernel/topology.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index 4642c7d..cba99bd 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -262,19 +262,14 @@ void store_cpu_topology(unsigned int cpuid)
>  
>  		if (mpidr & MPIDR_MT_BITMASK) {
>  			/* core performance interdependency */
> -			cpuid_topo->thread_id = (mpidr >> MPIDR_LEVEL0_SHIFT)
> -				& MPIDR_LEVEL0_MASK;
> -			cpuid_topo->core_id = (mpidr >> MPIDR_LEVEL1_SHIFT)
> -				& MPIDR_LEVEL1_MASK;
> -			cpuid_topo->socket_id = (mpidr >> MPIDR_LEVEL2_SHIFT)
> -				& MPIDR_LEVEL2_MASK;
> +			cpuid_topo->thread_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +			cpuid_topo->core_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +			cpuid_topo->socket_id = MPIDR_AFFINITY_LEVEL(mpidr, 2);
>  		} else {
>  			/* largely independent cores */
>  			cpuid_topo->thread_id = -1;
> -			cpuid_topo->core_id = (mpidr >> MPIDR_LEVEL0_SHIFT)
> -				& MPIDR_LEVEL0_MASK;
> -			cpuid_topo->socket_id = (mpidr >> MPIDR_LEVEL1_SHIFT)
> -				& MPIDR_LEVEL1_MASK;
> +			cpuid_topo->core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +			cpuid_topo->socket_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>  		}
>  	} else {
>  		/*
> -- 
> 1.7.12
> 
> 
