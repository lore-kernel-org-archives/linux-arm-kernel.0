From: avinashphilip@ti.com (Philip Avinash)
Date: Mon, 25 Mar 2013 15:07:48 +0530
Subject: [PATCH v3 1/3] ARM: davinci: clk framework support for enable/disable
 functionality
In-Reply-To: <1364197789-16783-1-git-send-email-avinashphilip@ti.com>
References: <1364197789-16783-1-git-send-email-avinashphilip@ti.com>
Message-ID: <1364204268-15010-1-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Davinci clock framework currently not supporting clock enable/disable
functionality on clock nodes. In Davinci platform, EHRPWM module requires
support for clock enable/disable for TBCLK support. Hence this patch
adds support for enabling/disabling clocks depends on the availability
of the functionality.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
---
Changes since v2:
	- start using "usecount" field in clk structure to
	  enable/disable clocks.

Changes since v1:
	- Add support for clock enable/disable functionality.

 arch/arm/mach-davinci/clock.c |   21 ++++++++++++++-------
 arch/arm/mach-davinci/clock.h |    2 ++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index d458558..960c7a5 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -35,19 +35,26 @@ static void __clk_enable(struct clk *clk)
 {
 	if (clk->parent)
 		__clk_enable(clk->parent);
-	if (clk->usecount++ == 0 && (clk->flags & CLK_PSC))
-		davinci_psc_config(clk->domain, clk->gpsc, clk->lpsc,
-				true, clk->flags);
+	if (clk->usecount++ == 0) {
+		if (clk->flags & CLK_PSC)
+			davinci_psc_config(clk->domain, clk->gpsc, clk->lpsc,
+					true, clk->flags);
+		else if (clk->clk_enable)
+			clk->clk_enable(clk);
+	}
 }
 
 static void __clk_disable(struct clk *clk)
 {
 	if (WARN_ON(clk->usecount == 0))
 		return;
-	if (--clk->usecount == 0 && !(clk->flags & CLK_PLL) &&
-	    (clk->flags & CLK_PSC))
-		davinci_psc_config(clk->domain, clk->gpsc, clk->lpsc,
-				false, clk->flags);
+	if (--clk->usecount == 0) {
+		if (!(clk->flags & CLK_PLL) && (clk->flags & CLK_PSC))
+			davinci_psc_config(clk->domain, clk->gpsc, clk->lpsc,
+					false, clk->flags);
+		else if (clk->clk_disable)
+			clk->clk_disable(clk);
+	}
 	if (clk->parent)
 		__clk_disable(clk->parent);
 }
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index 8694b39..1e4e836 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -104,6 +104,8 @@ struct clk {
 	int (*set_rate) (struct clk *clk, unsigned long rate);
 	int (*round_rate) (struct clk *clk, unsigned long rate);
 	int (*reset) (struct clk *clk, bool reset);
+	void (*clk_enable) (struct clk *clk);
+	void (*clk_disable) (struct clk *clk);
 };
 
 /* Clock flags: SoC-specific flags start at BIT(16) */
-- 
1.7.9.5
