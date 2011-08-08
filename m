From: will.deacon@arm.com (Will Deacon)
Date: Mon,  8 Aug 2011 18:16:01 +0100
Subject: [PATCH 00/10] ARM: perf: updates for 3.2
Message-ID: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series contains a number of updates to the ARM PMU and perf
code so that we can support mode exclusion, which is new in debug
architecture 7.1 (as implemented by the Cortex-A15). Some of these
updates also coincide with work to support System PMUs (PMUs that are
not affine to a single CPU) but that is a larger body of work which will
be posted separately at a later date.

The patches do the following:

  1.) Greatly simplify the PMU reservation mechanism so that the
      handling of platform_devices is moved into perf.
  2.) Cleans up the interrupt registration and some of the types used
      to represent events and registers.
  3.) Moves event indexing to start from zero rather than one, making
      the code more readable and also easier to extend for mode
      exclusion.
  4.) Adds support for mode exclusion (user / kernel / hyp) and
      implements this for Cortex-A15.

I've been running these patches since 3.0, so they've been tested on
1176, 11MPCore, Cortex-A5, Cortex-A9 and Cortex-A15 platforms.

Once again, all feedback is welcome.

Will

Cc: Jean Pihet <j-pihet@ti.com>
Cc: Jamie Iles <jamie@jamieiles.com>

Mark Rutland (1):
  ARM: perf: de-const struct arm_pmu

Will Deacon (9):
  ARM: PMU: move CPU PMU platform device handling and init into perf
  ARM: perf: use cpumask_t to record active IRQs
  ARM: perf: use u32 instead of unsigned long for PMNC register
  ARM: perf: use integers for ARMv7 event indices
  ARM: perf: index ARMv7 event counters starting from zero
  ARM: perf: index Xscale and ARMv6 event counters starting from zero
  ARM: perf: index PMU registers from zero
  ARM: perf: allow armpmu to implement mode exclusion
  ARM: perf: add mode exclusion for Cortex-A15 PMU

 arch/arm/include/asm/pmu.h          |   39 +---
 arch/arm/kernel/perf_event.c        |  176 ++++++++++++-------
 arch/arm/kernel/perf_event_v6.c     |   16 +-
 arch/arm/kernel/perf_event_v7.c     |  327 ++++++++++++++++-------------------
 arch/arm/kernel/perf_event_xscale.c |   18 +-
 arch/arm/kernel/pmu.c               |  181 +------------------
 6 files changed, 302 insertions(+), 455 deletions(-)
