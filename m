From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 4 Mar 2014 18:19:09 +0200
Subject: [PATCH 09/18] ARM: OMAP3: PRM: add API for saving PRM scratchpad
 contents
In-Reply-To: <1393949958-816-1-git-send-email-t-kristo@ti.com>
References: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Message-ID: <1393949958-816-10-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This isolates the PRM register access within the PRM driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/control.c |   11 ++---------
 arch/arm/mach-omap2/prm3xxx.c |    9 +++++++++
 arch/arm/mach-omap2/prm3xxx.h |    1 +
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 4322135..5eb991a 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -44,8 +44,7 @@ struct omap3_scratchpad {
 };
 
 struct omap3_scratchpad_prcm_block {
-	u32 prm_clksrc_ctrl;
-	u32 prm_clksel;
+	u32 prm_contents[2];
 	u32 cm_contents[11];
 	u32 prcm_block_size;
 };
@@ -327,13 +326,7 @@ void omap3_save_scratchpad_contents(void)
 	scratchpad_contents.sdrc_block_offset = 0x64;
 
 	/* Populate the PRCM block contents */
-	prcm_block_contents.prm_clksrc_ctrl =
-		omap2_prm_read_mod_reg(OMAP3430_GR_MOD,
-				       OMAP3_PRM_CLKSRC_CTRL_OFFSET);
-	prcm_block_contents.prm_clksel =
-		omap2_prm_read_mod_reg(OMAP3430_CCR_MOD,
-				       OMAP3_PRM_CLKSEL_OFFSET);
-
+	omap3_prm_save_scratchpad_contents(prcm_block_contents.prm_contents);
 	omap3_cm_save_scratchpad_contents(prcm_block_contents.cm_contents);
 
 	prcm_block_contents.prcm_block_size = 0x0;
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 2a6be73..9ebc22c 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -408,6 +408,15 @@ int omap3xxx_prm_clear_global_cold_reset(void)
 	return 0;
 }
 
+void omap3_prm_save_scratchpad_contents(u32 *ptr)
+{
+	*ptr++ = omap2_prm_read_mod_reg(OMAP3430_GR_MOD,
+					OMAP3_PRM_CLKSRC_CTRL_OFFSET);
+
+	*ptr++ = omap2_prm_read_mod_reg(OMAP3430_GR_MOD,
+					OMAP3_PRM_CLKSEL_OFFSET);
+}
+
 /* Powerdomain low-level functions */
 
 static int omap3_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index 12ff4a0..829cdc3 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -166,6 +166,7 @@ int omap3xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits);
 void omap3xxx_prm_iva_idle(void);
 void omap3_prm_reset_modem(void);
 int omap3xxx_prm_clear_global_cold_reset(void);
+void omap3_prm_save_scratchpad_contents(u32 *ptr);
 
 #endif /* __ASSEMBLER */
 
-- 
1.7.9.5
