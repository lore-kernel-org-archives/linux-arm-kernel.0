From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  5 Jun 2014 11:06:10 +0200
Subject: [PATCH 2/5] ARM: nommu: don't limit TASK_SIZE
In-Reply-To: <1401959173-13117-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1401959173-13117-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1401959173-13117-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With TASK_SIZE set to the maximal RAM address booting in some XIP
configurations fails (e.g. on efm32 DK3750). The problem is that
strncpy_from_user et al. check for the address not being above TASK_SIZE
(since 8c56cc8be5b3 (ARM: 7449/1: use generic strnlen_user and
strncpy_from_user functions)) and this makes booting fail if the XIP
flash is above the RAM address space.

This change is in line with blackfin, frv and m68k which also use
0xffffffff for TASK_SIZE with !MMU.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/include/asm/memory.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 02fa2558f662..fc947b305f36 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -93,9 +93,7 @@
  * of this define that was meant to.
  * Fortunately, there is no reference for this in noMMU mode, for now.
  */
-#ifndef TASK_SIZE
-#define TASK_SIZE		(CONFIG_DRAM_SIZE)
-#endif
+#define TASK_SIZE		UL(0xffffffff)
 
 #ifndef TASK_UNMAPPED_BASE
 #define TASK_UNMAPPED_BASE	UL(0x00000000)
-- 
2.0.0.rc2
