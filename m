From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 18 Oct 2012 17:06:57 +0800
Subject: [PATCH 03/10] tty: pxa: configure pin
In-Reply-To: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1350551224-12857-3-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure pins by pinctrl driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/tty/serial/pxa.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 5847a4b..ee6118a 100644
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
@@ -795,6 +796,7 @@ static int serial_pxa_probe_dt(struct platform_device *pdev,
 			       struct uart_pxa_port *sport)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct pinctrl *pinctrl;
 	int ret;
 
 	if (!np)
@@ -805,6 +807,12 @@ static int serial_pxa_probe_dt(struct platform_device *pdev,
 		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
 		return ret;
 	}
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		ret = PTR_ERR(pinctrl);
+		return ret;
+	}
+
 	sport->port.line = ret;
 	return 0;
 }
-- 
1.7.0.4
