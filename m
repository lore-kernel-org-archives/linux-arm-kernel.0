From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 13 Aug 2015 12:33:50 +0100
Subject: [PATCH 00/14] arm64: 16K translation granule support
Message-ID: <1439465645-22584-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

This series enables the 16K page size support on Linux for arm64.
This series adds support for 48bit VA(4 level), 47bit VA(3 level) and
36bit VA(2 level) with 16K. 16K was a late addition to the architecture
and is not implemented by all CPUs. Added a check to ensure the
selected granule size is supported by the CPU, failing which the CPU
won't proceed with booting.

KVM bits have been tested on a fast model with GICv3 using Andre's kvmtool
with gicv3 support[1].

Patches 1-7 cleans up the kernel page size handling code.
Patches 8-11 Fixes some issues with the KVM bits, mainly the fake PGD
             handling code.
Patch 12    Adds a check to ensure the CPU supports the selected granule size.
Patch 13-14 Adds the 16k page size support bits.

This series applies on top of for-next/core branch of the aarch64 tree and is
also available here:

	git://linux-arm.org/linux-skp.git  16k/v1

[1] git://linux-arm.org/kvmtool.git gicv3/v4

TODO:
 1) Testing on a silicon
 2) Analyse the performance of HugePages with 16K (32MB) on a
    silicon.
 3) SMMU driver

Suzuki K. Poulose (14):
  arm64: Move swapper pagetable definitions
  arm64: Handle section maps for swapper/idmap
  arm64: Introduce helpers for page table levels
  arm64: Calculate size for idmap_pg_dir at compile time
  arm64: Handle 4 level page table for swapper
  arm64: Clean config usages for page size
  arm64: Kconfig: Fix help text about AArch32 support with 64K pages
  arm64: kvm: Fix {V}TCR_EL2_TG0 mask
  arm64: Cleanup VTCR_EL2 computation
  arm: kvm: Move fake PGD handling to arch specific files
  arm64: kvm: Rewrite fake pgd handling
  arm64: Check for selected granule support
  arm64: Add 16K page size support
  arm64: 36 bit VA

 arch/arm/include/asm/kvm_mmu.h          |    7 ++
 arch/arm/kvm/mmu.c                      |   44 ++--------
 arch/arm64/Kconfig                      |   37 +++++++--
 arch/arm64/Kconfig.debug                |    2 +-
 arch/arm64/include/asm/boot.h           |    1 +
 arch/arm64/include/asm/fixmap.h         |    4 +-
 arch/arm64/include/asm/kernel-pgtable.h |   77 ++++++++++++++++++
 arch/arm64/include/asm/kvm_arm.h        |   29 +++++--
 arch/arm64/include/asm/kvm_mmu.h        |  135 +++++++++++++++++++++----------
 arch/arm64/include/asm/page.h           |   20 +----
 arch/arm64/include/asm/pgtable-hwdef.h  |   15 +++-
 arch/arm64/include/asm/sysreg.h         |    8 ++
 arch/arm64/include/asm/thread_info.h    |    4 +-
 arch/arm64/kernel/head.S                |   71 +++++++++-------
 arch/arm64/kernel/vmlinux.lds.S         |    1 +
 arch/arm64/mm/mmu.c                     |   70 +++++++---------
 arch/arm64/mm/proc.S                    |    4 +-
 17 files changed, 337 insertions(+), 192 deletions(-)
 create mode 100644 arch/arm64/include/asm/kernel-pgtable.h

-- 
1.7.9.5
