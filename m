From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Feb 2010 18:56:09 +0000
Subject: [PATCH 0/6] ARM: oprofile: use perf-events framework as backend
Message-ID: <1267124175-21721-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are currently two hardware performance monitoring subsystems in the
kernel for ARM: OProfile and perf-events. This creates the following problems:

1.) Duplicate PMU accessor code. Inevitable code drift may lead to bugs in one
framework that are fixed in the other.

2.) Locking issues. OProfile doesn't reprogram hardware counters between
profiling runs if the events to be monitored have not been changed. This means
that other profiling frameworks cannot use the counters if OProfile is in use.

3.) Due to differences in the two frameworks, it may not be possible to
compare the results obtained by OProfile with those obtained by perf.

This patch series removes the OProfile PMU driver code and replaces it with
calls to perf, therefore resolving the issues mentioned above. To preserve
compatibility with existing OProfile tools, drivers for XScale v1 and v2 PMUs
are added to the perf backend.

The only userspace-visible change is the lack of SCU counter support for
11MPCore. This is currently unsupported by OProfile userspace tools anyway and
therefore shouldn't cause any problems.

Tested on dual-core A9MP [Realview PBX], quad-core 11MPCore [Realview PB11MP]
and XScale PXA270 [Gumstix Verdex XL6P].

Patch taken against 2.6.33 + perf-events patches in Russell's branch:

ARM: 5890/1: Fix incorrect Realview board IRQs for L220 and PMU
ARM: 5899/2: arm: provide a mechanism to reserve performance counters
ARM: 5901/2: arm/oprofile: reserve the PMU when starting
ARM: 5900/2: arm: enable support for software perf events
ARM: 5902/4: arm/perfevents: implement perf event support for ARMv6
ARM: 5903/1: arm/perfevents: add support for ARMv7


Will Deacon (6):
  ARM: perf-events: add Realview PMU IRQs to pmu.c
  ARM: perf-events: use numeric ID to identify PMU
  ARM: perf-events: add support for xscale PMUs
  perf-events: export enable/disable event symbols to kernel modules
  ARM: oprofile: use perf-events framework as backend
  ARM: oprofile: remove old files and update KConfig

 arch/arm/Kconfig                        |   26 +-
 arch/arm/include/asm/perf_event.h       |   12 +
 arch/arm/kernel/perf_event.c            |  862 ++++++++++++++++++++++++++++++-
 arch/arm/kernel/pmu.c                   |   14 +
 arch/arm/oprofile/Makefile              |    7 +-
 arch/arm/oprofile/backtrace.c           |   83 ---
 arch/arm/oprofile/common.c              |  356 +++++++++++--
 arch/arm/oprofile/op_arm_model.h        |   35 --
 arch/arm/oprofile/op_counter.h          |   27 -
 arch/arm/oprofile/op_model_arm11_core.c |  162 ------
 arch/arm/oprofile/op_model_arm11_core.h |   45 --
 arch/arm/oprofile/op_model_mpcore.c     |  306 -----------
 arch/arm/oprofile/op_model_mpcore.h     |   61 ---
 arch/arm/oprofile/op_model_v6.c         |   78 ---
 arch/arm/oprofile/op_model_v7.c         |  415 ---------------
 arch/arm/oprofile/op_model_v7.h         |  103 ----
 arch/arm/oprofile/op_model_xscale.c     |  444 ----------------
 include/linux/perf_event.h              |    1 +
 kernel/perf_event.c                     |    8 +
 19 files changed, 1192 insertions(+), 1853 deletions(-)
 delete mode 100644 arch/arm/oprofile/backtrace.c
 delete mode 100644 arch/arm/oprofile/op_arm_model.h
 delete mode 100644 arch/arm/oprofile/op_counter.h
 delete mode 100644 arch/arm/oprofile/op_model_arm11_core.c
 delete mode 100644 arch/arm/oprofile/op_model_arm11_core.h
 delete mode 100644 arch/arm/oprofile/op_model_mpcore.c
 delete mode 100644 arch/arm/oprofile/op_model_mpcore.h
 delete mode 100644 arch/arm/oprofile/op_model_v6.c
 delete mode 100644 arch/arm/oprofile/op_model_v7.c
 delete mode 100644 arch/arm/oprofile/op_model_v7.h
 delete mode 100644 arch/arm/oprofile/op_model_xscale.c
