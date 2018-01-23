From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 23 Jan 2018 12:27:53 +0000
Subject: [PATCH 00/16] arm64: Rework cpu capabilities handling
Message-ID: <20180123122809.16269-1-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series reworks the arm64 CPU capabilities handling (which
manages the system features and errata). The current infrastructure
doesn't allow fine control for handling different features or errata.
There is one rule for features and another rule for errata.

* Features are checked only once, after all the boot time CPUs are
  activated. Any new CPU that is brought up is prevented from booting
  if it misses a feature already established. If the new CPU has a
  feature not enabled already, it is allowed to boot.

* Errata checks are performed on all the CPUs and any new CPU is
  OK to miss the capability. However if a late CPU requires a work around,
  then we fail the CPU.

  This doesn't always apply to some features. e.g, KPTI is a security
  feature which should be applied when at least one CPU needs it. So,
  the tests should be performed on all the booting CPUs individually.
  Also, if a CPU that needs this security feature is brought up later,
  when the system has not enabled it, the CPU can boot making the system
  insecure. Another exception is the hardware DBM for page tables. The
  kernel can safely run with a mix of CPUs that have the feature turned
  on and off. This again causes problem when a new CPU is brought up
  which may not have the feature, which is killed.

  Also there are other features like, GICV3 system register access,
  which now need to be enabled very early based on the boot CPU to
  allow the use of Priority handling to implement NMI.

This calls for finer level of control per capability and the series
implements the same by defining how to deal with a conflict of a
given capability on a CPU with that of the system level state. It
also consolidates the handling of features and errata into generic
helpers. The table of features and errata are left as they are to
allow easier look up for a given type.
We also cleans up the MIDR range handling and cleans up some of the
errata checks where the entries were duplicated for checking different
CPU models. Finally it also implements a work around for Arm Cortex-A55
erratum 1024718 based on the new infrastructure.

Applies on aarch64 for-next/core tree + [0]. The tree is also available
at :
	git://linux-arm.org/linux-skp.git cpu-caps-rework/v1

[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-January/554754.html

Dave Martin (1):
  arm64: capabilities: Update prototype for enable call back

Suzuki K Poulose (15):
  arm64: Move errata work around check on boot CPU
  arm64: Move errata capability processing code
  arm64: capabilities: Prepare for fine grained capabilities
  arm64: Add flags to check the safety of a capability for late CPU
  arm64: capabilities: Unify the verification
  arm64: capabilities: Filter the entries based on a given type
  arm64: capabilities: Group handling of features and errata
  arm64: capabilities: Introduce strict features based on local CPU
  arm64: Make KPTI strict CPU local feature
  arm64: errata: Clean up midr range helpers
  arm64: Add helpers for checking CPU MIDR against a range
  arm64: Add support for checking errata based on a list of MIDRS
  arm64: Add MIDR encoding for Arm Cortex-A55 and Cortex-A35
  arm64: Delay enabling hardware DBM feature
  arm64: Add work around for Arm Cortex-A55 Erratum 1024718

 Documentation/arm64/silicon-errata.txt |   1 +
 arch/arm64/Kconfig                     |  14 ++
 arch/arm64/include/asm/cpucaps.h       |   3 +-
 arch/arm64/include/asm/cpufeature.h    |  89 ++++++++---
 arch/arm64/include/asm/cputype.h       |  42 ++++++
 arch/arm64/include/asm/fpsimd.h        |   4 +-
 arch/arm64/include/asm/processor.h     |   7 +-
 arch/arm64/kernel/cpu_errata.c         | 173 +++++++++------------
 arch/arm64/kernel/cpufeature.c         | 267 +++++++++++++++++++++++++--------
 arch/arm64/kernel/fpsimd.c             |   3 +-
 arch/arm64/kernel/smp.c                |   6 -
 arch/arm64/kernel/traps.c              |   3 +-
 arch/arm64/mm/fault.c                  |   2 +-
 arch/arm64/mm/proc.S                   |   5 +-
 14 files changed, 422 insertions(+), 197 deletions(-)

-- 
2.13.6
