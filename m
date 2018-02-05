From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  5 Feb 2018 16:41:54 +0000
Subject: [PATCHv2 0/8] arm_pmu: fix lockdep issues with ACPI systems
Message-ID: <20180205164202.26502-1-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the arm_pmu ACPI code is somewhat dubious. It attempts to
allocate memory and manipulate IRQs in a hotplug callback, which is an
atomic context.

These patches (based on the arm64 for-next/core branch [1]) attempt to
address this by moving work out of hotplug callback, requiring a
reorganisation of the common arm_pmu code.

I've given these a boot-test on a Juno R1 system, both with DT and ACPI.
In either case the PMU works as expected, and lockdep seems happy.

I've pushed the series out to my arm64/acpi-pmu-lockdep branch [2].

Since v1 [3]:
* Kill arm_pmu_platdata (and ux500 IRQ bouncer)
* Make PMU/CPU binding implicit in hotplug notifier
* Explicitly enable/disable SPIs at hogplug
* Add armpmu_alloc_atomic
* Cleanup per Will's comments

Thanks,
Mark.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/core
[2] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/acpi-pmu-lockdep
[3] https://lkml.kernel.org/r/20171101141239.45340-1-mark.rutland at arm.com

Mark Rutland (8):
  ARM: ux500: remove PMU IRQ bouncer
  arm_pmu: kill arm_pmu_platdata
  arm_pmu: fold platform helpers into platform code
  arm_pmu: add armpmu_alloc_atomic()
  arm_pmu: acpi: check for mismatched PPIs
  arm_pmu: explicitly enable/disable SPIs at hotplug
  arm_pmu: note IRQs and PMUs per-cpu
  arm_pmu: acpi: request IRQs up-front

 arch/arm/mach-ux500/cpu-db8500.c |  35 ---------
 drivers/perf/arm_pmu.c           | 149 +++++++++++++++++----------------------
 drivers/perf/arm_pmu_acpi.c      |  61 +++++++++++-----
 drivers/perf/arm_pmu_platform.c  |  37 ++++++++--
 include/linux/perf/arm_pmu.h     |  26 ++-----
 5 files changed, 142 insertions(+), 166 deletions(-)

-- 
2.11.0
