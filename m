From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 30 Sep 2015 16:05:45 +0200
Subject: [PATCH 5/6] regulator: i.MX anatop: Allow supply regulator
In-Reply-To: <1443621946-8712-1-git-send-email-s.hauer@pengutronix.de>
References: <1443621946-8712-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1443621946-8712-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The anatop regulators are SoC internal LDO regulators usually supplied
by an external PMIC. This patch adds support for specifying the supply
from the device tree using the vin-supply property.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 Documentation/devicetree/bindings/regulator/anatop-regulator.txt | 1 +
 drivers/regulator/anatop-regulator.c                             | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/anatop-regulator.txt b/Documentation/devicetree/bindings/regulator/anatop-regulator.txt
index 758eae2..37c4ea0 100644
--- a/Documentation/devicetree/bindings/regulator/anatop-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/anatop-regulator.txt
@@ -13,6 +13,7 @@ Optional properties:
 - anatop-delay-reg-offset: Anatop MFD step time register offset
 - anatop-delay-bit-shift: Bit shift for the step time register
 - anatop-delay-bit-width: Number of bits used in the step time register
+- vin-supply: The supply for this regulator
 
 Any property defined as part of the core regulator
 binding, defined in regulator.txt, can also be used.
diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 52ea605..ba78870 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -30,6 +30,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
+#include <linux/regulator/machine.h>
 
 #define LDO_RAMP_UP_UNIT_IN_CYCLES      64 /* 64 cycles per step */
 #define LDO_RAMP_UP_FREQ_IN_MHZ         24 /* cycle based on 24M OSC */
@@ -199,6 +200,7 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 	rdesc->owner = THIS_MODULE;
 
 	initdata = of_get_regulator_init_data(dev, np, rdesc);
+	initdata->supply_regulator = "vin";
 	sreg->initdata = initdata;
 
 	anatop_np = of_get_parent(np);
@@ -262,6 +264,7 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 	rdesc->vsel_reg = sreg->control_reg;
 	rdesc->vsel_mask = ((1 << sreg->vol_bit_width) - 1) <<
 			   sreg->vol_bit_shift;
+	rdesc->min_dropout_uv = 125000;
 
 	config.dev = &pdev->dev;
 	config.init_data = initdata;
-- 
2.5.3
