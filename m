From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 10 Apr 2014 15:52:45 +0200
Subject: [PATCH v3 6/7] pinctrl: sunxi: add reset control support
In-Reply-To: <1397137966-30818-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1397137966-30818-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1397137966-30818-7-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 SoC define a reset line for the R_PIO block which needs to be
deasserted.

Try to retrieve a reset control and deassert if one was found.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 drivers/pinctrl/pinctrl-sunxi.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
index 17b5f80..07af35a 100644
--- a/drivers/pinctrl/pinctrl-sunxi.c
+++ b/drivers/pinctrl/pinctrl-sunxi.c
@@ -26,6 +26,7 @@
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 
 #include "core.h"
@@ -792,6 +793,7 @@ static int sunxi_pinctrl_probe(struct platform_device *pdev)
 	const struct of_device_id *device;
 	struct pinctrl_pin_desc *pins;
 	struct sunxi_pinctrl *pctl;
+	struct reset_control *rstc;
 	int i, ret, last_pin;
 	struct clk *clk;
 
@@ -887,10 +889,17 @@ static int sunxi_pinctrl_probe(struct platform_device *pdev)
 	if (ret)
 		goto gpiochip_error;
 
+	rstc = devm_reset_control_get_optional(&pdev->dev, NULL);
+	if (!IS_ERR(rstc)) {
+		ret = reset_control_deassert(rstc);
+		if (ret)
+			goto clk_error;
+	}
+
 	pctl->irq = irq_of_parse_and_map(node, 0);
 	if (!pctl->irq) {
 		ret = -EINVAL;
-		goto clk_error;
+		goto rstc_error;
 	}
 
 	pctl->domain = irq_domain_add_linear(node, SUNXI_IRQ_NUMBER,
@@ -898,7 +907,7 @@ static int sunxi_pinctrl_probe(struct platform_device *pdev)
 	if (!pctl->domain) {
 		dev_err(&pdev->dev, "Couldn't register IRQ domain\n");
 		ret = -ENOMEM;
-		goto clk_error;
+		goto rstc_error;
 	}
 
 	for (i = 0; i < SUNXI_IRQ_NUMBER; i++) {
@@ -916,6 +925,9 @@ static int sunxi_pinctrl_probe(struct platform_device *pdev)
 
 	return 0;
 
+rstc_error:
+	if (!IS_ERR(rstc))
+		reset_control_assert(rstc);
 clk_error:
 	clk_disable_unprepare(clk);
 gpiochip_error:
-- 
1.8.3.2
