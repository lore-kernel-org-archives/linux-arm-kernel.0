From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 16 Oct 2015 18:06:09 +0100
Subject: [PATCHv4 00/12] arm64: 16K translation granule support
Message-ID: <1445015181-29711-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables the 16K page size support on Linux for arm64.
Adds support for 48bit VA(4 level), 47bit VA(3 level) and
36bit VA(2 level) with 16K. 16K was a late addition to the architecture
and is not implemented by all CPUs. Added a check to ensure the
selected granule size is supported by the CPU, failing which the CPU
won't proceed with booting. Also the kernel page size is added to the
kernel image header (patch from Ard).

KVM support has been dropped from this series, as we need to rewrite the
KVM stage-2 pagetable handling code to get rid of the fake page table
levels (as recommended by Christoffer and Marc). So, with 16K, we cannot
run KVM.

Patches 1-8	cleans up the kernel page size handling code.
Patch 9		Adds a check to ensure the CPU supports the selected granule size.
Patch 10		Adds the page size information to image header.
Patches 11-12	Adds the support for 16K page size

This series applies on top for aarch64:for-next/core with Contiguous bit
support for kernel pagetables.

The tree is also available here:

        git://linux-arm.org/linux-skp.git   	16k/v4-aarch64-4.3-next


This version remains fairly the same with v3, except for some minor changes:

Changes since V3:
  - Fix CONT_SHIFT for 16K (spotted by Jeremy Linton)
  - More comments around the pgtable helper macros
  - Picked up a new patch from Mark to simplify the calculation NR_FIX_BTMAPS
  - Added description for the logic behind FORCE_MAXZONE_ORDER
  - Addressed other review comments
  - Added reviews/acks

Changes since V2:
  - Dropped KVM support patches
  - Added proper comments for the page-table helper macros
  - Change ARM64_HW_PGTABLE_LEVEL_SHIFT() to accept page table level as described
    by ARM ARM.
  - Added reviews/acks
  - Added CONT_SHIFT for 16K

Changes since V1:
  - Rebase to 4.3-rc1
  - Fix vmemmap_populate for 16K (use !ARM64_SWAPPER_USES_SECTION_MAPS)
  - Better description for patch2 (suggested-by: Ard)
  - Add page size information to the image header flags.
  - Added reviewed-by/tested-by Ard.

Ard Biesheuvel (1):
  arm64: Add page size to the kernel image header

Mark Rutland (1):
  arm64: Simplify NR_FIX_BTMAPS calculation

Suzuki K. Poulose (10):
  arm64: Move swapper pagetable definitions
  arm64: Handle section maps for swapper/idmap
  arm64: Introduce helpers for page table levels
  arm64: Calculate size for idmap_pg_dir at compile time
  arm64: Handle 4 level page table for swapper
  arm64: Clean config usages for page size
  arm64: Kconfig: Fix help text about AArch32 support with 64K pages
  arm64: Check for selected granule support
  arm64: Add 16K page size support
  arm64: 36 bit VA

 Documentation/arm64/booting.txt         |    7 ++-
 arch/arm64/Kconfig                      |   54 +++++++++++++++++---
 arch/arm64/Kconfig.debug                |    2 +-
 arch/arm64/include/asm/fixmap.h         |    7 +--
 arch/arm64/include/asm/kernel-pgtable.h |   83 +++++++++++++++++++++++++++++++
 arch/arm64/include/asm/page.h           |   21 ++------
 arch/arm64/include/asm/pgtable-hwdef.h  |   39 +++++++++++++--
 arch/arm64/include/asm/sysreg.h         |   23 +++++++++
 arch/arm64/include/asm/thread_info.h    |    4 +-
 arch/arm64/kernel/head.S                |   59 ++++++++++------------
 arch/arm64/kernel/image.h               |    5 +-
 arch/arm64/kernel/vmlinux.lds.S         |    1 +
 arch/arm64/kvm/Kconfig                  |    3 ++
 arch/arm64/mm/mmu.c                     |   74 ++++++++++++---------------
 arch/arm64/mm/proc.S                    |    4 +-
 15 files changed, 274 insertions(+), 112 deletions(-)
 create mode 100644 arch/arm64/include/asm/kernel-pgtable.h

-- 
1.7.9.5
