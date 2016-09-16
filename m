From: punit.agrawal@arm.com (Punit Agrawal)
Date: Fri, 16 Sep 2016 18:13:09 +0100
Subject: [PATCH v9 00/10] Enable PMUs in ACPI systems
In-Reply-To: <1473892358-22574-1-git-send-email-jeremy.linton@arm.com> (Jeremy
 Linton's message of "Wed, 14 Sep 2016 17:32:28 -0500")
References: <1473892358-22574-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <8760pvu5sq.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

Jeremy Linton <jeremy.linton@arm.com> writes:

> This patch expands and reworks the patches published by Mark Salter
> in order to clean up a few of the previous review comments, as well as
> add support for newer CPUs and big/little configurations.
>
> v9:
> Add/cleanup an additional hotplug patch I've had sitting around. This
> patch brings the ACPI PMU mostly on par with the DT functionality with
> respect to having CPUs offline during boot. This should help clarify
> some of the code structuring.
> Cleanup the list of PMU types early if we fail to allocate memory for an
> additional pmu type.

The earlier patches in the series look OK but there are still
unaddressed comments on Patch 8 from previous versions - coding style,
excessive indentation, complicated logic etc.

Additionally, I'd suggest moving hotplug/unsed MADT related changes out
of Patch 8 to later patches, i.e., add support for hotplug on top.

Thanks,
Punit

>
> v8:
> Rebase to 4.8rc4
> Assorted minor comment/hunk placement/etc tweaks per Punit Agrawal
>
> v7:
> Rebase to 4.8rc3
> Remove cpu affinity sysfs entry. While providing a CPU mask for
> ARMv8 PMU's is really helpful in big/little environments, reworking
> the PMU code to support the cpumask attribute for !arm64 PMUs is out
> of the scope of this patch set.
> Fix CPU miscount problem where an alloc failure followed by successfully
> allocating the structure can result in under counting the CPUs associated
> with the PMU. This bug was created in v6 with the conversion to a linked
> list.
> Remove initial platform device creation code by Mark Salter, and re-squash
> multiple platform device creation code together with helper routines.
> Other minor tweakage.
>
> v6:
> Added cpu affinity sysfs entry
> Converted pmu_types array, to linked list
> Restrict use of the armv8_pmu_probe_table to ACPI systems
> Rename MADT parsing routines in smp.c
> Convert sysfs PMU name to use index rather than partnum
> Remove pr_devel statements
> Other Minor cleanups
> Add Partial Ack-by Will Deacon
>
> v5:
> Remove list of CPU types for ACPI systems. We now match a generic
> event list, and use the PMCIED[01] to select events which exist on
> the given PMU. This avoids the need to update the kernel every time
> a new CPU is released.
> Update the maintainers list to include the new file.
>
> v4:
> Correct build issues with ARM (!ARM64) kernels.
> Add ThunderX to list of PMU types.
>
> v3:
> Enable ARM performance monitoring units on ACPI/arm64 machines.
>
> Jeremy Linton (8):
>   arm64: pmu: Probe default hw/cache counters
>   arm64: pmu: Hoist pmu platform device name
>   arm64: Rename the common MADT parse routine
>   arm: arm64: Add routine to determine cpuid of other cpus
>   arm: arm64: pmu: Assign platform PMU CPU affinity
>   arm64: pmu: Detect and enable multiple PMUs in an ACPI system
>   arm: pmu: Add PMU definitions for hot-plugged CPUs
>   MAINTAINERS: Tweak ARM PMU maintainers
>
> Mark Salter (2):
>   arm64: pmu: add fallback probe table
>   arm64: pmu: Cache PMU interrupt numbers from MADT parse
>
>  MAINTAINERS                      |   3 +-
>  arch/arm/include/asm/cputype.h   |   2 +
>  arch/arm64/include/asm/cputype.h |   3 +
>  arch/arm64/kernel/perf_event.c   |  58 ++++++++-
>  arch/arm64/kernel/smp.c          |  18 ++-
>  drivers/perf/Kconfig             |   4 +
>  drivers/perf/Makefile            |   1 +
>  drivers/perf/arm_pmu.c           | 110 ++++++++++++++--
>  drivers/perf/arm_pmu_acpi.c      | 264 +++++++++++++++++++++++++++++++++++++++
>  include/linux/perf/arm_pmu.h     |  13 ++
>  10 files changed, 452 insertions(+), 24 deletions(-)
>  create mode 100644 drivers/perf/arm_pmu_acpi.c
