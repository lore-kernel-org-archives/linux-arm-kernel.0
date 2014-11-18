From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Nov 2014 12:07:04 -0600
Subject: [PATCH 06/10] input: touchscreen: edt-ft5x06: fix driver autoprobing
In-Reply-To: <1416334028-7766-1-git-send-email-balbi@ti.com>
References: <1416334028-7766-1-git-send-email-balbi@ti.com>
Message-ID: <1416334028-7766-6-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i2c devices match against struct i2c_device_id
even for CONFIG_OF case, so adding a struct of_device_id
doesn't change anything. As a result, currently, edt-ft5x06
will not autoprobe if built as a module.

To fix the issue and still maintain backwards compatibility
with all DTS files currently in tree, we're just moving
all ids from of_device_id to i2c_device_id while also
adding the following specific ids which should be used
from now on:

	{ "edt-ft5206", 0, }
	{ "edt-ft5306", 0, }
	{ "edt-ft5406", 0, }

Cc: Lothar Wa?mann <lw@karo-electronics.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: <devicetree@vger.kernel.org>
Cc: <linux-input@vger.kernel.org>
Cc: <stable@vger.kernel.org> # v3.15+
Fixes: dac90dc2 (Input: edt-ft5x06 - add DT support)
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 .../bindings/input/touchscreen/edt-ft5x06.txt           |  9 ++++++---
 drivers/input/touchscreen/edt-ft5x06.c                  | 17 ++++++-----------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
index 76db967..50bd5d2 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
@@ -14,9 +14,12 @@ bindings.
 
 
 Required properties:
- - compatible:  "edt,edt-ft5206"
-           or:  "edt,edt-ft5306"
-           or:  "edt,edt-ft5406"
+ - compatible:  "edt-ft5206"
+	   or:  "edt-ft5306"
+	   or:  "edt-ft5406"
+	   or:  "edt,edt-ft5206" (deprecated)
+           or:  "edt,edt-ft5306" (deprecated)
+           or:  "edt,edt-ft5406" (deprecated)
 
  - reg:         I2C slave address of the chip (0x38)
  - interrupt-parent: a phandle pointing to the interrupt controller
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index ee3434f..f161ff9 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1119,25 +1119,20 @@ static SIMPLE_DEV_PM_OPS(edt_ft5x06_ts_pm_ops,
 
 static const struct i2c_device_id edt_ft5x06_ts_id[] = {
 	{ "edt-ft5x06", 0, },
+	{ "edt-ft5206", 0, },
+	{ "edt-ft5306", 0, },
+	{ "edt-ft5406", 0, },
+	{ "edt,edt-ft5206", 0, },
+	{ "edt,edt-ft5306", 0, },
+	{ "edt,edt-ft5406", 0, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, edt_ft5x06_ts_id);
 
-#ifdef CONFIG_OF
-static const struct of_device_id edt_ft5x06_of_match[] = {
-	{ .compatible = "edt,edt-ft5206", },
-	{ .compatible = "edt,edt-ft5306", },
-	{ .compatible = "edt,edt-ft5406", },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, edt_ft5x06_of_match);
-#endif
-
 static struct i2c_driver edt_ft5x06_ts_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "edt_ft5x06",
-		.of_match_table = of_match_ptr(edt_ft5x06_of_match),
 		.pm = &edt_ft5x06_ts_pm_ops,
 	},
 	.id_table = edt_ft5x06_ts_id,
-- 
2.1.0.GIT
