From: dave.long@linaro.org (David Long)
Date: Thu,  1 Aug 2013 19:45:44 -0400
Subject: [PATCH 0/9] uprobes: Add uprobes support for ARM
Message-ID: <1375400753-3454-1-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "David A. Long" <dave.long@linaro.org>

This patch series adds basic uprobes support to ARM. It is based on patches
developed earlier by Rabin Vincent.  That approach of adding hooks into
the kprobes instruction parsing code was not well received.  This approach
separates the ARM instruction parsing code in kprobes out into a separate set
of functions which can be used by both kprobes and uprobes. Both kprobes and
uprobes then provide their own semantic action tables to process the results of
the parsing.

These patches are based on v3.11-rc3

David A. Long (6):
  uprobes: move function declarations out of arch
  uprobes: add arch write opcode hook
  ARM: move shared uprobe/kprobe definitions into new include file
  ARM: Move uprobes/kprobes shared functions to common file
  ARM: Add "action" table for kprobes/uprobes instruction
  ARM: add uprobes support

Rabin Vincent (3):
  uprobes: allow ignoring of probe hits
  uprobes: allow arch access to xol slot
  uprobes: allow arch-specific initialization

 arch/arm/Kconfig                   |   4 +
 arch/arm/include/asm/kprobes.h     |  17 +-
 arch/arm/include/asm/probes.h      |  23 ++
 arch/arm/include/asm/ptrace.h      |   6 +
 arch/arm/include/asm/thread_info.h |   5 +-
 arch/arm/include/asm/uprobes.h     |  34 +++
 arch/arm/kernel/Makefile           |   3 +-
 arch/arm/kernel/kprobes-arm.c      | 476 ++++++++-----------------------------
 arch/arm/kernel/kprobes-common.c   | 269 +--------------------
 arch/arm/kernel/kprobes-thumb.c    | 217 +++++++++++------
 arch/arm/kernel/kprobes.c          |  11 +-
 arch/arm/kernel/kprobes.h          |  64 ++---
 arch/arm/kernel/probes-arm.c       | 311 ++++++++++++++++++++++++
 arch/arm/kernel/probes-arm.h       |  60 +++++
 arch/arm/kernel/probes-thumb.h     |  59 +++++
 arch/arm/kernel/probes.c           | 325 +++++++++++++++++++++++++
 arch/arm/kernel/probes.h           |  35 +++
 arch/arm/kernel/signal.c           |   4 +
 arch/arm/kernel/uprobes-arm.c      | 221 +++++++++++++++++
 arch/arm/kernel/uprobes.c          | 203 ++++++++++++++++
 arch/arm/kernel/uprobes.h          |  25 ++
 arch/powerpc/include/asm/uprobes.h |   1 -
 arch/x86/include/asm/uprobes.h     |   7 -
 include/linux/uprobes.h            |  17 ++
 kernel/events/uprobes.c            |  58 ++++-
 25 files changed, 1668 insertions(+), 787 deletions(-)
 create mode 100644 arch/arm/include/asm/probes.h
 create mode 100644 arch/arm/include/asm/uprobes.h
 create mode 100644 arch/arm/kernel/probes-arm.c
 create mode 100644 arch/arm/kernel/probes-arm.h
 create mode 100644 arch/arm/kernel/probes-thumb.h
 create mode 100644 arch/arm/kernel/probes.c
 create mode 100644 arch/arm/kernel/probes.h
 create mode 100644 arch/arm/kernel/uprobes-arm.c
 create mode 100644 arch/arm/kernel/uprobes.c
 create mode 100644 arch/arm/kernel/uprobes.h

-- 
1.8.1.2
