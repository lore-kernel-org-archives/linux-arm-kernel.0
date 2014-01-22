From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Wed, 22 Jan 2014 20:12:47 +0530
Subject: [PATCH v7 0/6] arm64: KGDB Support
Message-ID: <1390401773-12100-1-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>

Based on the step-handler and break-handler hooks patch from
Sandeepa, KGDB debugging support is added for EL1
debug in AArch64 mode.

In first patch, PSTATE.D is set correctly

In second patch,register layout is updated to be inline with GDB tool.
Basic GDB connection, break point set/clear and info commands
are supported except step/next debugging

With second patch, step/next debugging support is added, where in
pc is updated to point to the instruction to be stepped and
stopped.

With third patch, the compile time breakpoint instruction
reordering is fixed by making kgbd_breakpoint() as noinline

Tested with ARM64 simulator

v7:
 - Changes made to set PSTATE.D properly
 - Performed KGDB boot tests
 - Fixed compilation warnings in driver/misc/kgbdts.c

Results:

kgdb boot test:

  [32927.237895] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
  [32927.266066] kgdb: Registered I/O driver kgdbts.
  [32927.266419] kgdb: Waiting for connection from remote gdb...
  [32927.268598] kgdbts:RUN plant and detach test
  [32927.270683] kgdbts:RUN sw breakpoint test
  [32927.287659] kgdbts:RUN bad memory access test
  [32927.290322] kgdbts:RUN singlestep test 1000 iterations
  [32927.330342] kgdbts:RUN singlestep [0/1000]
  [32931.286356] kgdbts:RUN singlestep [100/1000]
  [32935.242536] kgdbts:RUN singlestep [200/1000]
  [32939.205392] kgdbts:RUN singlestep [300/1000]
  [32943.169522] kgdbts:RUN singlestep [400/1000]
  [32947.231868] kgdbts:RUN singlestep [500/1000]
  [32951.188008] kgdbts:RUN singlestep [600/1000]
  [32955.332243] kgdbts:RUN singlestep [700/1000]
  [32959.467109] kgdbts:RUN singlestep [800/1000]
  [32963.430888] kgdbts:RUN singlestep [900/1000]
  [32967.346992] kgdbts:RUN do_fork for 100 breakpoints

kgdb test from sysfs:

  ~ # echo V1F1000 > /sys/module/kgdbts/parameters/kgdbts
  [33231.554237] kgdb: Registered I/O driver kgdbts.
  [33231.554677] kgdbts:RUN plant and detach test
  [33231.557072] kgdbts:RUN sw breakpoint test
  [33231.576980] kgdbts:RUN bad memory access test
  [33231.580022] kgdbts:RUN singlestep test 1000 iterations
  [33231.627056] kgdbts:RUN singlestep [0/1000]
  [33235.954027] kgdbts:RUN singlestep [100/1000]
  [33240.429086] kgdbts:RUN singlestep [200/1000]
  [33244.687118] kgdbts:RUN singlestep [300/1000]
  [33248.945191] kgdbts:RUN singlestep [400/1000]
  [33253.203751] kgdbts:RUN singlestep [500/1000]
  [33257.462019] kgdbts:RUN singlestep [600/1000]
  [33261.817809] kgdbts:RUN singlestep [700/1000]
  [33266.081268] kgdbts:RUN singlestep [800/1000]
  [33270.339813] kgdbts:RUN singlestep [900/1000]
  [33274.712404] kgdbts:RUN do_fork for 1000 breakpoints
  ~ #

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

Vijaya Kumar K (6):
  arm64: Add macros to manage processor debug state
  arm64: KGDB: Add Basic KGDB support
  arm64: KGDB: Add step debugging support
  KGDB: make kgdb_breakpoint() as noinline
  misc: debug: remove compilation warnings
  arm64: KGDB: Add KGDB config

 arch/arm64/Kconfig                      |    1 +
 arch/arm64/include/asm/debug-monitors.h |   65 ++++--
 arch/arm64/include/asm/irqflags.h       |   22 ++
 arch/arm64/include/asm/kgdb.h           |   84 ++++++++
 arch/arm64/kernel/Makefile              |    1 +
 arch/arm64/kernel/debug-monitors.c      |    3 +-
 arch/arm64/kernel/kgdb.c                |  336 +++++++++++++++++++++++++++++++
 drivers/misc/kgdbts.c                   |   12 +-
 kernel/debug/debug_core.c               |    2 +-
 9 files changed, 502 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm64/include/asm/kgdb.h
 create mode 100644 arch/arm64/kernel/kgdb.c

-- 
1.7.9.5
