From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 11 Aug 2013 18:51:50 +0200
Subject: [PATCH 9/16] arch/arm/mach-pxa/mioa701.c: Avoid using
 ARRAY_AND_SIZE(e) as a function argument
In-Reply-To: <1376239917-15594-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1376239917-15594-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1376239917-15594-10-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Replace ARRAY_AND_SIZE(e) in function argument position to avoid hiding the
arity of the called function.

The semantic match that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e,f;
@@

f(...,
- ARRAY_AND_SIZE(e)
+ e,ARRAY_SIZE(e)
  ,...)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Not compiled.

 arch/arm/mach-pxa/mioa701.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index acc9d3c..f287b1e 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -319,7 +319,7 @@ static int __init gsm_init(void)
 {
 	int rc;
 
-	rc = gpio_request_array(ARRAY_AND_SIZE(gsm_gpios));
+	rc = gpio_request_array(gsm_gpios, ARRAY_SIZE(gsm_gpios));
 	if (rc)
 		goto err_gpio;
 	rc = request_irq(gpio_to_irq(GPIO25_GSM_MOD_ON_STATE), gsm_on_irq,
@@ -333,7 +333,7 @@ static int __init gsm_init(void)
 
 err_irq:
 	printk(KERN_ERR "Mioa701: Can't request GSM_ON irq\n");
-	gpio_free_array(ARRAY_AND_SIZE(gsm_gpios));
+	gpio_free_array(gsm_gpios, ARRAY_SIZE(gsm_gpios));
 err_gpio:
 	printk(KERN_ERR "Mioa701: gsm not available\n");
 	return rc;
@@ -342,7 +342,7 @@ err_gpio:
 static void gsm_exit(void)
 {
 	free_irq(gpio_to_irq(GPIO25_GSM_MOD_ON_STATE), NULL);
-	gpio_free_array(ARRAY_AND_SIZE(gsm_gpios));
+	gpio_free_array(gsm_gpios, ARRAY_SIZE(gsm_gpios));
 }
 
 /*
@@ -731,11 +731,11 @@ static void __init mioa701_machine_init(void)
 	__raw_writel(0x0001c391, MCIO0);
 
 
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(mioa701_pin_config));
+	pxa2xx_mfp_config(mioa701_pin_config, ARRAY_SIZE(mioa701_pin_config));
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
-	rc = gpio_request_array(ARRAY_AND_SIZE(global_gpios));
+	rc = gpio_request_array(global_gpios, ARRAY_SIZE(global_gpios));
 	if (rc)
 		pr_err("MioA701: Failed to request GPIOs: %d", rc);
 	bootstrap_init();
@@ -748,7 +748,8 @@ static void __init mioa701_machine_init(void)
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	gsm_init();
 
-	i2c_register_board_info(1, ARRAY_AND_SIZE(mioa701_pi2c_devices));
+	i2c_register_board_info(1, mioa701_pi2c_devices,
+				ARRAY_SIZE(mioa701_pi2c_devices));
 	pxa_set_i2c_info(&i2c_pdata);
 	pxa27x_set_i2c_power_info(NULL);
 	pxa_set_camera_info(&mioa701_pxacamera_platform_data);
