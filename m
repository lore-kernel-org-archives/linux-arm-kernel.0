From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 May 2012 14:45:17 +0100
Subject: [PATCH 12/18] ARM: ux500: Disable platform setup of the ab8500 when
 DT is enabled
In-Reply-To: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337262323-27692-13-git-send-email-lee.jones@linaro.org>
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
 arch/arm/mach-ux500/board-mop500.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 46df945..de94b2d 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -601,7 +601,6 @@ static struct platform_device *snowball_platform_devs[] __initdata = {
 
 static struct platform_device *snowball_of_platform_devs[] __initdata = {
 	&snowball_key_dev,
-	&ab8500_device,
 };
 
 static void __init mop500_init_machine(void)
@@ -767,6 +766,9 @@ struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 static const struct of_device_id u8500_local_bus_nodes[] = {
 	/* only create devices below soc node */
 	{ .compatible = "stericsson,db8500", },
+	{ .compatible = "stericsson,db8500-prcmu", },
+	{ .compatible = "stericsson,ab8500", },
+	{ .compatible = "stericsson,ab8500-regulator", },
 	{ .compatible = "simple-bus"},
 	{ },
 };
@@ -802,7 +804,6 @@ static void __init u8500_init_machine(void)
 				ARRAY_SIZE(mop500_platform_devs));
 
 		mop500_sdi_init(parent);
-
 		i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
 		i2c_register_board_info(0, mop500_i2c0_devices, i2c0_devs);
 		i2c_register_board_info(2, mop500_i2c2_devices,
-- 
1.7.9.5
