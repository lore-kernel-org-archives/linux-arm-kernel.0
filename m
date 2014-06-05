From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  5 Jun 2014 11:06:11 +0200
Subject: [PATCH 3/5] ARM: nommu: simplify definition of MODULES_END
In-Reply-To: <1401959173-13117-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1401959173-13117-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1401959173-13117-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The definition of MODULES_END is the last user of CONFIG_DRAM_SIZE.
Just to define this limit hardly justifies to keep the compile time
setting about the RAM size which makes it harder to compile a kernel for
more than one machine. Still more as MODULES_END is hardly used on !MMU
apart from the memory layout info during boot up.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/include/asm/memory.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index fc947b305f36..f5b8b145d9a2 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -99,14 +99,10 @@
 #define TASK_UNMAPPED_BASE	UL(0x00000000)
 #endif
 
-#ifndef END_MEM
-#define END_MEM     		(UL(CONFIG_DRAM_BASE) + CONFIG_DRAM_SIZE)
-#endif
-
 /*
  * The module can be at any place in ram in nommu mode.
  */
-#define MODULES_END		(END_MEM)
+#define MODULES_END		UL(0xffffffff)
 #define MODULES_VADDR		PAGE_OFFSET
 
 #define XIP_VIRT_ADDR(physaddr)  (physaddr)
-- 
2.0.0.rc2
