From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 14 Jun 2012 18:17:05 +0530
Subject: [PATCH 16/29] ARM: omap: clk: Define a function to enable clocks at
 init
In-Reply-To: <1339678038-23082-1-git-send-email-rnayak@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Message-ID: <1339678038-23082-17-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platform code can use omap2_clk_enable_init_clocks() to enable a
list of clocks that are needed to be enabled at init.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock.c |   11 +++++++++++
 arch/arm/mach-omap2/clock.h |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index df7062d..859f3c9 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -391,6 +391,17 @@ int omap2_clk_disable_autoidle_all(void)
 	return 0;
 }
 
+void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks)
+{
+	struct clk *init_clk;
+	int i;
+
+	for (i = 0; i < num_clocks; i++) {
+		init_clk = clk_get(NULL, clk_names[i]);
+		clk_prepare_enable(init_clk);
+	}
+}
+
 const struct clk_hw_omap_ops clkhwops_omap3_dpll = {
 	.allow_idle	= omap3_dpll_allow_idle,
 	.deny_idle	= omap3_dpll_deny_idle,
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 0a38b56..d5020d3 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -178,6 +178,7 @@ void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk, void __iomem **idlest_r
 void omap2_init_clk_hw_omap_clocks(struct clk *clk);
 int omap2_clk_enable_autoidle_all(void);
 int omap2_clk_disable_autoidle_all(void);
+void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks);
 #else
 int omap2_dflt_clk_enable(struct clk *clk);
 void omap2_dflt_clk_disable(struct clk *clk);
-- 
1.7.1
