From: leo.yan@linaro.org (Leo Yan)
Date: Mon, 30 Mar 2015 13:24:24 +0800
Subject: [PATCH v2 5/5] clk: hisi: add stub clock register function
In-Reply-To: <1427693064-11062-1-git-send-email-leo.yan@linaro.org>
References: <1427693064-11062-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1427693064-11062-6-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add stub clock register function, so can easily enable stub clock for
platforms.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/clk/hisilicon/clk.c | 29 +++++++++++++++++++++++++++++
 drivers/clk/hisilicon/clk.h | 12 ++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index 87f8173..0859e4d 100644
--- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -243,3 +243,32 @@ void __init hisi_clk_register_gate_sep(struct hisi_gate_clock *clks,
 		data->clk_data.clks[clks[i].id] = clk;
 	}
 }
+
+void __init hisi_clk_register_stub(struct hisi_stub_clock *clks, int nums,
+				   struct hisi_clock_data *data,
+				   struct device_node *np)
+{
+	struct clk *clk;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk = hisi_register_stub_clk(np,
+					     clks[i].id,
+					     clks[i].name,
+					     clks[i].parent_name,
+					     clks[i].flags,
+					     &hisi_clk_lock);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			continue;
+		}
+
+		if (clks[i].alias)
+			clk_register_clkdev(clk, clks[i].name, NULL);
+
+		data->clk_data.clks[clks[i].id] = clk;
+	}
+
+	return;
+}
diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
index e99184a..89ce9ad 100644
--- a/drivers/clk/hisilicon/clk.h
+++ b/drivers/clk/hisilicon/clk.h
@@ -90,6 +90,14 @@ struct hisi_gate_clock {
 	const char		*alias;
 };
 
+struct hisi_stub_clock {
+	unsigned int		id;
+	char			*name;
+	const char		*parent_name;
+	unsigned long		flags;
+	const char		*alias;
+};
+
 struct clk *hisi_register_clkgate_sep(struct device *, const char *,
 				const char *, unsigned long,
 				void __iomem *, u8,
@@ -113,4 +121,8 @@ void __init hisi_clk_register_gate(struct hisi_gate_clock *,
 					int, struct hisi_clock_data *);
 void __init hisi_clk_register_gate_sep(struct hisi_gate_clock *,
 					int, struct hisi_clock_data *);
+void __init hisi_clk_register_stub(struct hisi_stub_clock *clks, int nums,
+				   struct hisi_clock_data *data,
+				   struct device_node *np);
+
 #endif	/* __HISI_CLK_H */
-- 
1.9.1
