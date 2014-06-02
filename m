From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon,  2 Jun 2014 13:57:34 -0700
Subject: [PATCHv2 0/4] Page protections for arm64
Message-ID: <1401742658-11841-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v2 of adding page protections for arm64. This implements
CONFIG_DEBUG_SET_MODULE_RONX for modules and adds similar protections
for direct mapped memory. The module portion (1/4) should be ready for
merging assuming no more issues are found (I know I'm off cycle here).

v2:
 - Added a memory barrier after flush_tlb_kernel_range per request of
   Steve Capper.
 - Dropped the ENTRY per Will in handle_arch_irq
 - Added the Kconfig to align sections up to SECTION_SIZE. Added a patch
   to fix the related relocation errors from this option.

Laura Abbott (4):
  arm64: Add CONFIG_DEBUG_SET_MODULE_RONX support
  arm64: Treat handle_arch_irq as a function pointer
  arm64: Switch to ldr for loading the stub vectors
  arm64: add better page protections to arm64

 arch/arm64/Kconfig.debug            |  34 +++++++
 arch/arm64/include/asm/cacheflush.h |   4 +
 arch/arm64/kernel/entry.S           |   8 +-
 arch/arm64/kernel/head.S            |   2 +-
 arch/arm64/kernel/vmlinux.lds.S     |  17 ++++
 arch/arm64/mm/Makefile              |   2 +-
 arch/arm64/mm/init.c                |   1 +
 arch/arm64/mm/mm.h                  |   2 +
 arch/arm64/mm/mmu.c                 | 173 ++++++++++++++++++++++++++++++++----
 arch/arm64/mm/pageattr.c            | 121 +++++++++++++++++++++++++
 10 files changed, 344 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm64/mm/pageattr.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
