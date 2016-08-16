From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Aug 2016 15:35:00 +0200
Subject: [RFC 03/17] clk: s2mps11: Switch to new clock controller API
In-Reply-To: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
References: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1471354514-24224-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allocate a clock controller and use new clk_register_with_ctrl() API.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/clk-s2mps11.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index fbaa84a33c46..881f1e226867 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -41,6 +41,7 @@ struct s2mps11_clk {
 	struct clk_hw hw;
 	struct clk *clk;
 	struct clk_lookup *lookup;
+	struct clk_ctrl *clk_ctrl;
 	u32 mask;
 	unsigned int reg;
 };
@@ -176,6 +177,10 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
 	if (IS_ERR(s2mps11_clks->clk_np))
 		return PTR_ERR(s2mps11_clks->clk_np);
 
+	s2mps11_clks->clk_ctrl = clk_ctrl_register(&pdev->dev);
+	if (IS_ERR(s2mps11_clks->clk_ctrl))
+		return PTR_ERR(s2mps11_clks->clk_ctrl); // FIXME: use devm-like
+
 	for (i = 0; i < S2MPS11_CLKS_NUM; i++) {
 		if (i == S2MPS11_CLK_CP && hwid == S2MPS14X)
 			continue; /* Skip clocks not present in some devices */
@@ -184,7 +189,8 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
 		s2mps11_clks[i].mask = 1 << i;
 		s2mps11_clks[i].reg = s2mps11_reg;
 
-		s2mps11_clks[i].clk = devm_clk_register(&pdev->dev,
+		s2mps11_clks[i].clk = devm_clk_register_with_ctrl(&pdev->dev,
+							s2mps11_clks->clk_ctrl,
 							&s2mps11_clks[i].hw);
 		if (IS_ERR(s2mps11_clks[i].clk)) {
 			dev_err(&pdev->dev, "Fail to register : %s\n",
@@ -233,6 +239,8 @@ static int s2mps11_clk_remove(struct platform_device *pdev)
 		clkdev_drop(s2mps11_clks[i].lookup);
 	}
 
+	clk_ctrl_unregister(s2mps11_clks->clk_ctrl);
+
 	return 0;
 }
 
-- 
1.9.1
