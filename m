From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed,  9 Dec 2015 09:57:11 +0000
Subject: [RFC PATCH v3 0/8] arm64: Verify early CPU features
Message-ID: <1449655039-22022-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for verifying some of the cpufeatures
that are decided early in the boot process based on the boot
CPU and cannot be delayed until all the CPUs are up (e.g, ASIDBits
and may be VHE?). It also adds support for handling the failures
in booting the secondary CPUs which could not be synchronised
with the master CPU, otherwise.

It also adds one of the users of this early hook, check for ASIDBits.
The mm_context id is based on the ASIDBits width supported by the
boot CPU and is used early in the initialisation. So we need to make
sure that all the secondary CPUs supports the width reported by the
booting CPU, failing which we crash the system.

This series has been tested on Juno, Fast model by injecting smaller
ASIDBits and lack of page-size support.

Changes since V2:
 - Add support for synchronising the booting status of a secondary
   CPU. Added RFC Tag. Patch - 4
 - Panic the system with incompatible ASIDBits

Suzuki K. Poulose (8):
  arm64: Introduce cpu_die_early
  arm64: Move cpu_die_early to smp.c
  arm64: head.S : Change register usage
  arm64: Handle early CPU boot failures
  arm64: Enable CPU capability verification unconditionally
  arm64: Add hook for checking early CPU features
  arm64: Add helper for extracting ASIDBits
  arm64: Ensure the secondary CPUs have safe ASIDBits size

 arch/arm64/include/asm/cpufeature.h  |    6 ---
 arch/arm64/include/asm/mmu_context.h |    2 +
 arch/arm64/include/asm/smp.h         |   25 +++++++++++-
 arch/arm64/kernel/asm-offsets.c      |    3 ++
 arch/arm64/kernel/cpufeature.c       |   48 ++++++++--------------
 arch/arm64/kernel/head.S             |   22 ++++++++--
 arch/arm64/kernel/smp.c              |   73 +++++++++++++++++++++++++++++++++-
 arch/arm64/mm/context.c              |   52 ++++++++++++++++++------
 8 files changed, 176 insertions(+), 55 deletions(-)

-- 
1.7.9.5
