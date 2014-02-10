From: dave.long@linaro.org (David Long)
Date: Mon, 10 Feb 2014 02:38:51 -0500
Subject: [PATCH v6 00/14] uprobes: Add uprobes support for ARM
Message-ID: <1392017945-4507-1-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "David A. Long" <dave.long@linaro.org>

This patch series adds basic uprobes support to ARM. It is based on patches
developed earlier by Rabin Vincent. That approach of adding hooks into
the kprobes instruction parsing code was not well received. This approach
separates the ARM instruction parsing code in kprobes out into a separate set
of functions which can be used by both kprobes and uprobes. Both kprobes and
uprobes then provide their own semantic action tables to process the results of
the parsing.

The following are noteworthy changes made for v6:

1) Put back the "const" type modifier in decode table usage.
2) Made t16_decode_pop() static again.
3) Merged the last patch back into the previous patch, to avoid
   needlessly introducing a uprobes dependency on kprobes in Kconfig.
4) Added a signed-off From rabin, and ack's from Tixy.

David A. Long (13):
  uprobes: allow ignoring of probe hits
  ARM: move shared uprobe/kprobe definitions into new include file
  ARM: Move generic arm instruction parsing code to new files for
    sharing between features
  ARM: move generic thumb instruction parsing code to new files for use
    by other feature
  ARM: use a function table for determining instruction interpreter
    action
  ARM: Remove use of struct kprobe from generic probes code
  ARM: Make the kprobes condition_check symbol names more generic
  ARM: Change more ARM kprobes symbol names to something more
  ARM: Rename the shared kprobes/uprobe return value enum
  ARM: Change the remaining shared kprobes/uprobes symbols to something
    generic
  ARM: Add an emulate flag to the kprobes/uprobes instruction decode
    functions
  ARM: Make arch_specific_insn a define for new arch_probes_insn
    structure
  ARM: add uprobes support

Jon Medhurst (Tixy) (1):
  ARM: Disable jprobes test when built into thumb-mode kernel

 arch/arm/Kconfig                                   |    3 +
 arch/arm/include/asm/kprobes.h                     |   15 +-
 arch/arm/include/asm/probes.h                      |   43 +
 arch/arm/include/asm/ptrace.h                      |    6 +
 arch/arm/include/asm/thread_info.h                 |    5 +-
 arch/arm/include/asm/uprobes.h                     |   45 +
 arch/arm/kernel/Makefile                           |    7 +-
 arch/arm/kernel/kprobes-arm.c                      |  804 ++------------
 arch/arm/kernel/kprobes-common.c                   |  468 +-------
 arch/arm/kernel/kprobes-test.c                     |   18 +-
 arch/arm/kernel/kprobes-thumb.c                    | 1142 +++-----------------
 arch/arm/kernel/kprobes.c                          |   23 +-
 arch/arm/kernel/kprobes.h                          |  400 +------
 arch/arm/kernel/{kprobes-arm.c => probes-arm.c}    |  441 ++------
 arch/arm/kernel/probes-arm.h                       |   73 ++
 .../arm/kernel/{kprobes-thumb.c => probes-thumb.c} |  770 ++-----------
 arch/arm/kernel/probes-thumb.h                     |   97 ++
 arch/arm/kernel/{kprobes-common.c => probes.c}     |  205 +---
 arch/arm/kernel/{kprobes.h => probes.h}            |  125 +--
 arch/arm/kernel/signal.c                           |    4 +
 arch/arm/kernel/uprobes-arm.c                      |  232 ++++
 arch/arm/kernel/uprobes.c                          |  208 ++++
 arch/arm/kernel/uprobes.h                          |   35 +
 include/linux/uprobes.h                            |    1 +
 kernel/events/uprobes.c                            |    9 +
 25 files changed, 1341 insertions(+), 3838 deletions(-)
 create mode 100644 arch/arm/include/asm/probes.h
 create mode 100644 arch/arm/include/asm/uprobes.h
 copy arch/arm/kernel/{kprobes-arm.c => probes-arm.c} (64%)
 create mode 100644 arch/arm/kernel/probes-arm.h
 copy arch/arm/kernel/{kprobes-thumb.c => probes-thumb.c} (56%)
 create mode 100644 arch/arm/kernel/probes-thumb.h
 copy arch/arm/kernel/{kprobes-common.c => probes.c} (67%)
 copy arch/arm/kernel/{kprobes.h => probes.h} (80%)
 create mode 100644 arch/arm/kernel/uprobes-arm.c
 create mode 100644 arch/arm/kernel/uprobes.c
 create mode 100644 arch/arm/kernel/uprobes.h

-- 
1.8.1.2
