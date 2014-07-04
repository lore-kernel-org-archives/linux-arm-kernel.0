From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 4 Jul 2014 17:10:29 +0300
Subject: [PATCH 04/10] ARM: OMAP3: PRM: add API for checking and clearing cold
 reset status
In-Reply-To: <1404483035-21666-1-git-send-email-t-kristo@ti.com>
References: <1404483035-21666-1-git-send-email-t-kristo@ti.com>
Message-ID: <1404483035-21666-5-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This isolates the PRM register access within the PRM driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/control.c |    6 +-----
 arch/arm/mach-omap2/prm3xxx.c |   20 ++++++++++++++++++++
 arch/arm/mach-omap2/prm3xxx.h |    1 +
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 751f354..f8eb3e4 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -282,13 +282,9 @@ void omap3_clear_scratchpad_contents(void)
 	void __iomem *v_addr;
 	u32 offset = 0;
 	v_addr = OMAP2_L4_IO_ADDRESS(OMAP343X_SCRATCHPAD_ROM);
-	if (omap2_prm_read_mod_reg(OMAP3430_GR_MOD, OMAP3_PRM_RSTST_OFFSET) &
-	    OMAP3430_GLOBAL_COLD_RST_MASK) {
+	if (omap3xxx_prm_clear_global_cold_reset()) {
 		for ( ; offset <= max_offset; offset += 0x4)
 			writel_relaxed(0x0, (v_addr + offset));
-		omap2_prm_set_mod_reg_bits(OMAP3430_GLOBAL_COLD_RST_MASK,
-					   OMAP3430_GR_MOD,
-					   OMAP3_PRM_RSTST_OFFSET);
 	}
 }
 
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index e46ff71..4733c28 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -389,6 +389,26 @@ void omap3xxx_prm_iva_idle(void)
 				OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
 }
 
+/**
+ * omap3xxx_prm_clear_global_cold_reset - checks the global cold reset status
+ *					  and clears it if asserted
+ *
+ * Checks if cold-reset has occurred and clears the status bit if yes. Returns
+ * 1 if cold-reset has occurred, 0 otherwise.
+ */
+int omap3xxx_prm_clear_global_cold_reset(void)
+{
+	if (omap2_prm_read_mod_reg(OMAP3430_GR_MOD, OMAP3_PRM_RSTST_OFFSET) &
+	    OMAP3430_GLOBAL_COLD_RST_MASK) {
+		omap2_prm_set_mod_reg_bits(OMAP3430_GLOBAL_COLD_RST_MASK,
+					   OMAP3430_GR_MOD,
+					   OMAP3_PRM_RSTST_OFFSET);
+		return 1;
+	}
+
+	return 0;
+}
+
 /* Powerdomain low-level functions */
 
 static int omap3_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index 21eb1d5..7548ae0 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -165,6 +165,7 @@ extern u32 omap3xxx_prm_get_reset_sources(void);
 int omap3xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits);
 void omap3xxx_prm_iva_idle(void);
 void omap3_prm_reset_modem(void);
+int omap3xxx_prm_clear_global_cold_reset(void);
 
 #endif /* __ASSEMBLER */
 
-- 
1.7.9.5
