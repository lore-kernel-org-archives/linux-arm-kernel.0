From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 28 Jul 2015 06:27:20 +0000
Subject: [PATCH 2/7] clk: atlas7: export mux clks so that driver can use it
In-Reply-To: <1438064845-17894-1-git-send-email-21cnbao@gmail.com>
References: <1438064845-17894-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1438064845-17894-3-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guo Zeng <guo.zeng@csr.com>

this patch makes mux clks can be referenced by device drivers.

Signed-off-by: Guo Zeng <guo.zeng@csr.com>
Signed-off-by: Barry Song <Barry.Song@csr.com>
---
 drivers/clk/sirf/clk-atlas7.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sirf/clk-atlas7.c b/drivers/clk/sirf/clk-atlas7.c
index a92e7ea..d01dce3 100644
--- a/drivers/clk/sirf/clk-atlas7.c
+++ b/drivers/clk/sirf/clk-atlas7.c
@@ -1180,7 +1180,7 @@ static struct atlas7_unit_init_data unit_list[] __initdata = {
 	{ 141 , "thcgum_sys", "sys_mux", 0, SIRFSOC_CLKC_LEAF_CLK_EN0_SET, 3, &leaf0_gate_lock },
 };
 
-static struct clk *atlas7_clks[ARRAY_SIZE(unit_list)];
+static struct clk *atlas7_clks[ARRAY_SIZE(unit_list) + ARRAY_SIZE(mux_list)];
 
 static int unit_clk_is_enabled(struct clk_hw *hw)
 {
@@ -1613,6 +1613,7 @@ static void __init atlas7_clk_init(struct device_node *np)
 			       sirfsoc_clk_vbase + mux->mux_offset,
 			       mux->shift, mux->width,
 			       mux->mux_flags, NULL);
+		atlas7_clks[ARRAY_SIZE(unit_list) + i] = clk;
 		BUG_ON(!clk);
 	}
 
@@ -1624,7 +1625,7 @@ static void __init atlas7_clk_init(struct device_node *np)
 	}
 
 	clk_data.clks = atlas7_clks;
-	clk_data.clk_num = ARRAY_SIZE(unit_list);
+	clk_data.clk_num = ARRAY_SIZE(unit_list) + ARRAY_SIZE(mux_list);
 
 	ret = of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 	BUG_ON(ret);
-- 
1.9.1
