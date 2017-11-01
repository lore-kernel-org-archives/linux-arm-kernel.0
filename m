From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  1 Nov 2017 14:12:34 +0000
Subject: [PATCH 0/5] arm_pmu: fix lockdep issues with ACPI systems
Message-ID: <20171101141239.45340-1-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the arm_pmu ACPI code is somewhat dubious. It attempts ot
allocate memory any manpiulate IRQs in a hotplug callback, which is an
atomic context.

These patches (based on the arm64 for-next/core branch [1]) attempt to
address this by moving work out of hotplug callback, requiring a
reorganisation of the common arm_pmu code.

I've given these a boot-test on a Juno R1 system, both with DT and ACPI.
In either case the PMU works as expected, and lockdep seems happy.

I've pushed the series out to my arm64/acpi-pmu-lockdep branch [2].

Thanks,
Mark.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/core
[2] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/acpi-pmu-lockdep

Mark Rutland (5):
  arm_pmu: fold platform helpers into platform code
  arm_pmu: have armpmu_alloc() take GFP flags
  arm_pmu: acpi: check for mismatched PPIs
  arm_pmu: note IRQs/PMUs per-cpu
  arm_pmu: acpi: request IRQs up-front

 drivers/perf/arm_pmu.c          | 107 ++++++++++++++--------------------------
 drivers/perf/arm_pmu_acpi.c     |  62 ++++++++++++++++-------
 drivers/perf/arm_pmu_platform.c |  42 +++++++++++++++-
 include/linux/perf/arm_pmu.h    |  20 +++++---
 4 files changed, 137 insertions(+), 94 deletions(-)

-- 
2.11.0
