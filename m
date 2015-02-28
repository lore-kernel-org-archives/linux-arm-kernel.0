From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 27 Feb 2015 16:11:32 -0800
Subject: [PATCH v3 0/3] Scorpion PMU support
Message-ID: <1425082295-10941-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add support for the Scorpion PMU found on devices
such as msm8660, qsd8x50, etc. The first patch is some groundwork
to make functions more "generic". Even then we end up copying quite
a bit of code from the Krait part into the Scorpion part with only
subtle tweaks because two things happen:

 1. We gain another "region" register, L2LPM
 2. The way to access the region registers are with different cp15 instructions

I'm not sure how to make this better, suggestions are welcome. The second
patch is an optimization for an implementation defined register. The 
final patch is the one that actually adds support for Scorpion.

Changes from v2:
 * New patch 2
 * Macros instead of an inline function for patch 1

Changes from v1:
 * Added stub functions for CONFIG_CPU_V7=n
 * Fixed L2LPM register accessors
 * Exposed mp and !mp versions of PMU to userspace differently (mrutland)
 * Dropped I-cache events that shouldn't be there (mrutland)
 * Fixed branch misprediction event (mrutland)

Stephen Boyd (3):
  ARM: perf: Preparatory work for Scorpion PMU support
  ARM: perf: Only reset PMxEVCNTCR registers on reset
  ARM: perf: Add support for Scorpion PMUs

 Documentation/devicetree/bindings/arm/pmu.txt |   2 +
 arch/arm/kernel/perf_event_cpu.c              |   2 +
 arch/arm/kernel/perf_event_v7.c               | 525 +++++++++++++++++++++++---
 3 files changed, 470 insertions(+), 59 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
