From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 31 Mar 2014 18:16:00 +0300
Subject: [PATCH 21/55] ARM: OMAP2+: PRCM: remove references to clock.h from
 PRCM core code
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Message-ID: <1396278994-12624-22-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Done in preparation to make PRCM a standalone driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c |    1 -
 arch/arm/mach-omap2/clockdomain.h |    2 +-
 arch/arm/mach-omap2/prcm-common.h |    2 ++
 arch/arm/mach-omap2/prm_common.c  |   11 ++++-------
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 2da3b5e..9a59efb 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -29,7 +29,6 @@
 #include <linux/bitops.h>
 
 #include "soc.h"
-#include "clock.h"
 #include "clockdomain.h"
 
 /* clkdm_list contains all registered struct clockdomains */
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 82c37b1..4322a28 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -17,7 +17,6 @@
 #include <linux/init.h>
 
 #include "powerdomain.h"
-#include "clock.h"
 
 /*
  * Clockdomain flags
@@ -98,6 +97,7 @@ struct clkdm_dep {
 #define _CLKDM_FLAG_HWSUP_ENABLED		BIT(0)
 
 struct omap_hwmod;
+struct clk;
 
 /**
  * struct clockdomain - OMAP clockdomain
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index f356532..1a05d04 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -519,6 +519,8 @@ struct omap_prcm_irq_setup {
 
 struct of_device_id;
 
+extern void __iomem *clk_memmaps[];
+
 extern void omap_prcm_irq_cleanup(void);
 extern int omap_prcm_register_chain_handler(
 	struct omap_prcm_irq_setup *irq_setup);
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 080b3ed..090d13f 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -32,7 +32,6 @@
 #include "prm2xxx.h"
 #include "prm3xxx.h"
 #include "prm44xx.h"
-#include "clock.h"
 
 /*
  * OMAP_PRCM_MAX_NR_PENDING_REG: maximum number of PRM_IRQ*_MPU regs
@@ -481,18 +480,16 @@ static struct of_device_id omap_prcm_dt_match_table[] = {
 	{ }
 };
 
-static struct clk_hw_omap memmap_dummy_ck = {
-	.flags = MEMMAP_ADDRESSING,
-};
-
 static u32 prm_clk_readl(void __iomem *reg)
 {
-	return omap2_clk_readl(&memmap_dummy_ck, reg);
+	struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
+	return readl_relaxed(clk_memmaps[r->index] + r->offset);
 }
 
 static void prm_clk_writel(u32 val, void __iomem *reg)
 {
-	omap2_clk_writel(val, &memmap_dummy_ck, reg);
+	struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
+	writel_relaxed(val, clk_memmaps[r->index] + r->offset);
 }
 
 static struct ti_clk_ll_ops omap_clk_ll_ops = {
-- 
1.7.9.5
