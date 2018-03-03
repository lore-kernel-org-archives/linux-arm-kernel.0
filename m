From: andre.przywara@arm.com (Andre Przywara)
Date: Sat,  3 Mar 2018 12:25:54 +0000
Subject: [PATCH v2] pinctrl: sunxi: always look for apb block
Message-ID: <20180303122554.20984-1-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner pinctrl device tree binding suggests that a clock named
"apb" would drive the pin controller IP. However (for legacy reasons) we
rely on this clock actually being the first clock defined.
Since named clocks can be in any order, let's explicitly check for a
clock called "apb" if there is more than one clock referenced.

Kudo to Maxime for suggesting this much more elegant approach.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 341312d66512..bc3d59f2173f 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -1363,7 +1363,8 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 			goto gpiochip_error;
 	}
 
-	clk = devm_clk_get(&pdev->dev, NULL);
+	ret = of_count_phandle_with_args(node, "clocks", "#clock-cells");
+	clk = devm_clk_get(&pdev->dev, ret == 1 ? NULL : "apb");
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
 		goto gpiochip_error;
-- 
2.14.1
