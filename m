From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Apr 2017 15:05:39 +0100
Subject: [PATCH] arm64: pmuv3: handle pmuv3+
In-Reply-To: <1493118530-5314-1-git-send-email-mark.rutland@arm.com>
References: <1493118530-5314-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20170425140538.GO24484@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 12:08:50PM +0100, Mark Rutland wrote:
> Commit f1b36dcb5c316c27 ("arm64: pmuv3: handle !PMUv3 when probing") is
> a little too restrictive, and prevents the use of of backwards
> compatible PMUv3 extenstions, which have a PMUver value other than 1.
> 
> For instance, ARMv8.1 PMU extensions (as implemented by ThunderX2) are
> reported with PMUver value 4.
> 
> Per the usual ID register principles, at least 0x1-0x7 imply a
> PMUv3-compatible PMU. It's not currently clear whether 0x8-0xe imply the
> same.
> 
> For the time being, treat the value as signed, and with 0x1-0x7 treated
> as meaning PMUv3 is implemented. This may be relaxed by future patches.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reported-by: Jayachandran C <jnair@caviumnetworks.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/perf_event.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

> Will, would you be happy to queue this fixup for v4.12?

Catalin: please can you pick this up via arm64 with my Ack and
Jayachandran's tested-by?

Will

> 
> Thanks,
> Mark.
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 98c7493..5f64d19 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -966,13 +966,14 @@ static void __armv8pmu_probe_pmu(void *info)
>  {
>  	struct armv8pmu_probe_info *probe = info;
>  	struct arm_pmu *cpu_pmu = probe->pmu;
> -	u64 dfr0, pmuver;
> +	u64 dfr0;
>  	u32 pmceid[2];
> +	int pmuver;
>  
>  	dfr0 = read_sysreg(id_aa64dfr0_el1);
> -	pmuver = cpuid_feature_extract_unsigned_field(dfr0,
> +	pmuver = cpuid_feature_extract_signed_field(dfr0,
>  			ID_AA64DFR0_PMUVER_SHIFT);
> -	if (pmuver != 1)
> +	if (pmuver < 1)
>  		return;
>  
>  	probe->present = true;
> -- 
> 1.9.1
> 
