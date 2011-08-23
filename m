From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Aug 2011 22:46:44 +0100
Subject: [PATCH v4 0/8] MMU disabling code and kexec fixes
Message-ID: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is version 4 of the patches originally posted here:

v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052157.html
v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052559.html
v3: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/053252.html

There are many changes since v3. Notably:
	- Support for Thumb-2
	- Based on 3.1-rc3 (now that some of the previous patches have
	  been merged)
	- The reserved stack page now sits below swapper and is reserved
	  by memblock during memory init. This has the advantage of being
	  at a known physical address for a platform, which will be helpful
	  for non-hotplug SMP booting.

Currently, SMP kexec relies on platform_cpu_kill (a CPU hotplug callback)
doing the right thing. I'm working on a generic SMP soft reboot implementation
but this isn't quite working yet (and my git repo is predictably offline
at the moment so I can't provide a link to the patches).

All feedback welcome.

Thanks,

Will


Will Deacon (8):
  ARM: proc-v7: disable SCTLR.TE when disabling MMU
  ARM: kexec: ensure new kernel is entered in ARM state
  ARM: lib: add switch_stack function for safely changing stack
  ARM: idmap: add header file for identity mapping functions
  ARM: reset: allow kernelspace mappings to be flat mapped during reset
  ARM: reset: add reset functionality for jumping to a physical address
  ARM: kexec: use arm_machine_reset for branching to the reboot buffer
  ARM: stop: execute platform callback from cpu_stop code

 arch/arm/Kconfig                  |    2 +-
 arch/arm/include/asm/idmap.h      |   15 +++++++
 arch/arm/include/asm/pgtable.h    |    3 -
 arch/arm/include/asm/system.h     |    1 +
 arch/arm/kernel/machine_kexec.c   |   14 +------
 arch/arm/kernel/process.c         |   76 ++++++++++++++++++++++++++++++++++--
 arch/arm/kernel/relocate_kernel.S |    2 +-
 arch/arm/kernel/smp.c             |    5 ++
 arch/arm/lib/Makefile             |    3 +-
 arch/arm/lib/switch_stack.S       |   44 +++++++++++++++++++++
 arch/arm/mm/idmap.c               |   43 ++++++++++++++++-----
 arch/arm/mm/mmu.c                 |   13 +++++-
 arch/arm/mm/proc-v7.S             |    1 +
 13 files changed, 187 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm/include/asm/idmap.h
 create mode 100644 arch/arm/lib/switch_stack.S
