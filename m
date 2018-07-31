From: tony.xie@rock-chips.com (Tony Xie)
Date: Tue, 31 Jul 2018 16:00:29 +0800
Subject: [PATCH v2 5/5] clk: RK808: add RK809 and RK817 support.
In-Reply-To: <1533023850-29004-1-git-send-email-tony.xie@rock-chips.com>
References: <1533023850-29004-1-git-send-email-tony.xie@rock-chips.com>
Message-ID: <1533024029-30273-1-git-send-email-tony.xie@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RK809 and RK817 are power management IC chips for multimedia products.
most of their functions and registers are same, including the clkout
funciton.

Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
---
 drivers/clk/Kconfig     |  6 ++---
 drivers/clk/clk-rk808.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 721572a..fc1427c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -46,11 +46,11 @@ config COMMON_CLK_MAX77686
 	  clock.
 
 config COMMON_CLK_RK808
-	tristate "Clock driver for RK805/RK808/RK818"
+	tristate "Clock driver for RK805/RK808/RK809/RK817/RK818"
 	depends on MFD_RK808
 	---help---
-	  This driver supports RK805, RK808 and RK818 crystal oscillator clock. These
-	  multi-function devices have two fixed-rate oscillators,
+	  This driver supports RK805, RK809 and RK817, RK808 and RK818 crystal oscillator clock.
+          These multi-function devices have two fixed-rate oscillators,
 	  clocked at 32KHz each. Clkout1 is always on, Clkout2 can off
 	  by control register.
 
diff --git a/drivers/clk/clk-rk808.c b/drivers/clk/clk-rk808.c
index 6461f28..c5d3492 100644
--- a/drivers/clk/clk-rk808.c
+++ b/drivers/clk/clk-rk808.c
@@ -96,6 +96,66 @@ static int rk808_clkout2_is_prepared(struct clk_hw *hw)
 	return idx ? &rk808_clkout->clkout2_hw : &rk808_clkout->clkout1_hw;
 }
 
+static int rk817_clkout2_enable(struct clk_hw *hw, bool enable)
+{
+	struct rk808_clkout *rk808_clkout = container_of(hw,
+							 struct rk808_clkout,
+							 clkout2_hw);
+	struct rk808 *rk808 = rk808_clkout->rk808;
+
+	return regmap_update_bits(rk808->regmap, RK817_SYS_CFG(1),
+				  RK817_CLK32KOUT2_EN,
+				  enable ? RK817_CLK32KOUT2_EN : 0);
+}
+
+static int rk817_clkout2_prepare(struct clk_hw *hw)
+{
+	return rk817_clkout2_enable(hw, true);
+}
+
+static void rk817_clkout2_unprepare(struct clk_hw *hw)
+{
+	rk817_clkout2_enable(hw, false);
+}
+
+static int rk817_clkout2_is_prepared(struct clk_hw *hw)
+{
+	struct rk808_clkout *rk808_clkout = container_of(hw,
+							 struct rk808_clkout,
+							 clkout2_hw);
+	struct rk808 *rk808 = rk808_clkout->rk808;
+	unsigned int val;
+
+	int ret = regmap_read(rk808->regmap, RK817_SYS_CFG(1), &val);
+
+	if (ret < 0)
+		return ret;
+
+	return (val & RK817_CLK32KOUT2_EN) ? 1 : 0;
+}
+
+static const struct clk_ops rk817_clkout2_ops = {
+	.prepare = rk817_clkout2_prepare,
+	.unprepare = rk817_clkout2_unprepare,
+	.is_prepared = rk817_clkout2_is_prepared,
+	.recalc_rate = rk808_clkout_recalc_rate,
+};
+
+static const struct clk_ops *rkpmic_get_ops(long variant)
+{
+	switch (variant) {
+	case RK809_ID:
+	case RK817_ID:
+		return &rk817_clkout2_ops;
+	case RK805_ID:
+	case RK808_ID:
+	case RK818_ID:
+		return &rk808_clkout2_ops;
+	}
+
+	return &rk808_clkout2_ops;
+}
+
 static int rk808_clkout_probe(struct platform_device *pdev)
 {
 	struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
@@ -127,7 +187,7 @@ static int rk808_clkout_probe(struct platform_device *pdev)
 		return ret;
 
 	init.name = "rk808-clkout2";
-	init.ops = &rk808_clkout2_ops;
+	init.ops = rkpmic_get_ops(rk808->variant);
 	rk808_clkout->clkout2_hw.init = &init;
 
 	/* optional override of the clockname */
-- 
1.9.1
