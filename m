From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 27 May 2016 22:26:58 +0200
Subject: [RFC PATCH v2 6/7] ARM: pxa: mioa701 convert to the new AC97 bus
In-Reply-To: <1464380819-19075-1-git-send-email-robert.jarzmik@free.fr>
References: <1464380819-19075-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1464380819-19075-7-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This migration implies :
 - wm9713 device is removed, it will be auto-probed
 - the AC97 bit clock is added as the pxa internally generated 13MHz
   clock

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/mioa701.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index 38a96a193dc4..e26bace43147 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -19,6 +19,7 @@
  *
  */
 
+#include <linux/clkdev.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -682,7 +683,6 @@ MIO_SIMPLE_DEV(mioa701_led,	  "leds-gpio",	    &gpio_led_info)
 MIO_SIMPLE_DEV(pxa2xx_pcm,	  "pxa2xx-pcm",	    NULL)
 MIO_SIMPLE_DEV(mioa701_sound,	  "mioa701-wm9713", NULL)
 MIO_SIMPLE_DEV(mioa701_board,	  "mioa701-board",  NULL)
-MIO_SIMPLE_DEV(wm9713_acodec,	  "wm9713-codec",   NULL);
 MIO_SIMPLE_DEV(gpio_vbus,	  "gpio-vbus",      &gpio_vbus_data);
 MIO_SIMPLE_DEV(mioa701_camera,	  "soc-camera-pdrv",&iclink);
 
@@ -690,7 +690,6 @@ static struct platform_device *devices[] __initdata = {
 	&mioa701_gpio_keys,
 	&mioa701_backlight,
 	&mioa701_led,
-	&wm9713_acodec,
 	&pxa2xx_pcm,
 	&mioa701_sound,
 	&power_dev,
@@ -742,6 +741,15 @@ static void __init mioa701_machine_init(void)
 	__raw_writel(0x0001c391, MCATT0);
 	__raw_writel(0x0001c391, MCIO0);
 
+	rc = clk_add_alias("ac97_clk", "pxa2xx-ac97:0", "AC97CONFCLK",
+			   &pxa_device_ac97.dev);
+	if (rc)
+		pr_err("PXA2xx AC97 clock1 alias error: %d\n", rc);
+
+	rc = clk_add_alias("ac97_clk", "pxa2xx-ac97:1", "AC97CONFCLK",
+			   &pxa_device_ac97.dev);
+	if (rc)
+		pr_err("PXA2xx AC97 clock2 alias error: %d\n", rc);
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(mioa701_pin_config));
 	pxa_set_ffuart_info(NULL);
-- 
2.1.4
