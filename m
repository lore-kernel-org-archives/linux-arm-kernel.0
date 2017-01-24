From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Tue, 24 Jan 2017 12:16:58 +0530
Subject: [PATCH v14 0/6] Enable PMUs in ACPI systems
In-Reply-To: <1485210765-9422-1-git-send-email-jeremy.linton@arm.com>
References: <1485210765-9422-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <CAFpQJXXKf_c6kddG-5ueH50CAr7Q=SEGZSUUtmJootuxc4-cvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

do you have any public git branch to try these patches?

thanks
Ganapat

On Tue, Jan 24, 2017 at 4:02 AM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> This patch expands and reworks the patches published by Mark Salter
> in order to clean up a few of the previous review comments, as well as
> add support for newer CPUs and big/little configurations.
>
> v14:
> - drop rename patch requested for v6
> - Shuffle couple include lines from one patch to a later
>   patch.
>
> v13:
> - Correct int/bool conversion bug in pmu_acpi_init()
>   created during v10 code shuffle
>
> v12:
> - Rebase to 4.10
> - Removed lock in the hotplug path.
>
> v11:
> - Add is_smp() check to read_specific_cpuid() for arch/arm. Update
>   c_show() and various routines in arm_pmu_acpi() to use the macro.
> - Moved the duplicate "generic" pmu detection code into its own
>   patch and hoist it into arm_pmu_device_probe() so it works
>   for DT based systems as well.
>
> v10:
> - Rebase to 4.9
> - Rework the arm_perf_start_cpu changes to support the 4.9 hotplug
>   changes.
> - Remove the call to acpi_register_gsi() from the cpu online code path.
>   Instead the GSI's are registered during the initcall. This changes
>   the error handling a bit because we now try to clean up the
>   previously registered GSIs in a couple important places. This
>   was also a result of the rebase.
> - Dropped the MIDR partnumber usage, its no longer necessary to
>   differentiate by only the partnum, so this helps to clarify the code
>   a bit.
> - Shuffle some code around and rename a few variables.
> - Added a few comments to hopefully clarify some questions people have
>   previously had about unused MADT entries, skipping processing cores
>   with MIDR=0, etc.
>
> v9:
> - Add/cleanup an additional hotplug patch I've had sitting around. This
>   patch brings the ACPI PMU mostly on par with the DT functionality with
>   respect to having CPUs offline during boot. This should help clarify
>   some of the code structuring.
> - Cleanup the list of PMU types early if we fail to allocate memory for an
>   additional pmu type.
>
> v8:
> - Rebase to 4.8rc4
> - Assorted minor comment/hunk placement/etc tweaks per Punit Agrawal
>
> v7:
> - Rebase to 4.8rc3
> - Remove cpu affinity sysfs entry. While providing a CPU mask for
>   ARMv8 PMU's is really helpful in big/little environments, reworking
>   the PMU code to support the cpumask attribute for !arm64 PMUs is out
>   of the scope of this patch set.
> - Fix CPU miscount problem where an alloc failure followed by successfully
>   allocating the structure can result in under counting the CPUs associated
>   with the PMU. This bug was created in v6 with the conversion to a linked
>   list.
> - Remove initial platform device creation code by Mark Salter, and re-squash
>   multiple platform device creation code together with helper routines.
>   Other minor tweakage.
>
> v6:
> - Added cpu affinity sysfs entry
> - Converted pmu_types array, to linked list
> - Restrict use of the armv8_pmu_probe_table to ACPI systems
> - Rename MADT parsing routines in smp.c
> - Convert sysfs PMU name to use index rather than partnum
> - Remove pr_devel statements
> - Other Minor cleanups
> - Add Partial Ack-by Will Deacon
>
> v5:
> - Remove list of CPU types for ACPI systems. We now match a generic
>   event list, and use the PMCIED[01] to select events which exist on
>   the given PMU. This avoids the need to update the kernel every time
>   a new CPU is released.
> - Update the maintainers list to include the new file.
>
> v4:
> - Correct build issues with ARM (!ARM64) kernels.
> - Add ThunderX to list of PMU types.
>
>
> Jeremy Linton (5):
>   arm: arm64: Add routine to determine cpuid of other cpus
>   arm: arm64: pmu: Assign platform PMU CPU affinity
>   arm64: pmu: Detect multiple generic PMUs and append counter
>   arm64: pmu: Detect and enable multiple PMUs in an ACPI system
>   arm: pmu: Add PMU definitions for cores not initially online
>
> Mark Salter (1):
>   arm64: pmu: Cache PMU interrupt numbers from MADT parse
>
>  arch/arm/include/asm/cputype.h   |   4 +
>  arch/arm/kernel/setup.c          |   2 +-
>  arch/arm64/include/asm/cputype.h |   3 +
>  arch/arm64/kernel/perf_event.c   |   2 +-
>  arch/arm64/kernel/smp.c          |   5 +
>  drivers/perf/Kconfig             |   4 +
>  drivers/perf/Makefile            |   1 +
>  drivers/perf/arm_pmu.c           | 103 +++++++++++++--
>  drivers/perf/arm_pmu_acpi.c      | 271 +++++++++++++++++++++++++++++++++++++++
>  include/linux/perf/arm_pmu.h     |  12 ++
>  10 files changed, 393 insertions(+), 14 deletions(-)
>  create mode 100644 drivers/perf/arm_pmu_acpi.c
>
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
