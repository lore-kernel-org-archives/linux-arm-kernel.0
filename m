From: jean.pihet@linaro.org (Jean Pihet)
Date: Thu, 26 Sep 2013 13:36:34 +0200
Subject: [PATCH v3 0/4] perf: parse the dwarf backtrace info from .debug_frame
 section
Message-ID: <1380195398-4402-1-git-send-email-jean.pihet@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM the debug info is not present in the .eh_frame sections but
in .debug_frame instead, in dwarf format.

This patch set uses libunwind to load and parse the dwarf debug info from
the .debug_frame section if no .eh_frame_hdr section is found; also it
sets the hooks in the perf_regs and libunwind code for ARMv7.

Dependencies:
 . if present, libunwind >= 1.1 is needed to prevent a segfault when
   parsing the dwarf info,
 . libunwind needs to be configured with --enable-debug-frame. Note:
   --enable-debug-frame is automatically selected on ARM.

The generated perf binary has been tested on ARMv7 (OMAP4, Marvell
Armada XP) and x86_64, using the following commands:
 perf record -g [dwarf] -- <binary>
 perf report --sort symbol --call-graph --stdio


Jean Pihet (2):
  perf tools: Check libunwind for availability of dwarf parsing feature
  perf: parse the .debug_frame section in case .eh_frame is not present

Will Deacon (2):
  ARM: perf: add support for perf registers API
  ARM: perf: wire up perf_regs and unwind support for ARM

 arch/arm/Kconfig                        |  2 +
 arch/arm/include/uapi/asm/Kbuild        |  1 +
 arch/arm/include/uapi/asm/perf_regs.h   | 23 ++++++++++
 arch/arm/kernel/Makefile                |  1 +
 arch/arm/kernel/perf_regs.c             | 30 +++++++++++++
 tools/perf/arch/arm/Makefile            |  3 ++
 tools/perf/arch/arm/include/perf_regs.h | 54 ++++++++++++++++++++++++
 tools/perf/arch/arm/util/unwind.c       | 48 +++++++++++++++++++++
 tools/perf/config/Makefile              | 13 ++++--
 tools/perf/config/feature-tests.mak     | 21 ++++++++-
 tools/perf/util/unwind.c                | 75 ++++++++++++++++++++++++++-------
 11 files changed, 251 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm/include/uapi/asm/perf_regs.h
 create mode 100644 arch/arm/kernel/perf_regs.c
 create mode 100644 tools/perf/arch/arm/include/perf_regs.h
 create mode 100644 tools/perf/arch/arm/util/unwind.c

-- 
1.7.11.7
