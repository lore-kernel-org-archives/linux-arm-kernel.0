From: jean.pihet@linaro.org (Jean Pihet)
Date: Wed, 22 Jan 2014 15:11:15 +0100
Subject: [PATCH v5 0/4] perf: AARCH64 arch support
Message-ID: <1390399879-5109-1-git-send-email-jean.pihet@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add AARCH64 specific support. This includes the following:
- AARCH64 perf registers definition and hooks,
- compat mode registers use, i.e. profiling a 32-bit binary on
   a 64-bit system,
- unwinding using the dwarf information from the .debug_frame
   section of the ELF binary,
- unwinding using the frame pointer information; in 64-bit and
   compat modes.

Note: support for unwinding using the dwarf information in compat
mode requires some changes to the libunwind code. Those changes
have been submitted on the libunwind ML and are in discussion.

Tested on ARMv7, ARMv8 and x86_64 platforms. The compat mode has been
tested on ARMv8 using statically built 32-bit binaries.


Jean Pihet (4):
  ARM64: perf: add support for perf registers API
  ARM64: perf: wire up perf_regs and unwind support
  ARM64: perf: add support for frame pointer unwinding in compat mode
  ARM64: perf: support dwarf unwinding in compat mode

 arch/arm64/Kconfig                        |  2 +
 arch/arm64/include/asm/compat.h           |  2 +-
 arch/arm64/include/asm/ptrace.h           |  3 +-
 arch/arm64/include/uapi/asm/Kbuild        |  1 +
 arch/arm64/include/uapi/asm/perf_regs.h   | 40 ++++++++++++++
 arch/arm64/kernel/Makefile                |  1 +
 arch/arm64/kernel/perf_event.c            | 75 +++++++++++++++++++++++---
 arch/arm64/kernel/perf_regs.c             | 44 ++++++++++++++++
 tools/perf/arch/arm64/Makefile            |  7 +++
 tools/perf/arch/arm64/include/perf_regs.h | 88 +++++++++++++++++++++++++++++++
 tools/perf/arch/arm64/util/dwarf-regs.c   | 80 ++++++++++++++++++++++++++++
 tools/perf/arch/arm64/util/unwind.c       | 82 ++++++++++++++++++++++++++++
 tools/perf/config/Makefile                |  8 ++-
 13 files changed, 422 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/include/uapi/asm/perf_regs.h
 create mode 100644 arch/arm64/kernel/perf_regs.c
 create mode 100644 tools/perf/arch/arm64/Makefile
 create mode 100644 tools/perf/arch/arm64/include/perf_regs.h
 create mode 100644 tools/perf/arch/arm64/util/dwarf-regs.c
 create mode 100644 tools/perf/arch/arm64/util/unwind.c

-- 
1.7.11.7
