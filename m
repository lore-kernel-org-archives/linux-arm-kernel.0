From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Wed, 27 Mar 2013 18:20:40 -0300
Subject: [PATCH v2 4/7] pinctrl: sunxi: add clock support
In-Reply-To: <1364419243-18446-1-git-send-email-emilio@elopez.com.ar>
References: <1363962042-29536-1-git-send-email-emilio@elopez.com.ar>
 <1364419243-18446-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1364419243-18446-5-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the port controller to work, we need to enable the apb0_pio gate.
This commit adds the ability to enable one clock specified on the device
tree to the pinctrl driver.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---

Changes from v1:
  - no changes

 drivers/pinctrl/pinctrl-sunxi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
index 3e41cd1..a1e2af7 100644
--- a/drivers/pinctrl/pinctrl-sunxi.c
+++ b/drivers/pinctrl/pinctrl-sunxi.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -1917,6 +1918,7 @@ static int sunxi_pinctrl_probe(struct platform_device *pdev)
 	struct pinctrl_pin_desc *pins;
 	struct sunxi_pinctrl *pctl;
 	int i, ret, last_pin;
+	struct clk *clk;
 
 	pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
 	if (!pctl)
@@ -1987,6 +1989,12 @@ static int sunxi_pinctrl_probe(struct platform_device *pdev)
 			goto gpiochip_error;
 	}
 
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		goto gpiochip_error;
+
+	clk_prepare_enable(clk);
+
 	dev_info(&pdev->dev, "initialized sunXi PIO driver\n");
 
 	return 0;
-- 
1.8.2
