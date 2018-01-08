From: will.deacon@arm.com (Will Deacon)
Date: Mon,  8 Jan 2018 17:32:25 +0000
Subject: [PATCH v3 00/13] arm64 kpti hardening and variant 2 workarounds
Message-ID: <1515432758-26440-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is version three of the patches previously posted here:

  v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2018-January/551838.html
  v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2018-January/552085.html

Changes since v2:

  * Fix typo in comment
  * Include Falkor hardening from Shanker
  * Add ThunderX2 MIDRs (subsequent patches under review)
  * Avoid applying hardening from preemtible context
  * Fix stack offsets in hyp SMC call

Cheers,

Will

--->8

Jayachandran C (1):
  arm64: cputype: Add MIDR values for Cavium ThunderX2 CPUs

Marc Zyngier (3):
  arm64: Move post_ttbr_update_workaround to C code
  arm64: KVM: Use per-CPU vector when BP hardening is enabled
  arm64: KVM: Make PSCI_VERSION a fast path

Shanker Donthineni (1):
  arm64: Implement branch predictor hardening for Falkor

Will Deacon (8):
  arm64: use RET instruction for exiting the trampoline
  arm64: Kconfig: Reword UNMAP_KERNEL_AT_EL0 kconfig entry
  arm64: Take into account ID_AA64PFR0_EL1.CSV3
  arm64: cpufeature: Pass capability structure to ->enable callback
  drivers/firmware: Expose psci_get_version through psci_ops structure
  arm64: Add skeleton to harden the branch predictor against aliasing
    attacks
  arm64: cputype: Add missing MIDR values for Cortex-A72 and Cortex-A75
  arm64: Implement branch predictor hardening for affected Cortex-A CPUs

 arch/arm/include/asm/kvm_mmu.h     |  10 +++
 arch/arm64/Kconfig                 |  30 +++++--
 arch/arm64/include/asm/assembler.h |  13 ---
 arch/arm64/include/asm/cpucaps.h   |   4 +-
 arch/arm64/include/asm/cputype.h   |   7 ++
 arch/arm64/include/asm/kvm_asm.h   |   2 +
 arch/arm64/include/asm/kvm_mmu.h   |  38 +++++++++
 arch/arm64/include/asm/mmu.h       |  37 +++++++++
 arch/arm64/include/asm/sysreg.h    |   2 +
 arch/arm64/kernel/Makefile         |   4 +
 arch/arm64/kernel/bpi.S            |  87 ++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c     | 161 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/cpufeature.c     |  13 ++-
 arch/arm64/kernel/entry.S          |  19 ++++-
 arch/arm64/kvm/hyp/entry.S         |  12 +++
 arch/arm64/kvm/hyp/switch.c        |  25 +++++-
 arch/arm64/mm/context.c            |  11 +++
 arch/arm64/mm/fault.c              |  17 ++++
 arch/arm64/mm/proc.S               |   3 +-
 drivers/firmware/psci.c            |   2 +
 include/linux/psci.h               |   1 +
 virt/kvm/arm/arm.c                 |   8 +-
 22 files changed, 474 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm64/kernel/bpi.S

-- 
2.1.4
