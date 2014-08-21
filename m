From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 20 Aug 2014 18:20:32 -0700
Subject: [PATCHv3 0/7] Better page protections for arm64
Message-ID: <1408584039-12735-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v3 of the series to add stricter page protections for arm64
(Text should be read only, data/heap should be no execute etc.). There
are quite a few more patches in this series

Patch 1 - 4 address issues where text was ending up up in areas that
needed to be read only. Two of these patches were sent out before[1]
and two are new issues found with more testing (hotplug/suspend test cases)

Patch 5 - 6 add support for patching kernel text via fixmap. This matches
the same approach taken for arm.

Patch 7 is the patch to map memory with appropriate permissions.

This has been tested with 3 level page tables, 2 and 4 could use testing.

Thanks,
Laura


[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/261458.html

Laura Abbott (7):
  arm64: Treat handle_arch_irq as a function pointer
  arm64: Switch to ldr for loading the stub vectors
  arm64: Move cpu_resume into the text section
  arm64: Move some head.text functions to executable section
  arm64: Factor out fixmap initialiation from ioremap
  arm64: use fixmap for text patching when text is RO
  arm64: add better page protections to arm64

 arch/arm64/Kconfig                  |   8 +
 arch/arm64/Kconfig.debug            |  23 ++
 arch/arm64/include/asm/cacheflush.h |   3 +
 arch/arm64/include/asm/fixmap.h     |   8 +-
 arch/arm64/include/asm/insn.h       |   2 +
 arch/arm64/include/asm/irq.h        |   1 -
 arch/arm64/kernel/entry.S           |   6 +-
 arch/arm64/kernel/head.S            | 427 +++++++++++++++++++-----------------
 arch/arm64/kernel/insn.c            |  74 ++++++-
 arch/arm64/kernel/irq.c             |   2 +
 arch/arm64/kernel/jump_label.c      |   2 +-
 arch/arm64/kernel/setup.c           |   3 +-
 arch/arm64/kernel/sleep.S           |  12 +-
 arch/arm64/kernel/vmlinux.lds.S     |  18 ++
 arch/arm64/mm/init.c                |   1 +
 arch/arm64/mm/ioremap.c             |  93 +-------
 arch/arm64/mm/mm.h                  |   2 +
 arch/arm64/mm/mmu.c                 | 397 ++++++++++++++++++++++++++++++---
 18 files changed, 740 insertions(+), 342 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
