From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 6 Dec 2013 16:44:49 +0000
Subject: [PATCH] ARM: mcpm: remove redundant dsb instructions prior to sev
In-Reply-To: <1386347645-16570-1-git-send-email-will.deacon@arm.com>
References: <1386347645-16570-1-git-send-email-will.deacon@arm.com>
Message-ID: <20131206164449.GC4897@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 04:34:05PM +0000, Will Deacon wrote:
> sync_cache_w already includes a dsb, so we can just use sev() directly
> then following a cache-sync.
> 
> Cc: Dave Martin <Dave.Martin@arm.com>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

This makes sense.  I have a feeling the dsb_sev() calls originated
during my original attempt to use dedicated uncached memory for the
synchronisation buffer -- i.e., there was no cache flush.

The extra dsbs do indeed look redundant now.

Acked-by: Dave Martin <Dave.Martin@arm.com>

Cheers
---Dave

> ---
> 
> Hi guys,
> 
> I was auditing our uses of wfe (they're all fine) but noticed these
> extra dsbs in the process.
> 
> Will
> 
>  arch/arm/common/mcpm_entry.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
> index 26020a03f659..74140ed9922f 100644
> --- a/arch/arm/common/mcpm_entry.c
> +++ b/arch/arm/common/mcpm_entry.c
> @@ -167,7 +167,7 @@ void __mcpm_cpu_down(unsigned int cpu, unsigned int cluster)
>  	dmb();
>  	mcpm_sync.clusters[cluster].cpus[cpu].cpu = CPU_DOWN;
>  	sync_cache_w(&mcpm_sync.clusters[cluster].cpus[cpu].cpu);
> -	dsb_sev();
> +	sev();
>  }
>  
>  /*
> @@ -183,7 +183,7 @@ void __mcpm_outbound_leave_critical(unsigned int cluster, int state)
>  	dmb();
>  	mcpm_sync.clusters[cluster].cluster = state;
>  	sync_cache_w(&mcpm_sync.clusters[cluster].cluster);
> -	dsb_sev();
> +	sev();
>  }
>  
>  /*
> -- 
> 1.8.2.2
> 
