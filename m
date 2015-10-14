From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Wed, 14 Oct 2015 10:51:17 +0800
Subject: [PATCH] ARM: SWP emulation: Restore original *data when failed
Message-ID: <1444791077-26020-1-git-send-email-shengjiu.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__user_swpX_asm maybe failed in first STREX operation, emulate_swpX
will try again, but the *data has been changed in first time. which
cause the result is wrong. So need to recover the *data when failed.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 arch/arm/kernel/swp_emulate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/swp_emulate.c b/arch/arm/kernel/swp_emulate.c
index 5b26e7e..c61fbf92 100644
--- a/arch/arm/kernel/swp_emulate.c
+++ b/arch/arm/kernel/swp_emulate.c
@@ -41,6 +41,7 @@
 	"1:	strex"B"	%0, %2, [%3]\n"			\
 	"	cmp		%0, #0\n"			\
 	"	movne		%0, %4\n"			\
+	"	movne		%1, %2\n"			\
 	"2:\n"							\
 	"	.section	 .text.fixup,\"ax\"\n"		\
 	"	.align		2\n"				\
-- 
1.9.1
