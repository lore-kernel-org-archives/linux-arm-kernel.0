From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 Apr 2016 19:25:05 +0100
Subject: Applied "regulator: axp20x: Fix LDO4 linear voltage range" to the
 regulator tree
In-Reply-To: <1461679251-25538-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <E1av7fV-00083t-3k@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: axp20x: Fix LDO4 linear voltage range

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

>From 8d4d5c3a7c25e69075e60e5e70c1e05c205aef89 Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 26 Apr 2016 16:00:51 +0200
Subject: [PATCH] regulator: axp20x: Fix LDO4 linear voltage range

The current linear voltage range for the LDO4 regulator found in the APX20X
PMICs assumes that the voltage is linear between 2.5 and 3.1V.

However, the PMIC can output up to 3.3V on that regulator by skipping the
2.6V and 2.9V steps.

Fix the ranges to read and set the proper voltages.

Fixes: 13d57e64352a ("regulator: axp20x: Use linear voltage ranges for AXP20X LDO4")
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/axp20x-regulator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 40cd894e4df5..29ab0985b46e 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -157,7 +157,9 @@ static struct regulator_ops axp20x_ops_sw = {
 static const struct regulator_linear_range axp20x_ldo4_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1250000, 0x0, 0x0, 0),
 	REGULATOR_LINEAR_RANGE(1300000, 0x1, 0x8, 100000),
-	REGULATOR_LINEAR_RANGE(2500000, 0x9, 0xf, 100000),
+	REGULATOR_LINEAR_RANGE(2500000, 0x9, 0x9, 0),
+	REGULATOR_LINEAR_RANGE(2700000, 0xa, 0xb, 100000),
+	REGULATOR_LINEAR_RANGE(3000000, 0xc, 0xf, 100000),
 };
 
 static const struct regulator_desc axp20x_regulators[] = {
-- 
2.8.0.rc3
