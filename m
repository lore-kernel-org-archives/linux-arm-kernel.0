From: broonie@kernel.org (Mark Brown)
Date: Tue, 12 Jul 2016 10:02:03 +0100
Subject: Applied "regulator: qcom_smd: Avoid overlapping linear voltage
 ranges" to the regulator tree
In-Reply-To: <20160711215009.4519-4-sboyd@codeaurora.org>
Message-ID: <E1bMtZr-00087D-7K@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: qcom_smd: Avoid overlapping linear voltage ranges

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

>From b7a8524cfae0b3bde80be38c171e4ecac8ba527e Mon Sep 17 00:00:00 2001
From: Stephen Boyd <sboyd@codeaurora.org>
Date: Mon, 11 Jul 2016 14:50:09 -0700
Subject: [PATCH] regulator: qcom_smd: Avoid overlapping linear voltage ranges

The pm8x41_hfsmps ranges overlap. The first range is from 375000
to 1562500:

 375000 + (95 * 12500) == 1562500

and the second range starts at 1550000. Interestingly, the second
range ends at the correct value when it's set to be the
appropriate start value, 1575000:

 1575000 + ((158 - 96) * 25000) == 3125000

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Reviewed-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/qcom_smd-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 6c7fe4778793..5022fa8d10c6 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -211,7 +211,7 @@ static const struct regulator_desc pma8084_switch = {
 static const struct regulator_desc pm8x41_hfsmps = {
 	.linear_ranges = (struct regulator_linear_range[]) {
 		REGULATOR_LINEAR_RANGE( 375000,  0,  95, 12500),
-		REGULATOR_LINEAR_RANGE(1550000, 96, 158, 25000),
+		REGULATOR_LINEAR_RANGE(1575000, 96, 158, 25000),
 	},
 	.n_linear_ranges = 2,
 	.n_voltages = 159,
-- 
2.8.1
