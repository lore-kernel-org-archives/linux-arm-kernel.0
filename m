From: huawei.libin@huawei.com (Li Bin)
Date: Thu, 28 May 2015 13:51:00 +0800
Subject: [RFC PATCH 0/5] livepatch: add support on arm64
Message-ID: <1432792265-24076-1-git-send-email-huawei.libin@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset propose a method for gcc -mfentry feature(profile
before prologue) implementation for arm64, and propose the livepatch
implementation for arm64 based on this feature.
The gcc implementation about this feature will be post to the gcc 
community soon.

With this -mfentry feature, the entry of each function like:

foo:
    mov x9, x30 
    bl __fentry__
    mov x30, x9
    [prologue]
    ... 

The x9 is a callee corruptible register, and the __fentry__ function
is responsible to protect all registers, so it can be used to protect
the x30. And the added two instructions which is register mov operation
have ralatively small impact on performance.

This patchset has been tested on arm64 platform.

Li Bin (4):
  livepatch: ftrace: arm64: Add support for DYNAMIC_FTRACE_WITH_REGS
  livepatch: ftrace: add ftrace_function_stub_ip function
  livepatch: ftrace: arm64: Add support for -mfentry on arm64
  livepatch: arm64: add support for livepatch on arm64

Xie XiuQi (1):
  livepatch: arm64: support relocation in a module

 arch/arm64/Kconfig                 |    5 +
 arch/arm64/include/asm/ftrace.h    |    9 +
 arch/arm64/include/asm/livepatch.h |   45 +++++
 arch/arm64/kernel/Makefile         |    1 +
 arch/arm64/kernel/arm64ksyms.c     |    4 +
 arch/arm64/kernel/entry-ftrace.S   |  154 +++++++++++++++-
 arch/arm64/kernel/ftrace.c         |   28 +++-
 arch/arm64/kernel/livepatch.c      |   41 ++++
 arch/arm64/kernel/module.c         |  355 ++++++++++++++++++------------------
 include/linux/ftrace.h             |    1 +
 kernel/livepatch/core.c            |   17 ++-
 kernel/trace/ftrace.c              |   32 ++++
 scripts/recordmcount.pl            |    2 +-
 13 files changed, 508 insertions(+), 186 deletions(-)
 create mode 100644 arch/arm64/include/asm/livepatch.h
 create mode 100644 arch/arm64/kernel/livepatch.c
