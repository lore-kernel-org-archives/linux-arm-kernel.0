From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 21 Dec 2012 17:45:18 +0800
Subject: [PATCH v6 8/8] i2c: pxa: configure pinmux
In-Reply-To: <1356083118-18857-1-git-send-email-haojian.zhuang@linaro.org>
References: <1356083118-18857-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1356083118-18857-9-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haojian Zhuang <haojian.zhuang@gmail.com>

Configure pins by pinctrl driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/i2c/busses/i2c-pxa.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 7c8b5d0..11e4a30 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -32,6 +32,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_i2c.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/err.h>
 #include <linux/clk.h>
@@ -1051,6 +1052,7 @@ static int i2c_pxa_probe_dt(struct platform_device *pdev, struct pxa_i2c *i2c,
 			    enum pxa_i2c_types *i2c_types)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct pinctrl *pinctrl;
 	const struct of_device_id *of_id =
 			of_match_device(i2c_pxa_dt_ids, &pdev->dev);
 	int ret;
@@ -1063,6 +1065,9 @@ static int i2c_pxa_probe_dt(struct platform_device *pdev, struct pxa_i2c *i2c,
 		return ret;
 	}
 	pdev->id = ret;
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl))
+		return -EPROBE_DEFER;
 	if (of_get_property(np, "mrvl,i2c-polling", NULL))
 		i2c->use_pio = 1;
 	if (of_get_property(np, "mrvl,i2c-fast-mode", NULL))
-- 
1.7.10.4
