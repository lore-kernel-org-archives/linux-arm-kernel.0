From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 Dec 2013 15:07:43 +0100
Subject: [PATCH] mfd: s2mps11: Fix build after regmap field rename in
 sec-core.c
Message-ID: <1386770863-32247-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix building of s2mps11 regulator and clock drivers after renaming
regmap field in struct sec_pmic_dev in commit:
 - "mfd/rtc: s5m: Fix register updating by adding regmap for RTC"

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clk/clk-s2mps11.c   |    6 +++---
 drivers/regulator/s2mps11.c |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index 7be41e676a64..00a3abe103a5 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -60,7 +60,7 @@ static int s2mps11_clk_prepare(struct clk_hw *hw)
 	struct s2mps11_clk *s2mps11 = to_s2mps11_clk(hw);
 	int ret;
 
-	ret = regmap_update_bits(s2mps11->iodev->regmap,
+	ret = regmap_update_bits(s2mps11->iodev->regmap_pmic,
 				S2MPS11_REG_RTC_CTRL,
 				 s2mps11->mask, s2mps11->mask);
 	if (!ret)
@@ -74,7 +74,7 @@ static void s2mps11_clk_unprepare(struct clk_hw *hw)
 	struct s2mps11_clk *s2mps11 = to_s2mps11_clk(hw);
 	int ret;
 
-	ret = regmap_update_bits(s2mps11->iodev->regmap, S2MPS11_REG_RTC_CTRL,
+	ret = regmap_update_bits(s2mps11->iodev->regmap_pmic, S2MPS11_REG_RTC_CTRL,
 			   s2mps11->mask, ~s2mps11->mask);
 
 	if (!ret)
@@ -174,7 +174,7 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
 		s2mps11_clk->hw.init = &s2mps11_clks_init[i];
 		s2mps11_clk->mask = 1 << i;
 
-		ret = regmap_read(s2mps11_clk->iodev->regmap,
+		ret = regmap_read(s2mps11_clk->iodev->regmap_pmic,
 				  S2MPS11_REG_RTC_CTRL, &val);
 		if (ret < 0)
 			goto err_reg;
diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index 333677d68d0e..9e61922d8230 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -438,7 +438,7 @@ common_reg:
 	platform_set_drvdata(pdev, s2mps11);
 
 	config.dev = &pdev->dev;
-	config.regmap = iodev->regmap;
+	config.regmap = iodev->regmap_pmic;
 	config.driver_data = s2mps11;
 	for (i = 0; i < S2MPS11_REGULATOR_MAX; i++) {
 		if (!reg_np) {
-- 
1.7.9.5
