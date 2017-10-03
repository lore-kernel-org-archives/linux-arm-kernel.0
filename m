From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  3 Oct 2017 17:23:04 +0200
Subject: [PATCH] ARM: head-common.S: Clear lr before jumping to start_kernel()
Message-ID: <1507044184-27152-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_DEBUG_LOCK_ALLOC=y, the kernel log is spammed with a few
hundred identical messages:

    unwind: Unknown symbol address c0800300
    unwind: Index not found c0800300

c0800300 is the return address from the last subroutine call (to
__memzero()) in __mmap_switched().  Apparently having this address in
the link register confuses the unwinder.

To fix this, reset the link register to zero before jumping to
start_kernel().

Fixes: 9520b1a1b5f7a348 ("ARM: head-common.S: speed up startup code")
Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Commit 9520b1a1b5f7a348 is in arm/for-next.

 arch/arm/kernel/head-common.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index a25027b87a6024b9..21dde771a7dd8d14 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -114,6 +114,7 @@ __mmap_switched:
 	str	r8, [r2]			@ Save atags pointer
 	cmp	r3, #0
 	strne	r10, [r3]			@ Save control register values
+	mov	lr, #0
 	b	start_kernel
 ENDPROC(__mmap_switched)
 
-- 
2.7.4
