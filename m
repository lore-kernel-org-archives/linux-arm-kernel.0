From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Fri, 20 Mar 2015 16:13:19 -0500
Subject: [PATCH v11 0/4] ARM: VDSO
Message-ID: <1426886003-30123-1-git-send-email-nathan_lynch@mentor.com>
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

getcpu support is planned but not included at this time.

For applications to transparently benefit from this change,
ARM-specific support code needs to be added to glibc.  I hope to have
that code added to glibc for the 2.22 release, pending acceptance of
the kernel changes.

The VDSO symbols are available for lookup via dlsym even with an
unpatched glibc.

Here are some tables demonstrating the improvement on one platform
which benefits from the VDSO (OMAP5), and the hopefully acceptable
cost on two platforms lacking the architected timer.  The numbers are
the cost in nanoseconds for a call to gettimeofday via glibc, measured
with a microbenchmark.

| OMAP5           | glibc 2.21 | glibc 2.21 + |
| (Cortex-A15)    |            | vdso support |
|-----------------+------------+--------------|
| v4.0-rc1        |        346 |          351 |
| v4.0-rc1 + vdso |        343 |          118 |


| BeagleBone Black | glibc 2.21 | glibc 2.21 + |
| (Cortex-A8)      |            | vdso support |
|------------------+------------+--------------|
| v4.0-rc1         |        651 |          668 |
| v4.0-rc1 + vdso  |        651 |          661 |


| i.MX6Q          | glibc 2.21 | glibc 2.21 + |
| (Cortex-A9)     |            | vdso support |
|-----------------+------------+--------------|
| v4.0-rc1        |        563 |          579 |
| v4.0-rc1 + vdso |        569 |          584 |


These numbers vary slightly from one run to another (i.MX6Q in
particular seems a little "noisy" with variances of +/-10ns).

I believe this is the minimum overhead (or very close to it) that can
be achieved on systems lacking the arch timer, and it's due to adding
a test and branch to the syscall wrappers in glibc.  Previous versions
of these patches caused glibc to dispatch through the VDSO
unconditionally, imposing up to ~70ns penalty on i.MX6Q.  See patch #3
for how this has been addressed.

I've been verifying and benchmarking this with some custom test code
which I have hosted here:

https://github.com/nlynch-mentor/vdsotest

Unpatched FSF GDB may complain "warning: Could not load shared library
symbols for linux-vdso.so.1."  This is not an ARM-specific issue.
Current Fedora and Debian patch their GDB packages to prevent this
warning.

Changes since v10:
- Update to 4.0-rc1.
- Drop clock_getres support (easy to implement, but no use case).
- User access to virtual counter is always enabled since e1ce5c7adc73
  "clocksource: arm_arch_timer: Enable counter access for 32-bit ARM";
  drop runtime check.
- Zero out gettimeofday/clock_gettime entry points when the
  architected timer is unusable.
- Do not use the generic timer facility when the CPU registers are not
  initialized by firmware (arm,cpu-registers-not-fw-configured).
- Do not service coarse clocks if high-resolution clocks are not
  accelerated.

Changes since v9:
- Update to 3.17-rc5.
- Fixed minor checkpatch warnings (line length etc).
- Removed useless VDSO_LBASE constant.
- Added 'notrace' attributes to VDSO-internal functions.
- Removed unused debug code from vdsomunge host program.

Changes since v8:
- Update to 3.17-rc1.
- Split out arch timer changes into separate series.
- Ensure that VDSO will not attempt to read the counter if access is
  not enabled; this check can be removed after the arch timer changes
  are merged.  See update_vsyscall and vdso_can_use_arch_timer in
  patch #5.

Changes since v7:
- Update to next-20140801.
- In arch_setup_additional_pages, fix call to get_unmapped_area - use
  bytes (not pages) for length argument.
- As x86 does, separate data and text into two VMAs, [vvar] and [vdso]
  respectively.  These have different permissions; [vdso] will allow
  debuggers to set breakpoints, but [vvar] is read-only and cannot be
  modified even via ptrace.
- Use _install_special_mapping for signal page, vvar, and vdso
  mappings.
- Add -DDISABLE_BRANCH_PROFILING.
- Add --no-undefined -Bsymbolic to link options to cause linker to
  error out on unresolved references, making checkundef script
  unnecessary.
- Specify max-page-size, common-page-size in linker options so the
  true alignment is reflected in program header; otherwise gdb gets
  confused.
- Fix incremental build vs. generated auxvec.h.
- Use appropriate unwind directives in __get_datapage.
- Added vdso_install target and help text.  Install build-id symlinks
  as x86 does.
- Adjust update_vsyscall for changes in struct timekeeper.

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


Nathan Lynch (4):
  ARM: miscellaneous vdso infrastructure, preparation
  ARM: add VDSO user-space code
  ARM: VDSO initialization, mapping, and synchronization
  ARM: add CONFIG_VDSO Kconfig and Makefile bits

 arch/arm/Makefile                    |   8 +
 arch/arm/include/asm/Kbuild          |   1 -
 arch/arm/include/asm/auxvec.h        |   1 +
 arch/arm/include/asm/elf.h           |   9 +
 arch/arm/include/asm/mmu.h           |   3 +
 arch/arm/include/asm/vdso.h          |  32 ++++
 arch/arm/include/asm/vdso_datapage.h |  60 +++++++
 arch/arm/include/uapi/asm/Kbuild     |   1 +
 arch/arm/include/uapi/asm/auxvec.h   |   7 +
 arch/arm/kernel/Makefile             |   1 +
 arch/arm/kernel/asm-offsets.c        |   5 +
 arch/arm/kernel/process.c            |  17 +-
 arch/arm/kernel/vdso.c               | 337 +++++++++++++++++++++++++++++++++++
 arch/arm/mm/Kconfig                  |  14 ++
 arch/arm/vdso/.gitignore             |   1 +
 arch/arm/vdso/Makefile               |  74 ++++++++
 arch/arm/vdso/datapage.S             |  15 ++
 arch/arm/vdso/vdso.S                 |  35 ++++
 arch/arm/vdso/vdso.lds.S             |  87 +++++++++
 arch/arm/vdso/vdsomunge.c            | 201 +++++++++++++++++++++
 arch/arm/vdso/vgettimeofday.c        | 282 +++++++++++++++++++++++++++++
 21 files changed, 1187 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/include/asm/auxvec.h
 create mode 100644 arch/arm/include/asm/vdso.h
 create mode 100644 arch/arm/include/asm/vdso_datapage.h
 create mode 100644 arch/arm/include/uapi/asm/auxvec.h
 create mode 100644 arch/arm/kernel/vdso.c
 create mode 100644 arch/arm/vdso/.gitignore
 create mode 100644 arch/arm/vdso/Makefile
 create mode 100644 arch/arm/vdso/datapage.S
 create mode 100644 arch/arm/vdso/vdso.S
 create mode 100644 arch/arm/vdso/vdso.lds.S
 create mode 100644 arch/arm/vdso/vdsomunge.c
 create mode 100644 arch/arm/vdso/vgettimeofday.c

-- 
1.9.3
