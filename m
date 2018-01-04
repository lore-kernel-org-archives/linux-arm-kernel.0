From: will.deacon@arm.com (Will Deacon)
Date: Thu,  4 Jan 2018 15:08:24 +0000
Subject: [PATCH 00/11] arm64 kpti hardening and variant 2 workarounds
Message-ID: <1515078515-13723-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This set of patches builds on top of the arm64 kpti patches[1] queued for
4.16 and further hardens the arm64 Linux kernel against the side-channel
attacks recently published by Google Project Zero.

In particular, the series does the following:

  * Enable kpti by default on arm64, based on the value of ID_AA64PFR0_EL1.CSV3

  * Prevent speculative resteering of the indirect branch in the exception
    trampoline page, which resides at a fixed virtual address to avoid a
    KASLR leak

  * Add hooks to changes of context where the branch predictor could
    theoretically resteer the speculative instruction stream having been trained
    by userspace or a guest OS. These hooks are signal delivery (to prevent
    training the branch predictor on kernel addresses from userspace),
    switch_mm (return to user if SW PAN is enabled) and exit from a guest VM.

  * Implement a dummy PSCI "VERSION" call as the hook for affected Cortex-A
    CPUs. This will invalidate the predictor state with the latest Arm Trusted
    Firmware patches which will appear at [2] and SoC vendors with affected
    CPUs are strongly encouraged to update. We plan to switch to a more
    efficient, special-purpose call when it is available and the PSCI spec
    has been updated accordingly.

I'd like to get this in for 4.16, but that doesn't mean we can't improve
it further once it's merged.

For more information about the impact of this issue and the software migitations
for Arm processors, please see http://www.arm.com/security-update.

Thanks,

Will

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/tag/?h=kpti-base
[2] https://github.com/ARM-software/arm-trusted-firmware/wiki/ARM-Trusted-Firmware-Security-Advisory-TFV-6

--->8

Marc Zyngier (3):
  arm64: Move post_ttbr_update_workaround to C code
  arm64: KVM: Use per-CPU vector when BP hardening is enabled
  arm64: KVM: Make PSCI_VERSION a fast path

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

 arch/arm/include/asm/kvm_mmu.h     |  10 ++++
 arch/arm64/Kconfig                 |  30 +++++++---
 arch/arm64/include/asm/assembler.h |  13 -----
 arch/arm64/include/asm/cpucaps.h   |   3 +-
 arch/arm64/include/asm/cputype.h   |   4 ++
 arch/arm64/include/asm/kvm_mmu.h   |  38 ++++++++++++
 arch/arm64/include/asm/mmu.h       |  37 ++++++++++++
 arch/arm64/include/asm/sysreg.h    |   2 +
 arch/arm64/kernel/Makefile         |   4 ++
 arch/arm64/kernel/bpi.S            |  79 +++++++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c     | 116 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/cpufeature.c     |  12 +++-
 arch/arm64/kernel/entry.S          |   7 ++-
 arch/arm64/kvm/hyp/switch.c        |  15 ++++-
 arch/arm64/mm/context.c            |  11 ++++
 arch/arm64/mm/fault.c              |   1 +
 arch/arm64/mm/proc.S               |   3 +-
 drivers/firmware/psci.c            |   2 +
 include/linux/psci.h               |   1 +
 virt/kvm/arm/arm.c                 |   8 ++-
 20 files changed, 366 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm64/kernel/bpi.S

-- 
2.1.4
