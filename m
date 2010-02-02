From: will.deacon@arm.com (Will Deacon)
Date: Tue,  2 Feb 2010 16:22:24 +0000
Subject: [RFC PATCH 0/4] ARM: add support for hw-breakpoints
Message-ID: <1265127748-4587-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modern ARM cores provide hardware resources for setting breakpoints
and watchpoints from software when in monitor debug mode. When these
are triggered, a debug exception is taken [in the form of a prefetch
or data abort] and a trap can be raised to notify the user that the
event has occurred.

This patch adds an ARM [v6+] backend to the recent HW-Breakpoint framework
in the Kernel. The ptrace interface is extended to support the new features
and has been tested successfully with GDB on 11MPCore and Cortex-A9 platforms.

All comments welcome, particularly those related to:
	- The ptrace interface, where I tried to avoid defining a new struct
	- The debug register accessors, which are rather ugly
	- Discovering the faulting data address when a watchpoint fires

Patch taken against 2.6.33-rc6 with perf [ARM 5900/1] and atomic64 [ARM 5889/1]
support.


Will Deacon (4):
  ARM: hw-breakpoint: add mechanism for hooking into prefetch aborts
  ARM: hw-breakpoint: add ARM backend for the hw-breakpoint framework
  ARM: hw-breakpoint: add new ptrace requests for hw-breakpoint
    interaction
  ARM: hw-breakpoint: add HAVE_HW_BREAKPOINT to Kconfig

 arch/arm/Kconfig                     |    1 +
 arch/arm/include/asm/hw_breakpoint.h |  113 ++++++
 arch/arm/include/asm/processor.h     |    4 +
 arch/arm/include/asm/ptrace.h        |    2 +
 arch/arm/include/asm/system.h        |    3 +
 arch/arm/kernel/Makefile             |    1 +
 arch/arm/kernel/hw_breakpoint.c      |  672 ++++++++++++++++++++++++++++++++++
 arch/arm/kernel/ptrace.c             |  158 ++++++++
 arch/arm/mm/fault.c                  |   11 +
 9 files changed, 965 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/hw_breakpoint.h
 create mode 100644 arch/arm/kernel/hw_breakpoint.c
