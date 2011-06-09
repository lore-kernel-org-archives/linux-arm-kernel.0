From: will.deacon@arm.com (Will Deacon)
Date: Thu,  9 Jun 2011 16:58:52 +0100
Subject: [PATCH v2 00/10] MMU disabling code and kexec fixes
Message-ID: <1307635142-11312-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is version 2 of the patches originally posted here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052157.html

Thanks to Dave and Frank for feedback on those patches.

Changes from v1 include:

  * Implementation of cpu_reset for ARMv6 cores.
  * Introduction of stack-switching code to allow us to include more of
    the address space in the 1:1 mapping.
  * Exposure of non-static identity mappings functions via a new header
    file.
  * Changes to the cpu_* macro definitions when MULTI_CPU is defined.
  * Introduction of a new reboot mode, 'k', for mapping (most of)
    kernelspace as 1:1.
  * Use of swapper_pg_dir to create the identity mapping.

The idea is to remap all of the address space apart from the kernel
image and a small amount of memory (up to a page) immediately following
it as part of the identity map. This means that we can guarantee the
reset code will be available at its physical address (unless the
difference between virtual and physical space is unusually small. The
1:1 scenario is a special case that I haven't handled here).

I've tested this with kexec on a Realview-PBX (Cortex-A9) and it appears
to work well, although kexecing an SMP kernel exposes issues with other
parts of the code (timer initialisation for example).

Once again, all feedback welcome!

Will


Will Deacon (10):
  ARM: l2x0: fix disabling function to avoid livelock
  ARM: l2x0: fix invalidate-all function to avoid livelock
  ARM: proc: add definition of cpu_reset for ARMv6 and ARMv7 cores
  ARM: lib: add switch_stack function for safely changing stack
  ARM: idmap: add header file for identity mapping functions
  ARM: reset: allow kernelspace mappings to be flat mapped during reset
  ARM: multi-cpu: remove arguments from CPU proc macros
  ARM: reset: add reset functionality for jumping to a physical address
  ARM: kexec: use arm_machine_reset for branching to the reboot buffer
  ARM: stop: execute platform callback from cpu_stop code

 arch/arm/Kconfig                |    2 +-
 arch/arm/include/asm/idmap.h    |   23 ++++++++++++
 arch/arm/include/asm/pgtable.h  |    3 --
 arch/arm/include/asm/proc-fns.h |   14 ++++----
 arch/arm/include/asm/system.h   |    1 +
 arch/arm/kernel/machine_kexec.c |   14 +------
 arch/arm/kernel/process.c       |   75 +++++++++++++++++++++++++++++++++-----
 arch/arm/kernel/smp.c           |    5 +++
 arch/arm/lib/Makefile           |    3 +-
 arch/arm/lib/switch_stack.S     |   44 +++++++++++++++++++++++
 arch/arm/mm/cache-l2x0.c        |   13 ++++---
 arch/arm/mm/idmap.c             |   31 +++++++++++-----
 arch/arm/mm/proc-v6.S           |    5 +++
 arch/arm/mm/proc-v7.S           |    7 ++++
 14 files changed, 191 insertions(+), 49 deletions(-)
 create mode 100644 arch/arm/include/asm/idmap.h
 create mode 100644 arch/arm/lib/switch_stack.S
