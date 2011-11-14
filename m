From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 Nov 2011 01:42:09 +0530
Subject: [PATCH v4 4/4] ARM: davinci: add support for multiple power domains
In-Reply-To: <1321301529-7582-3-git-send-email-nsekhar@ti.com>
References: <1321301529-7582-1-git-send-email-nsekhar@ti.com>
 <1321301529-7582-2-git-send-email-nsekhar@ti.com>
 <1321301529-7582-3-git-send-email-nsekhar@ti.com>
Message-ID: <1321301529-7582-4-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Murali Karicheri <m-karicheri2@ti.com>

On a new SoC based on DaVinci, there are multiple power
domains similar to that in C6670 (c6x). Currently the
clock module assumes that there are only two power domains
(0 and 1).

This patch removes this restriction to allow porting on to
the new SoC.

Reviewed-by :Sergei Shtylyov <sshtylyov@mvista.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
This patch has not been tested on DM644x yet.

 arch/arm/mach-davinci/clock.c  |   13 +++----------
 arch/arm/mach-davinci/clock.h  |   10 +++++-----
 arch/arm/mach-davinci/dm644x.c |    4 ++--
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index 0086113..008772e 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -31,19 +31,12 @@ static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);
 static DEFINE_SPINLOCK(clockfw_lock);
 
-static unsigned psc_domain(struct clk *clk)
-{
-	return (clk->flags & PSC_DSP)
-		? DAVINCI_GPSC_DSPDOMAIN
-		: DAVINCI_GPSC_ARMDOMAIN;
-}
-
 static void __clk_enable(struct clk *clk)
 {
 	if (clk->parent)
 		__clk_enable(clk->parent);
 	if (clk->usecount++ == 0 && (clk->flags & CLK_PSC))
-		davinci_psc_config(psc_domain(clk), clk->gpsc, clk->lpsc,
+		davinci_psc_config(clk->domain, clk->gpsc, clk->lpsc,
 				true, clk->flags);
 }
 
@@ -53,7 +46,7 @@ static void __clk_disable(struct clk *clk)
 		return;
 	if (--clk->usecount == 0 && !(clk->flags & CLK_PLL) &&
 	    (clk->flags & CLK_PSC))
-		davinci_psc_config(psc_domain(clk), clk->gpsc, clk->lpsc,
+		davinci_psc_config(clk->domain, clk->gpsc, clk->lpsc,
 				false, clk->flags);
 	if (clk->parent)
 		__clk_disable(clk->parent);
@@ -237,7 +230,7 @@ static int __init clk_disable_unused(void)
 
 		pr_debug("Clocks: disable unused %s\n", ck->name);
 
-		davinci_psc_config(psc_domain(ck), ck->gpsc, ck->lpsc,
+		davinci_psc_config(ck->domain, ck->gpsc, ck->lpsc,
 				false, ck->flags);
 	}
 	spin_unlock_irq(&clockfw_lock);
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index a705f36..46f0f1b 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -93,6 +93,7 @@ struct clk {
 	u8			usecount;
 	u8			lpsc;
 	u8			gpsc;
+	u8			domain;
 	u32			flags;
 	struct clk              *parent;
 	struct list_head	children; 	/* list of children */
@@ -107,11 +108,10 @@ struct clk {
 /* Clock flags: SoC-specific flags start at BIT(16) */
 #define ALWAYS_ENABLED		BIT(1)
 #define CLK_PSC			BIT(2)
-#define PSC_DSP			BIT(3) /* PSC uses DSP domain, not ARM */
-#define CLK_PLL			BIT(4) /* PLL-derived clock */
-#define PRE_PLL			BIT(5) /* source is before PLL mult/div */
-#define PSC_SWRSTDISABLE	BIT(6) /* Disable state is SwRstDisable */
-#define PSC_FORCE		BIT(7) /* Force module state transtition */
+#define CLK_PLL			BIT(3) /* PLL-derived clock */
+#define PRE_PLL			BIT(4) /* source is before PLL mult/div */
+#define PSC_SWRSTDISABLE	BIT(5) /* Disable state is SwRstDisable */
+#define PSC_FORCE		BIT(6) /* Force module state transtition */
 
 #define CLK(dev, con, ck) 	\
 	{			\
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 555ff5b..f38c4bb 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -130,7 +130,7 @@ static struct clk dsp_clk = {
 	.name = "dsp",
 	.parent = &pll1_sysclk1,
 	.lpsc = DAVINCI_LPSC_GEM,
-	.flags = PSC_DSP,
+	.domain = DAVINCI_GPSC_DSPDOMAIN,
 	.usecount = 1,			/* REVISIT how to disable? */
 };
 
@@ -145,7 +145,7 @@ static struct clk vicp_clk = {
 	.name = "vicp",
 	.parent = &pll1_sysclk2,
 	.lpsc = DAVINCI_LPSC_IMCOP,
-	.flags = PSC_DSP,
+	.domain = DAVINCI_GPSC_DSPDOMAIN,
 	.usecount = 1,			/* REVISIT how to disable? */
 };
 
-- 
1.6.2.4
