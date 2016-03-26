From: zhengxing@rock-chips.com (Xing Zheng)
Date: Sat, 26 Mar 2016 14:37:53 +0800
Subject: [PATCH v5 1/4] clk: rockchip: fix big.LITTLE cores alternate reparent
 failed
In-Reply-To: <1458974276-10325-1-git-send-email-zhengxing@rock-chips.com>
References: <1458974276-10325-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1458974276-10325-2-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the RK3399, the order of the core's parents are LPLL/BPLL/DPLL/GPLL,
there is incorrect to select bit_0 and bit_1 as the main and alternate
parents for LPLL/BPLL. They should be configurable.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

Changes in v5: None
Changes in v3: None
Changes in v2: None

 drivers/clk/rockchip/clk-cpu.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cpu.c
index 5556849..4bb130c 100644
--- a/drivers/clk/rockchip/clk-cpu.c
+++ b/drivers/clk/rockchip/clk-cpu.c
@@ -258,7 +258,7 @@ struct clk *rockchip_clk_register_cpuclk(const char *name,
 		return ERR_PTR(-ENOMEM);
 
 	init.name = name;
-	init.parent_names = &parent_names[0];
+	init.parent_names = &parent_names[reg_data->mux_core_main];
 	init.num_parents = 1;
 	init.ops = &rockchip_cpuclk_ops;
 
@@ -276,10 +276,10 @@ struct clk *rockchip_clk_register_cpuclk(const char *name,
 	cpuclk->clk_nb.notifier_call = rockchip_cpuclk_notifier_cb;
 	cpuclk->hw.init = &init;
 
-	cpuclk->alt_parent = __clk_lookup(parent_names[1]);
+	cpuclk->alt_parent = __clk_lookup(parent_names[reg_data->mux_core_alt]);
 	if (!cpuclk->alt_parent) {
-		pr_err("%s: could not lookup alternate parent\n",
-		       __func__);
+		pr_err("%s: could not lookup alternate parent: (%d)\n",
+		       __func__, reg_data->mux_core_alt);
 		ret = -EINVAL;
 		goto free_cpuclk;
 	}
@@ -291,10 +291,11 @@ struct clk *rockchip_clk_register_cpuclk(const char *name,
 		goto free_cpuclk;
 	}
 
-	clk = __clk_lookup(parent_names[0]);
+	clk = __clk_lookup(parent_names[reg_data->mux_core_main]);
 	if (!clk) {
-		pr_err("%s: could not lookup parent clock %s\n",
-		       __func__, parent_names[0]);
+		pr_err("%s: could not lookup parent clock: (%d) %s\n",
+		       __func__, reg_data->mux_core_main,
+		       parent_names[reg_data->mux_core_main]);
 		ret = -EINVAL;
 		goto free_alt_parent;
 	}
-- 
1.7.9.5
