From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Thu, 19 Dec 2013 17:20:48 +0530
Subject: [PATCH v6 0/3] AArch64: KGDB support
Message-ID: <1387453851-19341-1-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>

Based on the step-handler and break-handler hooks patch from
Sandeepa, KGDB debugging support is added for EL1
debug in AArch64 mode. Any updates that come for Patch 1 from
Sandeepa will be rebased in next version

With second patch,register layout is updated to be inline with GDB tool.
Basic GDB connection, break point set/clear and info commands
are supported except step/next debugging

With third patch, step/next debugging support is added, where in
pc is updated to point to the instruction to be stepped and
stopped.

With fourth patch, the compile time breakpoint instruction
reordering is fixed by making kgbd_breakpoint() as noinline

Tested with ARM64 simulator

v6:
 - Change pstate register to 8 bytes to make endian nuetral.
   Use GDB below GDB patch to display pstate in Big endian mode.
   https://sourceware.org/ml/gdb-patches/2013-12/msg00720.html
   Thanks to Andrew.

v5:
 - Updated BRK #imm16 value to 0x400 & 0x401 as per recommendation
   as per Marcus recommendataion
   http://patchwork.ozlabs.org/patch/290801/
 - Rebased to 3.13 AArch64 kernel

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

Vijaya Kumar K (3):
  AArch64: KGDB: Add Basic KGDB support
  AArch64: KGDB: Add step debugging support
  KGDB: make kgdb_breakpoint() as noinline

 arch/arm64/include/asm/debug-monitors.h |   47 +++++
 arch/arm64/include/asm/kgdb.h           |   86 ++++++++
 arch/arm64/kernel/Makefile              |    1 +
 arch/arm64/kernel/kgdb.c                |  341 +++++++++++++++++++++++++++++++
 kernel/debug/debug_core.c               |    2 +-
 5 files changed, 476 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/kgdb.h
 create mode 100644 arch/arm64/kernel/kgdb.c

-- 
1.7.9.5
