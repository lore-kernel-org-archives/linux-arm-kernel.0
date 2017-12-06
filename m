From: will.deacon@arm.com (Will Deacon)
Date: Wed,  6 Dec 2017 11:16:06 +0000
Subject: [PATCH 0/2] Fixes for SW PAN
Message-ID: <1512558968-28980-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

After lots of collective head scratching in response to Vinayak's mail
here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2017-December/545641.html

It turns out that we have a problem with SW PAN and kernel threads, where
the saved ttbr0 value for a kernel thread can be stale and subsequently
inherited by other kernel threads over a fork.

These two patches attempt to fix that. We've not be able to reproduce
the exact failure reported above, but I added some assertions to the
uaccess routines to check for discrepancies between the active_mm pgd
and the saved ttbr0 value (ignoring the zero page) and these no longer
fire with these changes, but do fire without them if EFI runtime services
are enabled on my Seattle board.

Cheers,

Will

--->8

Will Deacon (2):
  arm64: SW PAN: Point saved ttbr0 at the zero page when switching to
    init_mm
  arm64: SW PAN: Update saved ttbr0 value on enter_lazy_tlb

 arch/arm64/include/asm/efi.h         |  4 +---
 arch/arm64/include/asm/mmu_context.h | 46 ++++++++++++++++++------------------
 2 files changed, 24 insertions(+), 26 deletions(-)

-- 
2.1.4
