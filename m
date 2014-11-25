From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Nov 2014 13:48:55 +0000
Subject: [PATCH] arm64: topology: Fix handling of multi-level cluster
 MPIDR-based detection
In-Reply-To: <1416530209-16016-1-git-send-email-broonie@kernel.org>
References: <1416530209-16016-1-git-send-email-broonie@kernel.org>
Message-ID: <20141125134854.GA8541@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 12:36:49AM +0000, Mark Brown wrote:
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index b6ee26b..fcb8f7b 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -255,12 +255,15 @@ void store_cpu_topology(unsigned int cpuid)
>  		/* Multiprocessor system : Multi-threads per core */
>  		cpuid_topo->thread_id  = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>  		cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> -		cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 2);
> +		cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 2) |
> +					 MPIDR_AFFINITY_LEVEL(mpidr, 3) << 8;
>  	} else {
>  		/* Multiprocessor system : Single-thread per core */
>  		cpuid_topo->thread_id  = -1;
>  		cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> -		cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +		cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 1) |
> +					 MPIDR_AFFINITY_LEVEL(mpidr, 2) << 8 |
> +					 MPIDR_AFFINITY_LEVEL(mpidr, 3) << 16;
>  	}
>  
>  	pr_debug("CPU%u: cluster %d core %d thread %d mpidr %#016llx\n",

I'll queue this for 3.19, thanks Mark.

Will
