From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 20 Jan 2015 09:43:19 +0000
Subject: [GIT PULL] ARM kprobe updates
Message-ID: <1421746999.4328.3.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell

Please consider pulling the following changes to ARM kprobes.

This consists of Wang Nan's implementation of optimized kprobes on ARM,
which use branch instructions to call the handler rather than using
undefined instructions as breakpoints. It also contains various fixes
and extensions to the test code which were discovered along the way.

The patch from Masami Hiramatsu is outside of arch/arm but as kprobes
maintainer he indicated that it was OK for this simple patch to go
through the ARM tree, if you are also amenable. (See
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/317948.html)

Thanks


The following changes since commit b1940cd21c0f4abdce101253e860feff547291b0:

  Linux 3.19-rc3 (2015-01-05 17:05:20 -0800)

are available in the git repository at:

  git://git.linaro.org/people/tixy/kernel.git kprobes

for you to fetch changes up to fb892bd0fdcb2e5eac9c105cf68def90396ed8cc:

  ARM: kprobes: Eliminate test code's use of BX instruction on ARMv4 CPUs (2015-01-20 09:06:04 +0000)

----------------------------------------------------------------
Jon Medhurst (4):
      ARM: kprobes: Add test cases for stack consuming instructions
      ARM: kprobes: Fix unreliable MRS instruction tests
      ARM: probes: Use correct action types for MOVW, SEV and WFI
      ARM: kprobes: Eliminate test code's use of BX instruction on ARMv4 CPUs

Masami Hiramatsu (1):
      kprobes: Pass the original kprobe for preparing optimized kprobe

Wang Nan (7):
      ARM: probes: move all probe code to dedicate directory
      ARM: kprobes: introduces checker
      ARM: kprobes: collects stack consumption for store instructions
      ARM: kprobes: disallow probing stack consuming instructions
      ARM: kprobes: enable OPTPROBES for ARM 32
      ARM: kprobes: check register usage for probed instruction.
      ARM: optprobes: execute instruction during restoring if possible.

 arch/arm/Kconfig                                   |   1 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/{kernel => include/asm}/insn.h            |   0
 arch/arm/include/asm/kprobes.h                     |  33 +-
 arch/arm/{kernel => include/asm}/patch.h           |   0
 arch/arm/include/asm/probes.h                      |  15 +
 arch/arm/kernel/Makefile                           |  16 +-
 arch/arm/kernel/entry-armv.S                       |   3 +-
 arch/arm/kernel/ftrace.c                           |   3 +-
 arch/arm/kernel/jump_label.c                       |   5 +-
 arch/arm/kernel/kgdb.c                             |   3 +-
 arch/arm/kernel/patch.c                            |   3 +-
 arch/arm/probes/Makefile                           |   7 +
 .../{kernel/probes-arm.c => probes/decode-arm.c}   |  18 +-
 .../{kernel/probes-arm.h => probes/decode-arm.h}   |   9 +-
 .../probes-thumb.c => probes/decode-thumb.c}       |  16 +-
 .../probes-thumb.h => probes/decode-thumb.h}       |  10 +-
 arch/arm/{kernel/probes.c => probes/decode.c}      |  81 ++++-
 arch/arm/{kernel/probes.h => probes/decode.h}      |  13 +-
 arch/arm/probes/kprobes/Makefile                   |  12 +
 .../kprobes-arm.c => probes/kprobes/actions-arm.c} |  11 +-
 .../kprobes/actions-common.c}                      |   4 +-
 .../kprobes/actions-thumb.c}                       |  10 +-
 arch/arm/probes/kprobes/checkers-arm.c             | 192 +++++++++++
 arch/arm/probes/kprobes/checkers-common.c          | 101 ++++++
 arch/arm/probes/kprobes/checkers-thumb.c           | 110 ++++++
 arch/arm/probes/kprobes/checkers.h                 |  55 +++
 .../{kernel/kprobes.c => probes/kprobes/core.c}    |  49 ++-
 .../{kernel/kprobes.h => probes/kprobes/core.h}    |  12 +-
 arch/arm/probes/kprobes/opt-arm.c                  | 370 +++++++++++++++++++++
 .../kprobes/test-arm.c}                            |  40 ++-
 .../kprobes-test.c => probes/kprobes/test-core.c}  |  46 ++-
 .../kprobes-test.h => probes/kprobes/test-core.h}  |  35 +-
 .../kprobes/test-thumb.c}                          |  20 +-
 arch/arm/probes/uprobes/Makefile                   |   1 +
 .../uprobes-arm.c => probes/uprobes/actions-arm.c} |   8 +-
 .../{kernel/uprobes.c => probes/uprobes/core.c}    |   8 +-
 .../{kernel/uprobes.h => probes/uprobes/core.h}    |   0
 arch/x86/kernel/kprobes/opt.c                      |   3 +-
 include/linux/kprobes.h                            |   3 +-
 kernel/kprobes.c                                   |   4 +-
 41 files changed, 1200 insertions(+), 131 deletions(-)
 rename arch/arm/{kernel => include/asm}/insn.h (100%)
 rename arch/arm/{kernel => include/asm}/patch.h (100%)
 create mode 100644 arch/arm/probes/Makefile
 rename arch/arm/{kernel/probes-arm.c => probes/decode-arm.c} (98%)
 rename arch/arm/{kernel/probes-arm.h => probes/decode-arm.h} (92%)
 rename arch/arm/{kernel/probes-thumb.c => probes/decode-thumb.c} (98%)
 rename arch/arm/{kernel/probes-thumb.h => probes/decode-thumb.h} (90%)
 rename arch/arm/{kernel/probes.c => probes/decode.c} (84%)
 rename arch/arm/{kernel/probes.h => probes/decode.h} (97%)
 create mode 100644 arch/arm/probes/kprobes/Makefile
 rename arch/arm/{kernel/kprobes-arm.c => probes/kprobes/actions-arm.c} (98%)
 rename arch/arm/{kernel/kprobes-common.c => probes/kprobes/actions-common.c} (98%)
 rename arch/arm/{kernel/kprobes-thumb.c => probes/kprobes/actions-thumb.c} (98%)
 create mode 100644 arch/arm/probes/kprobes/checkers-arm.c
 create mode 100644 arch/arm/probes/kprobes/checkers-common.c
 create mode 100644 arch/arm/probes/kprobes/checkers-thumb.c
 create mode 100644 arch/arm/probes/kprobes/checkers.h
 rename arch/arm/{kernel/kprobes.c => probes/kprobes/core.c} (94%)
 rename arch/arm/{kernel/kprobes.h => probes/kprobes/core.h} (79%)
 create mode 100644 arch/arm/probes/kprobes/opt-arm.c
 rename arch/arm/{kernel/kprobes-test-arm.c => probes/kprobes/test-arm.c} (97%)
 rename arch/arm/{kernel/kprobes-test.c => probes/kprobes/test-core.c} (98%)
 rename arch/arm/{kernel/kprobes-test.h => probes/kprobes/test-core.h} (92%)
 rename arch/arm/{kernel/kprobes-test-thumb.c => probes/kprobes/test-thumb.c} (97%)
 create mode 100644 arch/arm/probes/uprobes/Makefile
 rename arch/arm/{kernel/uprobes-arm.c => probes/uprobes/actions-arm.c} (97%)
 rename arch/arm/{kernel/uprobes.c => probes/uprobes/core.c} (97%)
 rename arch/arm/{kernel/uprobes.h => probes/uprobes/core.h} (100%)
