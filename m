From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 18 Nov 2014 11:41:21 +0000
Subject: [PATCH v5 0/6] Legacy instruction emulation for arm64
Message-ID: <1416310887-14649-1-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the fifth posting of the legacy instruction support for
arm64. Previous postings can be found at [1][2][3][4].

This version addresses all the feedback received so far.

Changes since previous posting:
* Split out legacy instructions framework into a separate patch 3/6.
* Simplified the error checking for undefined abort hooks
registration.
* Revert to previous mode when setting up hardware execution fails.
* Dropped duplicate information in trace that was already being
captured by the framework. 

Cheers,
Punit

Changes since [3]:
* Shortened function name aarch32_insn_is_wide_instruction ->
aarch32_insn_is_wide
* Removed unnecessary addprefix
* Changed default suggestion from 'N' to 'Y'
* Allow deprecated instructions to potentially only implement
emulation or hardware execution - should help when certain
instructions are difficult to emulate.
* Disable CP15 barriers when hot-unplugging the CPUs
* Added assembler comment to trace the equivalent barrier when CP15
Barriers are used.

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
[3] http://thread.gmane.org/gmane.linux.ports.arm.kernel/366728
[4] http://thread.gmane.org/gmane.linux.ports.arm.kernel/371017

Punit Agrawal (6):
  arm64: Add support for hooks to handle undefined instructions
  arm64: Add AArch32 instruction set condition code checks
  arm64: Add framework for legacy instruction emulation
  arm64: Port SWP/SWPB emulation support from arm
  arm64: Emulate CP15 Barrier instructions
  arm64: Trace emulation of AArch32 legacy instructions

 Documentation/arm64/legacy_instructions.txt |  45 +++
 arch/arm64/Kconfig                          |  54 +++
 arch/arm64/include/asm/insn.h               |  10 +
 arch/arm64/include/asm/opcodes.h            |   1 +
 arch/arm64/include/asm/traps.h              |  16 +
 arch/arm64/kernel/Makefile                  |   5 +-
 arch/arm64/kernel/armv8_deprecated.c        | 553 ++++++++++++++++++++++++++++
 arch/arm64/kernel/insn.c                    |  26 ++
 arch/arm64/kernel/trace-events-emulation.h  |  35 ++
 arch/arm64/kernel/traps.c                   |  66 ++++
 10 files changed, 810 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/arm64/legacy_instructions.txt
 create mode 100644 arch/arm64/include/asm/opcodes.h
 create mode 100644 arch/arm64/kernel/armv8_deprecated.c
 create mode 100644 arch/arm64/kernel/trace-events-emulation.h

-- 
2.1.1
