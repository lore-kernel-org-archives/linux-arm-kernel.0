From: jorge.ramirez-ortiz@linaro.org (Jorge Ramirez-Ortiz)
Date: Fri,  8 Jul 2016 10:11:06 +0200
Subject: [PATCH 1/2] tty: amba-pl011: add support for clock frequency setting
 via dt
Message-ID: <1467965467-28180-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow to specify the clock frequency for any given port via the
assigned-clock-rates device tree property.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Tested-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 1b7331e..51867ab 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -55,6 +55,7 @@
 #include <linux/types.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/clk/clk-conf.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/sizes.h>
 #include <linux/io.h>
@@ -2472,6 +2473,10 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	if (IS_ERR(uap->clk))
 		return PTR_ERR(uap->clk);
 
+	ret = of_clk_set_defaults(dev->dev.of_node, false);
+	if (ret < 0)
+		return ret;
+
 	uap->reg_offset = vendor->reg_offset;
 	uap->vendor = vendor;
 	uap->fifosize = vendor->get_fifosize(dev);
-- 
2.7.4
