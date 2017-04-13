From: c.jayachandran@gmail.com (Jayachandran C.)
Date: Thu, 13 Apr 2017 19:36:45 +0530
Subject: [PATCHv3 13/14] arm64: pmuv3: handle !PMUv3 when probing
In-Reply-To: <1491899997-32210-14-git-send-email-mark.rutland@arm.com>
References: <1491899997-32210-1-git-send-email-mark.rutland@arm.com>
 <1491899997-32210-14-git-send-email-mark.rutland@arm.com>
Message-ID: <CA+7sy7AA+SX_YUNAgCL5tyBXGW+rUidaApN7D2g3O0maRNcKSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 11, 2017 at 2:09 PM, Mark Rutland <mark.rutland@arm.com> wrote:
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
>  arch/arm64/kernel/perf_event.c | 87 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 71 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 57ae9d9..53f2354 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -957,11 +957,26 @@ static int armv8_vulcan_map_event(struct perf_event *event)
>                                 ARMV8_PMU_EVTYPE_EVENT);
>  }
>
> +struct armv8pmu_probe_info {
> +       struct arm_pmu *pmu;
> +       bool present;
> +};
> +
>  static void __armv8pmu_probe_pmu(void *info)
>  {
> -       struct arm_pmu *cpu_pmu = info;
> +       struct armv8pmu_probe_info *probe = info;
> +       struct arm_pmu *cpu_pmu = probe->pmu;
> +       u64 dfr0, pmuver;
>         u32 pmceid[2];
>
> +       dfr0 = read_sysreg(id_aa64dfr0_el1);
> +       pmuver = cpuid_feature_extract_unsigned_field(dfr0,
> +                       ID_AA64DFR0_PMUVER_SHIFT);
> +       if (pmuver != 1)
> +               return;

There is a problem here, the 8.1 spec allows PMUver value 4 for PMUv3
"Performance Monitors extension System registers implemented, PMUv3,
with a 16-bit evtCount field, and if EL2 is implemented, the addition
of the MDCR_EL2.HPMD bit"

On Broadcom Vulcan/Cavium ThunderX2 the value of PMUver is 4 and this
breaks (even the working DT case if I am not mistaken).

JC.
