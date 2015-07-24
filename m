From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 24 Jul 2015 10:43:46 +0100
Subject: [RFC PATCH 00/10] arm64: Expose CPU feature registers
Message-ID: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

This is an early RFC prototype for an API to export ARMv8 CPU
feature registers to AArch64 userspace. The series also
consolidates the CPU info, HWCAPs and the sanity check
infrastructure.

The ARM architecture exposes the system/cpu capabilities via a set
of CPU feature Registers. Currently, we relay some of this information
to userspace via the following mechanisms:

1)  ELF HWCAPS auxiliary vector
 * There are limited number of bits available in the HWCAPS and
   may soon run out of bits.
 * the auxv is not available at all the time (e.g prior to libc is
   initialised at startup)
 * They cannot represent non-boolean information effectively.

2)  /proc/cpuinfo
 Provides CPU identification information along with the hwcaps.
 However, parsing the information is complex and prone to errors.
 Also this method cannot be used during the early application startup
 (e.g ld/libc load time).

This proposal emulates the 'MRS' instruction and exposes a limited set
of feature values (See Patch 1 for the detailed list and documentation)
that are safe across all the CPUs (e.g heterogeneous CPUs). The feature
bits that are not exposed are set to the 'safe value' which implies
'not supported'.

Apart from the selected feature registers, we expose MIDR_EL1 (Main
ID Register). The user should be aware that, reading MIDR_EL1 can be
tricky on a heterogeneous system (just like getcpu()). We export the
value of the current CPU where 'MRS' is executed.

This infrastructure  useful for the toolchains (e.g, gcc, dynamic linker,
JIT) to make better runtime decisions based on what is available.

This patch series is based on: 4.2.0-rc3 + the patch
"arm64: Generalise msr_s/mrs_s operations"
	http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/358462.html

Suzuki K. Poulose (10):
  arm64: feature registers: Documentation
  arm64: Make the CPU information more clear
  arm64: Delay ELF HWCAP initialisation until all CPUs are up
  arm64: Consolidate cpuinfo handling
  arm64: Keep track of CPU feature registers
  arm64: Add helper to decode register from instruction
  arm64: Expose feature registers by emulating MRS
  arm64: Emulate ID registers
  arm64: Read system wide CPUID value
  arm64: Use system-wide safe value of CPU feature register

 Documentation/arm64/cpu-feature-registers.txt |  185 +++++++
 arch/arm64/include/asm/cpu.h                  |  165 ++++++
 arch/arm64/include/asm/insn.h                 |    2 +
 arch/arm64/kernel/cpuinfo.c                   |  720 +++++++++++++++++++++++--
 arch/arm64/kernel/debug-monitors.c            |    6 +-
 arch/arm64/kernel/fpsimd.c                    |    5 +-
 arch/arm64/kernel/hw_breakpoint.c             |    5 +-
 arch/arm64/kernel/insn.c                      |   29 +
 arch/arm64/kernel/setup.c                     |  209 +------
 arch/arm64/kernel/smp.c                       |    3 +-
 arch/arm64/kvm/reset.c                        |    3 +-
 arch/arm64/kvm/sys_regs.c                     |    5 +-
 12 files changed, 1076 insertions(+), 261 deletions(-)
 create mode 100644 Documentation/arm64/cpu-feature-registers.txt

-- 
1.7.9.5
