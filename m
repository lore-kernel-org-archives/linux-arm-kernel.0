From: broonie@kernel.org (Mark Brown)
Date: Fri, 29 Apr 2016 12:31:53 +0100
Subject: Applied "regulator: max77686: Configure enable time to properly
 handle regulator enable" to the regulator tree
In-Reply-To: <1461927591-7864-4-git-send-email-k.kozlowski@samsung.com>
Message-ID: <E1aw6eH-0003js-IV@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: max77686: Configure enable time to properly handle regulator enable

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

>From a9597305d97f6cf7c9e89dc1461e834c446d91fd Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date: Fri, 29 Apr 2016 12:59:51 +0200
Subject: [PATCH] regulator: max77686: Configure enable time to properly handle
 regulator enable

The enable time for buck regulators was not configured but actually is
essential: consumers, like usb3503, doing hard reset (regulator off/on)
should wait for the regulator to settle.

Configure the enable time according to datasheet.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max77686-regulator.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/regulator/max77686-regulator.c b/drivers/regulator/max77686-regulator.c
index d1ab6a4da88f..ac4fa581e0a5 100644
--- a/drivers/regulator/max77686-regulator.c
+++ b/drivers/regulator/max77686-regulator.c
@@ -41,6 +41,8 @@
 #define MAX77686_LDO_LOW_UVSTEP	25000
 #define MAX77686_BUCK_MINUV	750000
 #define MAX77686_BUCK_UVSTEP	50000
+#define MAX77686_BUCK_ENABLE_TIME	40		/* us */
+#define MAX77686_DVS_ENABLE_TIME	22		/* us */
 #define MAX77686_RAMP_DELAY	100000			/* uV/us */
 #define MAX77686_DVS_RAMP_DELAY	27500			/* uV/us */
 #define MAX77686_DVS_MINUV	600000
@@ -422,6 +424,7 @@ static struct regulator_ops max77686_buck_dvs_ops = {
 	.min_uV		= MAX77686_BUCK_MINUV,				\
 	.uV_step	= MAX77686_BUCK_UVSTEP,				\
 	.ramp_delay	= MAX77686_RAMP_DELAY,				\
+	.enable_time	= MAX77686_BUCK_ENABLE_TIME,			\
 	.n_voltages	= MAX77686_VSEL_MASK + 1,			\
 	.vsel_reg	= MAX77686_REG_BUCK5OUT + (num - 5) * 2,	\
 	.vsel_mask	= MAX77686_VSEL_MASK,				\
@@ -439,6 +442,7 @@ static struct regulator_ops max77686_buck_dvs_ops = {
 	.min_uV		= MAX77686_BUCK_MINUV,				\
 	.uV_step	= MAX77686_BUCK_UVSTEP,				\
 	.ramp_delay	= MAX77686_RAMP_DELAY,				\
+	.enable_time	= MAX77686_BUCK_ENABLE_TIME,			\
 	.n_voltages	= MAX77686_VSEL_MASK + 1,			\
 	.vsel_reg	= MAX77686_REG_BUCK1OUT,			\
 	.vsel_mask	= MAX77686_VSEL_MASK,				\
@@ -456,6 +460,7 @@ static struct regulator_ops max77686_buck_dvs_ops = {
 	.min_uV		= MAX77686_DVS_MINUV,				\
 	.uV_step	= MAX77686_DVS_UVSTEP,				\
 	.ramp_delay	= MAX77686_DVS_RAMP_DELAY,			\
+	.enable_time	= MAX77686_DVS_ENABLE_TIME,			\
 	.n_voltages	= MAX77686_DVS_VSEL_MASK + 1,			\
 	.vsel_reg	= MAX77686_REG_BUCK2DVS1 + (num - 2) * 10,	\
 	.vsel_mask	= MAX77686_DVS_VSEL_MASK,			\
-- 
2.8.0.rc3
