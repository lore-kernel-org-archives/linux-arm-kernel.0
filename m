From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 10 Apr 2014 14:25:46 +0200
Subject: [PATCH v2 4/5] pinctrl: sunxi: add reset control support
In-Reply-To: <1397132747-13917-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1397132747-13917-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1397132747-13917-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 SoC define a reset line for the R_PIO block which needs to be
deasserted for the pin controller to be usable.

Try to retrieve a reset line and deassert if one was found.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 drivers/pinctrl/pinctrl-sunxi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
index ee62027..b752495 100644
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
 
@@ -885,6 +887,13 @@ static int sunxi_pinctrl_probe(struct platform_device *pdev)
 
 	clk_prepare_enable(clk);
 
+	rstc = devm_reset_control_get(&pdev->dev, NULL);
+	if (!IS_ERR(rstc)) {
+		ret = reset_control_deassert(rstc);
+		if (ret)
+			goto gpiochip_error;
+	}
+
 	pctl->irq = irq_of_parse_and_map(node, 0);
 	if (!pctl->irq) {
 		ret = -EINVAL;
-- 
1.8.3.2
