From: lauraa@codeaurora.org (Laura Abbott)
Date: Fri, 21 Nov 2014 13:50:37 -0800
Subject: [PATCHv6 0/8] Better page protections for arm64
Message-ID: <1416606645-25633-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v6 of the series to add stricter page protections for arm64.
The goal is to have text be RO/NX and everything else be RW/NX.
The biggest change here is the addition of ioremap_exec for EFI
services. The series did its job and caught EFI services trying to
use regular RAM for code purposes.

Laura Abbott (8):
  arm64: Treat handle_arch_irq as a function pointer
  arm64: Switch to adrp for loading the stub vectors
  arm64: Move cpu_resume into the text section
  arm64: Move some head.text functions to executable section
  arm64: Factor out fixmap initialiation from ioremap
  arm64: use fixmap for text patching when text is RO
  arm64: efi: Use ioremap_exec for code sections
  arm64: add better page protections to arm64

 arch/arm64/Kconfig.debug            |  23 ++
 arch/arm64/include/asm/cacheflush.h |   7 +
 arch/arm64/include/asm/fixmap.h     |   8 +-
 arch/arm64/include/asm/insn.h       |   2 +
 arch/arm64/include/asm/io.h         |   1 +
 arch/arm64/include/asm/irq.h        |   1 -
 arch/arm64/include/asm/pgtable.h    |   1 +
 arch/arm64/kernel/efi.c             |  12 +-
 arch/arm64/kernel/entry.S           |   6 +-
 arch/arm64/kernel/head.S            | 410 +++++++++++++++++++-----------------
 arch/arm64/kernel/insn.c            |  72 ++++++-
 arch/arm64/kernel/irq.c             |   2 +
 arch/arm64/kernel/jump_label.c      |   2 +-
 arch/arm64/kernel/setup.c           |   1 +
 arch/arm64/kernel/sleep.S           |  36 +---
 arch/arm64/kernel/suspend.c         |   4 +-
 arch/arm64/kernel/vmlinux.lds.S     |  18 +-
 arch/arm64/mm/init.c                |   1 +
 arch/arm64/mm/ioremap.c             |  99 ++-------
 arch/arm64/mm/mm.h                  |   2 +
 arch/arm64/mm/mmu.c                 | 405 +++++++++++++++++++++++++++++++----
 21 files changed, 740 insertions(+), 373 deletions(-)

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
