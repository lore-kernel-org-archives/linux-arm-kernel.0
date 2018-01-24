From: m.slodczyk2@partner.samsung.com (Maciej Slodczyk)
Date: Wed, 24 Jan 2018 13:34:27 +0100
Subject: [PATCH 0/7] arm64: uprobes - ARM32 instruction probing
References: <CGME20180124123450eucas1p23a79f56cd4a65c790468cfc2f3e1339b@eucas1p2.samsung.com>
Message-ID: <1516797274-20320-1-git-send-email-m.slodczyk2@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The uprobe feature on ARM64 kernel does not support ARM A32 instruction
probing, making 32 bit apps running on 64 bit kernel unprobeable.

This patchset utilizes ARM32 uprobe code in ARM64 tree with following
modifications:
- moves ARM32 uprobes code form arch/arm to lib/uprobes/arm to be reused
by ARM64 code
- makes adjustments in api so that it suits the one used by ARM64 kernel, e.g.
struct pt_regs, register numbers
- takes into account differences between 32 and 64 bit ARM architectures.
A64 instruction handling is left unchanged.

Detect what kind of instruction is being probed and depending on the result:
- if an A64 instruction handle it the old way, using existing A64 instructions
probing code,
- if an A32 instruction decode it and handle using the new code, moved from
32 bit arm kernel tree.

Currently following test cases have been carried out with positive results:
- simulation-able instructions, like: STM, LDM, BLX, BL
- xol-able instructions, like: STR, LDR, ADD, CMN, CMP
- branching
- uretprobes.

This patchset does not implement T32 (Thumb) instructions probing (which is
also unsupported on "native" ARM32 arch).

Maciej Slodczyk (7):
  arm64: move arm uprobes code to be reused by arm64
  arm64: uprobes - fix checkpatch.pl issues
  arm64: introduce get_swbp_insn() instead of static assignment
  arm64: change arm64 probes handler prototype
  arm64: make arm uprobes code reusable by arm64
  arm64: change arm_probe_decode_insn() function name
  arm64: uprobes - ARM32 instruction probing

 arch/arm/include/asm/probes.h                      |   8 ++
 arch/arm/include/asm/ptrace.h                      |  32 +++++
 arch/arm/include/asm/uprobes.h                     |   2 +-
 arch/arm/probes/Makefile                           |   8 +-
 arch/arm/probes/kprobes/actions-arm.c              |   2 +-
 arch/arm/probes/kprobes/checkers-arm.c             |   4 +-
 arch/arm/probes/kprobes/checkers-common.c          |   4 +-
 arch/arm/probes/kprobes/checkers.h                 |   2 +-
 arch/arm/probes/kprobes/core.c                     |   2 +-
 arch/arm/probes/kprobes/core.h                     |   2 +-
 arch/arm/probes/uprobes/Makefile                   |   2 +-
 arch/arm/probes/uprobes/core.c                     |  10 +-
 arch/arm64/include/asm/probes.h                    |  24 +++-
 arch/arm64/include/asm/ptrace.h                    |  21 +++
 arch/arm64/include/asm/uprobes.h                   |  21 ++-
 arch/arm64/kernel/debug-monitors.c                 |   8 ++
 arch/arm64/kernel/probes/Makefile                  |   2 +
 arch/arm64/kernel/probes/decode-insn.c             |  30 ++--
 arch/arm64/kernel/probes/decode-insn.h             |  15 +-
 arch/arm64/kernel/probes/kprobes.c                 |   4 +-
 arch/arm64/kernel/probes/simulate-insn.c           |  32 +++--
 arch/arm64/kernel/probes/simulate-insn.h           |  24 ++--
 arch/arm64/kernel/probes/uprobes.c                 | 121 ++++++++++++++--
 include/linux/uprobes.h                            |   1 +
 kernel/events/uprobes.c                            |  15 +-
 lib/Makefile                                       |   2 +
 lib/probes/Makefile                                |   2 +
 lib/probes/arm/Makefile                            |  11 ++
 .../uprobes => lib/probes/arm}/actions-arm.c       | 153 ++++++++++++++++++---
 {arch/arm/probes => lib/probes/arm}/decode-arm.c   |  57 +++++---
 {arch/arm/probes => lib/probes/arm}/decode-arm.h   |   4 +-
 {arch/arm/probes => lib/probes/arm}/decode.c       |  18 ++-
 {arch/arm/probes => lib/probes/arm}/decode.h       |  48 ++++---
 33 files changed, 551 insertions(+), 140 deletions(-)
 create mode 100644 lib/probes/Makefile
 create mode 100644 lib/probes/arm/Makefile
 rename {arch/arm/probes/uprobes => lib/probes/arm}/actions-arm.c (61%)
 rename {arch/arm/probes => lib/probes/arm}/decode-arm.c (95%)
 rename {arch/arm/probes => lib/probes/arm}/decode-arm.h (94%)
 rename {arch/arm/probes => lib/probes/arm}/decode.c (98%)
 rename {arch/arm/probes => lib/probes/arm}/decode.h (94%)

-- 
2.7.4
