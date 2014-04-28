From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 20:33:26 +0100
Subject: [PATCH 85/97] ARM: l2c: imx: convert to common l2c310 early resume
 functionality
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Message-ID: <E1WerIs-0001ZT-9t@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-imx/suspend-imx6.S | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend-imx6.S
index 20048ff05739..fe123b079c05 100644
--- a/arch/arm/mach-imx/suspend-imx6.S
+++ b/arch/arm/mach-imx/suspend-imx6.S
@@ -334,28 +334,10 @@ ENDPROC(imx6_suspend)
  * turned into relative ones.
  */
 
-#ifdef CONFIG_CACHE_L2X0
-	.macro	pl310_resume
-	adr	r0, l2x0_saved_regs_offset
-	ldr	r2, [r0]
-	add	r2, r2, r0
-	ldr	r0, [r2, #L2X0_R_PHY_BASE]	@ get physical base of l2x0
-	ldr	r1, [r2, #L2X0_R_AUX_CTRL]	@ get aux_ctrl value
-	str	r1, [r0, #L2X0_AUX_CTRL]	@ restore aux_ctrl
-	mov	r1, #0x1
-	str	r1, [r0, #L2X0_CTRL]		@ re-enable L2
-	.endm
-
-l2x0_saved_regs_offset:
-	.word	l2x0_saved_regs - .
-
-#else
-	.macro	pl310_resume
-	.endm
-#endif
-
 ENTRY(v7_cpu_resume)
 	bl	v7_invalidate_l1
-	pl310_resume
+#ifdef CONFIG_CACHE_L2X0
+	bl	l2c310_early_resume
+#endif
 	b	cpu_resume
 ENDPROC(v7_cpu_resume)
-- 
1.8.3.1
