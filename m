From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Tue,  6 Dec 2016 16:03:42 +0000
Subject: [RFC PATCH v3 00/11] arm64: Add a compat vDSO
Message-ID: <20161206160353.14581-1-kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds support for a compat (AArch32) vDSO, providing two
userspace functionalities to compat processes:

* "Virtual" time syscalls (gettimeofday and clock_gettime). The
  implementation is an adaptation of the arm vDSO (vgettimeofday.c),
  sharing the data page with the 64-bit vDSO.

* sigreturn trampolines, following the example of the 64-bit vDSO
  (sigreturn.S), but slightly more complicated because we provide A32
  and T32 variants for both sigreturn and rt_sigreturn, and appropriate
  arm-specific unwinding directives.

The first point brings the performance improvement expected of a vDSO,
by implementing time syscalls directly in userspace. The second point
allows to provide unwinding information for sigreturn trampolines,
achieving feature parity with the trampolines provided by glibc.

Unfortunately, this time we cannot escape using a 32-bit toolchain. To
build the compat VDSO, CONFIG_COMPAT_VDSO must be set *and*
CROSS_COMPILE_ARM32 must be defined to the prefix of a 32-bit compiler.
Failure to do so will not prevent building the kernel, but a warning
will be printed and the compat vDSO will not be built.

v3 is a major refactor of the series. The main change is that the kuser
helpers are no longer mutually exclusive with the 32-bit vDSO, and can
be disabled independently of the 32-bit vDSO (they are kept enabled by
default). To this end, the "old" sigreturn trampolines have been moved
out of the [vectors] page into an independent [sigreturn] page, similar
to [sigpage] on arm. The [vectors] page is now [kuserhelpers], and its
presence is controlled by CONFIG_KUSER_HELPERS. The [sigreturn] page is
only present when the 32-bit vDSO is not included (the latter provides
its own sigreturn trampolines with unwinding information). The following
table summarises which pages are now added in 32-bit processes:

+----------------+----------------+----------------+
|     CONFIG     | !VDSO32        | VDSO32         |
+----------------+----------------+----------------+
| !KUSER_HELPERS | [sigreturn]    | [vvar]         |
|                |                | [vdso]         |
+----------------+----------------+----------------+
| KUSER_HELPERS  | [sigreturn]    | [vvar]         |
|                | [kuserhelpers] | [vdso]         |
|                |                | [kuserhelpers] |
+----------------+----------------+----------------+

Additionally, the 32-bit vDSO no longer requires a 32-bit compiler
supporting ARMv8, any compiler supporting ARMv7-A can now be used. The
only code change is to introduce separate AArch32 barriers, to stop
generating dmb ishld when using an ARMv7 assembler. However, a major
rework of the 32-bit vDSO Makefile was necessary, because mismatching
32/64-bit compiler versions prevent sharing flags (e.g.  recently
introduced warning flags). Copy/pasting flags is not nice or beautiful,
but filtering out flags is not practicable and may break when top-level
Makefiles are changed.

Patches overview:
*  1..3: split [vectors] -> [sigreturn] + [kuserhelpers], add
         CONFIG_KUSER_HELPERS
*  4..6: preparation patches
*     7: the 32-bit vDSO itself
* 8..10: plumbing for the 32-bit vDSO
*    11: Kconfig/Makefile wiring

Thanks,
Kevin

Changelog v2..v3:
* kuser helpers / sigreturn split.
* Rework/debug of the sigreturn trampolines in the 32-bit vDSO. The CFI
  directives have been removed, as they only provide debug information
  on arm (which is stripped from vdso.so). After adding a missing nop,
  unwinding now works properly with all the trampolines (see comment in
  patch 7).
* Some cleanup in vdso.c, to make the 32-bit and 64-bit setup more
  consistent.
* 32-bit vDSO Makefile refactor.
* AArch32 barriers, selected by the 32-bit compiler mode
  (armv7-a/armv8-a).
* Use PROVIDE_HIDDEN() instead of HIDDEN() in vdso32/vdso.lds.S, as
  HIDDEN() only exists since ld 2.23.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nathan Lynch <nathan_lynch@mentor.com>
Cc: Christopher Covington <cov@codeaurora.org>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: Jisheng Zhang <jszhang@marvell.com>

Kevin Brodsky (11):
  arm64: compat: Remove leftover variable declaration
  arm64: compat: Split the sigreturn trampolines and kuser helpers
  arm64: compat: Add CONFIG_KUSER_HELPERS
  arm64: Refactor vDSO init/setup
  arm64: compat: Add time-related syscall numbers
  arm64: compat: Expose offset to registers in sigframes
  arm64: compat: Add a 32-bit vDSO
  arm64: compat: 32-bit vDSO setup
  arm64: elf: Set AT_SYSINFO_EHDR in compat processes
  arm64: compat: Use vDSO sigreturn trampolines if available
  arm64: Wire up and expose the new compat vDSO

 arch/arm64/Kconfig                         |  52 +++++
 arch/arm64/Makefile                        |  28 ++-
 arch/arm64/include/asm/elf.h               |  15 +-
 arch/arm64/include/asm/processor.h         |   4 +-
 arch/arm64/include/asm/signal32.h          |  46 ++++-
 arch/arm64/include/asm/unistd.h            |   2 +
 arch/arm64/include/asm/vdso.h              |   3 +
 arch/arm64/kernel/Makefile                 |   9 +-
 arch/arm64/kernel/asm-offsets.c            |  13 ++
 arch/arm64/kernel/kuser32.S                |  48 +----
 arch/arm64/kernel/signal32.c               |  66 ++----
 arch/arm64/kernel/sigreturn32.S            |  59 ++++++
 arch/arm64/kernel/vdso.c                   | 315 ++++++++++++++++++++---------
 arch/arm64/kernel/vdso32/Makefile          | 166 +++++++++++++++
 arch/arm64/kernel/vdso32/aarch32-barrier.h |  33 +++
 arch/arm64/kernel/vdso32/sigreturn.S       |  76 +++++++
 arch/arm64/kernel/vdso32/vdso.S            |  32 +++
 arch/arm64/kernel/vdso32/vdso.lds.S        |  93 +++++++++
 arch/arm64/kernel/vdso32/vgettimeofday.c   | 295 +++++++++++++++++++++++++++
 19 files changed, 1147 insertions(+), 208 deletions(-)
 create mode 100644 arch/arm64/kernel/sigreturn32.S
 create mode 100644 arch/arm64/kernel/vdso32/Makefile
 create mode 100644 arch/arm64/kernel/vdso32/aarch32-barrier.h
 create mode 100644 arch/arm64/kernel/vdso32/sigreturn.S
 create mode 100644 arch/arm64/kernel/vdso32/vdso.S
 create mode 100644 arch/arm64/kernel/vdso32/vdso.lds.S
 create mode 100644 arch/arm64/kernel/vdso32/vgettimeofday.c

-- 
2.10.2
