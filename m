From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 16 May 2014 16:07:14 -0700
Subject: [PATCH 7/7] clk: qcom: Return error pointers for unimplemented clocks
In-Reply-To: <1400281634-9313-1-git-send-email-sboyd@codeaurora.org>
References: <1400281634-9313-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1400281634-9313-8-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not all clocks are implemented but client drivers can still
request them. Currently we will return a NULL pointer to them if
the clock isn't implemented in software but NULL pointers are
valid clock pointers. Return an error pointer so that driver's
don't proceed without a clock they may actually need.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 86b45fba5f90..9b5a1cfc6b91 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -62,8 +62,10 @@ int qcom_cc_probe(struct platform_device *pdev, const struct qcom_cc_desc *desc)
 	data->clk_num = num_clks;
 
 	for (i = 0; i < num_clks; i++) {
-		if (!rclks[i])
+		if (!rclks[i]) {
+			clks[i] = ERR_PTR(-ENOENT);
 			continue;
+		}
 		clk = devm_clk_register_regmap(dev, rclks[i]);
 		if (IS_ERR(clk))
 			return PTR_ERR(clk);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
