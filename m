From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 24 Nov 2016 13:40:00 +0000
Subject: [PATCH 0/9] arm64: Expose CPUID registers via emulation
Message-ID: <1479994809-9081-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds a new ABI to expose the CPU feature registers
to the user space via emulation of MRS instruction. The system exposes
only a limited set of feature values (See the documentation patch)
from the cpufeature infrastructure. The feature bits that are not
exposed are set to the 'safe value' which implies 'not supported'.

Apart from the selected feature registers, we expose MIDR_EL1 (Main
ID Register). The user should be aware that, reading MIDR_EL1 can be
tricky on a heterogeneous system (just like getcpu()). We export the
value of the current CPU where 'MRS' is executed.

Mark Rutland (2):
  arm64: cpufeature: treat unknown fields as RES0
  arm64: cpufeature: remove explicit RAZ fields

Suzuki K Poulose (7):
  arm64: cpufeature: Cleanup feature bit tables
  arm64: cpufeature: Document the rules of safe value for features
  arm64: cpufeature: Define helpers for sys_reg id
  arm64: Add helper to decode register from instruction
  arm64: cpufeature: Track user visible fields
  arm64: cpufeature: Expose CPUID registers by emulation
  arm64: Documentation - Expose CPU feature registers

 Documentation/arm64/cpu-feature-registers.txt | 198 +++++++++++++++
 arch/arm64/include/asm/cpufeature.h           |  27 +-
 arch/arm64/include/asm/insn.h                 |   2 +
 arch/arm64/include/asm/sysreg.h               |  25 +-
 arch/arm64/include/uapi/asm/hwcap.h           |   1 +
 arch/arm64/kernel/cpufeature.c                | 339 +++++++++++++++++---------
 arch/arm64/kernel/cpuinfo.c                   |   1 +
 arch/arm64/kernel/insn.c                      |  29 +++
 arch/arm64/kernel/traps.c                     |   2 +-
 9 files changed, 503 insertions(+), 121 deletions(-)
 create mode 100644 Documentation/arm64/cpu-feature-registers.txt

-- 
2.7.4
