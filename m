From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Thu, 15 Oct 2015 17:30:11 +0800
Subject: [PATCH V2] ARM: SWP emulation: Restore original *data when failed
Message-ID: <726a7ce88982fba5df84e4d22b083e39b57a6bc6.1444900732.git.shengjiu.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__user_swpX_asm maybe failed in first STREX operation, emulate_swpX
will try again, but the *data has been changed in first time. which
causes the result is wrong.
This patch is to fix this issue. When STREX succeed, change the *data.
if it fail, *data is not changed.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 arch/arm/kernel/swp_emulate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/swp_emulate.c b/arch/arm/kernel/swp_emulate.c
index 5b26e7e..c3fe769d 100644
--- a/arch/arm/kernel/swp_emulate.c
+++ b/arch/arm/kernel/swp_emulate.c
@@ -36,10 +36,10 @@
  */
 #define __user_swpX_asm(data, addr, res, temp, B)		\
 	__asm__ __volatile__(					\
-	"	mov		%2, %1\n"			\
-	"0:	ldrex"B"	%1, [%3]\n"			\
-	"1:	strex"B"	%0, %2, [%3]\n"			\
+	"0:	ldrex"B"	%2, [%3]\n"			\
+	"1:	strex"B"	%0, %1, [%3]\n"			\
 	"	cmp		%0, #0\n"			\
+	"	moveq		%1, %2\n"			\
 	"	movne		%0, %4\n"			\
 	"2:\n"							\
 	"	.section	 .text.fixup,\"ax\"\n"		\
-- 
1.9.1
