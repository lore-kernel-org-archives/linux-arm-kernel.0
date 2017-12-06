From: will.deacon@arm.com (Will Deacon)
Date: Wed,  6 Dec 2017 12:35:19 +0000
Subject: [PATCH v3 00/20] arm64: Unmap the kernel whilst running in userspace
 (KPTI)
Message-ID: <1512563739-25239-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everybody,

This is version three of the patches formerly known as KAISER (?).

  v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-November/542751.html
  v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-November/544817.html

Changes since v2 include:

  * Rename command-line option from "kaiser=" to "kpti=" for parity with x86
  * Fixed Falkor erratum workaround (missing '~')
  * Moved vectors base from literal pool into separate data page
  * Added TTBR_ASID_MASK instead of open-coded constants
  * Added missing newline to error message
  * Fail to probe SPE if KPTI is enabled
  * Addressed minor review comments
  * Added tags
  * Based on -rc2

Patches are also pushed here:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git kpti

Feedback and testing welcome. At this point, I'd like to start thinking
about getting this merged for 4.16.

Cheers,

Will

--->8

Will Deacon (20):
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
  perf: arm_spe: Fail device probe when arm64_kernel_unmapped_at_el0()
  arm64: mm: Introduce TTBR_ASID_MASK for getting at the ASID in the
    TTBR
  arm64: kaslr: Put kernel vectors address in separate data page

 arch/arm64/Kconfig                      |  30 +++--
 arch/arm64/include/asm/asm-uaccess.h    |  26 ++--
 arch/arm64/include/asm/assembler.h      |  27 +----
 arch/arm64/include/asm/cpucaps.h        |   3 +-
 arch/arm64/include/asm/fixmap.h         |   5 +
 arch/arm64/include/asm/kernel-pgtable.h |  12 +-
 arch/arm64/include/asm/mmu.h            |  11 ++
 arch/arm64/include/asm/mmu_context.h    |   9 +-
 arch/arm64/include/asm/pgtable-hwdef.h  |   1 +
 arch/arm64/include/asm/pgtable-prot.h   |  21 +++-
 arch/arm64/include/asm/pgtable.h        |   1 +
 arch/arm64/include/asm/proc-fns.h       |   6 -
 arch/arm64/include/asm/tlbflush.h       |  16 ++-
 arch/arm64/include/asm/uaccess.h        |  21 +++-
 arch/arm64/kernel/asm-offsets.c         |   6 +-
 arch/arm64/kernel/cpufeature.c          |  41 +++++++
 arch/arm64/kernel/entry.S               | 203 +++++++++++++++++++++++++++-----
 arch/arm64/kernel/process.c             |  12 +-
 arch/arm64/kernel/vmlinux.lds.S         |  40 ++++++-
 arch/arm64/lib/clear_user.S             |   2 +-
 arch/arm64/lib/copy_from_user.S         |   2 +-
 arch/arm64/lib/copy_in_user.S           |   2 +-
 arch/arm64/lib/copy_to_user.S           |   2 +-
 arch/arm64/mm/cache.S                   |   2 +-
 arch/arm64/mm/context.c                 |  36 +++---
 arch/arm64/mm/mmu.c                     |  31 +++++
 arch/arm64/mm/proc.S                    |  12 +-
 arch/arm64/xen/hypercall.S              |   2 +-
 drivers/perf/arm_spe_pmu.c              |   9 ++
 29 files changed, 454 insertions(+), 137 deletions(-)

-- 
2.1.4
