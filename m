From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 23 Oct 2012 00:08:56 +0800
Subject: [PATCH v2 6/9] tty: pxa: configure pin
In-Reply-To: <1350922139-3693-1-git-send-email-haojian.zhuang@gmail.com>
References: <1350922139-3693-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1350922139-3693-7-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure pins by pinctrl driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/tty/serial/pxa.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 9033fc6..02dc771 100644
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
@@ -809,6 +810,7 @@ static int serial_pxa_probe_dt(struct platform_device *pdev,
 			       struct uart_pxa_port *sport)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct pinctrl *pinctrl;
 	int ret;
 
 	if (!np)
@@ -819,6 +821,10 @@ static int serial_pxa_probe_dt(struct platform_device *pdev,
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
@@ -857,7 +863,7 @@ static int serial_pxa_probe(struct platform_device *dev)
 	ret = serial_pxa_probe_dt(dev, sport);
 	if (ret > 0)
 		sport->port.line = dev->id;
-	else if (ret < 0)
+	if (ret < 0)
 		goto err_clk;
 	snprintf(sport->name, PXA_NAME_LEN - 1, "UART%d", sport->port.line + 1);
 
-- 
1.7.0.4
