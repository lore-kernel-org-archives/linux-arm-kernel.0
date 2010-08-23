From: will.deacon@arm.com (Will Deacon)
Date: Mon, 23 Aug 2010 16:54:53 +0100
Subject: [PATCH 0/4] ARM: add support for hw-breakpoints [v6]
Message-ID: <1282578897-23247-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is version 6 of the patches originally posted at:

v1.) http://lists.infradead.org/pipermail/linux-arm-kernel/2010-February/009084.html
v2.) http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011170.html
v3.) http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/017680.html
v4.) http://lists.infradead.org/pipermail/linux-arm-kernel/2010-July/019882.html
v5.) http://lists.infradead.org/pipermail/linux-arm-kernel/2010-August/022882.html

Changes from v5 include:
	- Based on v2.6.36-rc2
	- ptrace breakpoints are now flushed before the thread state is zeroed
	- ptrace breakpoint pointers are zeroed in copy_thread
	- Debug registers are now zeroed on all cores during boot
	- Userspace breakpoint and watchpoint single-stepping is supported on
	  v7 processors. This means the perf tool can be used to monitor
	  function calls and variable accesses.

As with v5, these patches have been shown to work with GDB using the patches
posted here:

http://sourceware.org/ml/gdb-patches/2010-07/msg00110.html

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: S. Karthikeyan <informkarthik@gmail.com>

Will Deacon (4):
  ARM: hw-breakpoint: add mechanism for hooking into prefetch aborts
  ARM: hw-breakpoint: add ARM backend for the hw-breakpoint framework
  ARM: hw-breakpoint: add new ptrace requests for hw-breakpoint
    interaction
  ARM: hw-breakpoint: add HAVE_HW_BREAKPOINT to Kconfig

 arch/arm/Kconfig                     |    1 +
 arch/arm/include/asm/hw_breakpoint.h |  132 ++++++
 arch/arm/include/asm/processor.h     |    4 +
 arch/arm/include/asm/ptrace.h        |    2 +
 arch/arm/include/asm/system.h        |    4 +
 arch/arm/kernel/Makefile             |    1 +
 arch/arm/kernel/hw_breakpoint.c      |  849 ++++++++++++++++++++++++++++++++++
 arch/arm/kernel/process.c            |    5 +
 arch/arm/kernel/ptrace.c             |  239 ++++++++++
 arch/arm/mm/fault.c                  |   13 +
 10 files changed, 1250 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/hw_breakpoint.h
 create mode 100644 arch/arm/kernel/hw_breakpoint.c
