From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 29 Aug 2013 16:16:25 +0300
Subject: [PATCHv6 33/45] ARM: OMAP2+: hwmod: fix opt_clk handling with DT
In-Reply-To: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
References: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Message-ID: <1377782197-10611-34-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rajendra's patch had a bug which caused opt clocks to fail initialize
completely, causing boot warnings with devices that depend on them.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 116219e..f24246c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -827,8 +827,7 @@ static const char **_parse_opt_clks_dt(struct omap_hwmod *oh,
 		of_property_read_string_index(np, "clock-names", i, &clk_name);
 		if (!strcmp(clk_name, "fck"))
 			continue;
-		opt_clks_cnt++;
-		opt_clk_names[i] = clk_name;
+		opt_clk_names[(*opt_clks_cnt)++] = clk_name;
 	}
 	return opt_clk_names;
 }
@@ -851,7 +850,7 @@ static int _init_opt_clks_dt(struct omap_hwmod *oh, struct device_node *np)
 
 	oh->opt_clks_cnt = opt_clks_cnt;
 
-	for (i = 0; i < oh->opt_clks_cnt; i++) {
+	for (i = 0; i < opt_clks_cnt; i++) {
 		c = of_clk_get_by_name(np, opt_clk_names[i]);
 		if (IS_ERR(c)) {
 			pr_warn("omap_hwmod: %s: cannot clk_get opt_clk %s\n",
-- 
1.7.9.5
