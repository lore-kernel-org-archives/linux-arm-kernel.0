From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 18 Dec 2015 15:58:54 +0200
Subject: [RFC 2/9] ARM: OMAP2+: hwmod: initialize main clocks directly from DT
In-Reply-To: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
References: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
Message-ID: <1450447141-29936-3-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This avoids the need to add clock aliases under drivers/clk/ti/clk-xyz.c
files.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 48495ad..5fa8965 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -786,11 +786,20 @@ static int _init_main_clk(struct omap_hwmod *oh)
 	if (!oh->main_clk)
 		return 0;
 
-	oh->_clk = clk_get(NULL, oh->main_clk);
-	if (IS_ERR(oh->_clk)) {
-		pr_warn("omap_hwmod: %s: cannot clk_get main_clk %s\n",
-			oh->name, oh->main_clk);
-		return -EINVAL;
+	if (of_have_populated_dt()) {
+		struct of_phandle_args clkspec;
+
+		clkspec.np = of_find_node_by_name(NULL, oh->main_clk);
+		oh->_clk = of_clk_get_from_provider(&clkspec);
+	}
+
+	if (!oh->_clk) {
+		oh->_clk = clk_get(NULL, oh->main_clk);
+		if (IS_ERR(oh->_clk)) {
+			pr_warn("omap_hwmod: %s: cannot clk_get main_clk %s\n",
+				oh->name, oh->main_clk);
+			return -EINVAL;
+		}
 	}
 	/*
 	 * HACK: This needs a re-visit once clk_prepare() is implemented
-- 
1.7.9.5
