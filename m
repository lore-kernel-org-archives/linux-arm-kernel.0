From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue,  6 Jan 2015 13:41:11 +0000
Subject: [PATCH v2 0/2] arm64: don't call early_*map() post paging_init()
Message-ID: <1420551673-31416-1-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This (tiny) series resolves a fairly serious problem with
early_ioremap/iounmap/memremap/memunmap on arm64. These functions
cannot safely be called after paging_init(), but the sanity check
was not triggering.

As a result, a fixmap entry was incorrectly cleared during
early_initcalls on arm64 UEFI systems.

1/2 reworks the arm64 UEFI support code to not attempt these calls
and
2/2 enables the sanity check

Changes since v1:
- Rebased to v3.19-rc3
- Added 'Fixes:' tags
- Reworked 1/2 to restore call to efi_setup_idmap() to the original
  location in the boot process.

Leif Lindholm (2):
  arm64: don't make early_*map() calls post paging_init()
  arm64: call early_ioremap_reset() in paging_init()

 arch/arm64/include/asm/efi.h |  4 ++--
 arch/arm64/kernel/efi.c      | 27 ++++++++++++++-------------
 arch/arm64/kernel/setup.c    |  2 +-
 arch/arm64/mm/mmu.c          |  1 +
 4 files changed, 18 insertions(+), 16 deletions(-)

-- 
2.1.3
