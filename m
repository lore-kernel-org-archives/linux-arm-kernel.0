From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 25 Mar 2011 22:29:58 +0530
Subject: [PATCH 2/4] davinci: enable forced transitions on PSC
In-Reply-To: <1301072400-4036-1-git-send-email-nsekhar@ti.com>
References: <1301072400-4036-1-git-send-email-nsekhar@ti.com>
Message-ID: <1301072400-4036-2-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some DaVinci modules like the SATA on DA850
need forced module state transitions.

Add a "force" parameter to the PSC config function
to enable it to make forced transitions.

Forced transitions shouldn't normally be attempted,
unless the TRM explicitly specifies its usage.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/clock.c            |    8 +++++---
 arch/arm/mach-davinci/clock.h            |    1 +
 arch/arm/mach-davinci/include/mach/psc.h |    3 ++-
 arch/arm/mach-davinci/psc.c              |    4 +++-
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index e4e3af1..3b659c3 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -44,7 +44,7 @@ static void __clk_enable(struct clk *clk)
 		__clk_enable(clk->parent);
 	if (clk->usecount++ == 0 && (clk->flags & CLK_PSC))
 		davinci_psc_config(psc_domain(clk), clk->gpsc, clk->lpsc,
-				PSC_STATE_ENABLE);
+				PSC_STATE_ENABLE, !!(clk->flags & PSC_FORCE));
 }
 
 static void __clk_disable(struct clk *clk)
@@ -55,7 +55,8 @@ static void __clk_disable(struct clk *clk)
 	    (clk->flags & CLK_PSC))
 		davinci_psc_config(psc_domain(clk), clk->gpsc, clk->lpsc,
 				(clk->flags & PSC_SWRSTDISABLE) ?
-				PSC_STATE_SWRSTDISABLE : PSC_STATE_DISABLE);
+				PSC_STATE_SWRSTDISABLE : PSC_STATE_DISABLE,
+				!!(clk->flags & PSC_FORCE));
 	if (clk->parent)
 		__clk_disable(clk->parent);
 }
@@ -240,7 +241,8 @@ static int __init clk_disable_unused(void)
 
 		davinci_psc_config(psc_domain(ck), ck->gpsc, ck->lpsc,
 				(ck->flags & PSC_SWRSTDISABLE) ?
-				PSC_STATE_SWRSTDISABLE : PSC_STATE_DISABLE);
+				PSC_STATE_SWRSTDISABLE : PSC_STATE_DISABLE,
+				!!(ck->flags & PSC_FORCE));
 	}
 	spin_unlock_irq(&clockfw_lock);
 
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index 0dd2203..48ee462 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -111,6 +111,7 @@ struct clk {
 #define CLK_PLL			BIT(4) /* PLL-derived clock */
 #define PRE_PLL			BIT(5) /* source is before PLL mult/div */
 #define PSC_SWRSTDISABLE	BIT(6) /* Disable state is SwRstDisable */
+#define PSC_FORCE		BIT(7) /* Force module state transtition */
 
 #define CLK(dev, con, ck) 	\
 	{			\
diff --git a/arch/arm/mach-davinci/include/mach/psc.h b/arch/arm/mach-davinci/include/mach/psc.h
index 1110fdd..394b535 100644
--- a/arch/arm/mach-davinci/include/mach/psc.h
+++ b/arch/arm/mach-davinci/include/mach/psc.h
@@ -244,12 +244,13 @@
 #define PSC_STATE_ENABLE	3
 
 #define MDSTAT_STATE_MASK	0x1f
+#define MDCTL_FORCE		BIT(31)
 
 #ifndef __ASSEMBLER__
 
 extern int davinci_psc_is_clk_active(unsigned int ctlr, unsigned int id);
 extern void davinci_psc_config(unsigned int domain, unsigned int ctlr,
-		unsigned int id, u32 next_state);
+		unsigned int id, u32 next_state, bool force);
 
 #endif
 
diff --git a/arch/arm/mach-davinci/psc.c b/arch/arm/mach-davinci/psc.c
index a415804..651fcbf 100644
--- a/arch/arm/mach-davinci/psc.c
+++ b/arch/arm/mach-davinci/psc.c
@@ -48,7 +48,7 @@ int __init davinci_psc_is_clk_active(unsigned int ctlr, unsigned int id)
 
 /* Enable or disable a PSC domain */
 void davinci_psc_config(unsigned int domain, unsigned int ctlr,
-		unsigned int id, u32 next_state)
+		unsigned int id, u32 next_state, bool force)
 {
 	u32 epcpr, ptcmd, ptstat, pdstat, pdctl1, mdstat, mdctl;
 	void __iomem *psc_base;
@@ -65,6 +65,8 @@ void davinci_psc_config(unsigned int domain, unsigned int ctlr,
 	mdctl = __raw_readl(psc_base + MDCTL + 4 * id);
 	mdctl &= ~MDSTAT_STATE_MASK;
 	mdctl |= next_state;
+	if (force)
+		mdctl |= MDCTL_FORCE;
 	__raw_writel(mdctl, psc_base + MDCTL + 4 * id);
 
 	pdstat = __raw_readl(psc_base + PDSTAT);
-- 
1.7.3.2
