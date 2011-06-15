From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Jun 2011 18:23:11 +0100
Subject: [PATCH v3 0/9] MMU disabling code and kexec fixes
Message-ID: <1308158600-7169-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is version 3 of the patches originally posted here:

v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052157.html
v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052559.html

Changes from v2 include:

  * No longer remove locking from the L2 invalidation function. I had
    previously misdiagnosed the problem here, so it's now fixed
    correctly in the disabling code.
  * The reserve stack is now aligned to PMD_SIZE instead of SZ_1M so
    that it doesn't get clobbered by the identity mapping.

I've tested these patches with kexec on Versatile Express and
Realview-PBX without any problems. It would be nice to get any feedback
on how this can also be used by the hibernation code from Frank and
whether or not any changes are required.

Cheers,

Will


Will Deacon (9):
  ARM: l2x0: fix disabling function to avoid deadlock
  ARM: proc: add definition of cpu_reset for ARMv6 and ARMv7 cores
  ARM: lib: add switch_stack function for safely changing stack
  ARM: idmap: add header file for identity mapping functions
  ARM: reset: allow kernelspace mappings to be flat mapped during reset
  ARM: multi-cpu: remove arguments from CPU proc macros
  ARM: reset: add reset functionality for jumping to a physical address
  ARM: kexec: use arm_machine_reset for branching to the reboot buffer
  ARM: stop: execute platform callback from cpu_stop code

 arch/arm/Kconfig                |    2 +-
 arch/arm/include/asm/idmap.h    |   23 +++++++++++++
 arch/arm/include/asm/pgtable.h  |    3 --
 arch/arm/include/asm/proc-fns.h |   14 ++++----
 arch/arm/include/asm/system.h   |    1 +
 arch/arm/kernel/machine_kexec.c |   14 +-------
 arch/arm/kernel/process.c       |   67 +++++++++++++++++++++++++++++++++------
 arch/arm/kernel/smp.c           |    5 +++
 arch/arm/lib/Makefile           |    3 +-
 arch/arm/lib/switch_stack.S     |   44 +++++++++++++++++++++++++
 arch/arm/mm/cache-l2x0.c        |   19 +++++++---
 arch/arm/mm/idmap.c             |   31 +++++++++++++-----
 arch/arm/mm/proc-v6.S           |    5 +++
 arch/arm/mm/proc-v7.S           |    7 ++++
 14 files changed, 189 insertions(+), 49 deletions(-)
 create mode 100644 arch/arm/include/asm/idmap.h
 create mode 100644 arch/arm/lib/switch_stack.S
