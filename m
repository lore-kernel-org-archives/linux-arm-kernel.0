From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri,  6 Jul 2018 12:02:41 +0100
Subject: [PATCH v3 0/7] arm64: numa/topology/smp: update the cpumasks for CPU
 hotplug
Message-ID: <1530874968-5960-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Commit 37c3ec2d810f ("arm64: topology: divorce MC scheduling domain from core_siblings")
was reported to cause some hotplug and system suspend regressions when
it was merged. On investigation, it was found that unlike x86/PPC,
arm64 doesn't update the cpu and numa masks on CPU hotplug. That's
somewhat expected from the scheduler.

Since these changes were bit invasive as a solution to the above
mentioned regression, as small change was temporarily applied as a fix.
This series updates the cpu and numa masks on CPU hotplug and reverts
that temporary fix.

It would be good to get this tested(CPU hotplug - few and all CPUs in
a socket) on multi-socket/NUMA systems from Cavium and Huawei/Hisilicon.

Regards,
Sudeep

v2->v3:
	- Removed confusing boolean reset argument and inlined reset
	  part in reset_cpu_topology
	- Moved cpu_llc_shared_mask to asm/topology.h along with other
	  similar macros and renamed it topology_llc_cpumask
	- Use NUMA_NO_NODE instead of checking for any -ve integer

v1->v2:
	- Rebased on v4.18-rc1 and hence do revert of the temporary fix
	  that was merged for v4.18
	- Removed one of the wrong use of possible_mask

Sudeep Holla (7):
  arm64: topology: refactor reset_cpu_topology to add support for removing topology
  arm64: numa: separate out updates to percpu nodeid and NUMA node cpumap
  arm64: topology: add support to remove cpu topology sibling masks
  arm64: topology: restrict updating siblings_masks to online cpus only
  arm64: smp: remove cpu and numa topology information when hotplugging out CPU
  arm64: topology: rename llc_siblings to align with other struct members
  arm64: topology: re-introduce numa mask check for scheduler MC selection

 arch/arm64/include/asm/numa.h     |  4 +++
 arch/arm64/include/asm/topology.h |  4 ++-
 arch/arm64/kernel/smp.c           |  5 ++++
 arch/arm64/kernel/topology.c      | 58 +++++++++++++++++++++++++++------------
 arch/arm64/mm/numa.c              | 29 ++++++++++++++------
 5 files changed, 74 insertions(+), 26 deletions(-)

--
2.7.4
