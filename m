From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed,  1 Oct 2014 13:07:54 +0100
Subject: [PATCHv2 0/5] Legacy instruction emulation for arm64
Message-ID: <1412165279-8709-1-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the second posting of the legacy instruction support for
arm64. The previous posting can be found at [1].

The patchset ports the infrastructure to register hooks for undefined
instruction abort and uses this to adds support for the emulation of
SWP{B} and CP15 Barrier instructions from ARMv7 to the v8 port of
Linux.

Via sysctl, it is possible to control the runtime state of emulation
* Off
  sysctl value: 0
  Generates undefined instruction abort. Default for instructions that
  have been obsoleted in the architecture, e.g., SWP

* Emulate
  sysctl value: 1
  Uses software emulation. To aid migration of software, in this mode
  usage of emulated instruction is traced as well as rate limited
  warnings are issued. This is the default for deprecated
  instructions, .e.g., CP15 barriers

* Enable
  sysctl value: 2
  Although marked as deprecated, some implementations may support the
  enabling/disabling of hardware support for the execution of these
  instructions. Using hardware execution generally provides better
  performance, but at the loss of ability to gather runtime statistics
  about the use of the deprecated instructions.

Patches 1-2/5 add infrastructure code to add support for undefined
instruction hooks and decoding condition checks.

Patch 3-4/6 adds support for SWP and CP15 barriers respectively. They
also provide the ability to control the emulation by writing one of
the above three values to /proc/sys/abi file nodes.

Patch 6/6 introduces a trace point to log instruction emulation and then
uses this to trace the usage of the above instructions when using
emulation.

Although not in a merge window, the intention of the posting is to
allow early access to the code to reduce divergenece in product
kernels where additional features are being worked on.

Cheers,
Punit

Changes since [1]:
* Added support for Thumb instructions when registering undefined
hooks as well
* Emulation support is now added to armv8_deprecated.c (was previously
v7_obsolete.c)
* Instruction support level - Off, Emulate or Enable (when supported
in hardware) - is now controlled through sysctl
* Using trace points instead of debugfs for stats reporting


[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/351054

Punit Agrawal (5):
  arm64: Add support for hooks to handle undefined instructions
  arm64: Add AArch32 instruction set condition code checks
  arm64: Port SWP/SWPB emulation support from arm
  arm64: Emulate CP15 Barrier instructions
  arm64: Trace emulation of AArch32 legacy instructions

 arch/arm64/Kconfig                   |   54 ++++
 arch/arm64/include/asm/insn.h        |   10 +
 arch/arm64/include/asm/opcodes.h     |    1 +
 arch/arm64/include/asm/traps.h       |   16 ++
 arch/arm64/kernel/Makefile           |    5 +-
 arch/arm64/kernel/armv8_deprecated.c |  489 ++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/insn.c             |   26 ++
 arch/arm64/kernel/traps.c            |   68 +++++
 include/trace/events/emulation.h     |   35 +++
 9 files changed, 703 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/opcodes.h
 create mode 100644 arch/arm64/kernel/armv8_deprecated.c
 create mode 100644 include/trace/events/emulation.h

-- 
1.7.10.4
