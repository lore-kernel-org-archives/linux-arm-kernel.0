From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 19 Sep 2011 15:11:37 -0700
Subject: [PATCH] arm: Add unwinding annotations for 64bit division functions
Message-ID: <1316470297-5063-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 64bit division functions never had unwinding annotations
added. This prevents a backtrace from being printed within
the function and if a division by 0 occurs. Add the annotations.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/lib/div64.S |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/lib/div64.S b/arch/arm/lib/div64.S
index faa7748..e55c484 100644
--- a/arch/arm/lib/div64.S
+++ b/arch/arm/lib/div64.S
@@ -13,6 +13,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/unwind.h>
 
 #ifdef __ARMEB__
 #define xh r0
@@ -44,6 +45,7 @@
  */
 
 ENTRY(__do_div64)
+UNWIND(.fnstart)
 
 	@ Test for easy paths first.
 	subs	ip, r4, #1
@@ -189,7 +191,12 @@ ENTRY(__do_div64)
 	moveq	yh, xh
 	moveq	xh, #0
 	moveq	pc, lr
+UNWIND(.fnend)
 
+UNWIND(.fnstart)
+UNWIND(.pad #4)
+UNWIND(.save {lr})
+Ldiv0_64:
 	@ Division by 0:
 	str	lr, [sp, #-8]!
 	bl	__div0
@@ -200,4 +207,5 @@ ENTRY(__do_div64)
 	mov	xh, #0
 	ldr	pc, [sp], #8
 
+UNWIND(.fnend)
 ENDPROC(__do_div64)
-- 
1.7.3.3
