From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Nov 2017 18:21:43 +0000
Subject: [PATCH 00/18] arm64: Unmap the kernel whilst running in userspace
 (KAISER)
Message-ID: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series implements something along the lines of KAISER for arm64:

  https://gruss.cc/files/kaiser.pdf

although I wrote this from scratch because the paper has some funny
assumptions about how the architecture works. There is a patch series
in review for x86, which follows a similar approach:

  http://lkml.kernel.org/r/<20171110193058.BECA7D88@viggo.jf.intel.com>

and the topic was recently covered by LWN (currently subscriber-only):

  https://lwn.net/Articles/738975/

The basic idea is that transitions to and from userspace are proxied
through a trampoline page which is mapped into a separate page table and
can switch the full kernel mapping in and out on exception entry and
exit respectively. This is a valuable defence against various KASLR and
timing attacks, particularly as the trampoline page is at a fixed virtual
address and therefore the kernel text can be randomized independently.

The major consequences of the trampoline are:

  * We can no longer make use of global mappings for kernel space, so
    each task is assigned two ASIDs: one for user mappings and one for
    kernel mappings

  * Our ASID moves into TTBR1 so that we can quickly switch between the
    trampoline and kernel page tables

  * Switching TTBR0 always requires use of the zero page, so we can
    dispense with some of our errata workaround code.

  * entry.S gets more complicated to read

The performance hit from this series isn't as bad as I feared: things
like cyclictest and kernbench seem to be largely unaffected, although
syscall micro-benchmarks appear to show that syscall overhead is roughly
doubled, and this has an impact on things like hackbench which exhibits
a ~10% hit due to its heavy context-switching.

Patches based on 4.14 and also pushed here:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git kaiser

Feedback welcome,

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
  arm64: mm: Add arm64_kernel_mapped_at_el0 helper using static key
  arm64: mm: Invalidate both kernel and user ASIDs when performing TLBI
  arm64: entry: Add exception trampoline page for exceptions from EL0
  arm64: mm: Map entry trampoline into trampoline and kernel page tables
  arm64: entry: Explicitly pass exception level to kernel_ventry macro
  arm64: entry: Hook up entry trampoline to exception vectors
  arm64: erratum: Work around Falkor erratum #E1003 in trampoline code
  arm64: tls: Avoid unconditional zeroing of tpidrro_el0 for native
    tasks
  arm64: entry: Add fake CPU feature for mapping the kernel at EL0
  arm64: makefile: Ensure TEXT_OFFSET doesn't overlap with trampoline
  arm64: Kconfig: Add CONFIG_UNMAP_KERNEL_AT_EL0

 arch/arm64/Kconfig                      |  30 +++--
 arch/arm64/Makefile                     |  18 ++-
 arch/arm64/include/asm/asm-uaccess.h    |  25 ++--
 arch/arm64/include/asm/assembler.h      |  27 +----
 arch/arm64/include/asm/cpucaps.h        |   3 +-
 arch/arm64/include/asm/kernel-pgtable.h |  12 +-
 arch/arm64/include/asm/memory.h         |   1 +
 arch/arm64/include/asm/mmu.h            |  12 ++
 arch/arm64/include/asm/mmu_context.h    |   9 +-
 arch/arm64/include/asm/pgtable-hwdef.h  |   1 +
 arch/arm64/include/asm/pgtable-prot.h   |  21 +++-
 arch/arm64/include/asm/pgtable.h        |   1 +
 arch/arm64/include/asm/proc-fns.h       |   6 -
 arch/arm64/include/asm/tlbflush.h       |  16 ++-
 arch/arm64/include/asm/uaccess.h        |  21 +++-
 arch/arm64/kernel/cpufeature.c          |  11 ++
 arch/arm64/kernel/entry.S               | 195 ++++++++++++++++++++++++++------
 arch/arm64/kernel/process.c             |  12 +-
 arch/arm64/kernel/vmlinux.lds.S         |  17 +++
 arch/arm64/lib/clear_user.S             |   2 +-
 arch/arm64/lib/copy_from_user.S         |   2 +-
 arch/arm64/lib/copy_in_user.S           |   2 +-
 arch/arm64/lib/copy_to_user.S           |   2 +-
 arch/arm64/mm/cache.S                   |   2 +-
 arch/arm64/mm/context.c                 |  36 +++---
 arch/arm64/mm/mmu.c                     |  60 ++++++++++
 arch/arm64/mm/proc.S                    |  12 +-
 arch/arm64/xen/hypercall.S              |   2 +-
 28 files changed, 418 insertions(+), 140 deletions(-)

-- 
2.1.4
