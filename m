From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 17 Nov 2014 16:54:58 -0800
Subject: [PATCHv5 0/7] Better page protections for arm64
Message-ID: <1416272105-14787-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v5 of the series to add stricter page protections for arm64.
The goal is to have text be RO/NX and everything else be RW/NX.
I finally got my hands on a Juno board so I was able to do more
testing with both 4K and 64K pages although I still haven't tested
with EFI. This is based off of 3.18-rc5.

Thanks,
Laura

Laura Abbott (7):
  arm64: Treat handle_arch_irq as a function pointer
  arm64: Switch to adrp for loading the stub vectors
  arm64: Move cpu_resume into the text section
  arm64: Move some head.text functions to executable section
  arm64: Factor out fixmap initialiation from ioremap
  arm64: use fixmap for text patching when text is RO
  arm64: add better page protections to arm64

 arch/arm64/Kconfig.debug            |  23 ++
 arch/arm64/include/asm/cacheflush.h |   4 +
 arch/arm64/include/asm/fixmap.h     |   8 +-
 arch/arm64/include/asm/insn.h       |   2 +
 arch/arm64/include/asm/irq.h        |   1 -
 arch/arm64/kernel/entry.S           |   6 +-
 arch/arm64/kernel/head.S            | 409 +++++++++++++++++-----------------
 arch/arm64/kernel/insn.c            |  72 +++++-
 arch/arm64/kernel/irq.c             |   2 +
 arch/arm64/kernel/jump_label.c      |   2 +-
 arch/arm64/kernel/setup.c           |   1 +
 arch/arm64/kernel/sleep.S           |  29 +--
 arch/arm64/kernel/suspend.c         |   4 +-
 arch/arm64/kernel/vmlinux.lds.S     |  21 ++
 arch/arm64/mm/init.c                |   1 +
 arch/arm64/mm/ioremap.c             |  93 +-------
 arch/arm64/mm/mm.h                  |   2 +
 arch/arm64/mm/mmu.c                 | 429 ++++++++++++++++++++++++++++++++----
 18 files changed, 743 insertions(+), 366 deletions(-)

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
