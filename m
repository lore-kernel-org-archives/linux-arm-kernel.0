From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 May 2013 17:25:37 -0700
Subject: [PATCH] ARM: OMAP3: Fix iva2_pwrdm settings for 3703
Message-ID: <20130515002537.GG5600@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a819c4f1 (ARM: OMAP3: PM: Only access IVA if one exists)
changed PM to not access IVA registers on omaps that don't have
them. Turns out we still need to idle iva2 as otherwise iva2_pwrdm
will stay on and block deeper idle states.

Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Paul & Kevin, do you have better ideas for fixing this?

--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -546,8 +546,10 @@ static void __init prcm_setup_regs(void)
 	/* Clear any pending PRCM interrupts */
 	omap2_prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 
-	if (omap3_has_iva())
-		omap3_iva_idle();
+	/*
+	 * We need to idle iva2_pwrdm even on am3703 with no iva2.
+	 */
+	omap3_iva_idle();
 
 	omap3_d2d_idle();
 }
