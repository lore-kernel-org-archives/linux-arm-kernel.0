From: skannan@codeaurora.org (Saravana Kannan)
Date: Thu, 08 Mar 2018 15:59:04 -0800
Subject: [PATCH v11 8/8] perf: ARM DynamIQ Shared Unit PMU support
In-Reply-To: <20180102112533.13640-9-suzuki.poulose@arm.com>
References: <20180102112533.13640-1-suzuki.poulose@arm.com>
 <20180102112533.13640-9-suzuki.poulose@arm.com>
Message-ID: <5AA1CE48.5030203@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/2018 03:25 AM, Suzuki K Poulose wrote:
> Add support for the Cluster PMU part of the ARM DynamIQ Shared Unit (DSU).
> The DSU integrates one or more cores with an L3 memory system, control
> logic, and external interfaces to form a multicore cluster. The PMU
> allows counting the various events related to L3, SCU etc, along with
> providing a cycle counter.
>
> The PMU can be accessed via system registers, which are common
> to the cores in the same cluster. The PMU registers follow the
> semantics of the ARMv8 PMU, mostly, with the exception that
> the counters record the cluster wide events.
>
> This driver is mostly based on the ARMv8 and CCI PMU drivers.
> The driver only supports ARM64 at the moment. It can be extended
> to support ARM32 by providing register accessors like we do in
> arch/arm64/include/arm_dsu_pmu.h.
>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V9:
>   - Rely on cpuhp callback for probing the PMU.
>   - Clear the overflow mask whenever the first CPU is brought up.
>   - Remove dsu_pmu_get_online_cpu(), which is not needed anymore.
>   - Flip the order of context migration and setting the active CPU.
>
> Changes since V8:
>   - Include required header files (Mark Rutland)
>   - Remove Kconfig dependency on PERF_EVENTS (Mark Rutland)
>   - Fix typo in event name, bus_acesss => bus_access (Mark Rutland)
>   - Use find_first_zero_bit instead of find_next_zero_bit (Mark Rutland)
>   - Change order of checks in dsu_pmu_event_init (Mark Rutland)
>   - Allow lazy initialisation of DSU PMU to handle cases where CPUs
>     may be brought up later (e.g, maxcpus=N)- Mark Rutland.
>   - Clear the interrupt overflow status upon initialisation (Mark Rutland)
>   - Change the CPU check to "associated_cpus" from "active_cpus",
>     as when we migrate the perf context we will access the DSU
>     from two different CPUs (source and destination).
>   - Fill in the "module" field for the PMU to prevent the module unload
>     when the PMU is active.
> Changes since V6:
>   - Address comments from Jonathan
>   - Add Reviewed-by tags from Jonathan
> Changes since V5:
>   - Address comments on V5 by Mark.
>   - Use IRQ_NOBALANCING for IRQ handler
>   - Don't expose events which could be unimplemented.
>   - Get rid of dsu_pmu_event_supported and allow raw event
>     code to be used without validating whether it is supported.
>   - Rename "supported_cpus" mask to "associated_cpus"
>   - Add Documentation for the PMU driver
>   - Don't disable IRQ for dsu_pmu_{enable/disable}_counters
>   - Use consistent return codes for validate_event/group calls.
>   - Check PERF_ATTACH_TASK flag in event_init.
>   - Allow missing CPUs in dsu_pmu_dt_get_cpus, to handle cases
>     where kernel could have capped nr_cpus.
>   - Cleanup sanity checking for the CPU before accessing DSU
>   - Reject events with counting CPU not associated with the DSU.
> Changes since V4:
>   - Reflect the changed generic helper for mapping CPU id
> Changes since V2:
>   - Cleanup dsu_pmu_device_probe error handling.
>   - Fix event validate_group to invert the result check of validate_event
>   - Return errors if we failed to parse CPUs in the DSU.
>   - Add MODULE_DEVICE_TABLE entry
>   - Use hlist_entry_safe for converting cpuhp_node to dsu_pmu.
> ---
>   Documentation/perf/arm_dsu_pmu.txt   |  28 ++
>   arch/arm64/include/asm/arm_dsu_pmu.h | 129 ++++++
>   drivers/perf/Kconfig                 |   9 +
>   drivers/perf/Makefile                |   1 +
>   drivers/perf/arm_dsu_pmu.c           | 843 +++++++++++++++++++++++++++++++++++
>   5 files changed, 1010 insertions(+)
>   create mode 100644 Documentation/perf/arm_dsu_pmu.txt
>   create mode 100644 arch/arm64/include/asm/arm_dsu_pmu.h
>   create mode 100644 drivers/perf/arm_dsu_pmu.c
>

Looking at the code, I didn't see any specific handling of cluster power 
collapse. AFAIK, the HW counters do not retain config (what event they 
are counting) or value (the current count) across power collapse. 
Wouldn't you need to register for some kind of PM_ENTER/EXIT notifiers 
to handle that?

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
