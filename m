From: john.garry@huawei.com (John Garry)
Date: Mon, 10 Sep 2018 10:02:32 +0100
Subject: [PATCH v2] perf vendor events arm64: Revise core JSON events for
 eMAG
In-Reply-To: <20180910002625.22253-1-seanvk.dev@oregontracks.org>
References: <20180910002625.22253-1-seanvk.dev@oregontracks.org>
Message-ID: <677aea32-d81a-222b-5766-6715f47ba319@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2018 01:26, Sean V Kelley wrote:
> Split the PMU events into meaningful functional groups.  Update core
> pmu events based on supported ARMv8 recommended IMPLEMENTATION DEFINED
> events.
>
> The JSON files are updated with reference to a PMU table shared here:
>
> https://github.com/AmpereComputing/ampere-centos-kernel/blob/amp-centos-7.5-kernel/Documentation/arm64/eMAG-ARM-CoreImpDefined.pdf
>
> --
> Changes in V2:
> - Provided documentation for changes - John, William
> - Broke up into meaningful groups - William
> --
>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: William Cohen <wcohen@redhat.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: linux-arm-kernel at lists.infradead.org
>
> Signed-off-by: Sean V Kelley <seanvk.dev@oregontracks.org>
> ---
>  .../arch/arm64/ampere/emag/branch.json        |  23 +++
>  .../arch/arm64/ampere/emag/bus.json           |  26 +++
>  .../arch/arm64/ampere/emag/cache.json         | 191 ++++++++++++++++++
>  .../arch/arm64/ampere/emag/clock.json         |  20 ++
>  .../arch/arm64/ampere/emag/core-imp-def.json  |  32 ---
>  .../arch/arm64/ampere/emag/counter.json       |   8 +
>  .../arch/arm64/ampere/emag/exception.json     |  50 +++++
>  .../arch/arm64/ampere/emag/instruction.json   |  89 ++++++++
>  .../arch/arm64/ampere/emag/intrinsic.json     |  14 ++
>  .../arch/arm64/ampere/emag/memory.json        |  29 +++
>  .../arch/arm64/ampere/emag/pipeline.json      |  50 +++++
>  11 files changed, 500 insertions(+), 32 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/clock.json
>  delete mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/intrinsic.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/pipeline.json

I don't feel too strongly about this, but it would be better to organise 
all arm64 JSONs into this same structre for consistency?

However I actually like a single per-chip JSON for arm64 since it allows 
easy diff against armv8-recommended.json, so we don't miss/replicate events.


>
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/branch.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/branch.json
> new file mode 100644
> index 000000000000..abc98b018446
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/branch.json
> @@ -0,0 +1,23 @@
> +[
> +    {
> +        "ArchStdEvent": "BR_IMMED_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "BR_RETURN_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "BR_INDIRECT_SPEC",
> +    },
> +    {
> +        "PublicDescription": "Mispredicted or not predicted branch speculatively executed",
> +        "EventCode": "0x10",
> +        "EventName": "BR_MIS_PRED",
> +        "BriefDescription": "Branch mispredicted"

Isn't this a common architectural event, covered by the arm64 kernel 
perf driver?


> +    },
> +    {
> +        "PublicDescription": "Predictable branch speculatively executed",
> +        "EventCode": "0x12",
> +        "EventName": "BR_PRED",
> +        "BriefDescription": "Predictable branch"
> +    },
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/bus.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/bus.json
> new file mode 100644
> index 000000000000..687b2629e1d1
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/bus.json
> @@ -0,0 +1,26 @@
> +[
> +    {
> +        "ArchStdEvent": "BUS_ACCESS_RD",
> +    },
> +    {
> +        "ArchStdEvent": "BUS_ACCESS_WR",
> +    },
> +    {
> +        "ArchStdEvent": "BUS_ACCESS_SHARED",
> +    },
> +    {
> +        "ArchStdEvent": "BUS_ACCESS_NOT_SHARED",
> +    },
> +    {
> +        "ArchStdEvent": "BUS_ACCESS_NORMAL",
> +    },
> +    {
> +        "ArchStdEvent": "BUS_ACCESS_PERIPH",
> +    },
> +    {
> +        "PublicDescription": "Bus access",
> +        "EventCode": "0x19",
> +        "EventName": "BUS_ACCESS",
> +        "BriefDescription": "Bus access"

> +    },
> +]

Thanks,
John
