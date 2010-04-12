From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Apr 2010 16:04:15 +0100
Subject: [PATCH 0/6] ARM: oprofile: use perf-events framework as backend [v3]
Message-ID: <1271084661-2305-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is version 3 of the patchset originally posted here:

V1: http://lists.infradead.org/pipermail/linux-arm-kernel/2010-February/010476.html
V2: http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011126.html

Changes since V2:
	- Rebased onto 2.6.34-rc3
	- No longer export perf_event_{enable,disable} functions as this
	  stopped working with 2.6.34-rc1. Instead create/destroy counters
	  between profiling runs. This also prevents OProfile from hogging
	  the PMU lock.
	- Merged in patch from Aaro Koskinen to use platform_device
	  instead of sys_device for OProfile suspend.
	- Fixed XScale PMU interrupt handlers to call perf_sample_data_init.

I've tested this on a quad-core Realview PB11MPCore board and compared the
OProfile results with perf-events. The only scope for confusion is that, by
default, OProfile organises samples by symbol name and so counts may appear
significantly less then those reported by perf stat [which combines the
per-symbol counts into a single overall count].

This patch is intended to be applied on top of 604{4-9}/1 in RMK's incoming
patch queue.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Richter <robert.richter@amd.com>
Cc: Jamie Iles <jamie.iles@picochip.com>
Cc: Jean Pihet <jpihet@mvista.com>

Will Deacon (6):
  ARM: perf-events: use numeric ID to identify PMU
  ARM: perf-events: add support for xscale PMUs
  perf-events: allow modules to query the maximum number of perf events
  ARM: oprofile: use perf-events framework as backend
  ARM: oprofile: remove old files and update KConfig
  ARM: oprofile: convert from sysdev to platform device

 arch/arm/Kconfig                        |   26 +-
 arch/arm/include/asm/perf_event.h       |   14 +
 arch/arm/kernel/perf_event.c            |  864 ++++++++++++++++++++++++++++++-
 arch/arm/oprofile/Makefile              |    7 +-
 arch/arm/oprofile/backtrace.c           |   83 ---
 arch/arm/oprofile/common.c              |  375 +++++++++++---
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
 kernel/perf_event.c                     |    6 +
 18 files changed, 1182 insertions(+), 1870 deletions(-)
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
