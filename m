From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Tue, 26 Oct 2010 11:16:01 -0500
Subject: [PATCH v2 2/4] OMAP3: PM: update DSP reset code to use new SCM DSP
	boot control functions
In-Reply-To: <1288109763-9446-1-git-send-email-omar.ramirez@ti.com>
References: <1288109763-9446-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <1288109763-9446-3-git-send-email-omar.ramirez@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Paul Walmsley <paul@pwsan.com>

Update the DSP reset code in pm34xx.c to use one of the new SCM DSP
boot control functions, omap2430_ctrl_set_dsp_bootmode().

This reset code should be moved out to a separate function to be
called by the hwmod reset process at some point.  Also, 2430
should be initializing the DSP in a similar fashion.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 8c8f1ac..b90b1fb 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -37,6 +37,7 @@
 #include <plat/prcm.h>
 #include <plat/gpmc.h>
 #include <plat/dma.h>
+#include <plat/iva2_dsp.h>
 
 #include <asm/tlbflush.h>
 
@@ -614,6 +615,7 @@ static struct platform_suspend_ops omap_pm_ops = {
  * function forces the IVA2 into idle state so it can go
  * into retention/off and thus allow full-chip retention/off.
  *
+ * XXX This should be handled by the hwmod.
  **/
 static void __init omap3_iva_idle(void)
 {
@@ -635,9 +637,7 @@ static void __init omap3_iva_idle(void)
 	cm_write_mod_reg(OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_MASK,
 			 OMAP3430_IVA2_MOD, CM_FCLKEN);
 
-	/* Set IVA2 boot mode to 'idle' */
-	omap_ctrl_writel(OMAP3_IVA2_BOOTMOD_IDLE,
-			 OMAP343X_CONTROL_IVA2_BOOTMOD);
+	omap2430_ctrl_set_dsp_bootmode(OMAP_IVA2_DSP_BOOTMODE_IDLE);
 
 	/* Un-reset IVA2 */
 	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
-- 
1.7.1
