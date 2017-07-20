From: broonie@kernel.org (Mark Brown)
Date: Thu, 20 Jul 2017 13:24:11 +0100
Subject: Applied "regulator: fan53555: Use of_device_get_match_data() to
 simplify probe" to the regulator tree
In-Reply-To: <20170720084217.2584-1-jszhang@marvell.com>
Message-ID: <E1dYAV1-0001Dx-4F@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: fan53555: Use of_device_get_match_data() to simplify probe

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

>From d110e3e921742980a54c27f16086dc5a6c1aecd7 Mon Sep 17 00:00:00 2001
From: Jisheng Zhang <jszhang@marvell.com>
Date: Thu, 20 Jul 2017 16:42:17 +0800
Subject: [PATCH] regulator: fan53555: Use of_device_get_match_data() to
 simplify probe

if fan53555_regulator_probe() is called and the "client->dev.of_node"
isn't NULL, it means OF registered a device with a valid compatible
string, so match cannot be NULL.

Use of_device_get_match_data() to retrieve the drvdata pointer.  No
functional change intended.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/fan53555.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index 60f431831582..6b1c0e4672a2 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -407,14 +407,8 @@ static int fan53555_regulator_probe(struct i2c_client *client,
 
 	di->regulator = pdata->regulator;
 	if (client->dev.of_node) {
-		const struct of_device_id *match;
-
-		match = of_match_device(of_match_ptr(fan53555_dt_ids),
-					&client->dev);
-		if (!match)
-			return -ENODEV;
-
-		di->vendor = (unsigned long) match->data;
+		di->vendor =
+			(unsigned long)of_device_get_match_data(&client->dev);
 	} else {
 		/* if no ramp constraint set, get the pdata ramp_delay */
 		if (!di->regulator->constraints.ramp_delay) {
-- 
2.13.2
