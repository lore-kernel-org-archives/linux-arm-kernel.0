From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 25 Sep 2014 22:59:31 -0700
Subject: [PATCH 1/2] regulator: anatop: allow LDO bypass to be set from
 device-tree
In-Reply-To: <1411711172-16498-1-git-send-email-tharvey@gateworks.com>
References: <1411711172-16498-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1411711172-16498-2-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core regulators provided by the Anatop regulator (reg_core, reg_soc,
reg_pu) should be set in bypass mode if an extern PMIC regulator is used.
This allows configuring this from device-tree.

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Mark Brown <broonie@linaro.org>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 Documentation/devicetree/bindings/regulator/anatop-regulator.txt | 1 +
 drivers/regulator/anatop-regulator.c                             | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/anatop-regulator.txt b/Documentation/devicetree/bindings/regulator/anatop-regulator.txt
index 758eae2..e958c60 100644
--- a/Documentation/devicetree/bindings/regulator/anatop-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/anatop-regulator.txt
@@ -13,6 +13,7 @@ Optional properties:
 - anatop-delay-reg-offset: Anatop MFD step time register offset
 - anatop-delay-bit-shift: Bit shift for the step time register
 - anatop-delay-bit-width: Number of bits used in the step time register
+- anatop-ldo-bypass: Enable LDO bypass mode (for core regulators)
 
 Any property defined as part of the core regulator
 binding, defined in regulator.txt, can also be used.
diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 4f730af..0a22d3a 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -279,8 +279,10 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 		}
 
 		sreg->sel = (val & rdesc->vsel_mask) >> sreg->vol_bit_shift;
-		if (sreg->sel == LDO_FET_FULL_ON) {
+		if (sreg->sel == LDO_FET_FULL_ON ||
+		    of_property_read_bool(np, "anatop-ldo-bypass")) {
 			sreg->sel = 0;
+			dev_info(dev, "LDO bypass mode\n");
 			sreg->bypass = true;
 		}
 	} else {
-- 
1.8.3.2
