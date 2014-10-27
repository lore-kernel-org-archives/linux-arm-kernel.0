From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 27 Oct 2014 18:40:01 +0000
Subject: [PATCHv3 0/5] Legacy instruction emulation for arm64
Message-ID: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the third posting of the legacy instruction support for
arm64. Previous postings can be found at [1][2].

The patchset creates the infrastructure to support legacy instruction
emulation and then uses this to add support for the emulation of
SWP{B} and CP15 Barrier instructions from ARMv7 to the v8 port of
Linux. When available, the common infrastructure allows for enabling
the hardware execution of legacy instructions. Runtime support for
changing the execution mode - undef, legacy, or hw execution is
provided via nodes in sysctl. The default behaviour varies with the
state of the instruction in the architecture (deprecated or obsolete)
and is documented as part of this series.

Patches 1-2/5 add infrastructure code to add support for undefined
instruction hooks and decoding condition checks.

Patch 3-4/5 adds infrastructure to support legacy instruction
emulation and uses this to then add support for SWP and CP15 barriers
respectively.

Patch 5/5 introduces a trace point to log instruction emulation and then
uses this to trace the usage of the above instructions when using
emulation.


Cheers,
Punit

Changes since [2]:
* Made trace point local to arm64
* Re-factored infrastructure to handle registration / un-registration
of undefined hooks as well as handle enabling hardware execution when
supported
* Added documentation for default execution modes and how to change it
via sysctl

Changes since [1]:
* Added support for Thumb instructions when registering undefined
hooks as well
* Emulation support is now added to armv8_deprecated.c (was previously
v7_obsolete.c)
* Instruction support level - Off, Emulate or Enable (when supported
in hardware) - is now controlled through sysctl
* Using trace points instead of debugfs for stats reporting


[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/351054
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/292213.html

Punit Agrawal (5):
  arm64: Add support for hooks to handle undefined instructions
  arm64: Add AArch32 instruction set condition code checks
  arm64: Port SWP/SWPB emulation support from arm
  arm64: Emulate CP15 Barrier instructions
  arm64: Trace emulation of AArch32 legacy instructions

 Documentation/arm64/legacy_instructions.txt |  45 +++
 arch/arm64/Kconfig                          |  54 +++
 arch/arm64/include/asm/insn.h               |  10 +
 arch/arm64/include/asm/opcodes.h            |   1 +
 arch/arm64/include/asm/traps.h              |  16 +
 arch/arm64/kernel/Makefile                  |   6 +-
 arch/arm64/kernel/armv8_deprecated.c        | 541 ++++++++++++++++++++++++++++
 arch/arm64/kernel/insn.c                    |  26 ++
 arch/arm64/kernel/trace-events-emulation.h  |  40 ++
 arch/arm64/kernel/traps.c                   |  68 ++++
 10 files changed, 806 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/arm64/legacy_instructions.txt
 create mode 100644 arch/arm64/include/asm/opcodes.h
 create mode 100644 arch/arm64/kernel/armv8_deprecated.c
 create mode 100644 arch/arm64/kernel/trace-events-emulation.h

-- 
2.1.1
