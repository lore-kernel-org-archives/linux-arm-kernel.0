From: eric.miao@linaro.org (Eric Miao)
Date: Thu, 22 Dec 2011 11:55:01 +0800
Subject: [PATCH] ARM: imx6q: resume PL310 only when CACHE_L2X0 defined
Message-ID: <1324526101-7140-1-git-send-email-eric.miao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Original patch from Lothar Wa?mann, this patch fixes a building error
when CONFIG_CACHE_L2X0 is not defined.

Cc: Lothar Wa?mann <lw@karo-electronics.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Eric Miao <eric.miao@linaro.org>
---
 arch/arm/mach-imx/head-v7.S |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/head-v7.S b/arch/arm/mach-imx/head-v7.S
index a59cae7..cec23a8 100644
--- a/arch/arm/mach-imx/head-v7.S
+++ b/arch/arm/mach-imx/head-v7.S
@@ -80,6 +80,7 @@ ENDPROC(v7_secondary_startup)
 	.data
 	.align
 
+#ifdef CONFIG_CACHE_L2X0
 	.macro	pl310_resume
 	ldr	r2, phys_l2x0_saved_regs
 	ldr	r0, [r2, #L2X0_R_PHY_BASE]	@ get physical base of l2x0
@@ -89,13 +90,17 @@ ENDPROC(v7_secondary_startup)
 	str	r1, [r0, #L2X0_CTRL]		@ re-enable L2
 	.endm
 
+	.globl	phys_l2x0_saved_regs
+phys_l2x0_saved_regs:
+        .long   0
+#else
+	.macro	pl310_resume
+	.endm
+#endif
+
 ENTRY(v7_cpu_resume)
 	bl	v7_invalidate_l1
 	pl310_resume
 	b	cpu_resume
 ENDPROC(v7_cpu_resume)
-
-	.globl	phys_l2x0_saved_regs
-phys_l2x0_saved_regs:
-        .long   0
 #endif
-- 
1.7.5.4
