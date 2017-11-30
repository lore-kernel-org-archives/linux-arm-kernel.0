From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 Nov 2017 16:39:28 +0000
Subject: [PATCH v2 00/18] arm64: Unmap the kernel whilst running in userspace
 (KAISER)
Message-ID: <1512059986-21325-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again,

This is version two of the patches previously posted here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2017-November/542751.html

Changes since v1 include:

  * Based on v4.15-rc1
  * Trampoline moved into FIXMAP area
  * Explicit static key replaced by cpu cap
  * Disable SPE for userspace profiling if kernel unmapped at EL0
  * Changed polarity of cpu feature to match config option
  * Changed command-line option so we can force on in future if necessary
  * Changed Falkor workaround to invalidate different page within 2MB region
  * Reworked alternative sequences in entry.S, since the NOP slides with
    kaiser=off were measurable

I experimented with leaving the vbar set to point at the kaiser vectors,
but I couldn't measure any performance improvement from that and it made
the code slightly more complicated, so I've left it as-is.

Patches based on 4.15-rc1 and also pushed here:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git kaiser

Feedback welcome, particularly on a better name for the command-line option.

Will

--->8

Will Deacon (18):
  arm64: mm: Use non-global mappings for kernel space
  arm64: mm: Temporarily disable ARM64_SW_TTBR0_PAN
  arm64: mm: Move ASID from TTBR0 to TTBR1
  arm64: mm: Remove pre_ttbr0_update_workaround for Falkor erratum
    #E1003
  arm64: mm: Rename post_ttbr0_update_workaround
  arm64: mm: Fix and re-enable ARM64_SW_TTBR0_PAN
  arm64: mm: Allocate ASIDs in pairs
  arm64: mm: Add arm64_kernel_unmapped_at_el0 helper
  arm64: mm: Invalidate both kernel and user ASIDs when performing TLBI
  arm64: entry: Add exception trampoline page for exceptions from EL0
  arm64: mm: Map entry trampoline into trampoline and kernel page tables
  arm64: entry: Explicitly pass exception level to kernel_ventry macro
  arm64: entry: Hook up entry trampoline to exception vectors
  arm64: erratum: Work around Falkor erratum #E1003 in trampoline code
  arm64: tls: Avoid unconditional zeroing of tpidrro_el0 for native
    tasks
  arm64: entry: Add fake CPU feature for unmapping the kernel at EL0
  arm64: Kconfig: Add CONFIG_UNMAP_KERNEL_AT_EL0
  perf: arm_spe: Disallow userspace profiling when
    arm_kernel_unmapped_at_el0()

 arch/arm64/Kconfig                      |  30 +++--
 arch/arm64/include/asm/asm-uaccess.h    |  25 +++--
 arch/arm64/include/asm/assembler.h      |  27 +----
 arch/arm64/include/asm/cpucaps.h        |   3 +-
 arch/arm64/include/asm/fixmap.h         |   4 +
 arch/arm64/include/asm/kernel-pgtable.h |  12 +-
 arch/arm64/include/asm/mmu.h            |  10 ++
 arch/arm64/include/asm/mmu_context.h    |   9 +-
 arch/arm64/include/asm/pgtable-hwdef.h  |   1 +
 arch/arm64/include/asm/pgtable-prot.h   |  21 +++-
 arch/arm64/include/asm/pgtable.h        |   1 +
 arch/arm64/include/asm/proc-fns.h       |   6 -
 arch/arm64/include/asm/tlbflush.h       |  16 ++-
 arch/arm64/include/asm/uaccess.h        |  21 +++-
 arch/arm64/kernel/asm-offsets.c         |   6 +-
 arch/arm64/kernel/cpufeature.c          |  41 +++++++
 arch/arm64/kernel/entry.S               | 190 +++++++++++++++++++++++++++-----
 arch/arm64/kernel/process.c             |  12 +-
 arch/arm64/kernel/vmlinux.lds.S         |  17 +++
 arch/arm64/lib/clear_user.S             |   2 +-
 arch/arm64/lib/copy_from_user.S         |   2 +-
 arch/arm64/lib/copy_in_user.S           |   2 +-
 arch/arm64/lib/copy_to_user.S           |   2 +-
 arch/arm64/mm/cache.S                   |   2 +-
 arch/arm64/mm/context.c                 |  36 +++---
 arch/arm64/mm/mmu.c                     |  23 ++++
 arch/arm64/mm/proc.S                    |  12 +-
 arch/arm64/xen/hypercall.S              |   2 +-
 drivers/perf/arm_spe_pmu.c              |   7 ++
 29 files changed, 407 insertions(+), 135 deletions(-)

-- 
2.1.4
