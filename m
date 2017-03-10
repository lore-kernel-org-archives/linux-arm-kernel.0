From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 10 Mar 2017 10:46:12 +0000
Subject: [PATCHv4 0/3] drivers/perf: arm_pmu: rework IRQ management
Message-ID: <1489142775-11290-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For historical reasons, we lazily request and free interrupts in the
arm_pmu driver, managing affinity at request time. Unfortunately, this
is not well balanced w.r.t. CPU hotplug, resulting in a number of
issues.

This series addresses this by reworking the way we manage interrupts,
splitting request/free from affinity management. This renders some code
redundant, and said code is removed.

I've given this a spin on a Juno R1 system, a Cortex-A9 based system, and
another system which uses PPIs. I've verified that the IRQ affinity is as
expected after CPUs are brought online. I've also run basic perf queries and
the perf fuzzer, both in parallel with random hotplug events.

I've pushed this out to the arm/perf/irq-rework branch [1] of my kernel.org
repo.

Since v1 [2]:
* Free resources correctly.
* Remove unused fields from struct arm_pmu.
* Improve messages when parsing IRQs.

Since v2 [3]:
* Fix broken pdev handling
* Improve probe-time error reporting

Since v3 [4]:
* Rebase to v4.11-rc1

Thanks,
Mark.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm/perf/irq-rework
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/484285.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-February/485610.html
[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-February/487204.html

Mark Rutland (3):
  drivers/perf: arm_pmu: rework per-cpu allocation
  drivers/perf: arm_pmu: manage interrupts per-cpu
  drivers/perf: arm_pmu: split irq request from enable

 drivers/perf/arm_pmu.c       | 487 +++++++++++++++++++++----------------------
 include/linux/perf/arm_pmu.h |   7 +-
 2 files changed, 237 insertions(+), 257 deletions(-)

-- 
1.9.1
