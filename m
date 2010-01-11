From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 11 Jan 2010 08:22:23 -0800
Subject: [PATCH] davinci: clkdev cleanup: remove clk_lookup wrapper, use clkdev_add_table()
Message-ID: <mailman.137.1263247581.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unneeded 'struct davinci_clk' wrapper around 'struct clk_lookup'
and use clkdev_add_table() to add the list of clocks in one go.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/clock.c               |   13 ++++++++-----
 arch/arm/mach-davinci/clock.h               |   20 +++++++-------------
 arch/arm/mach-davinci/da830.c               |    2 +-
 arch/arm/mach-davinci/da850.c               |    8 ++++----
 arch/arm/mach-davinci/dm355.c               |    2 +-
 arch/arm/mach-davinci/dm365.c               |    2 +-
 arch/arm/mach-davinci/dm644x.c              |    2 +-
 arch/arm/mach-davinci/dm646x.c              |    2 +-
 arch/arm/mach-davinci/include/mach/common.h |    2 +-
 9 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index baece65..a992716 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -428,13 +428,14 @@ int davinci_set_pllrate(struct pll_data *pll, unsigned int prediv,
 }
 EXPORT_SYMBOL(davinci_set_pllrate);
 
-int __init davinci_clk_init(struct davinci_clk *clocks)
+int __init davinci_clk_init(struct clk_lookup *clocks)
   {
-	struct davinci_clk *c;
+	struct clk_lookup *c;
 	struct clk *clk;
+	size_t num_clocks = 0;
 
-	for (c = clocks; c->lk.clk; c++) {
-		clk = c->lk.clk;
+	for (c = clocks; c->clk; c++) {
+		clk = c->clk;
 
 		if (!clk->recalc) {
 
@@ -457,14 +458,16 @@ int __init davinci_clk_init(struct davinci_clk *clocks)
 		if (clk->lpsc)
 			clk->flags |= CLK_PSC;
 
-		clkdev_add(&c->lk);
 		clk_register(clk);
+		num_clocks++;
 
 		/* Turn on clocks that Linux doesn't otherwise manage */
 		if (clk->flags & ALWAYS_ENABLED)
 			clk_enable(clk);
 	}
 
+	clkdev_add_table(clocks, num_clocks);
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index c92d77a..450e204 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -89,20 +89,14 @@ struct clk {
 #define CLK_PLL			BIT(4) /* PLL-derived clock */
 #define PRE_PLL                 BIT(5) /* source is before PLL mult/div */
 
-struct davinci_clk {
-	struct clk_lookup lk;
-};
-
-#define CLK(dev, con, ck) 		\
-	{				\
-		.lk = {			\
-			.dev_id = dev,	\
-			.con_id = con,	\
-			.clk = ck,	\
-		},			\
-	}
+#define CLK(dev, con, ck) 	\
+	{			\
+		.dev_id = dev,	\
+		.con_id = con,	\
+		.clk = ck,	\
+	}			\
 
-int davinci_clk_init(struct davinci_clk *clocks);
+int davinci_clk_init(struct clk_lookup *clocks);
 int davinci_set_pllrate(struct pll_data *pll, unsigned int prediv,
 				unsigned int mult, unsigned int postdiv);
 
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index b22b5cf..5796f1e 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -371,7 +371,7 @@ static struct clk rmii_clk = {
 	.parent		= &pll0_sysclk7,
 };
 
-static struct davinci_clk da830_clks[] = {
+static struct clk_lookup da830_clks[] = {
 	CLK(NULL,		"ref",		&ref_clk),
 	CLK(NULL,		"pll0",		&pll0_clk),
 	CLK(NULL,		"pll0_aux",	&pll0_aux_clk),
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 717806c..9c112b4 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -333,7 +333,7 @@ static struct clk aemif_clk = {
 	.flags		= ALWAYS_ENABLED,
 };
 
-static struct davinci_clk da850_clks[] = {
+static struct clk_lookup da850_clks[] = {
 	CLK(NULL,		"ref",		&ref_clk),
 	CLK(NULL,		"pll0",		&pll0_clk),
 	CLK(NULL,		"pll0_aux",	&pll0_aux_clk),
@@ -825,12 +825,12 @@ static struct davinci_timer_info da850_timer_info = {
 static void da850_set_async3_src(int pllnum)
 {
 	struct clk *clk, *newparent = pllnum ? &pll1_sysclk2 : &pll0_sysclk2;
-	struct davinci_clk *c;
+	struct clk_lookup *c;
 	unsigned int v;
 	int ret;
 
-	for (c = da850_clks; c->lk.clk; c++) {
-		clk = c->lk.clk;
+	for (c = da850_clks; c->clk; c++) {
+		clk = c->clk;
 		if (clk->flags & DA850_CLK_ASYNC3) {
 			ret = clk_set_parent(clk, newparent);
 			WARN(ret, "DA850: unable to re-parent clock %s",
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index dedf4d4..93fc4ec 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -335,7 +335,7 @@ static struct clk usb_clk = {
 	.lpsc = DAVINCI_LPSC_USB,
 };
 
-static struct davinci_clk dm355_clks[] = {
+static struct clk_lookup dm355_clks[] = {
 	CLK(NULL, "ref", &ref_clk),
 	CLK(NULL, "pll1", &pll1_clk),
 	CLK(NULL, "pll1_sysclk1", &pll1_sysclk1),
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index f53735c..3c9a48e 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -403,7 +403,7 @@ static struct clk mjcp_clk = {
 	.lpsc		= DM365_LPSC_MJCP,
 };
 
-static struct davinci_clk dm365_clks[] = {
+static struct clk_lookup dm365_clks[] = {
 	CLK(NULL, "ref", &ref_clk),
 	CLK(NULL, "pll1", &pll1_clk),
 	CLK(NULL, "pll1_aux", &pll1_aux_clk),
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 2cd0081..40beeb9 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -277,7 +277,7 @@ static struct clk timer2_clk = {
 	.usecount = 1,              /* REVISIT: why cant' this be disabled? */
 };
 
-struct davinci_clk dm644x_clks[] = {
+struct clk_lookup dm644x_clks[] = {
 	CLK(NULL, "ref", &ref_clk),
 	CLK(NULL, "pll1", &pll1_clk),
 	CLK(NULL, "pll1_sysclk1", &pll1_sysclk1),
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 829a44b..53a7fe9 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -313,7 +313,7 @@ static struct clk vpif1_clk = {
 	.flags = ALWAYS_ENABLED,
 };
 
-struct davinci_clk dm646x_clks[] = {
+struct clk_lookup dm646x_clks[] = {
 	CLK(NULL, "ref", &ref_clk),
 	CLK(NULL, "aux", &aux_clkin),
 	CLK(NULL, "pll1", &pll1_clk),
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 6ca2c9a..50a955f 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -43,7 +43,7 @@ struct davinci_soc_info {
 	void __iomem			*jtag_id_base;
 	struct davinci_id		*ids;
 	unsigned long			ids_num;
-	struct davinci_clk		*cpu_clks;
+	struct clk_lookup		*cpu_clks;
 	void __iomem			**psc_bases;
 	unsigned long			psc_bases_num;
 	void __iomem			*pinmux_base;
-- 
1.6.6
