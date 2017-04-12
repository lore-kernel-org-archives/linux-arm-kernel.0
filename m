From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 12 Apr 2017 09:58:45 +0800
Subject: [PATCH 4/6] regulator: anatop: remove unneeded name field of struct
 anatop_regulator
In-Reply-To: <1491962327-12477-1-git-send-email-aisheng.dong@nxp.com>
References: <1491962327-12477-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1491962327-12477-4-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sreg->name is only used as an intermediate assign of rdesc->name, plus
another strcmp. Since we already have rdesc->name, no need it anymore.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/regulator/anatop-regulator.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 9481730..19eb1f4 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -39,7 +39,6 @@
 #define LDO_FET_FULL_ON			0x1f
 
 struct anatop_regulator {
-	const char *name;
 	u32 control_reg;
 	struct regmap *anatop;
 	int vol_bit_shift;
@@ -194,12 +193,12 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 	if (!sreg)
 		return -ENOMEM;
 
-	of_property_read_string(np, "regulator-name", &sreg->name);
 	rdesc = &sreg->rdesc;
-	rdesc->name = sreg->name;
 	rdesc->type = REGULATOR_VOLTAGE;
 	rdesc->owner = THIS_MODULE;
 
+	of_property_read_string(np, "regulator-name", &rdesc->name);
+
 	initdata = of_get_regulator_init_data(dev, np, rdesc);
 	if (!initdata)
 		return -ENOMEM;
@@ -299,7 +298,7 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 		 * a sane default until imx6-cpufreq was probed and changes the
 		 * voltage to the correct value. In this case we set 1.25V.
 		 */
-		if (!sreg->sel && !strcmp(sreg->name, "vddpu"))
+		if (!sreg->sel && !strcmp(rdesc->name, "vddpu"))
 			sreg->sel = 22;
 
 		if (!sreg->bypass && !sreg->sel) {
-- 
2.7.4
