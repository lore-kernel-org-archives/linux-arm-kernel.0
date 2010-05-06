From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:02 -0700
Subject: [PATCH 11/34] Davinci: support LPSC SwRstDisable state
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-12-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

The current clock control code always gates the clock (PSC state Disable = 2)
on clk_disable().  Some on-chip peripherals (e.g. LCD controller on TNETV107X)
need to be put into SwRstDisable = 0 on clock disable, to maintain
hardware sanity.

This patch extends the davinci_psc_config() arguments to pass in the desired
module state instead of a boolean enable/disable.  Further, clk_disable() now
checks for the PSC_SWRSTDISABLE clk flag before selecting the target state.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/clock.c            |   12 +++++++++---
 arch/arm/mach-davinci/clock.h            |    7 ++++---
 arch/arm/mach-davinci/include/mach/psc.h |    8 +++++++-
 arch/arm/mach-davinci/psc.c              |    3 +--
 4 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index 058c77f..5de60ae 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -43,7 +43,8 @@ static void __clk_enable(struct clk *clk)
 	if (clk->parent)
 		__clk_enable(clk->parent);
 	if (clk->usecount++ == 0 && (clk->flags & CLK_PSC))
-		davinci_psc_config(psc_domain(clk), clk->gpsc, clk->lpsc, 1);
+		davinci_psc_config(psc_domain(clk), clk->gpsc, clk->lpsc,
+				PSC_STATE_ENABLE);
 }
 
 static void __clk_disable(struct clk *clk)
@@ -52,7 +53,9 @@ static void __clk_disable(struct clk *clk)
 		return;
 	if (--clk->usecount == 0 && !(clk->flags & CLK_PLL) &&
 	    (clk->flags & CLK_PSC))
-		davinci_psc_config(psc_domain(clk), clk->gpsc, clk->lpsc, 0);
+		davinci_psc_config(psc_domain(clk), clk->gpsc, clk->lpsc,
+				(clk->flags & PSC_SWRSTDISABLE) ?
+				PSC_STATE_SWRSTDISABLE : PSC_STATE_DISABLE);
 	if (clk->parent)
 		__clk_disable(clk->parent);
 }
@@ -234,7 +237,10 @@ static int __init clk_disable_unused(void)
 			continue;
 
 		pr_info("Clocks: disable unused %s\n", ck->name);
-		davinci_psc_config(psc_domain(ck), ck->gpsc, ck->lpsc, 0);
+
+		davinci_psc_config(psc_domain(ck), ck->gpsc, ck->lpsc,
+				(ck->flags & PSC_SWRSTDISABLE) ?
+				PSC_STATE_SWRSTDISABLE : PSC_STATE_DISABLE);
 	}
 	spin_unlock_irq(&clockfw_lock);
 
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index aa0a611..53a0f7b 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -101,10 +101,11 @@ struct clk {
 
 /* Clock flags: SoC-specific flags start at BIT(16) */
 #define ALWAYS_ENABLED		BIT(1)
-#define CLK_PSC                 BIT(2)
-#define PSC_DSP                 BIT(3) /* PSC uses DSP domain, not ARM */
+#define CLK_PSC			BIT(2)
+#define PSC_DSP			BIT(3) /* PSC uses DSP domain, not ARM */
 #define CLK_PLL			BIT(4) /* PLL-derived clock */
-#define PRE_PLL                 BIT(5) /* source is before PLL mult/div */
+#define PRE_PLL			BIT(5) /* source is before PLL mult/div */
+#define PSC_SWRSTDISABLE	BIT(6) /* Disable state is SwRstDisable */
 
 #define CLK(dev, con, ck) 	\
 	{			\
diff --git a/arch/arm/mach-davinci/include/mach/psc.h b/arch/arm/mach-davinci/include/mach/psc.h
index 651f6d8..7dd2962 100644
--- a/arch/arm/mach-davinci/include/mach/psc.h
+++ b/arch/arm/mach-davinci/include/mach/psc.h
@@ -189,13 +189,19 @@
 #define MDSTAT		0x800
 #define MDCTL		0xA00
 
+/* PSC module states */
+#define PSC_STATE_SWRSTDISABLE	0
+#define PSC_STATE_SYNCRST	1
+#define PSC_STATE_DISABLE	2
+#define PSC_STATE_ENABLE	3
+
 #define MDSTAT_STATE_MASK 0x1f
 
 #ifndef __ASSEMBLER__
 
 extern int davinci_psc_is_clk_active(unsigned int ctlr, unsigned int id);
 extern void davinci_psc_config(unsigned int domain, unsigned int ctlr,
-		unsigned int id, char enable);
+		unsigned int id, u32 next_state);
 
 #endif
 
diff --git a/arch/arm/mach-davinci/psc.c b/arch/arm/mach-davinci/psc.c
index adf6b5c..d7cb438 100644
--- a/arch/arm/mach-davinci/psc.c
+++ b/arch/arm/mach-davinci/psc.c
@@ -47,12 +47,11 @@ int __init davinci_psc_is_clk_active(unsigned int ctlr, unsigned int id)
 
 /* Enable or disable a PSC domain */
 void davinci_psc_config(unsigned int domain, unsigned int ctlr,
-		unsigned int id, char enable)
+		unsigned int id, u32 next_state)
 {
 	u32 epcpr, ptcmd, ptstat, pdstat, pdctl1, mdstat, mdctl;
 	void __iomem *psc_base;
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
-	u32 next_state = enable ? 0x3 : 0x2; /* 0x3 enables, 0x2 disables */
 
 	if (!soc_info->psc_bases || (ctlr >= soc_info->psc_bases_num)) {
 		pr_warning("PSC: Bad psc data: 0x%x[%d]\n",
-- 
1.7.0.2
