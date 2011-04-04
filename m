From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 4 Apr 2011 10:51:24 +0200
Subject: [PATCH 2/2] mach-ux500: complete regulator constraints for MOP500
	board
Message-ID: <1301907084-16769-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This board now has complete regulation constraints and can turn
off unused regulators. For the moment we need to wire VAUX1
(V-DISPLAY rail) always on since it somehow affects the external
MMC.

Cc: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-regulators.c |    9 ++++++++-
 arch/arm/mach-ux500/board-mop500.c            |    3 +++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
index 9ed0f90..c0bc833 100644
--- a/arch/arm/mach-ux500/board-mop500-regulators.c
+++ b/arch/arm/mach-ux500/board-mop500-regulators.c
@@ -272,7 +272,14 @@ struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 			.max_uV = 2900000,
 			.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
 					  REGULATOR_CHANGE_STATUS,
-			.boot_on = 1, /* must be on for display */
+			.boot_on = 1, /* display is on at boot */
+			/*
+			 * This voltage cannot be disabled right now because
+			 * it is somehow affecting the external MMC
+			 * functionality, though that typically will use
+			 * AUX3.
+			 */
+			.always_on = 1,
 		},
 		.num_consumer_supplies = ARRAY_SIZE(ab8500_vaux1_consumers),
 		.consumer_supplies = ab8500_vaux1_consumers,
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index c271cfe..e4711f4 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -456,6 +456,9 @@ static void __init mop500_init_machine(void)
 	i2c_register_board_info(0, mop500_i2c0_devices, i2c0_devs);
 	i2c_register_board_info(2, mop500_i2c2_devices,
 				ARRAY_SIZE(mop500_i2c2_devices));
+
+	/* This board has full regulator constraints */
+	regulator_has_full_constraints();
 }
 
 MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
-- 
1.7.3.2
