From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Sun, 22 Jun 2014 22:11:49 -0500
Subject: [PATCH v7 0/9] ARM: VDSO
Message-ID: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide fast userspace implementations of gettimeofday and
clock_gettime on systems that implement the generic timers extension
defined in ARMv7.  This follows the example of arm64 in conception but
significantly differs in some aspects of the implementation (C vs
assembly, mainly).

Clocks supported:
- CLOCK_REALTIME
- CLOCK_MONOTONIC
- CLOCK_REALTIME_COARSE
- CLOCK_MONOTONIC_COARSE

This also provides clock_getres (as arm64 does).

getcpu support is planned but not included at this time.

Note that while the high-precision realtime and monotonic clock
support depends on the generic timers extension, support for
clock_getres and coarse clocks is independent of the timer
implementation and is provided unconditionally.

Run-time tested on OMAP5 and i.MX6, verifying that results obtained
with the vdso are consistent with those obtained from the kernel.  On
OMAP5 I observe a 3- to 4-fold speedup for gettimeofday /
CLOCK_REALTIME, with even better (if less interesting) speedups for
the coarse clock ids and clock_getres.

I've been testing and benchmarking this with some custom test code
which I have hosted here:

https://github.com/nlynch-mentor/vdsotest

If this series is applied to an already-built tree and
CONFIG_VDSO is enabled, an incremental build may fail with:

  fs/binfmt_elf.c: In function 'create_elf_tables':
  fs/binfmt_elf.c:231:35: error: 'AT_SYSINFO_EHDR' undeclared (first use
  in this function)

This can be worked around by removing
arch/arm/include/generated/asm/auxvec.h from the build tree.  I
lean toward attributing this to a Kbuild limitation/bug, but would
appreciate extra scrutiny on the patch "ARM: miscellaneous vdso
infrastructure, preparation" to see if there's anything to correct
there.

Changes since v6:
- Update to 3.16-rc1.
- Remove -lgcc from link step - need to support GCC installations
  without libgcc.
- Force -O2 compilation to prevent GCC from emitting calls to libgcc
  math routines.
- Use custom post-processing to clear the EF_ARM_ABI_FLOAT_SOFT flag
  if set in the ELF header to produce a shared object which is
  architecturally allowed to be used by both soft- and hard-float
  code.
- Consolidate common arch timer code instead of duplicating it.
- Prevent the VDSO from attempting CP15 access on memory-only
  architected timer implementations by renaming the clocksource.

Changes since v5:
- Update to 3.15-rc1.
- Place vdso at a randomized offset above the stack along with the
  sigpage.
- Properly export asm/auxvec.h.
- Split patch into series for ease of review.

Changes since v4:
- Map data page at the beginning of the VMA to prevent orphan
  sections at the end of output invalidating the calculated offset.
- Move checkundef into cmd_vdsold to avoid spurious rebuilds.
- Change vdso_init message to pr_debug.
- Add -fno-stack-protector to cflags.

Changes since v3:
- Update to 3.14-rc6.
- Record vdso base in mm context before installing mapping (for the
  sake of perf_mmap_event).
- Use a more seqcount-like API for critical sections.  Using seqcount
  API directly, however, would leak kernel pointers to userspace when
  lockdep is enabled.
- Trap instead of looping forever in division-by-zero stubs.

Changes since v2:
- Update to 3.14-rc4.
- Make vDSO configurable, depending on AEABI and MMU.
- Defer shifting of nanosecond component of timespec: fixes observed
  1ns inconsistencies for CLOCK_REALTIME, CLOCK_MONOTONIC (see
  45a7905fc48f for arm64 equivalent).
- Force reload of seq_count when spinning: without a memory clobber
  after the load of vdata->seq_count, GCC can generate code like this:
    2f8:   e59c9020        ldr     r9, [ip, #32]
    2fc:   e3190001        tst     r9, #1
    300:   1a000033        bne     3d4 <do_realtime+0x104>
    304:   f57ff05b        dmb     ish
    308:   e59c3034        ldr     r3, [ip, #52]   ; 0x34
    ...
    3d4:   eafffffe        b       3d4 <do_realtime+0x104>
- Build vdso.so with -lgcc: calls to __lshrdi3, __divsi3 sometimes
  emitted (especially with -Os).  Override certain libgcc functions to
  prevent undefined symbols.
- Do not clear PG_reserved on vdso pages.
- Remove unnecessary get_page calls.
- Simplify ELF signature check during init.
- Use volatile for asm syscall fallbacks.
- Check whether vdso_pagelist is initialized in arm_install_vdso.
- Record clocksource mask in data page.
- Reduce code duplication in do_realtime, do_monotonic.
- Reduce calculations performed in critical sections.
- Simplify coarse clock handling.
- Move datapage load to its own assembly routine.
- Tune vdso_data layout and tweak field names.
- Check vdso shared object for undefined symbols during build.

Changes since v1:
- update to 3.14-rc1
- ensure cache coherency for data page
- Document the kernel-to-userspace protocol for vdso data page updates,
  and note that the timekeeping core prevents concurrent updates.
- update wall-to-monotonic fields unconditionally
- move vdso_start, vdso_end declarations to vdso.h
- correctly build and run when CONFIG_ARM_ARCH_TIMER=n
- rearrange linker script to avoid overlapping sections when CONFIG_DEBUGINFO=n
- remove use_syscall checks from coarse clock paths
- crib BUG_INSTR (0xe7f001f2) from asm/bug.h for text fill

Nathan Lynch (9):
  clocksource: arm_arch_timer: change clocksource name if CP15
    unavailable
  clocksource: arm_arch_timer: enable counter access for 32-bit ARM
  ARM: arch_timer: remove unused functions
  arm64: arch_timer: remove unused functions
  ARM: place sigpage at a random offset above stack
  ARM: miscellaneous vdso infrastructure, preparation
  ARM: add vdso user-space code
  ARM: vdso initialization, mapping, and synchronization
  ARM: add CONFIG_VDSO Kconfig and Makefile bits

 arch/arm/include/asm/Kbuild          |   1 -
 arch/arm/include/asm/arch_timer.h    |  25 ---
 arch/arm/include/asm/elf.h           |  11 ++
 arch/arm/include/asm/mmu.h           |   3 +
 arch/arm/include/asm/vdso.h          |  47 +++++
 arch/arm/include/asm/vdso_datapage.h |  60 +++++++
 arch/arm/include/uapi/asm/Kbuild     |   1 +
 arch/arm/include/uapi/asm/auxvec.h   |   7 +
 arch/arm/kernel/Makefile             |   1 +
 arch/arm/kernel/asm-offsets.c        |   5 +
 arch/arm/kernel/process.c            |  56 +++++-
 arch/arm/kernel/vdso.c               | 168 ++++++++++++++++++
 arch/arm/kernel/vdso/.gitignore      |   1 +
 arch/arm/kernel/vdso/Makefile        |  59 +++++++
 arch/arm/kernel/vdso/checkundef.sh   |   9 +
 arch/arm/kernel/vdso/datapage.S      |  15 ++
 arch/arm/kernel/vdso/vdso.S          |  35 ++++
 arch/arm/kernel/vdso/vdso.lds.S      |  88 ++++++++++
 arch/arm/kernel/vdso/vdsomunge.c     | 193 +++++++++++++++++++++
 arch/arm/kernel/vdso/vgettimeofday.c | 320 +++++++++++++++++++++++++++++++++++
 arch/arm/mm/Kconfig                  |  15 ++
 arch/arm64/include/asm/arch_timer.h  |  31 ----
 drivers/clocksource/arm_arch_timer.c |  48 +++++-
 23 files changed, 1134 insertions(+), 65 deletions(-)
 create mode 100644 arch/arm/include/asm/vdso.h
 create mode 100644 arch/arm/include/asm/vdso_datapage.h
 create mode 100644 arch/arm/include/uapi/asm/auxvec.h
 create mode 100644 arch/arm/kernel/vdso.c
 create mode 100644 arch/arm/kernel/vdso/.gitignore
 create mode 100644 arch/arm/kernel/vdso/Makefile
 create mode 100755 arch/arm/kernel/vdso/checkundef.sh
 create mode 100644 arch/arm/kernel/vdso/datapage.S
 create mode 100644 arch/arm/kernel/vdso/vdso.S
 create mode 100644 arch/arm/kernel/vdso/vdso.lds.S
 create mode 100644 arch/arm/kernel/vdso/vdsomunge.c
 create mode 100644 arch/arm/kernel/vdso/vgettimeofday.c

-- 
1.9.3
