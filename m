From: will.deacon@arm.com (Will Deacon)
Date: Fri, 7 Apr 2017 15:29:09 +0100
Subject: [PATCHv2 15/16] arm64: pmuv3: handle !PMUv3 when probing
In-Reply-To: <1491503363-17731-16-git-send-email-mark.rutland@arm.com>
References: <1491503363-17731-1-git-send-email-mark.rutland@arm.com>
 <1491503363-17731-16-git-send-email-mark.rutland@arm.com>
Message-ID: <20170407142908.GO19342@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 06, 2017 at 07:29:22PM +0100, Mark Rutland wrote:
> When probing via ACPI, we won't know up-front whether a CPU has a PMUv3
> compatible PMU. Thus we need to consult ID registers during probe time.
> 
> This patch updates our PMUv3 probing code to test for the presence of
> PMUv3 functionality before touching an PMUv3-specific registers, and
> before updating the struct arm_pmu with PMUv3 data.
> 
> When a PMUv3-compatible PMU is not present, probing will return -ENODEV.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/perf_event.c | 85 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 69 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 57ae9d9..50790d7 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -957,11 +957,24 @@ static int armv8_vulcan_map_event(struct perf_event *event)
>  				ARMV8_PMU_EVTYPE_EVENT);
>  }
>  
> +struct armv8pmu_probe_info {
> +	struct arm_pmu *pmu;
> +	bool present;
> +};
> +
>  static void __armv8pmu_probe_pmu(void *info)
>  {
> -	struct arm_pmu *cpu_pmu = info;
> +	struct armv8pmu_probe_info *probe = info;
> +	struct arm_pmu *cpu_pmu = probe->pmu;
> +	u64 dfr0;
>  	u32 pmceid[2];
>  
> +	dfr0 = read_sysreg(id_aa64dfr0_el1);
> +	if (((dfr0 >> ID_AA64DFR0_PMUVER_SHIFT) & 0xf) != 1)
> +		return;

Shouldn't we be using one of those fancy cpuid_feature_extract_*_field helpers?

It would also be worth spinning this up on qemu, if you get a chance, as
I don't think that implements the PMU.

Will
