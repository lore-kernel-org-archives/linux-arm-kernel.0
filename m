From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 21 Dec 2012 17:45:16 +0800
Subject: [PATCH v6 6/8] tty: pxa: configure pin
In-Reply-To: <1356083118-18857-1-git-send-email-haojian.zhuang@linaro.org>
References: <1356083118-18857-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1356083118-18857-7-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haojian Zhuang <haojian.zhuang@gmail.com>

Configure pins by pinctrl driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/pxa.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 2764828..4492c1d 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -37,6 +37,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
@@ -864,6 +865,7 @@ static int serial_pxa_probe_dt(struct platform_device *pdev,
 			       struct uart_pxa_port *sport)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct pinctrl *pinctrl;
 	int ret;
 
 	if (!np)
@@ -874,6 +876,10 @@ static int serial_pxa_probe_dt(struct platform_device *pdev,
 		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
 		return ret;
 	}
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl))
+		return -EPROBE_DEFER;
+
 	sport->port.line = ret;
 	return 0;
 }
@@ -912,7 +918,7 @@ static int serial_pxa_probe(struct platform_device *dev)
 	ret = serial_pxa_probe_dt(dev, sport);
 	if (ret > 0)
 		sport->port.line = dev->id;
-	else if (ret < 0)
+	if (ret < 0)
 		goto err_clk;
 	snprintf(sport->name, PXA_NAME_LEN - 1, "UART%d", sport->port.line + 1);
 
-- 
1.7.10.4
