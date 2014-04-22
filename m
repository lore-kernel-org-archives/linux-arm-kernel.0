From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Tue, 22 Apr 2014 19:46:53 +0800
Subject: [PATCH 2/3] clk: hisi: add hisi_clk_register_gate
In-Reply-To: <1398167214-1604-1-git-send-email-zhangfei.gao@linaro.org>
References: <1398167214-1604-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1398167214-1604-3-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add hisi_clk_register_gate register clk gate table

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/clk/hisilicon/clk.c |   28 ++++++++++++++++++++++++++++
 drivers/clk/hisilicon/clk.h |    2 ++
 2 files changed, 30 insertions(+)

diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index 2699388..a078e84 100644
--- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -177,6 +177,34 @@ void __init hisi_clk_register_divider(struct hisi_divider_clock *clks,
 	}
 }
 
+void __init hisi_clk_register_gate(struct hisi_gate_clock *clks,
+				       int nums, struct hisi_clock_data *data)
+{
+	struct clk *clk;
+	void __iomem *base = data->base;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk = clk_register_gate(NULL, clks[i].name,
+						clks[i].parent_name,
+						clks[i].flags,
+						base + clks[i].offset,
+						clks[i].bit_idx,
+						clks[i].gate_flags,
+						&hisi_clk_lock);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			continue;
+		}
+
+		if (clks[i].alias)
+			clk_register_clkdev(clk, clks[i].alias, NULL);
+
+		data->clk_data.clks[clks[i].id] = clk;
+	}
+}
+
 void __init hisi_clk_register_gate_sep(struct hisi_gate_clock *clks,
 				       int nums, struct hisi_clock_data *data)
 {
diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
index bc39a6a..31083ff 100644
--- a/drivers/clk/hisilicon/clk.h
+++ b/drivers/clk/hisilicon/clk.h
@@ -104,6 +104,8 @@ void __init hisi_clk_register_mux(struct hisi_mux_clock *, int,
 				struct hisi_clock_data *);
 void __init hisi_clk_register_divider(struct hisi_divider_clock *,
 				int, struct hisi_clock_data *);
+void __init hisi_clk_register_gate(struct hisi_gate_clock *,
+					int, struct hisi_clock_data *);
 void __init hisi_clk_register_gate_sep(struct hisi_gate_clock *,
 					int, struct hisi_clock_data *);
 #endif	/* __HISI_CLK_H */
-- 
1.7.9.5
