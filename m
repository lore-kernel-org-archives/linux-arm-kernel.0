From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 17 Aug 2017 03:23:39 -0400
Subject: [PATCH v2 0/8] ELF-FDPIC support for ARM
Message-ID: <20170817072347.19990-1-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series provides the needed changes to suport the ELF_FDPIC binary
format on ARM. Both MMU and non-MMU systems are supported. This format
has many advantages over the BFLT format used on MMU-less systems, such
as being real ELF that can be parsed by standard tools, can support
shared dynamic libs, etc.

This series is also available in the following git repository:

http://git.linaro.org/people/nicolas.pitre/linux fdpic

A complete toolchain and prebuilt packages can be obtained here:

https://github.com/mickael-guene/fdpic_manifest

Changes from v1:

- Reworked the signal return code to be compatible with a non-executable
  stack.
- Rebased on v4.13-rc3 to pick up latest signal changes.
- Added MMU support.
- Fixed crash in the ELF-FDPIC loader when loading an executable with
  shared libs on a system with an MMU.
- Made the regular ELF loader reject FDPIC binaries.

diffstat:

 arch/arm/include/asm/elf.h         | 16 +++++++--
 arch/arm/include/asm/mmu.h         |  8 +++++
 arch/arm/include/asm/processor.h   | 22 +++++++++----
 arch/arm/include/asm/ucontext.h    |  1 +
 arch/arm/include/uapi/asm/ptrace.h |  4 +++
 arch/arm/include/uapi/asm/unistd.h |  1 +
 arch/arm/kernel/asm-offsets.c      |  4 +++
 arch/arm/kernel/elf.c              | 24 +++++++++++++-
 arch/arm/kernel/signal.c           | 53 +++++++++++++++++++++---------
 arch/arm/kernel/signal.h           | 11 +++++++
 arch/arm/kernel/sigreturn_codes.S  | 56 +++++++++++++++++++++++++++++---
 arch/arm/kernel/traps.c            |  3 ++
 fs/Kconfig.binfmt                  |  4 +--
 fs/binfmt_elf.c                    | 15 +++++++--
 fs/binfmt_elf_fdpic.c              | 13 ++++++--
 15 files changed, 199 insertions(+), 36 deletions(-)
