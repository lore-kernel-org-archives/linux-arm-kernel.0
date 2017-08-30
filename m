From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 29 Aug 2017 23:16:13 -0400 (EDT)
Subject: [PULL REQUEST v2] FDPIC ELF support for ARM
Message-ID: <nycvar.YSQ.7.76.1708292307400.2606@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, could you please pull the following:

  http://git.linaro.org/people/nicolas.pitre/linux fdpic

This series provides the needed changes to suport the ELF_FDPIC binary
format on ARM. Both MMU and non-MMU systems are supported. This format
has many advantages over the BFLT format used on MMU-less systems, such
as being real ELF that can be parsed by standard tools, can support
shared dynamic libs, etc.

This is based on v4.13-rc4 not to conflict with changes to signal.c
that happened in v4.13-rc3.

A complete toolchain and prebuilt packages can be obtained here:

https://github.com/mickael-guene/fdpic_manifest

Changes from v1:

- Reworked the signal return code to be compatible with a non-executable
  stack.
- Rebased on v4.13-rc4 to pick up latest signal changes.
- Added MMU support.
- Fixed crash in the ELF-FDPIC loader when loading an executable with
  shared libs on a system with an MMU.
- Made the regular ELF loader reject FDPIC binaries.
- Added ACKs and Reviewed-bys.

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
