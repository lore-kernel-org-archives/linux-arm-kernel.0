From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Thu,  8 Sep 2016 15:00:55 +0100
Subject: [RFC PATCH 0/8] arm64: Add a compat vDSO
Message-ID: <20160908140103.7468-1-kevin.brodsky@arm.com>
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
  and T32 variants for both sigreturn and rt_sigreturn.

The first point brings the performance improvement expected of a vDSO,
by implementing time syscalls directly in userspace. The second point
allows us to get rid of the compat vector page, at the expense of the
kuser helpers (this is one reason for not enabling the compat vDSO by
default).

Unfortunately, this time we cannot escape using a 32-bit toolchain. To
build the compat VDSO, CONFIG_COMPAT_VDSO must be set *and*
CROSS_COMPILE_ARM32 must be defined to the prefix of a 32-bit compiler.
Failure to do so will not prevent building the kernel, but a warning
will be printed and the compat vDSO will not be built.

I have only tested the series with a 64-bit userspace (+ 32-bit glibc).
Testing it with a 32-bit userspace would be very welcome.

Thanks,
Kevin

Kevin Brodsky (8):
  arm64: Refactor vDSO setup
  arm64: compat: Add time-related syscall numbers
  arm64: compat: Expose offset to registers in sigframes
  arm64: compat: Add a 32-bit vDSO
  arm64: compat: 32-bit vDSO setup
  arm64: elf: Set AT_SYSINFO_EHDR in compat processes
  arm64: compat: Use vDSO sigreturn trampolines if available
  arm64: Wire up and expose the new compat vDSO

 arch/arm64/Kconfig                       |  20 +++
 arch/arm64/Makefile                      |  20 ++-
 arch/arm64/include/asm/elf.h             |  15 +-
 arch/arm64/include/asm/signal32.h        |  46 +++++
 arch/arm64/include/asm/unistd.h          |   2 +
 arch/arm64/include/asm/vdso.h            |   3 +
 arch/arm64/kernel/Makefile               |   8 +-
 arch/arm64/kernel/asm-offsets.c          |  13 ++
 arch/arm64/kernel/signal32.c             |  61 ++-----
 arch/arm64/kernel/vdso.c                 | 198 ++++++++++++---------
 arch/arm64/kernel/vdso32/Makefile        | 121 +++++++++++++
 arch/arm64/kernel/vdso32/sigreturn.S     |  86 +++++++++
 arch/arm64/kernel/vdso32/vdso.S          |  32 ++++
 arch/arm64/kernel/vdso32/vdso.lds.S      |  98 +++++++++++
 arch/arm64/kernel/vdso32/vgettimeofday.c | 294 +++++++++++++++++++++++++++++++
 15 files changed, 883 insertions(+), 134 deletions(-)
 create mode 100644 arch/arm64/kernel/vdso32/Makefile
 create mode 100644 arch/arm64/kernel/vdso32/sigreturn.S
 create mode 100644 arch/arm64/kernel/vdso32/vdso.S
 create mode 100644 arch/arm64/kernel/vdso32/vdso.lds.S
 create mode 100644 arch/arm64/kernel/vdso32/vgettimeofday.c

-- 
2.9.3
