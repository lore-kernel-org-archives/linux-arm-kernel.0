From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Jan 2018 12:03:10 +0000
Subject: [PATCH 0/7] Fix kpti-enabled kernels for Cavium ThunderX
Message-ID: <1516968197-23206-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Cavium ThunderX suffers from a mysterious hardware erratum where a broadcast
TLBI can lead to I-cache corruption when executing from non-global mappings.
This is somehow resolved for userspace by invalidating the entire I-cache
on context-switch.

  http://lkml.kernel.org/r/56BB848A.6060603 at caviumnetworks.com

With kpti, the kernel always runs with non-global mappings which means that the
I-cache can become corrupted when running at EL1, causing weird crashes and
even attempts to execute user code.

This patch series tries to address this by making the transition from Global to
Non-global mappings a runtime decision after we've brought up all the CPUs. The
requirement for break-before-make in the presence of contiguous mappings make
this horribly complicated, so the page table manipulation runs mostly with the
MMU off and no stack.

I'd value feedback from people lucky enough to own a ThunderX as to whether
this fixes stability problems with their platform when running a kpti-enabled
kernel.

Patches based on for-next/core, which is why I've included Shanker's patch
introducing pre_disable_mmu_workaround as the first in the series (since
this is needed when we disable the MMU in idmap_kpti_install_ng_mappings).

Cheers,

Will

--->8

Marc Zyngier (1):
  arm64: Force KPTI to be disabled on Cavium ThunderX

Shanker Donthineni (1):
  arm64: Add software workaround for Falkor erratum 1041

Will Deacon (5):
  arm64: kpti: Make use of nG dependent on
    arm64_kernel_unmapped_at_el0()
  arm64: mm: Permit transitioning from Global to Non-Global without BBM
  arm64: kpti: Add ->enable callback to remap swapper using nG mappings
  arm64: assembler: Change order of macro arguments in phys_to_ttbr
  arm64: entry: Reword comment about post_ttbr_update_workaround

 Documentation/arm64/silicon-errata.txt  |   1 +
 arch/arm64/Kconfig                      |  12 +-
 arch/arm64/include/asm/assembler.h      |  22 +++-
 arch/arm64/include/asm/kernel-pgtable.h |  12 +-
 arch/arm64/include/asm/pgtable-prot.h   |  30 +++--
 arch/arm64/kernel/cpu-reset.S           |   1 +
 arch/arm64/kernel/cpufeature.c          |  42 ++++++-
 arch/arm64/kernel/efi-entry.S           |   2 +
 arch/arm64/kernel/entry.S               |  12 +-
 arch/arm64/kernel/head.S                |   5 +-
 arch/arm64/kernel/hibernate-asm.S       |   4 +-
 arch/arm64/kernel/relocate_kernel.S     |   1 +
 arch/arm64/kvm/hyp-init.S               |   3 +-
 arch/arm64/mm/mmu.c                     |   4 +
 arch/arm64/mm/proc.S                    | 206 ++++++++++++++++++++++++++++++--
 15 files changed, 302 insertions(+), 55 deletions(-)

-- 
2.1.4
