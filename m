From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Apr 2017 21:42:16 +0100
Subject: Applied "regulator: anatop: remove unneeded name field of struct
 anatop_regulator" to the regulator tree
In-Reply-To: <1491962327-12477-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <E1cy2cC-00085e-19@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: anatop: remove unneeded name field of struct anatop_regulator

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From aeb1404d68df62b0a1d277a4138dbd92a4330304 Mon Sep 17 00:00:00 2001
From: Dong Aisheng <aisheng.dong@nxp.com>
Date: Wed, 12 Apr 2017 09:58:45 +0800
Subject: [PATCH] regulator: anatop: remove unneeded name field of struct
 anatop_regulator

sreg->name is only used as an intermediate assign of rdesc->name, plus
another strcmp. Since we already have rdesc->name, no need it anymore.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/anatop-regulator.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 58141cbdf257..c6ce9745ffc8 100644
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
@@ -297,7 +296,7 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 		 * a sane default until imx6-cpufreq was probed and changes the
 		 * voltage to the correct value. In this case we set 1.25V.
 		 */
-		if (!sreg->sel && !strcmp(sreg->name, "vddpu"))
+		if (!sreg->sel && !strcmp(rdesc->name, "vddpu"))
 			sreg->sel = 22;
 
 		if (!sreg->bypass && !sreg->sel) {
-- 
2.11.0
