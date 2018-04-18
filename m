From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 18 Apr 2018 16:50:05 +0200
Subject: [PATCH v3 5/5] pinctrl: sunxi: Use of_clk_get_parent_count() instead
 of open coding
In-Reply-To: <1524063005-1716-1-git-send-email-geert+renesas@glider.be>
References: <1524063005-1716-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1524063005-1716-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new open coder has crept in since 470b73a38470e8ba ("pinctrl: sunxi:
Use of_clk_get_parent_count() instead of open coding"), replace it.

of_clk_get_parent_count() was moved to <linux/of_clk.h>, so include that
instead of <linux/clk-provider.h>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
This depends on "[PATCH v3 1/5] clk: Extract OF clock helpers in
<linux/of_clk.h>".

v3:
  - Add Acked-by,

v2:
  - New.
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 020d6d84639ca002..25e80a5370ca02f6 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -12,12 +12,12 @@
 
 #include <linux/io.h>
 #include <linux/clk.h>
-#include <linux/clk-provider.h>
 #include <linux/gpio/driver.h>
 #include <linux/irqdomain.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/export.h>
 #include <linux/of.h>
+#include <linux/of_clk.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
@@ -1361,7 +1361,7 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 			goto gpiochip_error;
 	}
 
-	ret = of_count_phandle_with_args(node, "clocks", "#clock-cells");
+	ret = of_clk_get_parent_count(node);
 	clk = devm_clk_get(&pdev->dev, ret == 1 ? NULL : "apb");
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
-- 
2.7.4
