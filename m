From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Jan 2017 15:31:16 +0000
Subject: [PATCH 0/3] drivers/perf: arm_pmu: rework IRQ management
Message-ID: <1485790279-3139-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For historical reasons, we lazily request and free interrupts in the
arm_pmu driver, managing affinity at request time. Unfortunately, this
is not well balanced w.r.t. CPU hotplug, resulting in a number of
issues.

This series addresses this by reworking the way we manage interrupts,
splitting request/free from affinity management. This renders some code
redundant, and said code is removed.

I've given this a spin on a Juno R1 system and another system which uses PPIs.
I've verified that the IRQ affinity is as expected after CPUs are brought
online. I've also run basic perf queries and the perf fuzzer, both in parallel
with random hotplug events.

Thanks,
Mark.

Mark Rutland (3):
  drivers/perf: arm_pmu: rework per-cpu allocation
  drivers/perf: arm_pmu: manage interrupts per-cpu
  drivers/perf: arm_pmu: split irq request from enable

 drivers/perf/arm_pmu.c       | 450 ++++++++++++++++++++-----------------------
 include/linux/perf/arm_pmu.h |   4 +-
 2 files changed, 210 insertions(+), 244 deletions(-)

-- 
1.9.1
