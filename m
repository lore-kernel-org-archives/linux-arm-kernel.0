From: matthew.leach@arm.com (Matthew Leach)
Date: Fri, 11 Oct 2013 14:52:06 +0100
Subject: [PATCH 00/14] AArch64 BE Support
Message-ID: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds big-endian support to the arm64 kernel. It has
been tested successfully with LTP on both AArch32 and AArch64
userspace configurations. There were no regressions reported over a
little-endian system.

The first patch (from Mark Rutland) clarifies the booting
requirements, which is needed for a big-endian kernel boot. The bulk
of the patches fix up issues in the architectural port, with the last
patch fixing an endianness assumption in the smc91x network driver.

Whilst there is another series of BE patches currently on the list:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/204031.html

we believe that our work is both more complete and has been subjected
to substantial testing effort.

All comments welcome,

Matt

Mark Rutland (1):
  Docs: arm64: booting: clarify boot requirements

Matthew Leach (6):
  arm64: compat: correct register concatenation for syscall wrappers
  arm64: big-endian: don't treat code as data when copying sigret code
  arm64: asm: add CPU_LE & CPU_BE assembler helpers
  arm64: head: create a new function for setting the boot_cpu_mode flag
  arm64: big-endian: set correct endianess on kernel entry
  arm64: big-endian: write CPU holding pen address as LE

Will Deacon (7):
  arm64: big-endian: add big-endian support to top-level arch Makefile
  arm64: big-endian: fix byteorder include
  arm64: ELF: add support for big-endian executables
  arm64: setup: report ELF_PLATFORM as the machine for utsname
  arm64: compat: add support for big-endian (BE8) AArch32 binaries
  arm64: kconfig: allow CPU_BIG_ENDIAN to be selected
  net: smc91x: dont't use SMC_outw for fixing up halfword-aligned data

 Documentation/arm64/booting.txt         |   45 +++++++++++++++++++---------
 arch/arm64/Kconfig                      |    5 ++++
 arch/arm64/Makefile                     |    6 ++++
 arch/arm64/include/asm/assembler.h      |   31 +++++++++++++++++++
 arch/arm64/include/asm/compat.h         |   14 +++++++++
 arch/arm64/include/asm/elf.h            |   18 ++++++++++++
 arch/arm64/include/asm/processor.h      |    5 ++++
 arch/arm64/include/asm/ptrace.h         |    1 +
 arch/arm64/include/asm/virt.h           |    3 +-
 arch/arm64/include/uapi/asm/byteorder.h |    4 +++
 arch/arm64/kernel/Makefile              |    2 +-
 arch/arm64/kernel/head.S                |   49 ++++++++++++++++++++++++-------
 arch/arm64/kernel/kuser32.S             |   42 ++++++++++++++++++++++++++
 arch/arm64/kernel/setup.c               |    2 +-
 arch/arm64/kernel/signal32.c            |   28 ------------------
 arch/arm64/kernel/smp_spin_table.c      |   11 ++++++-
 arch/arm64/kernel/sys32.S               |   22 +++++++-------
 arch/arm64/kernel/vdso.c                |    5 +++-
 arch/arm64/mm/proc.S                    |    4 +--
 drivers/net/ethernet/smsc/smc91x.h      |    6 ++--
 20 files changed, 228 insertions(+), 75 deletions(-)

-- 
1.7.9.5
