From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Tue,  5 Nov 2013 14:15:42 +0530
Subject: [PATCH v4 0/4] AArch64: KGDB support
Message-ID: <1383641146-27274-1-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>

Based on the step-handler and break-handler hooks patch from
Sandeepa (Patch 1), KGDB debugging support is added for EL1
debug in AArch64 mode. Any updates that come for Patch 1 from
Sandeepa will be rebased in next version

With second patch,register layout is updated to be inline with GDB tool.
Basic GDB connection, break point set/clear and info commands
are supported except step/next debugging

With third patch, step/next debugging support is added, where in
pc is updated to point to the instruction to be stepped and
stopped.

with fourth patch, the compile time breakpoint instruction
reordering is fixed by making kgbd_breakpoint() as noinline

v4:
 - Updated kgdb_single_step and kgdb_cpu_doing_single_step
   variables properly based on gdb state

v3:
 - Rebased to v4 version of Sandeepa Prabhu's patch (patch 1)
 - Made dynamic break point instruction encoding generic
 - Made ESR value encoding generic for dynamic and compile break point
 - Used memcpy and memset to copy register contents to gdb buffer
 - Fixed reordering of break point instruction by compiler with
   patch 3
 - Rebased against AAach64 upstream kernel

v2:
 - Moved break instruction encoding to debug-monitors.h file
 - Fixed endianess of compile break instruction encoding
 - Updated I/O buffer sizes
 - Updated register buffer size
 - Remove changes to debug_exception handler in entry.S for
 - ELR update and step debugging with update pc instead of ELR
 - Rebased against AArch64 upstream kernel

v1:
 - Initial patch-set

Sandeepa Prabhu (1):
  arm64: support single-step and breakpoint handler hooks

Vijaya Kumar K (3):
  AArch64: KGDB: Add Basic KGDB support
  AArch64: KGDB: Add step debugging support
  KGDB: make kgdb_breakpoint() as noinline

 arch/arm64/include/asm/debug-monitors.h |   67 ++++++
 arch/arm64/include/asm/kgdb.h           |   86 ++++++++
 arch/arm64/kernel/Makefile              |    1 +
 arch/arm64/kernel/debug-monitors.c      |   86 +++++++-
 arch/arm64/kernel/entry.S               |    2 +
 arch/arm64/kernel/kgdb.c                |  338 +++++++++++++++++++++++++++++++
 kernel/debug/debug_core.c               |    2 +-
 7 files changed, 580 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/include/asm/kgdb.h
 create mode 100644 arch/arm64/kernel/kgdb.c

-- 
1.7.9.5
