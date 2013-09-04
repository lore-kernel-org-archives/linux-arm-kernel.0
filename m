From: jean.pihet@linaro.org (Jean Pihet)
Date: Wed,  4 Sep 2013 20:04:11 +0200
Subject: [PATCH 0/3] perf: parse the dwarf backtrace info from .debug_frame
 section
Message-ID: <1378317854-25965-1-git-send-email-jean.pihet@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM the debug info is not present in the .eh_frame sections but
in .debug_frame instead.

This patch uses libunwind to load and parse the dwarf debug info from
the .debug_frame section if no .eh_frame_hdr section is found; also it
sets the hooks in the perf_regs and libunwind code for ARM.

The generated perf has been tested on ARM/OMAP4 and x86_64, using the
following commands:
 perf record -g [dwarf] -- <binary>
 perf report --sort symbol --call-graph --stdio


Jean Pihet (1):
  perf: parse the .debug_frame section in case .eh_frame is not present

Will Deacon (2):
  ARM: perf: add support for perf regs API
  ARM: perf: wire up perf_regs and unwind support for ARM

 arch/arm/Kconfig                        |  2 +
 arch/arm/include/uapi/asm/Kbuild        |  1 +
 arch/arm/include/uapi/asm/perf_regs.h   | 23 +++++++++++
 arch/arm/kernel/Makefile                |  1 +
 arch/arm/kernel/perf_regs.c             | 30 ++++++++++++++
 tools/perf/arch/arm/Makefile            |  3 ++
 tools/perf/arch/arm/include/perf_regs.h | 54 +++++++++++++++++++++++++
 tools/perf/arch/arm/util/unwind.c       | 48 ++++++++++++++++++++++
 tools/perf/config/Makefile              |  7 +++-
 tools/perf/util/unwind.c                | 70 +++++++++++++++++++++++++--------
 10 files changed, 221 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/include/uapi/asm/perf_regs.h
 create mode 100644 arch/arm/kernel/perf_regs.c
 create mode 100644 tools/perf/arch/arm/include/perf_regs.h
 create mode 100644 tools/perf/arch/arm/util/unwind.c

-- 
1.7.11.7
