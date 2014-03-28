From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 28 Mar 2014 14:22:25 +0100
Subject: [RFC 0/4] sched: consolidation of cpu_power
Message-ID: <1396012949-6227-1-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Part of this patchset was previously part of the larger tasks packing patchset
[1]. I have splitted the latter in 3 different patchsets (at least) to make the
thing easier.
-configuration of sched_domain topology [2]
-update and consolidation of cpu_power (this patchset)
-tasks packing algorithm

SMT system is no more the only system that can have a CPUs with capacity that
is different from the default value. We need to extend the use of
cpu_power_orig to all kind of platform so the scheduler will have both the
maximum capacity (cpu_power_orig/power_orig) and the current capacity
(cpu_power/power) of CPUs and groups of the sched_domains.
During load balance, the scheduler evaluates the number of tasks that a group
of CPUs can handle. The current method ensures that we will not return more
capacity than number of real cores but it returns wrong value for group of
LITTLE cores and in some situation for SMT system. The proposed solution
computes the ratio between CPUs and cores for a group durint the init sequence
and uses it with power and power_orig to return the current capacity of a
group.

[1] https://lkml.org/lkml/2013/10/18/121
[2] https://lkml.org/lkml/2014/3/19/377

Vincent Guittot (4):
  sched: extend the usage of cpu_power_orig
  ARM: topology: use new cpu_power interface
  sched: fix computed capacity for HMP
  sched: add per group cpu_power_orig

 arch/arm/kernel/topology.c |  4 ++--
 kernel/sched/core.c        |  9 ++++++++-
 kernel/sched/fair.c        | 31 +++++++++++++++++++------------
 kernel/sched/sched.h       |  3 ++-
 4 files changed, 31 insertions(+), 16 deletions(-)

-- 
1.9.0
