From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Aug 2016 15:35:01 +0200
Subject: [RFC 04/17] clk: samsung: Allocate a clock controller in context
In-Reply-To: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
References: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1471354514-24224-5-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allocate a clock controller and store it in context so it will be passed
later for creating clocks.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk.c | 4 ++++
 drivers/clk/samsung/clk.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index b7d87d6db9dc..fdeb35a48d3a 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -67,6 +67,10 @@ struct samsung_clk_provider *__init samsung_clk_init(struct device_node *np,
 	if (!ctx)
 		panic("could not allocate clock provider context.\n");
 
+	ctx->clk_ctrl = clk_ctrl_register(NULL);
+	if (!ctx->clk_ctrl)
+		panic("could not allocate clock provider controller.\n");
+
 	clk_table = kcalloc(nr_clks, sizeof(struct clk *), GFP_KERNEL);
 	if (!clk_table)
 		panic("could not allocate clock lookup table\n");
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index da3bdebabf1e..cb0ef6266b6d 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -28,6 +28,7 @@ struct samsung_clk_provider {
 	void __iomem *reg_base;
 	struct clk_onecell_data clk_data;
 	spinlock_t lock;
+	struct clk_ctrl *clk_ctrl;
 };
 
 /**
-- 
1.9.1
