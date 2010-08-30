From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:08:49 +0530
Subject: [PATCH 20/74] Clock Framework: Adding ENABLED_ON_INIT feature in clk
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <510ca14c78955ed8f6bed507a320ee7852b5cafa.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
---
 arch/arm/mach-spear13xx/clock.c          |    2 ++
 arch/arm/mach-spear3xx/clock.c           |    1 +
 arch/arm/mach-spear6xx/clock.c           |    1 +
 arch/arm/plat-spear/clock.c              |    6 ++++++
 arch/arm/plat-spear/include/plat/clock.h |    1 +
 5 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
index 9d97c69..9252940 100644
--- a/arch/arm/mach-spear13xx/clock.c
+++ b/arch/arm/mach-spear13xx/clock.c
@@ -89,6 +89,7 @@ static struct pll_clk_config pll1_config = {
 
 /* pll1 clock */
 static struct clk pll1_clk = {
+	.flags = ENABLED_ON_INIT,
 	.pclk_sel = &pll_pclk_sel,
 	.pclk_sel_shift = PLL1_CLK_SHIFT,
 	.en_reg = PLL1_CTR,
@@ -156,6 +157,7 @@ static struct pll_clk_config pll4_config = {
 
 /* pll4 (DDR) clock */
 static struct clk pll4_clk = {
+	.flags = ENABLED_ON_INIT,
 	.pclk = &osc1_24m_clk,
 	.en_reg = PLL4_CTR,
 	.en_reg_bit = PLL_ENABLE,
diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index 5eb6ff6..79f0159 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -62,6 +62,7 @@ static struct pll_clk_config pll1_config = {
 
 /* PLL1 clock */
 static struct clk pll1_clk = {
+	.flags = ENABLED_ON_INIT,
 	.pclk = &osc_24m_clk,
 	.en_reg = PLL1_CTR,
 	.en_reg_bit = PLL_ENABLE,
diff --git a/arch/arm/mach-spear6xx/clock.c b/arch/arm/mach-spear6xx/clock.c
index 3caf91a..fb05ec8 100644
--- a/arch/arm/mach-spear6xx/clock.c
+++ b/arch/arm/mach-spear6xx/clock.c
@@ -62,6 +62,7 @@ static struct pll_clk_config pll1_config = {
 
 /* PLL1 clock */
 static struct clk pll1_clk = {
+	.flags = ENABLED_ON_INIT,
 	.pclk = &osc_30m_clk,
 	.en_reg = PLL1_CTR,
 	.en_reg_bit = PLL_ENABLE,
diff --git a/arch/arm/plat-spear/clock.c b/arch/arm/plat-spear/clock.c
index 75c42a3..e871016 100644
--- a/arch/arm/plat-spear/clock.c
+++ b/arch/arm/plat-spear/clock.c
@@ -372,6 +372,9 @@ void propagate_rate(struct clk *pclk)
 				clk->recalc(clk);
 			propagate_rate(clk);
 		}
+		/* Enable clks enabled on init, in software view */
+		if (clk->flags & ENABLED_ON_INIT)
+			do_clk_enable(clk);
 	}
 }
 
@@ -550,6 +553,9 @@ void recalc_root_clocks(void)
 				pclk->recalc(pclk);
 			propagate_rate(pclk);
 		}
+		/* Enable clks enabled on init, in software view */
+		if (pclk->flags & ENABLED_ON_INIT)
+			do_clk_enable(pclk);
 	}
 	spin_unlock_irqrestore(&clocks_lock, flags);
 }
diff --git a/arch/arm/plat-spear/include/plat/clock.h b/arch/arm/plat-spear/include/plat/clock.h
index 2e55855..91f8e3f 100644
--- a/arch/arm/plat-spear/include/plat/clock.h
+++ b/arch/arm/plat-spear/include/plat/clock.h
@@ -21,6 +21,7 @@
 /* clk structure flags */
 #define	ALWAYS_ENABLED		(1 << 0) /* clock always enabled */
 #define	RESET_TO_ENABLE		(1 << 1) /* reset register bit to enable clk */
+#define	ENABLED_ON_INIT		(1 << 2) /* clocks enabled@init */
 
 /**
  * struct clkops - clock operations
-- 
1.7.2.2
