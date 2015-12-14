From: huawei.libin@huawei.com (Li Bin)
Date: Mon, 14 Dec 2015 20:49:35 +0800
Subject: [RFC PATCH 0/3] livepatch: arm64: add support for livepatch on arm64
Message-ID: <1450097378-3780-1-git-send-email-huawei.libin@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset depends on the on-going gcc feature "-fprolog-pad=N",
which will generate a pad of N nops at the beginning of each function.

Livepatch on arm64 can using the feature (that always placing one nop
at the beginning of the function). And when enable/disable func patching,
just modify the pad code to nop or branch. And that NOP and B instruction
are both safe instructions on arm64 which called "concurrent modification
and execution of instructions", that can be executed by one thread of
execution as they are being modified by another thread of execution without
requiring explicit synchronization.

And this method will improve performance significantly compared with the
method based on ftrace, especially for the critical function being frequently
called.

Li Bin (3):
  livepatch: allow arch specific implementation
  livepatch: module: arm64: extract the relocation code for reuse
  livepatch: arm64: add support for livepatch on arm64

 Makefile                           |    7 +-
 arch/arm64/Kconfig                 |    4 +
 arch/arm64/include/asm/livepatch.h |   45 +++++
 arch/arm64/include/asm/module.h    |    3 +
 arch/arm64/kernel/Makefile         |    1 +
 arch/arm64/kernel/livepatch.c      |  123 ++++++++++++
 arch/arm64/kernel/module.c         |  360 ++++++++++++++++++------------------
 kernel/livepatch/Kconfig           |   10 +-
 kernel/livepatch/core.c            |   45 +++--
 9 files changed, 403 insertions(+), 195 deletions(-)
 create mode 100644 arch/arm64/include/asm/livepatch.h
 create mode 100644 arch/arm64/kernel/livepatch.c
