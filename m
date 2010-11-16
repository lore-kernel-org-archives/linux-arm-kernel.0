From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Tue, 16 Nov 2010 09:59:43 +0100
Subject: [PATCH 1/5] ARM: perf: consolidate common PMU behaviour
In-Reply-To: <1289842263-21241-2-git-send-email-will.deacon@arm.com>
References: <1289842263-21241-1-git-send-email-will.deacon@arm.com>
	<1289842263-21241-2-git-send-email-will.deacon@arm.com>
Message-ID: <AANLkTi=mu6iG9Yhhtp31g0aDH7+X0i6G8vZiW5FGmV-C@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 15, 2010 at 6:30 PM, Will Deacon <will.deacon@arm.com> wrote:
> The functions for mapping PMU events (perf, cache and raw) are
> common between all PMU types and differ only in the data on which
> they operate.
>
> This patch implements common definitions of these mapping functions
> and changes the arm_pmu struct to hold pointers to the data which
> they require. This is in anticipation of separating out the PMU-specific
> code into separate files.
>
> Cc: Jamie Iles <jamie.iles@picochip.com>
> Cc: Jean Pihet <jean.pihet@newoldbits.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> ?arch/arm/kernel/perf_event.c | ?131 ++++++++++++------------------------------
> ?1 files changed, 38 insertions(+), 93 deletions(-)
>
> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index 07a5035..c49e170 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
...

> @@ -166,6 +165,19 @@ armpmu_map_cache_event(u64 config)
> ?}
>
> ?static int
> +armpmu_map_event(u64 config)
> +{
> + ? ? ? int mapping = (*armpmu->event_map)[config];
> + ? ? ? return mapping == HW_OP_UNSUPPORTED ? -EOPNOTSUPP : mapping;
> +}
> +
> +static int
> +armpmu_map_raw_event(u64 config)
> +{
> + ? ? ? return (int)(config & armpmu->raw_event_mask);
> +}
> +
> +static int
> ?armpmu_event_set_period(struct perf_event *event,
> ? ? ? ? ? ? ? ? ? ? ? ?struct hw_perf_event *hwc,
> ? ? ? ? ? ? ? ? ? ? ? ?int idx)

Those functions could be inlined for performance reason.

Other than that minor remark, I am OK
Acked-by: Jean Pihet <j-pihet@ti.com>

Thanks,
Jean
