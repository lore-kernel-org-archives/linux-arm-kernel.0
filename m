From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 13 Jul 2012 18:18:34 +0530
Subject: [PATCH] ARM: OMAP4: sleep: Save the complete used register stack frame
Message-ID: <1342183715-13734-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP4 sleep entry code even though itself don't use many CPU registers
makes call to the v7_flush_dcache_all() which uses them. Since
v7_flush_dcache_all() doesn't make use of stack, the caller must take
care of the stack frame. Otherwise it will lead to corrupted stack frame.

Fix it by saving used registers.

Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/sleep44xx.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
index 9f6b83d..b5823e9 100644
--- a/arch/arm/mach-omap2/sleep44xx.S
+++ b/arch/arm/mach-omap2/sleep44xx.S
@@ -58,7 +58,7 @@ ppa_por_params:
  * CPU failed to transition to targeted OFF/DORMANT state.
  */
 ENTRY(omap4_finish_suspend)
-	stmfd	sp!, {lr}
+	stmfd	sp!, {r4-r12, lr}
 	cmp	r0, #0x0
 	beq	do_WFI				@ No lowpower state, jump to WFI
 
@@ -226,7 +226,7 @@ scu_gp_clear:
 skip_scu_gp_clear:
 	isb
 	dsb
-	ldmfd	sp!, {pc}
+	ldmfd	sp!, {r4-r12, pc}
 ENDPROC(omap4_finish_suspend)
 
 /*
-- 
1.7.9.5
