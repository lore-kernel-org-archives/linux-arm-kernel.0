From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 10 Mar 2017 16:14:57 -0600
Subject: [PATCH 00/14] arm_pmu: ACPI support
In-Reply-To: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
References: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
Message-ID: <5b5dca5f-0ea3-d7e7-63c9-dba57969d4be@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/10/2017 05:04 AM, Mark Rutland wrote:
> Hi,
>
> This series implements ACPI support in the ARM PMU code. It borrows some code
> from Jeremy's series [1], but takes a different approach to probing and
> association, using the usual hotplug state machine, minimising external changes
> required, and simplifying the relationship with the common arm_pmu code.
>
> The first few patches are preparatory cleanup/refactoring, with the latter half
> of the series being specific to ACPI support.
>
> The series is based on my IRQ rework patches [2]. I've pushed the whole series
> out to the arm/perf/acpi branch [3] of my kernel.org repo.
>
> Due to the innards of the hotplug callback framework, it's not entirely
> safe to register a PMU in a hotplug callback. Due to this, we can only
> associated hotplugged CPUs with a PMU if a matching CPU was around at
> probe time. A similar restriction already applies to DT systems. We may
> be able to relax this with some future work.

Which is disappointing, as I thought that was one of Lorenzo's 
complaints about the last patch series.

>
> I've given this some testing on a Juno platform (using SPIs). To see that IRQs
> are correctly associated, I've tested with the following:
>
>   $ taskset -c ${SOME_CPU_HERE} perf record \
>     -e armv8_pmuv3_0/cpu_cycles/ \
>     -e armv8_pmuv3_1/cpu_cycles/ \
>     cat /proc/interrupts
>
> I've also booted with nr_cpus temporarily capped (passing maxcpus=) to test the
> association logic. This has also been tested in a VM using PPIs; I do not have
> access to a host machine which itself uses PPIs.

I tried these patches on a m400 (which uses PPIs), and the kernel fails 
to come up enough to login via the network (which works with 4.11rc1 
without these patches). So, I suspect there is something wrong with 
them. Although its quite possibly PEBCAK.

Given that SPCR/etc is also broken and the kernel itself seems to fail 
if I give it a full earlycon line, I can't pin down whats going on with 
the PMU code until I fix the console.

About the only thing it says with any meaning when earlycon is passed is:
[   10.965147] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[   11.064193] dw-apb-uart APMC0D08:00: cannot get irq

and promptly hangs up.

I'm OOO for the next week, and will debug this further when I return if 
no one else makes any progress.



>
> Thanks,
> Mark.
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/482397.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/492891.html
> [3] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm/perf/acpi
>
> Mark Rutland (14):
>   drivers/perf: arm_pmu: remove pointless PMU disabling
>   drivers/perf: arm_pmu: define armpmu_init_fn
>   drivers/perf: arm_pmu: fold init into alloc
>   drivers/perf: arm_pmu: factor out pmu registration
>   drivers/perf: arm_pmu: simplify cpu_pmu_request_irqs()
>   drivers/perf: arm_pmu: handle no platform_device
>   drivers/perf: arm_pmu: rename irq request/free functions
>   drivers/perf: arm_pmu: split cpu-local irq request/free
>   drivers/perf: arm_pmu: move irq request/free into probe
>   drivers/perf: arm_pmu: split out platform device probe logic
>   arm64: add function to get a cpu's MADT GICC table
>   arm64: kill acpi_set_mailbox_entry()
>   drivers/perf: arm_pmu: add ACPI framework
>   arm64: pmuv3: use arm_pmu ACPI framework
>
>  arch/arm64/include/asm/acpi.h             |   7 +-
>  arch/arm64/kernel/acpi_parking_protocol.c |  38 +--
>  arch/arm64/kernel/perf_event.c            |  26 +-
>  arch/arm64/kernel/smp.c                   |  19 +-
>  drivers/perf/Kconfig                      |   4 +
>  drivers/perf/Makefile                     |   3 +-
>  drivers/perf/arm_pmu.c                    | 383 ++++++++----------------------
>  drivers/perf/arm_pmu_acpi.c               | 237 ++++++++++++++++++
>  drivers/perf/arm_pmu_platform.c           | 235 ++++++++++++++++++
>  include/linux/cpuhotplug.h                |   1 +
>  include/linux/perf/arm_pmu.h              |  22 +-
>  11 files changed, 626 insertions(+), 349 deletions(-)
>  create mode 100644 drivers/perf/arm_pmu_acpi.c
>  create mode 100644 drivers/perf/arm_pmu_platform.c
>
