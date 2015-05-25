From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 25 May 2015 18:00:31 +0300
Subject: [PATCHv3 26/27] ARM: OMAP2+: clock: remove legacy
 omap2_clk_readl/writel APIs
In-Reply-To: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Message-ID: <1432566032-10860-27-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As most of the clock driver code has migrated, these are no longer used
for anything. Thus remove these APIs completely.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c |   16 ----------------
 arch/arm/mach-omap2/clock.h |    3 ---
 2 files changed, 19 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 40a88c2..79cec5f 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -87,22 +87,6 @@ static u32 clk_memmap_readl(void __iomem *reg)
 	return val;
 }
 
-void omap2_clk_writel(u32 val, struct clk_hw_omap *clk, void __iomem *reg)
-{
-	if (WARN_ON_ONCE(!(clk->flags & MEMMAP_ADDRESSING)))
-		writel_relaxed(val, reg);
-	else
-		clk_memmap_writel(val, reg);
-}
-
-u32 omap2_clk_readl(struct clk_hw_omap *clk, void __iomem *reg)
-{
-	if (WARN_ON_ONCE(!(clk->flags & MEMMAP_ADDRESSING)))
-		return readl_relaxed(reg);
-	else
-		return clk_memmap_readl(reg);
-}
-
 static struct ti_clk_ll_ops omap_clk_ll_ops = {
 	.clk_readl = clk_memmap_readl,
 	.clk_writel = clk_memmap_writel,
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index a7051d6..f3dc04c 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -68,9 +68,6 @@ void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
 			       const char *core_ck_name,
 			       const char *mpu_ck_name);
 
-u32 omap2_clk_readl(struct clk_hw_omap *clk, void __iomem *reg);
-void omap2_clk_writel(u32 val, struct clk_hw_omap *clk, void __iomem *reg);
-
 extern u16 cpu_mask;
 
 extern const struct clkops clkops_omap2_dflt_wait;
-- 
1.7.9.5
