From: broonie@kernel.org (Mark Brown)
Date: Fri, 05 Aug 2016 13:09:21 +0100
Subject: Applied "regulator: qcom_smd: Fix voltage ranges for pma8084 ftsmps
 and pldo" to the regulator tree
In-Reply-To: <20160711215009.4519-3-sboyd@codeaurora.org>
Message-ID: <E1bVdwH-0002jg-Cz@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: qcom_smd: Fix voltage ranges for pma8084 ftsmps and pldo

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

>From c488f0071eacd10a290df4fb34bbdeb4eb8e7888 Mon Sep 17 00:00:00 2001
From: Stephen Boyd <sboyd@codeaurora.org>
Date: Mon, 11 Jul 2016 14:50:08 -0700
Subject: [PATCH] regulator: qcom_smd: Fix voltage ranges for pma8084 ftsmps
 and pldo

The voltage ranges listed here are wrong. The pma8084 pldo
supports three different overlapping voltage ranges with
differing step sizes and the pma8084 ftsmps supports two. These
ranges can be seen in the "native" spmi regulator driver
(qcom_spmi-regulator.c) at pldo_ranges[] and ftsmps_ranges[]
respectively. Port these ranges over to the RPM SMD regulator
driver so that we list the appropriate set of supported voltages
on these types of regulators.

Fixes: ee01d0c91ef1 ("regulator: qcom-smd: Add support for PMA8084")
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Reviewed-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/qcom_smd-regulator.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 47cd28e960db..8ed46a9a55c8 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -178,20 +178,21 @@ static const struct regulator_desc pma8084_hfsmps = {
 static const struct regulator_desc pma8084_ftsmps = {
 	.linear_ranges = (struct regulator_linear_range[]) {
 		REGULATOR_LINEAR_RANGE(350000,  0, 184, 5000),
-		REGULATOR_LINEAR_RANGE(700000, 185, 339, 10000),
+		REGULATOR_LINEAR_RANGE(1280000, 185, 261, 10000),
 	},
 	.n_linear_ranges = 2,
-	.n_voltages = 340,
+	.n_voltages = 262,
 	.ops = &rpm_smps_ldo_ops,
 };
 
 static const struct regulator_desc pma8084_pldo = {
 	.linear_ranges = (struct regulator_linear_range[]) {
-		REGULATOR_LINEAR_RANGE(750000,  0,  30, 25000),
-		REGULATOR_LINEAR_RANGE(1500000, 31, 99, 50000),
+		REGULATOR_LINEAR_RANGE( 750000,  0,  63, 12500),
+		REGULATOR_LINEAR_RANGE(1550000, 64, 126, 25000),
+		REGULATOR_LINEAR_RANGE(3100000, 127, 163, 50000),
 	},
-	.n_linear_ranges = 2,
-	.n_voltages = 100,
+	.n_linear_ranges = 3,
+	.n_voltages = 164,
 	.ops = &rpm_smps_ldo_ops,
 };
 
-- 
2.8.1
