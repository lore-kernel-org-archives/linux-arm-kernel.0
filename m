From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 May 2012 12:47:28 +0800
Subject: [PATCH 10/22] ARM: ux500: Disable platform setup of the ab8500 when
 DT is enabled
In-Reply-To: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1338353260-10097-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The final piece of the ab8500 puzzle. Here we prevent any of the ab8500-*
drivers from being registered from platform code when Device Tree is
enabled, as we expect DT do probe each of these individually. We also
provide the relevant compatible strings, so that DT knows which nodes
it needs to pay attention to during population.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index aecb0e1..ea6082a 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -680,7 +680,6 @@ static struct platform_device *snowball_platform_devs[] __initdata = {
 static struct platform_device *snowball_of_platform_devs[] __initdata = {
 	&snowball_led_dev,
 	&snowball_key_dev,
-	&ab8500_device,
 };
 
 static void __init mop500_init_machine(void)
@@ -841,6 +840,9 @@ struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 static const struct of_device_id u8500_local_bus_nodes[] = {
 	/* only create devices below soc node */
 	{ .compatible = "stericsson,db8500", },
+	{ .compatible = "stericsson,db8500-prcmu", },
+	{ .compatible = "stericsson,ab8500", },
+	{ .compatible = "stericsson,ab8500-regulator", },
 	{ .compatible = "simple-bus"},
 	{ },
 };
@@ -876,7 +878,6 @@ static void __init u8500_init_machine(void)
 				ARRAY_SIZE(mop500_platform_devs));
 
 		mop500_sdi_init(parent);
-
 		i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
 		i2c_register_board_info(0, mop500_i2c0_devices, i2c0_devs);
 		i2c_register_board_info(2, mop500_i2c2_devices,
@@ -888,7 +889,7 @@ static void __init u8500_init_machine(void)
 		 *   snowball_led_dev   = todo
 		 *   snowball_key_dev   = todo
 		 *   snowball_sbnet_dev = done
-		 *   ab8500_device      = todo
+		 *   ab8500_device      = done
 		 */
 		platform_add_devices(snowball_of_platform_devs,
 				ARRAY_SIZE(snowball_of_platform_devs));
-- 
1.7.9.5
