From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 2 Nov 2011 22:19:26 +0100
Subject: [PATCH] pxa/mioa701: remove machine restart and halt code
Message-ID: <mailman.202.1320269595.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove all machine stop function which freed irq and gpio,
as this code is not necessary as the reboot are terminal
events, and won't suffer from a missing free.

Use the newly available machine descriptor soft_reboot field
to kill arm_pm_* hooks. This still ensures RTC clock is not
reset upon reboot.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/mioa701.c |   38 +-------------------------------------
 1 files changed, 1 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index 4bb1c2b..5068439 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -332,12 +332,6 @@ err_gpio:
 	return rc;
 }
 
-static void gsm_exit(void)
-{
-	free_irq(gpio_to_irq(GPIO25_GSM_MOD_ON_STATE), NULL);
-	gpio_free_array(ARRAY_AND_SIZE(gsm_gpios));
-}
-
 /*
  * Bluetooth BRF6150 chip
  *
@@ -501,15 +495,6 @@ static int __init bootstrap_init(void)
 	return 0;
 }
 
-static void bootstrap_exit(void)
-{
-	kfree(save_buffer);
-	unregister_syscore_ops(&mioa701_syscore_ops);
-
-	printk(KERN_CRIT "Unregistering mioa701 suspend will hang next"
-	       "resume !!!\n");
-}
-
 /*
  * Power Supply
  */
@@ -688,20 +673,6 @@ static struct platform_device *devices[] __initdata = {
 	&mioa701_board,
 };
 
-static void mioa701_machine_exit(void);
-
-static void mioa701_poweroff(void)
-{
-	mioa701_machine_exit();
-	arm_machine_restart('s', NULL);
-}
-
-static void mioa701_restart(char c, const char *cmd)
-{
-	mioa701_machine_exit();
-	arm_machine_restart('s', cmd);
-}
-
 static struct gpio global_gpios[] = {
 	{ GPIO9_CHARGE_EN, GPIOF_OUT_INIT_HIGH, "Charger enable" },
 	{ GPIO18_POWEROFF, GPIOF_OUT_INIT_LOW, "Power Off" },
@@ -739,8 +710,6 @@ static void __init mioa701_machine_init(void)
 	pxa_set_keypad_info(&mioa701_keypad_info);
 	pxa_set_udc_info(&mioa701_udc_info);
 	pxa_set_ac97_info(&mioa701_ac97_info);
-	pm_power_off = mioa701_poweroff;
-	arm_pm_restart = mioa701_restart;
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	gsm_init();
 
@@ -750,12 +719,6 @@ static void __init mioa701_machine_init(void)
 	pxa_set_camera_info(&mioa701_pxacamera_platform_data);
 }
 
-static void mioa701_machine_exit(void)
-{
-	bootstrap_exit();
-	gsm_exit();
-}
-
 MACHINE_START(MIOA701, "MIO A701")
 	.boot_params	= 0xa0000100,
 	.map_io		= &pxa27x_map_io,
@@ -763,4 +726,5 @@ MACHINE_START(MIOA701, "MIO A701")
 	.handle_irq	= &pxa27x_handle_irq,
 	.init_machine	= mioa701_machine_init,
 	.timer		= &pxa_timer,
+	.soft_reboot	= 1,
 MACHINE_END
-- 
1.7.5.4
