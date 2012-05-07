From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  7 May 2012 09:16:11 +0800
Subject: [PATCH RESEND 6/9] i2c: mxs: adopt pinctrl support
In-Reply-To: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
References: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1336353374-28939-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: linux-i2c at vger.kernel.org
Cc: Wolfram Sang <w.sang@pengutronix.de>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/i2c/busses/i2c-mxs.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 3d471d5..7c7711d 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/jiffies.h>
 #include <linux/io.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <mach/common.h>
 
@@ -323,10 +324,15 @@ static int __devinit mxs_i2c_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct mxs_i2c_dev *i2c;
 	struct i2c_adapter *adap;
+	struct pinctrl *pinctrl;
 	struct resource *res;
 	resource_size_t res_size;
 	int err, irq;
 
+	pinctrl = devm_pinctrl_get_select_default(dev);
+	if (IS_ERR(pinctrl))
+		return PTR_ERR(pinctrl);
+
 	i2c = devm_kzalloc(dev, sizeof(struct mxs_i2c_dev), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
-- 
1.7.5.4
