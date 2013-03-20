From: avinashphilip@ti.com (Philip Avinash)
Date: Wed, 20 Mar 2013 12:11:52 +0530
Subject: [PATCH v2 1/3] ARM: davinci: clk framework support for enable/disable
 functionality
In-Reply-To: <1363761714-15034-1-git-send-email-avinashphilip@ti.com>
References: <1363761714-15034-1-git-send-email-avinashphilip@ti.com>
Message-ID: <1363761714-15034-2-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DAVINCI clock framework currently not supporting clock enable/disable
functionality on clock nodes. In DAVINCI platform EHRPWM module requires
support for clock enable/disable for TBCLK support. Hence this patch
adds support for enabling/disabling clocks depends on the availability
of the functionality.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
---
Changes since v1:
	- Add support for clock enable/disable functionality.

:100644 100644 d458558... aa89e5e... M	arch/arm/mach-davinci/clock.c
:100644 100644 8694b39... 1e4e836... M	arch/arm/mach-davinci/clock.h
 arch/arm/mach-davinci/clock.c |    4 ++++
 arch/arm/mach-davinci/clock.h |    2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index d458558..aa89e5e 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -35,6 +35,8 @@ static void __clk_enable(struct clk *clk)
 {
 	if (clk->parent)
 		__clk_enable(clk->parent);
+	if (clk->clk_enable)
+		clk->clk_enable(clk);
 	if (clk->usecount++ == 0 && (clk->flags & CLK_PSC))
 		davinci_psc_config(clk->domain, clk->gpsc, clk->lpsc,
 				true, clk->flags);
@@ -44,6 +46,8 @@ static void __clk_disable(struct clk *clk)
 {
 	if (WARN_ON(clk->usecount == 0))
 		return;
+	if (clk->clk_disable)
+		clk->clk_disable(clk);
 	if (--clk->usecount == 0 && !(clk->flags & CLK_PLL) &&
 	    (clk->flags & CLK_PSC))
 		davinci_psc_config(clk->domain, clk->gpsc, clk->lpsc,
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
