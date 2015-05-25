From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 25 May 2015 18:00:25 +0300
Subject: =?UTF-8?q?=5BPATCHv3=2020/27=5D=20clk=3A=20ti=3A=20omap34xx=3A=20move=20omap34xx=20clock=20type=20support=20code=20to=20clock=20driver?=
In-Reply-To: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Message-ID: <1432566032-10860-21-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the legacy clock data gone, this is no longer needed under platform,
so move it under the clock driver itself. Remove unnecessary declarations
from the TI clock header also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/Makefile    |    2 +-
 arch/arm/mach-omap2/clock34xx.c |  138 ---------------------------------------
 drivers/clk/ti/clk-3xxx.c       |  118 +++++++++++++++++++++++++++++++++
 drivers/clk/ti/clock.h          |    4 ++
 include/linux/clk/ti.h          |    4 --
 5 files changed, 123 insertions(+), 143 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clock34xx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 695d58f..22d2e48 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -186,7 +186,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpllcore.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_virt_prcm_set.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpll.o
 obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common)
-obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o clkt34xx_dpll3m2.o
+obj-$(CONFIG_ARCH_OMAP3)		+= clkt34xx_dpll3m2.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock3517.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common)
 obj-$(CONFIG_SOC_AM33XX)		+= $(clock-common)
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
deleted file mode 100644
index 4596468..0000000
--- a/arch/arm/mach-omap2/clock34xx.c
+++ /dev/null
@@ -1,138 +0,0 @@
-/*
- * OMAP3-specific clock framework functions
- *
- * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * Copyright (C) 2007-2011 Nokia Corporation
- *
- * Paul Walmsley
- * Jouni H?gander
- *
- * Parts of this code are based on code written by
- * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu,
- * Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#undef DEBUG
-
-#include <linux/kernel.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-
-#include "clock.h"
-#include "clock34xx.h"
-#include "cm3xxx.h"
-#include "cm-regbits-34xx.h"
-
-/**
- * omap3430es2_clk_ssi_find_idlest - return CM_IDLEST info for SSI
- * @clk: struct clk * being enabled
- * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
- * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
- * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
- *
- * The OMAP3430ES2 SSI target CM_IDLEST bit is at a different shift
- * from the CM_{I,F}CLKEN bit.  Pass back the correct info via
- * @idlest_reg and @idlest_bit.  No return value.
- */
-static void omap3430es2_clk_ssi_find_idlest(struct clk_hw_omap *clk,
-					    void __iomem **idlest_reg,
-					    u8 *idlest_bit,
-					    u8 *idlest_val)
-{
-	u32 r;
-
-	r = (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
-	*idlest_reg = (__force void __iomem *)r;
-	*idlest_bit = OMAP3430ES2_ST_SSI_IDLE_SHIFT;
-	*idlest_val = OMAP34XX_CM_IDLEST_VAL;
-}
-const struct clk_hw_omap_ops clkhwops_omap3430es2_ssi_wait = {
-	.find_idlest	= omap3430es2_clk_ssi_find_idlest,
-	.find_companion	= omap2_clk_dflt_find_companion,
-};
-
-const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_ssi_wait = {
-	.allow_idle	= omap2_clkt_iclk_allow_idle,
-	.deny_idle	= omap2_clkt_iclk_deny_idle,
-	.find_idlest	= omap3430es2_clk_ssi_find_idlest,
-	.find_companion = omap2_clk_dflt_find_companion,
-};
-
-/**
- * omap3430es2_clk_dss_usbhost_find_idlest - CM_IDLEST info for DSS, USBHOST
- * @clk: struct clk * being enabled
- * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
- * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
- * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
- *
- * Some OMAP modules on OMAP3 ES2+ chips have both initiator and
- * target IDLEST bits.  For our purposes, we are concerned with the
- * target IDLEST bits, which exist at a different bit position than
- * the *CLKEN bit position for these modules (DSS and USBHOST) (The
- * default find_idlest code assumes that they are at the same
- * position.)  No return value.
- */
-static void omap3430es2_clk_dss_usbhost_find_idlest(struct clk_hw_omap *clk,
-						    void __iomem **idlest_reg,
-						    u8 *idlest_bit,
-						    u8 *idlest_val)
-{
-	u32 r;
-
-	r = (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
-	*idlest_reg = (__force void __iomem *)r;
-	/* USBHOST_IDLE has same shift */
-	*idlest_bit = OMAP3430ES2_ST_DSS_IDLE_SHIFT;
-	*idlest_val = OMAP34XX_CM_IDLEST_VAL;
-}
-
-const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_wait = {
-	.find_idlest	= omap3430es2_clk_dss_usbhost_find_idlest,
-	.find_companion	= omap2_clk_dflt_find_companion,
-};
-
-const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_dss_usbhost_wait = {
-	.allow_idle	= omap2_clkt_iclk_allow_idle,
-	.deny_idle	= omap2_clkt_iclk_deny_idle,
-	.find_idlest	= omap3430es2_clk_dss_usbhost_find_idlest,
-	.find_companion	= omap2_clk_dflt_find_companion,
-};
-
-/**
- * omap3430es2_clk_hsotgusb_find_idlest - return CM_IDLEST info for HSOTGUSB
- * @clk: struct clk * being enabled
- * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
- * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
- * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
- *
- * The OMAP3430ES2 HSOTGUSB target CM_IDLEST bit is at a different
- * shift from the CM_{I,F}CLKEN bit.  Pass back the correct info via
- * @idlest_reg and @idlest_bit.  No return value.
- */
-static void omap3430es2_clk_hsotgusb_find_idlest(struct clk_hw_omap *clk,
-						 void __iomem **idlest_reg,
-						 u8 *idlest_bit,
-						 u8 *idlest_val)
-{
-	u32 r;
-
-	r = (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
-	*idlest_reg = (__force void __iomem *)r;
-	*idlest_bit = OMAP3430ES2_ST_HSOTGUSB_IDLE_SHIFT;
-	*idlest_val = OMAP34XX_CM_IDLEST_VAL;
-}
-
-const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_hsotgusb_wait = {
-	.allow_idle	= omap2_clkt_iclk_allow_idle,
-	.deny_idle	= omap2_clkt_iclk_deny_idle,
-	.find_idlest	= omap3430es2_clk_hsotgusb_find_idlest,
-	.find_companion	= omap2_clk_dflt_find_companion,
-};
-
-const struct clk_hw_omap_ops clkhwops_omap3430es2_hsotgusb_wait = {
-	.find_idlest	= omap3430es2_clk_hsotgusb_find_idlest,
-	.find_companion	= omap2_clk_dflt_find_companion,
-};
diff --git a/drivers/clk/ti/clk-3xxx.c b/drivers/clk/ti/clk-3xxx.c
index 5489ad8..58879f0 100644
--- a/drivers/clk/ti/clk-3xxx.c
+++ b/drivers/clk/ti/clk-3xxx.c
@@ -28,6 +28,124 @@
  */
 #define DPLL5_FREQ_FOR_USBHOST		120000000
 
+#define OMAP3430ES2_ST_DSS_IDLE_SHIFT			1
+#define OMAP3430ES2_ST_HSOTGUSB_IDLE_SHIFT		5
+#define OMAP3430ES2_ST_SSI_IDLE_SHIFT			8
+
+#define OMAP34XX_CM_IDLEST_VAL				1
+
+/**
+ * omap3430es2_clk_ssi_find_idlest - return CM_IDLEST info for SSI
+ * @clk: struct clk * being enabled
+ * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
+ * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
+ *
+ * The OMAP3430ES2 SSI target CM_IDLEST bit is at a different shift
+ * from the CM_{I,F}CLKEN bit.  Pass back the correct info via
+ * @idlest_reg and @idlest_bit.  No return value.
+ */
+static void omap3430es2_clk_ssi_find_idlest(struct clk_hw_omap *clk,
+					    void __iomem **idlest_reg,
+					    u8 *idlest_bit,
+					    u8 *idlest_val)
+{
+	u32 r;
+
+	r = (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
+	*idlest_reg = (__force void __iomem *)r;
+	*idlest_bit = OMAP3430ES2_ST_SSI_IDLE_SHIFT;
+	*idlest_val = OMAP34XX_CM_IDLEST_VAL;
+}
+
+const struct clk_hw_omap_ops clkhwops_omap3430es2_ssi_wait = {
+	.find_idlest	= omap3430es2_clk_ssi_find_idlest,
+	.find_companion	= omap2_clk_dflt_find_companion,
+};
+
+const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_ssi_wait = {
+	.allow_idle	= omap2_clkt_iclk_allow_idle,
+	.deny_idle	= omap2_clkt_iclk_deny_idle,
+	.find_idlest	= omap3430es2_clk_ssi_find_idlest,
+	.find_companion	= omap2_clk_dflt_find_companion,
+};
+
+/**
+ * omap3430es2_clk_dss_usbhost_find_idlest - CM_IDLEST info for DSS, USBHOST
+ * @clk: struct clk * being enabled
+ * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
+ * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
+ *
+ * Some OMAP modules on OMAP3 ES2+ chips have both initiator and
+ * target IDLEST bits.  For our purposes, we are concerned with the
+ * target IDLEST bits, which exist at a different bit position than
+ * the *CLKEN bit position for these modules (DSS and USBHOST) (The
+ * default find_idlest code assumes that they are at the same
+ * position.)  No return value.
+ */
+static void omap3430es2_clk_dss_usbhost_find_idlest(struct clk_hw_omap *clk,
+						    void __iomem **idlest_reg,
+						    u8 *idlest_bit,
+						    u8 *idlest_val)
+{
+	u32 r;
+
+	r = (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
+	*idlest_reg = (__force void __iomem *)r;
+	/* USBHOST_IDLE has same shift */
+	*idlest_bit = OMAP3430ES2_ST_DSS_IDLE_SHIFT;
+	*idlest_val = OMAP34XX_CM_IDLEST_VAL;
+}
+
+const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_wait = {
+	.find_idlest	= omap3430es2_clk_dss_usbhost_find_idlest,
+	.find_companion	= omap2_clk_dflt_find_companion,
+};
+
+const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_dss_usbhost_wait = {
+	.allow_idle	= omap2_clkt_iclk_allow_idle,
+	.deny_idle	= omap2_clkt_iclk_deny_idle,
+	.find_idlest	= omap3430es2_clk_dss_usbhost_find_idlest,
+	.find_companion	= omap2_clk_dflt_find_companion,
+};
+
+/**
+ * omap3430es2_clk_hsotgusb_find_idlest - return CM_IDLEST info for HSOTGUSB
+ * @clk: struct clk * being enabled
+ * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
+ * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
+ *
+ * The OMAP3430ES2 HSOTGUSB target CM_IDLEST bit is at a different
+ * shift from the CM_{I,F}CLKEN bit.  Pass back the correct info via
+ * @idlest_reg and @idlest_bit.  No return value.
+ */
+static void omap3430es2_clk_hsotgusb_find_idlest(struct clk_hw_omap *clk,
+						 void __iomem **idlest_reg,
+						 u8 *idlest_bit,
+						 u8 *idlest_val)
+{
+	u32 r;
+
+	r = (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
+	*idlest_reg = (__force void __iomem *)r;
+	*idlest_bit = OMAP3430ES2_ST_HSOTGUSB_IDLE_SHIFT;
+	*idlest_val = OMAP34XX_CM_IDLEST_VAL;
+}
+
+const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_hsotgusb_wait = {
+	.allow_idle	= omap2_clkt_iclk_allow_idle,
+	.deny_idle	= omap2_clkt_iclk_deny_idle,
+	.find_idlest	= omap3430es2_clk_hsotgusb_find_idlest,
+	.find_companion	= omap2_clk_dflt_find_companion,
+};
+
+const struct clk_hw_omap_ops clkhwops_omap3430es2_hsotgusb_wait = {
+	.find_idlest	= omap3430es2_clk_hsotgusb_find_idlest,
+	.find_companion	= omap2_clk_dflt_find_companion,
+};
+
 static struct ti_dt_clk omap3xxx_clks[] = {
 	DT_CLK(NULL, "apb_pclk", "dummy_apb_pclk"),
 	DT_CLK(NULL, "omap_32k_fck", "omap_32k_fck"),
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 83476d1..c6fbd15 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -179,6 +179,10 @@ extern const struct clk_hw_omap_ops clkhwops_wait;
 extern const struct clk_hw_omap_ops clkhwops_iclk;
 extern const struct clk_hw_omap_ops clkhwops_iclk_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap2430_i2chs_wait;
+extern const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_wait;
+extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_hsotgusb_wait;
+extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_dss_usbhost_wait;
+extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_ssi_wait;
 
 int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 void omap2_clkops_disable_clkdm(struct clk_hw *hw);
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 6361f21..813b809 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -331,12 +331,8 @@ void ti_clk_setup_features(struct ti_clk_features *features);
 struct ti_clk_features *ti_clk_get_features(void);
 
 extern const struct clk_hw_omap_ops clkhwops_omap2xxx_dpll;
-extern const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_wait;
 extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait;
 extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_wait;
-extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_ssi_wait;
-extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_dss_usbhost_wait;
-extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_hsotgusb_wait;
 
 #ifdef CONFIG_ATAGS
 int omap3430_clk_legacy_init(void);
-- 
1.7.9.5
