From: rashika.kheria@gmail.com (Rashika Kheria)
Date: Sat, 14 Dec 2013 13:16:06 +0530
Subject: [PATCH] drivers: clk: Fix build break introduced in 3e1e4a5f
Message-ID: <20131214074606.GA20826@rashika>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the build break introduced by 3e1e4a5f. The mentioned
commit id makes the changes in file "include/linux/mfd/samsung/core.h"
by changing the members of structure sec_pmic_dev.

The patch replaces "regmap" with "regmap_pmic" because structure
sec_pmic_dev no more contains any member named regmap.

Thus, it removes the undefined reference to regmap in functions
s2mps11_clk_prepare(), s2mps11_clk_unprepare() and s2mps11_clk_probe().

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
---
 drivers/clk/clk-s2mps11.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index 7be41e6..94e3695 100644
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
@@ -74,7 +74,8 @@ static void s2mps11_clk_unprepare(struct clk_hw *hw)
 	struct s2mps11_clk *s2mps11 = to_s2mps11_clk(hw);
 	int ret;
 
-	ret = regmap_update_bits(s2mps11->iodev->regmap, S2MPS11_REG_RTC_CTRL,
+	ret = regmap_update_bits(s2mps11->iodev->regmap_pmic,
+			   S2MPS11_REG_RTC_CTRL,
 			   s2mps11->mask, ~s2mps11->mask);
 
 	if (!ret)
@@ -174,7 +175,7 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
 		s2mps11_clk->hw.init = &s2mps11_clks_init[i];
 		s2mps11_clk->mask = 1 << i;
 
-		ret = regmap_read(s2mps11_clk->iodev->regmap,
+		ret = regmap_read(s2mps11_clk->iodev->regmap_pmic,
 				  S2MPS11_REG_RTC_CTRL, &val);
 		if (ret < 0)
 			goto err_reg;
-- 
1.7.9.5
