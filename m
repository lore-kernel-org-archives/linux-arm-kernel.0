From: thomas.ab@samsung.com (Thomas Abraham)
Date: Mon, 18 Jan 2010 14:30:16 +0900
Subject: [PATCH] ARM: SAMSUNG: Add check to ensure that clksrc_clk does have
	multiple clock sources
Message-ID: <1263792616-19507-1-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds a additional check in s3c_set_clksrc function to ensure that the clksrc_clk
does have a choice of multiple clock sources. In addition to this, a check is
added to ensure that a parent is assigned to the clksrc_clk in case it does not
have a choice of parent clocks.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/plat-samsung/clock-clksrc.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-samsung/clock-clksrc.c b/arch/arm/plat-samsung/clock-clksrc.c
index 33c633a..98c6b88 100644
--- a/arch/arm/plat-samsung/clock-clksrc.c
+++ b/arch/arm/plat-samsung/clock-clksrc.c
@@ -129,11 +129,16 @@ void __init_or_cpufreq s3c_set_clksrc(struct clksrc_clk *clk, bool announce)
 {
 	struct clksrc_sources *srcs = clk->sources;
 	u32 mask = bit_mask(clk->reg_src.shift, clk->reg_src.size);
-	u32 clksrc = 0;
+	u32 clksrc;
 
-	if (clk->reg_src.reg)
-		clksrc = __raw_readl(clk->reg_src.reg);
+	if (!clk->reg_src.reg) {
+		if (!clk->clk.parent)
+			printk(KERN_ERR "%s: no parent clock specified\n",
+				clk->clk.name);
+		return;
+	}
 
+	clksrc = __raw_readl(clk->reg_src.reg);
 	clksrc &= mask;
 	clksrc >>= clk->reg_src.shift;
 
-- 
1.6.3.3
