From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 23 Oct 2012 15:29:01 +0200
Subject: [PATCH 1/2] input: qt1070: add pinctrl consumer
In-Reply-To: <20121023131627.GE18964@game.jcrosoft.org>
References: <20121023131627.GE18964@game.jcrosoft.org>
Message-ID: <1350998942-713-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If no pinctrl available just report a warning as some architecture may not
need to do anything.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-input at vger.kernel.org
---
 drivers/input/keyboard/qt1070.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
index ca68f29..967734e 100644
--- a/drivers/input/keyboard/qt1070.c
+++ b/drivers/input/keyboard/qt1070.c
@@ -33,6 +33,7 @@
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/delay.h>
+#include <linux/pinctrl/consumer.h>
 
 /* Address for each register */
 #define CHIP_ID            0x00
@@ -147,6 +148,7 @@ static int __devinit qt1070_probe(struct i2c_client *client,
 	struct input_dev *input;
 	int i;
 	int err;
+	struct pinctrl *pinctrl;
 
 	err = i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE);
 	if (!err) {
@@ -155,6 +157,15 @@ static int __devinit qt1070_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
+	pinctrl = devm_pinctrl_get_select_default(&client->dev);
+	if (IS_ERR(pinctrl)) {
+		err = PTR_ERR(pinctrl);
+		if (err == -EPROBE_DEFER)
+			return err;
+
+		dev_warn(&client->dev, "No pinctrl provided\n");
+	}
+
 	if (!client->irq) {
 		dev_err(&client->dev, "please assign the irq to this device\n");
 		return -EINVAL;
-- 
1.7.10.4
