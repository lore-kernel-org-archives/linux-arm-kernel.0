From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Fri, 20 Jul 2018 14:32:30 +0100
Subject: [PATCH 0/4] sched/topology: Set SD_ASYM_CPUCAPACITY flag automatically
Message-ID: <1532093554-30504-1-git-send-email-morten.rasmussen@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SD_ASYM_CPUCAPACITY flag has been around for some time now with no code to
actually set it. Android has carried patches to do this out-of-tree in the
meantime. The flag is meant to indicate cpu capacity asymmetry and is set at
the topology level where the sched_domain spans all available cpu capacity in
the system, i.e. all core types are visible, for any cpu in the system.

The flag was merged as being a topology flag meaning that architecture had to
provide the flag explicitly, however when mixed with cpusets splitting the
system into multiple root_domains the flag can't be set without knowledge about
the cpusets. Rather than exposing cpusets to architecture code this patch set
moves the responsibility for setting the flag to generic topology code which is
simpler and make the code architecture agnostic.

Morten Rasmussen (4):
  sched/topology: SD_ASYM_CPUCAPACITY flag detection
  drivers/base/arch_topology: Rebuild sched_domain hierarchy when
    capacities change
  arch/arm64: Rebuild sched_domain hierarchy when cpu capacity changes
  arch/arm: Rebuild sched_domain hierarchy when cpu capacity changes

 arch/arm/include/asm/topology.h   |  3 ++
 arch/arm64/include/asm/topology.h |  3 ++
 drivers/base/arch_topology.c      | 26 +++++++++++++
 include/linux/arch_topology.h     |  1 +
 include/linux/sched/topology.h    |  2 +-
 kernel/sched/topology.c           | 81 ++++++++++++++++++++++++++++++++++++---
 6 files changed, 109 insertions(+), 7 deletions(-)

-- 
2.7.4
