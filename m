From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 1 Sep 2010 16:01:59 +0200
Subject: [PATCH] ARM: Implement cpu_v7_reset.
Message-ID: <1283349719-21115-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Per Fransson <per.xx.fransson@stericsson.com>

This implementation of cpu_v7_reset flushes the L1 cache
and turns off the MMU.

Signed-off-by: Per Fransson <per.xx.fransson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mm/proc-v7.S |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index d5d9b58..f2e2c92 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -63,7 +63,18 @@ ENDPROC(cpu_v7_proc_fin)
  */
 	.align	5
 ENTRY(cpu_v7_reset)
-	mov	pc, r0
+	mov     r4, r0
+	mov     ip, #0
+	bl      v7_flush_kern_cache_all         @ invalidate I,D caches
+	dsb                                     @ drain WB
+#ifdef CONFIG_MMU
+	mcr     p15, 0, ip, c8, c7, 0           @ invalidate I & D TLBs
+#endif
+	mrc     p15, 0, ip, c1, c0, 0           @ ctrl register
+	bic     ip, ip, #0x000f                 @ ............wcam
+	bic     ip, ip, #0x1100                 @ ...i...s........
+	mcr     p15, 0, ip, c1, c0, 0           @ ctrl register
+	mov     pc, r4
 ENDPROC(cpu_v7_reset)
 
 /*
-- 
1.6.3.3
