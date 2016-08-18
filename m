From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 18 Aug 2016 14:10:24 +0100
Subject: [RESEND] [PATCH 0/8] arm64: Work around for mismatched cache line size
Message-ID: <1471525832-21209-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds a work around for systems with mismatched {I,D}-cache
line sizes. When a thread of execution gets migrated to a different CPU,
the cache line size it had cached could be larger than that of the new
CPU. This could cause data corruption issues. We work around this by

 - Dynamically patching the kernel to use the smallest line size on the
   system (from the CPU feature infrastructure)
 - Trapping the userspace access to CTR_EL0 (by clearing SCTLR_EL1.UCT) and
   emulating it with the system wide safe value of CTR.

The series also adds support for alternative code patching of adrp
instructions by adjusting the PC-relative address offset to reflect
the new PC.

The series has been tested on Juno with a hack to forced enabling
of the capability.

Applies on aarch64: for-next/core. The tree is avaiable at :

	git://linux-arm.org/linux-skp.git ctr-emulation

Suzuki K Poulose (8):
  arm64: Set the safe value for L1 icache policy
  arm64: Use consistent naming for errata handling
  arm64: Rearrange CPU errata workaround checks
  arm64: insn: Add helpers for adrp offsets
  arm64: alternative: Add support for patching adrp instructions
  arm64: Introduce raw_{d,i}cache_line_size
  arm64: Refactor sysinstr exception handling
  arm64: Work around systems with mismatched cache line sizes

 arch/arm64/include/asm/assembler.h  | 45 +++++++++++++++++--
 arch/arm64/include/asm/cpufeature.h | 14 +++---
 arch/arm64/include/asm/esr.h        | 56 ++++++++++++++++++++++++
 arch/arm64/include/asm/insn.h       |  4 ++
 arch/arm64/include/asm/sysreg.h     |  1 +
 arch/arm64/kernel/alternative.c     | 13 ++++++
 arch/arm64/kernel/asm-offsets.c     |  2 +
 arch/arm64/kernel/cpu_errata.c      | 26 ++++++++++-
 arch/arm64/kernel/cpufeature.c      | 44 ++++++++++++++-----
 arch/arm64/kernel/cpuinfo.c         |  2 -
 arch/arm64/kernel/hibernate-asm.S   |  2 +-
 arch/arm64/kernel/insn.c            | 13 ++++++
 arch/arm64/kernel/relocate_kernel.S |  2 +-
 arch/arm64/kernel/smp.c             |  8 +++-
 arch/arm64/kernel/traps.c           | 87 ++++++++++++++++++++++++++-----------
 15 files changed, 264 insertions(+), 55 deletions(-)

-- 
2.7.4
