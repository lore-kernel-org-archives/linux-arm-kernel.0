From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  9 Jan 2017 17:28:23 +0000
Subject: [PATCH v4 0/9] arm64: Expose CPUID registers via emulation
Message-ID: <1483982912-27215-1-git-send-email-suzuki.poulose@arm.com>
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

Applies on v4.10-rc3.

Changes since V3:
 - Mark ID_AA64ISAR0_EL1:RDM visible.
 - Improve commentary of the type of feature for safe value computation
 - Fix Documentation for the RES0 fields and minor cleanups
 - Added Reviewed-by tags from the previous version.

Changes since V2:
 - Mark DCZID_EL0 fields visible, as the register is already accessible
   to EL0.
 - Included the sample program to demonstrate the use of the new ABI in
   documentation.
 - Fixed minor coding style issues.

Changes since V1:
  - Drop mask for Op0 in sys_reg()
  - Fix documentation
  - Change safe value of MPIDR to drop MT support
  - Do not emulate AArch32 ID registers


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

 Documentation/arm64/cpu-feature-registers.txt | 240 ++++++++++++++++++
 arch/arm64/include/asm/cpufeature.h           |  26 +-
 arch/arm64/include/asm/insn.h                 |   2 +
 arch/arm64/include/asm/sysreg.h               |  25 +-
 arch/arm64/include/uapi/asm/hwcap.h           |   1 +
 arch/arm64/kernel/cpufeature.c                | 340 +++++++++++++++++---------
 arch/arm64/kernel/cpuinfo.c                   |   1 +
 arch/arm64/kernel/insn.c                      |  29 +++
 arch/arm64/kernel/traps.c                     |   2 +-
 9 files changed, 545 insertions(+), 121 deletions(-)
 create mode 100644 Documentation/arm64/cpu-feature-registers.txt

-- 
2.7.4
