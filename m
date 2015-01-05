From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Mon,  5 Jan 2015 18:33:53 +0000
Subject: [PATCH 0/2] arm64: don't call early_*map() post paging_init()
Message-ID: <1420482835-6444-1-git-send-email-leif.lindholm@linaro.org>
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

Leif Lindholm (2):
  arm64: don't make early_*map() calls post paging_init()
  arm64: call early_ioremap_reset() in paging_init()

 arch/arm64/kernel/efi.c   | 12 +++---------
 arch/arm64/kernel/setup.c |  2 --
 arch/arm64/mm/mmu.c       |  1 +
 3 files changed, 4 insertions(+), 11 deletions(-)

-- 
2.1.3
