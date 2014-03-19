From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Wed, 19 Mar 2014 17:22:39 +0100
Subject: [PATCH v3 0/6] rework sched_domain topology description
Message-ID: <1395246165-31150-1-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset was previously part of the larger tasks packing patchset [1].
I have splitted the latter in 3 different patchsets (at least) to make the
thing easier.
-configuration of sched_domain topology (this patchset)
-update and consolidation of cpu_power
-tasks packing algorithm

Based on Peter Z's proposal [2][3], this patchset modifies the way to configure
the sched_domain level in order to let architectures to add specific level like
the current BOOK level or the proposed power gating level for ARM architecture.

[1] https://lkml.org/lkml/2013/10/18/121
[2] https://lkml.org/lkml/2013/11/5/239
[3] https://lkml.org/lkml/2013/11/5/449

Change since v2:
- remove patch 1 as it has been already applied to metag tree for v3.15
- updates some commit messages
- add new flag description in TOPOLOGY_SD_FLAGS description

Change since v1:
- move sched_domains_curr_level back under #ifdef CONFIG_NUMA
- use function pointer to set flag instead of a plain value.
- add list of tunable flags in the commit message of patch 2
- add SD_SHARE_POWER_DOMAIN flag for powerpc's SMT level

Vincent Guittot (6):
  sched: rework of sched_domain topology definition
  sched: s390: create a dedicated topology table
  sched: powerpc: create a dedicated topology table
  sched: add a new SD_SHARE_POWERDOMAIN for sched_domain
  sched: ARM: create a dedicated scheduler topology table
  sched: powerpc: Add SD_SHARE_POWERDOMAIN for SMT level

 arch/arm/kernel/topology.c       |  26 +++++
 arch/ia64/include/asm/topology.h |  24 ----
 arch/powerpc/kernel/smp.c        |  31 +++--
 arch/s390/include/asm/topology.h |  13 +--
 arch/s390/kernel/topology.c      |  20 ++++
 arch/tile/include/asm/topology.h |  33 ------
 include/linux/sched.h            |  49 +++++++-
 include/linux/topology.h         | 128 +++-----------------
 kernel/sched/core.c              | 244 ++++++++++++++++++++-------------------
 9 files changed, 255 insertions(+), 313 deletions(-)

-- 
1.9.0
