From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Jan 2018 11:59:51 +0000
Subject: [PATCH v2 0/9] Fix kpti-enabled kernels for Cavium ThunderX
Message-ID: <1517227200-20412-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is version two of the patches I posted on Friday:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2018-January/556304.html

Changes since v1 include:

  * Use SCTLR_ELx_M instead of open-coded #1
  * Changed section attributes for .idmap.text to reflect actual mappings
  * Rejigged phys_to_pte for consistency with pte_to_phys
  * Added reviewer tags

Cheers,

Will

--->8

Marc Zyngier (1):
  arm64: Force KPTI to be disabled on Cavium ThunderX

Shanker Donthineni (1):
  arm64: Add software workaround for Falkor erratum 1041

Will Deacon (7):
  arm64: kpti: Make use of nG dependent on
    arm64_kernel_unmapped_at_el0()
  arm64: mm: Permit transitioning from Global to Non-Global without BBM
  arm64: kpti: Add ->enable callback to remap swapper using nG mappings
  arm64: assembler: Change order of macro arguments in phys_to_ttbr
  arm64: entry: Reword comment about post_ttbr_update_workaround
  arm64: assembler: Align phys_to_pte with pte_to_phys
  arm64: idmap: Use "awx" flags for .idmap.text .pushsection directives

 Documentation/arm64/silicon-errata.txt  |   1 +
 arch/arm64/Kconfig                      |  12 +-
 arch/arm64/include/asm/assembler.h      |  36 +++++-
 arch/arm64/include/asm/kernel-pgtable.h |  12 +-
 arch/arm64/include/asm/pgtable-prot.h   |  30 +++--
 arch/arm64/kernel/cpu-reset.S           |   3 +-
 arch/arm64/kernel/cpufeature.c          |  42 ++++++-
 arch/arm64/kernel/efi-entry.S           |   2 +
 arch/arm64/kernel/entry.S               |  12 +-
 arch/arm64/kernel/head.S                |  31 +----
 arch/arm64/kernel/hibernate-asm.S       |   4 +-
 arch/arm64/kernel/relocate_kernel.S     |   1 +
 arch/arm64/kernel/sleep.S               |   2 +-
 arch/arm64/kvm/hyp-init.S               |   3 +-
 arch/arm64/mm/mmu.c                     |   4 +
 arch/arm64/mm/proc.S                    | 212 ++++++++++++++++++++++++++++++--
 16 files changed, 324 insertions(+), 83 deletions(-)

-- 
2.1.4
