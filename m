From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 18 Dec 2017 11:57:51 +0800
Subject: [PATCH] clk: sunxi: sun9i-mmc: Implement reset callback for reset
 controls
Message-ID: <20171218035751.20661-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our MMC host driver now issues a reset, instead of just deasserting
the reset control, since commit c34eda69ad4c ("mmc: sunxi: Reset the
device at probe time"). The sun9i-mmc clock driver does not support
this, and will fail, which results in MMC not probing.

This patch implements the reset callback by asserting the reset control,
then deasserting it after a small delay.

Fixes: 7a6fca879f59 ("clk: sunxi: Add driver for A80 MMC config clocks/resets")
Cc: <stable@vger.kernel.org> # 4.14.x
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-sun9i-mmc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/sunxi/clk-sun9i-mmc.c b/drivers/clk/sunxi/clk-sun9i-mmc.c
index a1a634253d6f..f00d8758ba24 100644
--- a/drivers/clk/sunxi/clk-sun9i-mmc.c
+++ b/drivers/clk/sunxi/clk-sun9i-mmc.c
@@ -16,6 +16,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -83,9 +84,20 @@ static int sun9i_mmc_reset_deassert(struct reset_controller_dev *rcdev,
 	return 0;
 }
 
+static int sun9i_mmc_reset_reset(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	sun9i_mmc_reset_assert(rcdev, id);
+	udelay(10);
+	sun9i_mmc_reset_deassert(rcdev, id);
+
+	return 0;
+}
+
 static const struct reset_control_ops sun9i_mmc_reset_ops = {
 	.assert		= sun9i_mmc_reset_assert,
 	.deassert	= sun9i_mmc_reset_deassert,
+	.reset		= sun9i_mmc_reset_reset,
 };
 
 static int sun9i_a80_mmc_config_clk_probe(struct platform_device *pdev)
-- 
2.15.0
