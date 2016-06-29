From: broonie@kernel.org (Mark Brown)
Date: Wed, 29 Jun 2016 19:05:18 +0100
Subject: Applied "mfd: rn5t618: Register power off callback optionally" to the
 regulator tree
In-Reply-To: <20160626011515.4428-5-stefan@agner.ch>
Message-ID: <E1bIJrS-0003eP-5Y@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   mfd: rn5t618: Register power off callback optionally

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

>From fd65ae4cb65a9e41af44e37318afb39045d86bf2 Mon Sep 17 00:00:00 2001
From: Stefan Agner <stefan@agner.ch>
Date: Tue, 28 Jun 2016 22:53:21 -0700
Subject: [PATCH] mfd: rn5t618: Register power off callback optionally

Only register power off if the PMIC is defined as system power
controller (see Documentation/devicetree/bindings/power/
power-controller.txt).

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/rn5t618.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index c86160d3a773..1831740d9016 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -102,9 +102,13 @@ static int rn5t618_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	if (!pm_power_off) {
-		rn5t618_pm_power_off = priv;
-		pm_power_off = rn5t618_power_off;
+	if (of_device_is_system_power_controller(i2c->dev.of_node)) {
+		if (!pm_power_off) {
+			rn5t618_pm_power_off = priv;
+			pm_power_off = rn5t618_power_off;
+		} else {
+			dev_warn(&i2c->dev, "Poweroff callback already assigned\n");
+		}
 	}
 
 	return 0;
-- 
2.8.1
