From: jean.pihet@linaro.org (Jean Pihet)
Date: Fri, 18 Oct 2013 16:54:36 +0200
Subject: [PATCH 0/2] ARM64: perf: add support for the perf registers and dwarf
 unwinding
Message-ID: <1382108078-8807-1-git-send-email-jean.pihet@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean Pihet <jean.pihet@newoldbits.com>

This patch implements the functions required for the perf registers API,
allowing the perf tool to interface kernel register dumps with libunwind
in order to provide userspace backtracing.
Only the general purpose user space registers are exported, i.e.:
 PERF_REG_ARM_X0,
 ...
 PERF_REG_ARM_X28,
 PERF_REG_ARM_FP,
 PERF_REG_ARM_LR,
 PERF_REG_ARM_SP,
 PERF_REG_ARM_PC
and not the PERF_REG_ARM_V* registers.

Dependencies:
 . if present, libunwind >= 1.1 is needed to prevent a segfault when
   parsing the dwarf info,
 . libunwind needs to be configured with --enable-debug-frame. Note:
   --enable-debug-frame is automatically selected on ARM, NOT on ARM64.

The generated perf binary has been tested on ARMv8 (using the
foundation model simulator) and x86_64, using the following commands:
 perf record -g [fp,dwarf] -- <binary>
 perf report --sort symbol --call-graph --stdio


Jean Pihet (2):
  ARM64: perf: add support for perf registers API
  ARM64: perf: wire up perf_regs and unwind support

 arch/arm64/Kconfig                        |  2 +
 arch/arm64/include/uapi/asm/Kbuild        |  1 +
 arch/arm64/include/uapi/asm/perf_regs.h   | 40 ++++++++++++++
 arch/arm64/kernel/Makefile                |  1 +
 arch/arm64/kernel/perf_regs.c             | 29 ++++++++++
 tools/perf/arch/arm64/Makefile            |  7 +++
 tools/perf/arch/arm64/include/perf_regs.h | 88 +++++++++++++++++++++++++++++++
 tools/perf/arch/arm64/util/dwarf-regs.c   | 81 ++++++++++++++++++++++++++++
 tools/perf/arch/arm64/util/unwind.c       | 82 ++++++++++++++++++++++++++++
 tools/perf/config/Makefile                |  6 +++
 10 files changed, 337 insertions(+)
 create mode 100644 arch/arm64/include/uapi/asm/perf_regs.h
 create mode 100644 arch/arm64/kernel/perf_regs.c
 create mode 100644 tools/perf/arch/arm64/Makefile
 create mode 100644 tools/perf/arch/arm64/include/perf_regs.h
 create mode 100644 tools/perf/arch/arm64/util/dwarf-regs.c
 create mode 100644 tools/perf/arch/arm64/util/unwind.c

-- 
1.7.11.7
