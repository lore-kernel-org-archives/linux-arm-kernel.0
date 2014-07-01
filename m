From: mark.rutland@arm.com (Mark Rutland)
Date: Tue,  1 Jul 2014 16:11:10 +0100
Subject: [PATCH 0/8] arm: perf: cleanups and initial refactoring
Message-ID: <1404227478-9645-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While reorganising the ARM perf backend to provide support for
heterogeneous PMUs in big.LITTLE systems, I encountered a couple of
issues requiring some preparatory work in addition to some opportunities
for general cleanup in the backend. This series consists of those
initial cleanups.

Currently the event mapping code in the ARM perf backend requires
multi-dimensional tables to map from common event encodings to raw
hardware values, where empty slots must be initialised to non-zero
values. The current way of organising this results in very large support
files which we can simplify with some macro use to remove a few hundred
lines and make things more legible.

The PMU naming is somewhat of a mess, with most names not being
supported by the perf tool. Given that no-one has complained, it seems
that the PMUs are not being accessed by name in a perf context, and we
can fix these to be consistent and usable with current tools. We update
the OProfile name mangling to ensure that OProfile (which accesses the
PMUs in its own namespace) are not adversely affected.

To prepare for reorganisation of the PMU probing code, new
platform_device_id values are added to allow ARMv6, ARMv7, and XScale
PMU platform_devices to be distinguished.

Thanks,
Mark.

Mark Rutland (8):
  arm: perf: move event map macros to pmu.h
  arm: perf: add macros for empty event mappings
  arm: perf: armv7: condense event maps
  arm: perf: armv6: condense event maps
  arm: perf: xscale: condense event maps
  arm: perf: clean up PMU names
  arm: perf: add more specific platform device IDs
  arm: perf: krait: stop using singleton PMU

 arch/arm/include/asm/perf_event.h   |   9 -
 arch/arm/include/asm/pmu.h          |  19 +
 arch/arm/kernel/perf_event_cpu.c    |  13 +-
 arch/arm/kernel/perf_event_v6.c     | 307 +++---------
 arch/arm/kernel/perf_event_v7.c     | 967 ++++++++----------------------------
 arch/arm/kernel/perf_event_xscale.c | 121 +----
 arch/arm/oprofile/common.c          |  14 +-
 7 files changed, 349 insertions(+), 1101 deletions(-)

-- 
1.9.1
